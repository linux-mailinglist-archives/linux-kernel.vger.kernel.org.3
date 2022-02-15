Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1694B7161
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiBOPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:46:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiBOPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:45:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009BD241;
        Tue, 15 Feb 2022 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644939722; x=1676475722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YY8qERGDWcP8mIleICIL/OwYHGlGHS8O3+4Px7/b6Wc=;
  b=JJ5rb6sWVI000ARJDI4JPWxl92yv04mQzBNbhVpLZpHz33J4QdU7jcRF
   it3+UswgsTeEsdYlY3OROWuw6CtFFiX3URXPWM8x8oeVeMMJivX8iR3jR
   otrpi0tjHSF3vDmx3bp8Dgp3ojNr+R96uQX6kWji7T1EycboSwei3FvB+
   mBmoSxtWbJP/16SlqFzwJpIApdj5lVlcuStXp3LAFrvw86IsFx3bx1zM4
   CyzA49psVEbkplxQzuQh6ysqcexDU+8kGITWpKBqmHgzGWjNeF5JV/PRz
   1p7Ib81NQLQIQLta7xWCurhn/wQlImPLF/HbHKlsXK7qUDvvOmJ9UitiS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249211575"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="249211575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 07:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681080655"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 15 Feb 2022 07:41:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Feb 2022 17:41:58 +0200
Date:   Tue, 15 Feb 2022 17:41:58 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YgvJxkvdlz1ilOjE@kuha.fi.intel.com>
References: <20220208091621.3680427-1-xji@analogixsemi.com>
 <20220208091621.3680427-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208091621.3680427-2-xji@analogixsemi.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Where is patch 1/2 ?

On Tue, Feb 08, 2022 at 05:16:21PM +0800, Xin Ji wrote:
> Add driver for analogix ANX7411 USB Type-C DRP port controller.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> V4 -> V5: Fix Greg h-k comment, remove DEBUG define
> V3 -> V4: Fix compiling waring
> V2 -> V3: Add changelog history
> V1 -> V2: Fix compiling warning issue
> ---
>  drivers/usb/typec/Kconfig   |   11 +
>  drivers/usb/typec/Makefile  |    1 +
>  drivers/usb/typec/anx7411.c | 1471 +++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/anx7411.h |  271 +++++++
>  4 files changed, 1754 insertions(+)
>  create mode 100644 drivers/usb/typec/anx7411.c
>  create mode 100644 drivers/usb/typec/anx7411.h
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index ab480f38523a..615183f46405 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -52,6 +52,17 @@ source "drivers/usb/typec/ucsi/Kconfig"
>  
>  source "drivers/usb/typec/tipd/Kconfig"
>  
> +config TYPEC_ANX7411
> +	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
> +	depends on I2C
> +	depends on USB_ROLE_SWITCH
> +	help
> +	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
> +	  controller driver.
> +
> +	  If you choose to build this driver as a dynamically linked module, the
> +	  module will be called anx7411.ko.
> +
>  config TYPEC_HD3SS3220
>  	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
>  	depends on I2C
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index a0adb8947a30..f4e7188f174a 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC)		+= altmodes/
>  obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
>  obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
>  obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
> +obj-$(CONFIG_TYPEC_ANX7411)	+= anx7411.o
>  obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
>  obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
>  obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> new file mode 100644
> index 000000000000..fb9adda037b5
> --- /dev/null
> +++ b/drivers/usb/typec/anx7411.c
> @@ -0,0 +1,1471 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> + *
> + */
> +#include <linux/gcd.h>

Do you actually need that?

> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_gpio.h>

And that?

> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/usb/pd.h>
> +#include <linux/usb/role.h>
> +#include <linux/usb/typec.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/workqueue.h>
> +#include <linux/power_supply.h>
> +
> +#include "anx7411.h"
> +
> +static u8 snk_identity[] = {
> +	VENDOR_ID & 0xFF, (VENDOR_ID >> 8) & 0xFF, 0x00, 0x82,  /* snk_id_hdr */
> +	0x00, 0x00, 0x00, 0x00,                                 /* snk_cert */
> +	0x00, 0x00, PRODUCT_ID & 0xFF, (PRODUCT_ID >> 8) & 0xFF,/* 5snk_ama */
> +};

Hardcoded identity? I would have really expected that the firmware
provides that thing.

In any case, use the helpers from include/linux/usb/pd_vdo.h to fill
that thing.

> +static u8 dp_caps[4] = {0xC6, 0x00, 0x00, 0x00};

What is that?

> +static int anx7411_reg_read(struct i2c_client *client,
> +			    u8 reg_addr)
> +{
> +	return i2c_smbus_read_byte_data(client, reg_addr);
> +}
> +
> +static int anx7411_reg_block_read(struct i2c_client *client,
> +				  u8 reg_addr, u8 len, u8 *buf)
> +{
> +	return i2c_smbus_read_i2c_block_data(client, reg_addr, len, buf);
> +}
> +
> +static int anx7411_reg_write(struct i2c_client *client,
> +			     u8 reg_addr, u8 reg_val)
> +{
> +	return i2c_smbus_write_byte_data(client, reg_addr, reg_val);
> +}
> +
> +static int anx7411_reg_block_write(struct i2c_client *client,
> +				   u8 reg_addr, u8 len, u8 *buf)
> +{
> +	return i2c_smbus_write_i2c_block_data(client, reg_addr, len, buf);
> +}
> +
> +static struct anx7411_i2c_select anx7411_i2c_addr[] = {
> +	{TCPC_ADDRESS1, SPI_ADDRESS1},
> +	{TCPC_ADDRESS2, SPI_ADDRESS2},
> +	{TCPC_ADDRESS3, SPI_ADDRESS3},
> +	{TCPC_ADDRESS4, SPI_ADDRESS4},
> +};

What are those?

> +static int anx7411_detect_power_mode(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;


spi_client ?

> +	int ret;
> +	int mode;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
> +	if (ret < 0) {
> +		dev_info(dev, "failed to read request current.\n");

dev_err()?

> +		return ret;
> +	}
> +	ctx->typec.request_current = ret * CURRENT_UNIT; /* 50ma per unit */
> +
> +	ret = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
> +	if (ret < 0) {
> +		dev_info(dev, "failed to read voltage.\n");

Ditto.

> +		return ret;
> +	}
> +	ctx->typec.request_voltage = ret * VOLTAGE_UNIT; /* 100mv per unit */
> +
> +	if (ctx->psy_online == ANX7411_PSY_OFFLINE) {
> +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +		power_supply_changed(ctx->psy);
> +	}
> +
> +	if (!ctx->typec.cc_orientation_valid) {
> +		dev_info(dev, "cc orientation is 0(debug cable plug in).\n");

That is just noise.

What does cc_orientation_valid mean here? If it's just indicating is
the connector in accessory mode, then why not name it like that?

> +		return 0;
> +	}
> +
> +	if (ctx->typec.cc_connect == CC1_CONNECTED)
> +		mode = CC1_RP(ctx->typec.cc_status);
> +	else
> +		mode = CC2_RP(ctx->typec.cc_status);
> +	if (mode) {
> +		dev_info(dev, "set power opmode as %d.\n", mode - 1);

More noise.

> +		typec_set_pwr_opmode(ctx->typec.port, mode - 1);
> +		return 0;
> +	}
> +
> +	typec_set_pwr_opmode(ctx->typec.port, TYPEC_PWR_MODE_PD);
> +
> +	return 0;
> +}
> +
> +static int anx7411_register_partner(struct anx7411_data *ctx,
> +				    int pd, int accessory)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	struct typec_partner_desc desc;
> +
> +	if (ctx->typec.partner) {
> +		dev_info(dev, "ignore register typec partner request.\n");

Noise.

> +		return 0;
> +	}
> +
> +	dev_info(dev, "register typec partner port.\n");

Noise.

> +	desc.usb_pd = pd;
> +	desc.accessory = accessory;
> +	desc.identity = NULL;
> +	ctx->typec.partner = typec_register_partner(ctx->typec.port, &desc);
> +	if (IS_ERR(ctx->typec.partner)) {
> +		dev_err(dev, "failed to register partner\n");
> +		ctx->typec.partner = NULL;
> +		return PTR_ERR(ctx->typec.partner);
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_detect_cc_orientation(struct anx7411_data *ctx)
> +{
> +	int ret;
> +	int cc1_rd, cc2_rd;
> +	int cc1_ra, cc2_ra;
> +	int cc1_rp, cc2_rp;
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, CC_STATUS);
> +	if (ret < 0) {
> +		dev_info(dev, "failed to read cc status.\n");

dev_err().

> +		return ret;
> +	}
> +
> +	dev_info(dev, "cc status %.02x\n", ret);

Noise.

> +	ctx->typec.cc_status = ret;
> +
> +	cc1_rd = ret & CC1_RD ? 1 : 0;
> +	cc2_rd = ret & CC2_RD ? 1 : 0;
> +	cc1_ra = ret & CC1_RA ? 1 : 0;
> +	cc2_ra = ret & CC2_RA ? 1 : 0;

Do you need all of those here?

        cc_rd = !!((ret & CC1_RD) || (ret & CC2_RD))
        cc_ra = !!((ret & CC1_RA) || (ret & CC2_RA))

> +	cc1_rp = CC1_RP(ret);
> +	cc2_rp = CC2_RP(ret);
> +
> +	/* Debug cable, nothing to do */
> +	if (cc1_rd && cc2_rd) {
> +		ctx->typec.cc_orientation_valid = 0;
> +		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_DEBUG);
> +		return 0;
> +	}
> +
> +	if (cc1_ra && cc2_ra) {
> +		ctx->typec.cc_orientation_valid = 0;
> +		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_AUDIO);
> +		return 0;
> +	}
> +
> +	ctx->typec.cc_orientation_valid = 1;
> +
> +	anx7411_register_partner(ctx, 1, TYPEC_ACCESSORY_NONE);
> +
> +	if (cc1_rd || cc1_rp) {
> +		dev_info(dev, "set orientation to normal\n");

Noise.

> +		typec_set_orientation(ctx->typec.port,
> +				      TYPEC_ORIENTATION_NORMAL);
> +		ctx->typec.cc_connect = CC1_CONNECTED;
> +	}
> +
> +	if (cc2_rd || cc2_rp) {
> +		dev_info(dev, "set orientation to reverse\n");

Noise.

> +		typec_set_orientation(ctx->typec.port,
> +				      TYPEC_ORIENTATION_REVERSE);
> +		ctx->typec.cc_connect = CC2_CONNECTED;
> +	}
> +
> +	dev_info(dev, "cc1_rp(%d), cc2_rp(%d)", cc1_rp, cc2_rp);
> +	dev_info(dev, "\tcc1_rd(%d), cc2_rd(%d), cc_connected(%d).\n",
> +		 cc1_rd, cc2_rd, ctx->typec.cc_connect);

Noise!

I'll stop commenting on the dev_info() lines. You need to drop
all of them.

> +	return 0;
> +}
> +
> +static int anx7411_set_mux(struct anx7411_data *ctx, int pin_assignment)
> +{
> +	int mode = TYPEC_STATE_SAFE;
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	switch (pin_assignment) {
> +	case SELECT_PIN_ASSIGMENT_U:
> +		/* default 4 line USB 3.1 */
> +		mode = TYPEC_STATE_MODAL;
> +		break;
> +	case SELECT_PIN_ASSIGMENT_C:
> +	case SELECT_PIN_ASSIGMENT_E:
> +		/* 4 line DP */
> +		mode = TYPEC_STATE_SAFE;
> +		break;
> +	case SELECT_PIN_ASSIGMENT_D:
> +		/* 2 line DP, 2 line USB */
> +		mode = TYPEC_MODE_USB3;
> +		break;
> +	default:
> +		mode = TYPEC_STATE_SAFE;
> +		break;
> +	}
> +
> +	ctx->typec.pin_assignment = pin_assignment;
> +
> +	dev_info(dev, "pin assignment %d, mux mode %d.\n",
> +		 pin_assignment, mode);
> +
> +	return typec_set_mode(ctx->typec.port, mode);
> +}
> +
> +static void anx7411_set_usb_role(struct anx7411_data *ctx, enum usb_role role)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	if (!ctx->typec.role_sw) {
> +		dev_info(dev, "no usb role switch");
> +		return;
> +	}
> +
> +	usb_role_switch_set_role(ctx->typec.role_sw, role);
> +}
> +
> +static int anx7411_data_role_detect(struct anx7411_data *ctx)
> +{
> +	int ret;
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
> +	if (ret < 0) {
> +		dev_err(dev, "read system status failed: %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ctx->typec.data_role = (ret & DATA_ROLE) ? TYPEC_HOST : TYPEC_DEVICE;
> +	ctx->typec.vconn_role = (ret & VCONN_STATUS) ? TYPEC_SOURCE : TYPEC_SINK;
> +
> +	typec_set_data_role(ctx->typec.port, ctx->typec.data_role);
> +	typec_set_vconn_role(ctx->typec.port, ctx->typec.vconn_role);
> +
> +	if (ctx->typec.data_role == TYPEC_HOST)
> +		anx7411_set_usb_role(ctx, USB_ROLE_HOST);
> +	else
> +		anx7411_set_usb_role(ctx, USB_ROLE_DEVICE);
> +
> +	dev_info(dev, "data role change, status(0x%.02x), data role(%d)\n",
> +		 ret, ctx->typec.data_role);
> +
> +	return 0;
> +}
> +
> +static int anx7411_power_role_detect(struct anx7411_data *ctx)
> +{
> +	int ret;
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
> +	if (ret < 0) {
> +		dev_err(dev, "read system status failed: %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ctx->typec.power_role = (ret & SINK_STATUS) ? TYPEC_SINK : TYPEC_SOURCE;
> +
> +	if (ctx->typec.power_role == TYPEC_SOURCE) {
> +		ctx->typec.request_current = DEF_1_5A;
> +		ctx->typec.request_voltage = DEF_5V;
> +	}
> +
> +	dev_info(dev, "power role change, status(0x%.02x), power role(%d).\n",
> +		 ret, ctx->typec.power_role);
> +	typec_set_pwr_role(ctx->typec.port, ctx->typec.power_role);
> +
> +	return 0;
> +}
> +
> +static int anx7411_cc_status_detect(struct anx7411_data *ctx)
> +{
> +	anx7411_detect_cc_orientation(ctx);
> +	anx7411_detect_power_mode(ctx);
> +
> +	return 0;
> +}
> +
> +static int anx7411_partner_unregister_altmode(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	int i;
> +
> +	dev_info(dev, "unregister typec altmode.\n");
> +
> +	ctx->typec.dp_altmode_enter = 0;
> +	ctx->typec.cust_altmode_enter = 0;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++)
> +		if (ctx->typec.amode[i]) {
> +			typec_unregister_altmode(ctx->typec.amode[i]);
> +			ctx->typec.amode[i] = NULL;
> +		}
> +
> +	ctx->typec.pin_assignment = 0;
> +	return 0;
> +}
> +
> +static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
> +					  int svid, int vdo)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	struct typec_altmode_desc desc;
> +	int i;
> +
> +	dev_info(dev, "register typec altmode -> vdo = 0x%x.\n", vdo);
> +	desc.svid = svid;
> +	desc.vdo = vdo;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++)
> +		if (!ctx->typec.amode[i])
> +			break;
> +
> +	desc.mode = i + 1; /* start with 1 */
> +
> +	if (i >= MAX_ALTMODE) {
> +		dev_info(dev, "no altmode space for registering\n");
> +		return -ENOMEM;
> +	}
> +
> +	ctx->typec.amode[i] = typec_partner_register_altmode(ctx->typec.partner,
> +							     &desc);
> +	if (IS_ERR(ctx->typec.amode[i])) {
> +		dev_err(dev, "failed to register altmode\n");
> +		ctx->typec.amode[i] = NULL;
> +		return PTR_ERR(ctx->typec.amode);
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_unregister_partner(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	dev_info(dev, "unregister typec partner port.\n");
> +	if (ctx->typec.partner) {
> +		typec_unregister_partner(ctx->typec.partner);
> +		ctx->typec.partner = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_update_altmode(struct anx7411_data *ctx, int svid)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	int i;
> +
> +	dev_info(dev, "update typec altmode to true.\n");
> +
> +	if (svid == DP_SVID)
> +		ctx->typec.dp_altmode_enter = 1;
> +	else
> +		ctx->typec.cust_altmode_enter = 1;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++) {
> +		if (!ctx->typec.amode[i])
> +			continue;
> +
> +		if (ctx->typec.amode[i]->svid == svid) {
> +			typec_altmode_update_active(ctx->typec.amode[i], true);
> +			typec_altmode_notify(ctx->typec.amode[i],
> +					     ctx->typec.pin_assignment,
> +					     &ctx->typec.data);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_register_altmode(struct anx7411_data *ctx,
> +				    bool dp_altmode, u8 *buf)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	int ret;
> +	int svid;
> +	int mid;
> +
> +	if (!ctx->typec.partner) {
> +		dev_info(dev, "partner not register yet, ignore altmode(%d)\n",
> +			 dp_altmode);
> +		return 0;
> +	}
> +
> +	svid = DP_SVID;
> +	if (dp_altmode) {
> +		dev_info(dev, "register DP altmode\n");
> +		mid = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
> +
> +		return anx7411_typec_register_altmode(ctx, svid, mid);
> +	}
> +
> +	svid = (buf[3] << 8) | buf[2];
> +	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_ENTER_MODE)) {
> +		dev_info(dev, "svid(0x%x) enter mode\n", svid);
> +		return anx7411_update_altmode(ctx, svid);
> +	}
> +
> +	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_DIS_MOD)) {
> +		dev_info(dev, "ignore VDM message 0x%.02x%.02x\n",
> +			 buf[0], buf[1]);
> +		return 0;
> +	}
> +
> +	mid = buf[4] | (buf[5] << 8) | (buf[6] << 16) | (buf[7] << 24);
> +
> +	ret = anx7411_typec_register_altmode(ctx, svid, mid);
> +	if (ctx->typec.cust_altmode_enter)
> +		ret |= anx7411_update_altmode(ctx, svid);
> +
> +	return ret;
> +}
> +
> +static int anx7411_parse_cmd(struct anx7411_data *ctx, u8 type, u8 *buf, u8 len)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	u8 cur_50ma, vol_100mv;
> +
> +	dev_info(dev, "received message: type:0x%.02x, len:%d, buf[0]:%d\n",
> +		 type, len, buf[0]);
> +
> +	switch (type) {
> +	case TYPE_SRC_CAP:
> +		cur_50ma = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
> +		vol_100mv = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
> +		dev_info(dev, "get current(%dma), voltage(%dmv), power(%dmw)\n",
> +			 cur_50ma * CURRENT_UNIT, vol_100mv * VOLTAGE_UNIT,
> +			 cur_50ma * vol_100mv * 5);
> +
> +		ctx->typec.request_voltage = vol_100mv * VOLTAGE_UNIT;
> +		ctx->typec.request_current = cur_50ma * CURRENT_UNIT;
> +
> +#ifndef CUST_SINK_CTRL_EN
> +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +		power_supply_changed(ctx->psy);

I can not find that definition anywhere, which means this is dead
block. Please drop this code, and the ifdef with it. Do the same for
the other places where use the definition too.

> +#else
> +		/* Enable OCM automatically control sink_ctrl pin*/
> +		dev_info(dev, "Enable OCM auto control sink_ctrl pin\n");
> +		anx7411_reg_write(ctx->tcpc_client, FW_CTRL_2,
> +				  anx7411_reg_read(ctx->tcpc_client, FW_CTRL_2) &
> +				  ~SINK_CTRL_DIS_FLAG);
> +		if (vol_100mv != REQ_VOL_20V_IN_100MV)
> +			break;
> +
> +		if (cur_50ma != REQ_CUR_2_25A_IN_50MA &&
> +		    cur_50ma != REQ_CUR_3_25A_IN_50MA)
> +			break;
> +
> +		/* Disable OCM automatically control sink_ctrl pin*/
> +		dev_info(dev, "Disable OCM auto control sink_ctrl pin\n");
> +		anx7411_reg_write(ctx->tcpc_client, FW_CTRL_2,
> +				  anx7411_reg_read(ctx->tcpc_client, FW_CTRL_2) |
> +				  SINK_CTRL_DIS_FLAG);
> +
> +		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
> +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
> +		power_supply_changed(ctx->psy);
> +#endif
> +		break;
> +	case TYPE_SNK_CAP:
> +		break;
> +	case TYPE_SVID:
> +		break;
> +	case TYPE_SNK_IDENTITY:
> +		break;
> +	case TYPE_GET_DP_ALT_ENTER:
> +		/* DP alt mode enter success */
> +		if (buf[0])
> +			anx7411_update_altmode(ctx, DP_SVID);
> +		break;
> +	case TYPE_DP_ALT_ENTER:
> +		/* Update DP altmode */
> +		anx7411_update_altmode(ctx, DP_SVID);
> +		break;
> +	case TYPE_OBJ_REQ:
> +		anx7411_detect_power_mode(ctx);
> +		break;
> +	case TYPE_DP_CONFIGURE:
> +		anx7411_set_mux(ctx, buf[1]);
> +		break;
> +	case TYPE_DP_DISCOVER_MODES_INFO:
> +		/* Make sure discover modes valid */
> +		if (buf[0] | buf[1])
> +			/* Register DP Altmode */
> +			anx7411_register_altmode(ctx, 1, buf);
> +		break;
> +	case TYPE_VDM:
> +		/* Register other altmode */
> +		anx7411_register_altmode(ctx, 0, buf);
> +		break;
> +	default:
> +		dev_info(dev, "ignore message(0x%.02x).\n", type);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static u8 checksum(struct device *dev, u8 *buf, u8 len)
> +{
> +	u8 ret;
> +	u8 i;
> +
> +	ret = 0;

        u8 ret = 0;

> +	for (i = 0; i < len; i++)
> +		ret += buf[i];
> +
> +	return ret;
> +}

This looks like some kind of a helper for something (not sure for
what yet). You don't need to pass the device to it since you are not
using it.

> +static int anx7411_read_msg_ctrl_status(struct i2c_client *client)
> +{
> +	return anx7411_reg_read(client, CMD_SEND_BUF);
> +}
> +
> +static int anx7411_wait_msg_empty(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	int ret, val;
> +
> +	ret = readx_poll_timeout(anx7411_read_msg_ctrl_status,
> +				 client, val, (val < 0) || (val == 0),
> +				 2000, 2000 * 150);
> +	if (ret)
> +		dev_info(dev, "msg buffer busy\n");
> +
> +	return ret;
> +}
> +
> +static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	u8 msg[MSG_LEN];
> +	u8 crc;
> +	int ret;
> +
> +	if (size)
> +		memcpy(&msg[MSG_RAWDATA], buf, size);
> +	msg[MSG_TYPE] = type;
> +	msg[MSG_HEADER] = size + 1;
> +
> +	crc = checksum(dev, msg, size + HEADER_LEN);
> +	msg[size + HEADER_LEN] = 0 - crc;

That looks a bit odd...

What is the checksum here? We have build-in crc function in kernel.
Can't you use those?

> +	ret = anx7411_wait_msg_empty(ctx->spi_client);
> +	if (ret) {
> +		dev_info(dev, "firmware busy, ret(0x%.02x)\n", ret);
> +		return ret;
> +	}
> +
> +	anx7411_reg_block_write(ctx->spi_client,
> +				CMD_SEND_BUF + 1, size + HEADER_LEN,
> +				&msg[MSG_TYPE]);
> +	return anx7411_reg_write(ctx->spi_client, CMD_SEND_BUF,
> +				 msg[MSG_HEADER]);
> +}
> +
> +static int anx7411_process_cmd(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	u8 msg[MSG_LEN];
> +	u8 len;
> +	u8 crc;
> +
> +	/* Read message from firmware */
> +	anx7411_reg_block_read(ctx->spi_client, CMD_RECV_BUF, MSG_LEN, msg);
> +	anx7411_reg_write(ctx->spi_client, CMD_RECV_BUF, 0);
> +
> +	if (!msg[MSG_HEADER]) {
> +		dev_info(dev, "message empty\n");
> +		return 0;
> +	}
> +
> +	len = msg[MSG_HEADER] & MSG_LEN_MASK;
> +	crc = checksum(dev, msg, len + HEADER_LEN);
> +	if (crc) {
> +		dev_err(dev, "message error crc(0x%.02x)\n", crc);
> +		return -1;

What does -1 mean here?

> +	}
> +
> +	return anx7411_parse_cmd(ctx, msg[MSG_TYPE],
> +				 &msg[MSG_RAWDATA], len - 1);
> +}
> +
> +static void anx7411_translate_payload(struct device *dev, __le32 *payload,
> +				      u32 *pdo, int nr, const char *type)
> +{
> +	int i;
> +
> +	dev_info(dev, "convert %s pdos to little endian format\n", type);
> +	if (nr > PDO_MAX_OBJECTS) {
> +		dev_err(dev, "nr(%d) exceed PDO_MAX_OBJECTS(%d)\n",
> +			nr, PDO_MAX_OBJECTS);
> +
> +		return;
> +	}
> +
> +	for (i = 0; i < nr; i++)
> +		payload[i] = cpu_to_le32(pdo[i]);
> +}
> +
> +static void anx7411_config(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	struct typec_params *typecp = &ctx->typec;
> +	__le32 payload[PDO_MAX_OBJECTS];
> +
> +	dev_info(dev, "initial anx7411\n");
> +	/* Config PD FW work under PD 2.0 */
> +	anx7411_reg_write(ctx->spi_client, PD_REV_INIT, PD_REV20);
> +	anx7411_reg_write(ctx->tcpc_client, FW_CTRL_0,
> +			  UNSTRUCT_VDM_EN | DELAY_200MS |
> +			  VSAFE1 | FRS_EN);
> +	anx7411_reg_write(ctx->spi_client, FW_CTRL_1,
> +			  AUTO_PD_EN | FORCE_SEND_RDO);
> +
> +	/* Set VBUS current threshold */
> +	anx7411_reg_write(ctx->tcpc_client, VBUS_THRESHOLD_H, 0xff);
> +	anx7411_reg_write(ctx->tcpc_client, VBUS_THRESHOLD_L, 0x03);
> +
> +	/* Fix dongle compatible issue */
> +	anx7411_reg_write(ctx->tcpc_client, FW_PARAM,
> +			  anx7411_reg_read(ctx->tcpc_client, FW_PARAM) |
> +			  DONGLE_IOP);
> +	anx7411_reg_write(ctx->spi_client, INT_MASK, 0);
> +
> +	anx7411_reg_write(ctx->spi_client, PD_EXT_MSG_CTRL, 0xFF);
> +
> +	if (typecp->caps_flags & HAS_SOURCE_CAP) {
> +		anx7411_translate_payload(dev, payload, typecp->src_pdo,
> +					  typecp->src_pdo_nr, "source");
> +		anx7411_send_msg(ctx, TYPE_SRC_CAP, (u8 *)&payload,
> +				 typecp->src_pdo_nr * 4);
> +		anx7411_send_msg(ctx, TYPE_SNK_IDENTITY, snk_identity,
> +				 sizeof(snk_identity));
> +		anx7411_send_msg(ctx, TYPE_SET_SNK_DP_CAP, dp_caps,
> +				 sizeof(dp_caps));
> +	}
> +
> +	if (typecp->caps_flags & HAS_SINK_CAP) {
> +		anx7411_translate_payload(dev, payload, typecp->sink_pdo,
> +					  typecp->sink_pdo_nr, "sink");
> +		anx7411_send_msg(ctx, TYPE_SNK_CAP, (u8 *)&payload,
> +				 typecp->sink_pdo_nr * 4);
> +	}
> +
> +	if (typecp->caps_flags & HAS_SINK_WATT) {
> +		if (typecp->sink_watt) {
> +			anx7411_reg_write(ctx->spi_client, MAX_POWER,
> +					  typecp->sink_watt);
> +			/* Set min power to 1W */
> +			anx7411_reg_write(ctx->spi_client, MIN_POWER, 2);
> +		}
> +
> +		if (typecp->sink_voltage)
> +			anx7411_reg_write(ctx->spi_client, MAX_VOLTAGE,
> +					  typecp->sink_voltage);
> +	}
> +
> +	if (!typecp->caps_flags)
> +		usleep_range(5000, 6000);
> +
> +	ctx->fw_version = anx7411_reg_read(ctx->spi_client, FW_VER);
> +	ctx->fw_subversion = anx7411_reg_read(ctx->spi_client,
> +					      FW_SUBVER);
> +	dev_info(dev, "power on, ocm version %.02x%.02x\n",
> +		 ctx->fw_version, ctx->fw_subversion);
> +}
> +
> +static void anx7411_chip_standby(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->tcpc_client->dev;
> +
> +	dev_info(dev, "Anx7411 enter into standby mode.\n");
> +
> +	anx7411_reg_write(ctx->spi_client, OCM_CTRL_0,
> +			  anx7411_reg_read(ctx->spi_client, OCM_CTRL_0) |
> +			  OCM_RESET);
> +	anx7411_reg_write(ctx->tcpc_client, ANALOG_CTRL_10, 0x80);
> +	/* Set TCPC to RD and DRP enable */
> +	anx7411_reg_write(ctx->tcpc_client, TCPC_ROLE_CONTROL, 0x4A);
> +	/* Send DRP toggle command */
> +	anx7411_reg_write(ctx->tcpc_client, TCPC_COMMAND, 0x99);

So that would be Look4Connection command, no?

> +	/* Send TCPC enter standby command */
> +	anx7411_reg_write(ctx->tcpc_client, TCPC_COMMAND, 0xFF);

And that is the I2C Idle command.

Those commands are already defined in drivers/usb/typec/tcpm/tcpci.h.
I would really prefer that we use the same definitions everywhere. We
probable  should have them in a file include/linux/usb/tcpci.h.

> +}
> +
> +static void anx7411_work_func(struct work_struct *work)
> +{
> +	int ret;
> +	u8 buf[STATUS_LEN];
> +	u8 int_change, int_status, alert0, alert1;

Sorry to be picky here, but it would be easier to read this code if
you introduced each of those registers on its own line. And please try
to use the same style also when introducing the variable in every
function.

> +	struct anx7411_data *ctx = container_of(work,
> +						struct anx7411_data, work);

One line is enough here.

> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	mutex_lock(&ctx->lock);
> +
> +	/* Read interrupt change status */
> +	ret = anx7411_reg_block_read(ctx->spi_client, INT_STS,
> +				     STATUS_LEN, buf);

Ditto.

> +	if (ret < 0) {
> +		/* Power standby mode, just return */
> +		goto unlock;
> +	}
> +	int_change = buf[0];
> +	int_status = buf[1];
> +
> +	/* Read alert register */
> +	ret = anx7411_reg_block_read(ctx->tcpc_client, ALERT_0,
> +				     STATUS_LEN, buf);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read register(%d)\n", ALERT_0);
> +		goto unlock;
> +	}
> +	alert0 = buf[0];
> +	alert1 = buf[1];
> +
> +	/* Clear interrupt and alert status */
> +	anx7411_reg_write(ctx->spi_client, INT_STS, 0);
> +	anx7411_reg_write(ctx->tcpc_client, ALERT_0, alert0);
> +	anx7411_reg_write(ctx->tcpc_client, ALERT_1, alert1);
> +
> +	dev_info(dev, "int_change(0x%.02x), int_status(0x%.02x).\n",
> +		 int_change, int_status);
> +	dev_info(dev, "alert0(0x%.02x), alert1(0x%.02x).\n", alert0, alert1);
> +
> +	if (alert1 & INTP_POW_OFF) {
> +		anx7411_partner_unregister_altmode(ctx);
> +		anx7411_set_usb_role(ctx, USB_ROLE_NONE);
> +		anx7411_unregister_partner(ctx);
> +		ctx->psy_online = ANX7411_PSY_OFFLINE;
> +		ctx->usb_type = POWER_SUPPLY_USB_TYPE_C;
> +		ctx->typec.request_voltage = 0;
> +		ctx->typec.request_current = 0;
> +		power_supply_changed(ctx->psy);
> +		anx7411_chip_standby(ctx);
> +		goto unlock;
> +	}
> +
> +	if ((alert0 & SOFTWARE_INT) && (int_change & OCM_BOOT_UP)) {
> +		anx7411_config(ctx);
> +		anx7411_data_role_detect(ctx);
> +		anx7411_power_role_detect(ctx);
> +		anx7411_set_mux(ctx, SELECT_PIN_ASSIGMENT_C);
> +	}
> +
> +	if (alert0 & RECEIVED_MSG)
> +		anx7411_process_cmd(ctx);
> +
> +	ret = (int_status & DATA_ROLE) ? TYPEC_HOST : TYPEC_DEVICE;
> +	if (ctx->typec.data_role != ret)
> +		anx7411_data_role_detect(ctx);
> +
> +	ret = (int_status & SINK_STATUS) ? TYPEC_SINK : TYPEC_SOURCE;
> +	if (ctx->typec.power_role != ret)
> +		anx7411_power_role_detect(ctx);
> +
> +	if ((alert0 & SOFTWARE_INT) && (int_change & CC_STATUS_CHANGE))
> +		anx7411_cc_status_detect(ctx);
> +
> +unlock:
> +	mutex_unlock(&ctx->lock);
> +}
> +
> +static irqreturn_t anx7411_intr_isr(int irq, void *data)
> +{
> +	struct anx7411_data *ctx = (struct anx7411_data *)data;
> +
> +	queue_work(ctx->workqueue, &ctx->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int anx7411_register_i2c_dummy_clients(struct anx7411_data *ctx,
> +					      struct i2c_client *client)
> +{
> +	int i;
> +	u8 spi_addr;
> +
> +	for (i = 0; i < sizeof(anx7411_i2c_addr); i++) {
> +		if (client->addr == (anx7411_i2c_addr[i].tcpc_address >> 1)) {
> +			spi_addr = anx7411_i2c_addr[i].spi_address >> 1;
> +			ctx->spi_client = i2c_new_dummy_device(client->adapter,
> +							       spi_addr);
> +			if (ctx->spi_client) {
> +				dev_info(&client->dev, "found spi slave\n");
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	dev_err(&client->dev, "unable to get SPI slave\n");
> +	return -ENOMEM;
> +}

To which bus is the device actually attached to, SPI or I2C?

I'm not sure I understand what is going on here?

> +static void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_ALTMODE; i++)
> +		if (adev[i]) {
> +			typec_unregister_altmode(adev[i]);
> +			adev[i] = NULL;
> +		}
> +}
> +
> +static int anx7411_usb_mux_set(struct typec_mux *mux,
> +			       struct typec_mux_state *state)
> +{
> +	struct anx7411_data *ctx = typec_mux_get_drvdata(mux);
> +	struct device *dev = &ctx->spi_client->dev;
> +	int has_dp;
> +
> +	has_dp = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
> +		  state->alt->mode == USB_TYPEC_DP_MODE);
> +	dev_info(dev, "callback: mux set: %d", has_dp);
> +	if (!has_dp) {
> +		dev_info(dev, "dp altmode not register\n");
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_usb_set_orientation(struct typec_switch *sw,
> +				       enum typec_orientation orientation)
> +{
> +	struct anx7411_data *ctx = typec_switch_get_drvdata(sw);
> +	struct device *dev = &ctx->spi_client->dev;
> +
> +	dev_info(dev, "callback: orientation set %d\n", orientation);
> +
> +	return 0;
> +}
> +
> +static int anx7411_register_switch(struct anx7411_data *ctx,
> +				   struct device *dev,
> +				   struct fwnode_handle *fwnode)
> +{
> +	struct typec_switch_desc sw_desc = { };
> +
> +	sw_desc.fwnode = fwnode;
> +	sw_desc.drvdata = ctx;
> +	sw_desc.name = fwnode_get_name(fwnode);
> +	sw_desc.set = anx7411_usb_set_orientation;
> +
> +	ctx->typec.typec_switch = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(ctx->typec.typec_switch)) {
> +		dev_err(dev, "switch register failed\n");
> +		return PTR_ERR(ctx->typec.typec_switch);
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx7411_register_mux(struct anx7411_data *ctx,
> +				struct device *dev,
> +				struct fwnode_handle *fwnode)
> +{
> +	struct typec_mux_desc mux_desc = { };
> +
> +	mux_desc.fwnode = fwnode;
> +	mux_desc.drvdata = ctx;
> +	mux_desc.name = fwnode_get_name(fwnode);
> +	mux_desc.set = anx7411_usb_mux_set;
> +
> +	ctx->typec.typec_mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(ctx->typec.typec_mux)) {
> +		dev_err(dev, "mux register failed\n");
> +		return PTR_ERR(ctx->typec.typec_mux);
> +	}
> +
> +	return 0;
> +}
> +
> +static void anx7411_unregister_mux(struct anx7411_data *ctx)
> +{
> +	if (ctx->typec.typec_mux) {
> +		typec_mux_unregister(ctx->typec.typec_mux);
> +		ctx->typec.typec_mux = NULL;
> +	}
> +}
> +
> +static void anx7411_unregister_switch(struct anx7411_data *ctx)
> +{
> +	if (ctx->typec.typec_switch) {
> +		typec_switch_unregister(ctx->typec.typec_switch);
> +		ctx->typec.typec_switch = NULL;
> +	}
> +}
> +
> +static int anx7411_typec_switch_probe(struct anx7411_data *ctx,
> +				      struct device *dev)
> +{
> +	int ret;
> +	struct device_node *node;
> +
> +	node = of_find_node_by_name(dev->of_node, "orientation_switch");
> +	if (!node) {
> +		dev_info(dev, "no typec switch exist\n");
> +		return 0;
> +	}
> +
> +	dev_info(dev, "register switch\n");
> +	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
> +	if (ret) {
> +		dev_err(dev, "failed register switch");
> +		return ret;
> +	}
> +
> +	node = of_find_node_by_name(dev->of_node, "mode_switch");
> +	if (!node) {
> +		dev_err(dev, "no typec mux exist");
> +		ret = -ENODEV;
> +		goto unregister_switch;
> +	}
> +
> +	dev_info(dev, "register mode switch\n");
> +	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
> +	if (ret) {
> +		dev_err(dev, "failed register mode switch");
> +		ret = -ENODEV;
> +		goto unregister_switch;
> +	}
> +
> +	return 0;
> +
> +unregister_switch:
> +	anx7411_unregister_switch(ctx);
> +
> +	return ret;
> +}
> +
> +static int anx7411_typec_port_probe(struct anx7411_data *ctx,
> +				    struct device *dev)
> +{
> +	struct typec_capability *cap = &ctx->typec.caps;
> +	struct typec_params *typecp = &ctx->typec;
> +	struct fwnode_handle *fwnode;
> +	const char *buf;
> +	int ret, i;
> +
> +	fwnode = device_get_named_child_node(dev, "connector");
> +	if (!fwnode)
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "power-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_port_power_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->type = ret;
> +
> +	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "data-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_port_data_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->data = ret;
> +
> +	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "try-power-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_power_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->prefer_role = ret;
> +
> +	/* Get source pdos */
> +	ret = fwnode_property_count_u32(fwnode, "source-pdos");
> +	if (ret > 0) {
> +		dev_info(dev, "%d source-pdos found\n", ret);
> +		typecp->src_pdo_nr = min(ret, PDO_MAX_OBJECTS);
> +		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> +						     typecp->src_pdo,
> +						     typecp->src_pdo_nr);
> +		if (ret < 0) {
> +			dev_err(dev, "source cap validate failed: %d\n", ret);
> +			return -EINVAL;
> +		}
> +
> +		typecp->caps_flags |= HAS_SOURCE_CAP;
> +	}
> +
> +	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
> +	if (ret > 0) {
> +		dev_info(dev, "%d sink-pdos found\n", ret);
> +		typecp->sink_pdo_nr = min(ret, PDO_MAX_OBJECTS);
> +		ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
> +						     typecp->sink_pdo,
> +						     typecp->sink_pdo_nr);
> +		if (ret < 0) {
> +			dev_err(dev, "sink cap validate failed: %d\n", ret);
> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < typecp->sink_pdo_nr; i++) {
> +			ret = 0;
> +			switch (pdo_type(typecp->sink_pdo[i])) {
> +			case PDO_TYPE_FIXED:
> +				ret = pdo_fixed_voltage(typecp->sink_pdo[i]);
> +				break;
> +			case PDO_TYPE_BATT:
> +			case PDO_TYPE_VAR:
> +				ret = pdo_max_voltage(typecp->sink_pdo[i]);
> +				break;
> +			case PDO_TYPE_APDO:
> +			default:
> +				ret = 0;
> +				break;
> +			}
> +
> +			/* 100mv per unit */
> +			typecp->sink_voltage = max(5000, ret) / 100;
> +		}
> +
> +		typecp->caps_flags |= HAS_SINK_CAP;
> +	}
> +
> +	if (!fwnode_property_read_u32(fwnode, "op-sink-microwatt", &ret)) {
> +		dev_info(dev, "%d sink-microwat found\n", ret);
> +		typecp->sink_watt = ret / 500000; /* 500mw per unit */
> +		typecp->caps_flags |= HAS_SINK_WATT;
> +	}
> +
> +	cap->fwnode = fwnode;
> +
> +	ctx->typec.role_sw = usb_role_switch_get(dev);
> +	if (IS_ERR(ctx->typec.role_sw)) {
> +		dev_err(dev, "USB role switch not found.\n");
> +		ctx->typec.role_sw = NULL;
> +	}
> +
> +	ctx->typec.port = typec_register_port(dev, cap);
> +	if (IS_ERR(ctx->typec.port)) {
> +		ret = PTR_ERR(ctx->typec.port);
> +		ctx->typec.port = NULL;
> +		dev_err(dev, "Failed to register type c port %d\n", ret);
> +		return ret;
> +	}
> +
> +	typec_port_register_altmodes(ctx->typec.port, NULL, ctx,
> +				     ctx->typec.port_amode,
> +				     MAX_ALTMODE);
> +
> +	return 0;
> +}
> +
> +static int anx7411_typec_check_connection(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	int ret;
> +
> +	ret = anx7411_reg_read(ctx->spi_client, FW_VER);
> +	if (ret < 0) {
> +		/* No device attached in typec port */
> +		dev_info(dev, "no connection detect.\n");
> +		return 0;
> +	}
> +
> +	dev_info(dev, "detected typec connected, ocm ver:0x%.02x.\n", ret);
> +	dev_info(dev, "force clear interrupt and alert.\n");
> +	/* Clear interrupt and alert status */
> +	anx7411_reg_write(ctx->spi_client, INT_STS, 0);
> +	anx7411_reg_write(ctx->tcpc_client, ALERT_0, 0xFF);
> +	anx7411_reg_write(ctx->tcpc_client, ALERT_1, 0xFF);
> +
> +	anx7411_cc_status_detect(ctx);
> +
> +	anx7411_power_role_detect(ctx);
> +
> +	dev_info(dev, "PD %s voltage(%d), current(%d).\n",
> +		 ctx->typec.power_role == TYPEC_SOURCE ? "supply" : "request",
> +		 ctx->typec.request_voltage, ctx->typec.request_current);
> +
> +	anx7411_data_role_detect(ctx);
> +
> +	anx7411_set_mux(ctx, SELECT_PIN_ASSIGMENT_C);
> +
> +	anx7411_send_msg(ctx, TYPE_GET_DP_ALT_ENTER, NULL, 0);
> +
> +	anx7411_send_msg(ctx, TYPE_GET_DP_DISCOVER_MODES_INFO, NULL, 0);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused anx7411_runtime_pm_suspend(struct device *dev)
> +{
> +	struct anx7411_data *ctx = dev_get_drvdata(dev);
> +
> +	mutex_lock(&ctx->lock);
> +
> +	anx7411_partner_unregister_altmode(ctx);
> +
> +	if (ctx->typec.partner)
> +		anx7411_unregister_partner(ctx);
> +
> +	mutex_unlock(&ctx->lock);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused anx7411_runtime_pm_resume(struct device *dev)
> +{
> +	struct anx7411_data *ctx = dev_get_drvdata(dev);
> +
> +	mutex_lock(&ctx->lock);
> +	/* Detect PD connection */
> +	anx7411_typec_check_connection(ctx);
> +
> +	mutex_unlock(&ctx->lock);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops anx7411_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(anx7411_runtime_pm_suspend,
> +			   anx7411_runtime_pm_resume, NULL)
> +};
> +
> +static void anx7411_get_gpio_irq(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->tcpc_client->dev;
> +
> +	ctx->intp_gpiod = devm_gpiod_get_optional(dev, "interrupt", GPIOD_IN);
> +	if (!ctx->intp_gpiod) {
> +		dev_info(dev, "no interrupt gpio property\n");
> +		return;
> +	}
> +
> +	ctx->intp_irq = gpiod_to_irq(ctx->intp_gpiod);
> +	dev_info(dev, "request gpio(%d) irq(%d)\n",
> +		 desc_to_gpio(ctx->intp_gpiod), ctx->intp_irq);
> +
> +	if (!ctx->intp_irq)
> +		dev_err(dev, "failed to get GPIO IRQ\n");
> +}
> +
> +static const char *anx7411_psy_name_prefix = "anx7411-source-psy-";
> +
> +static enum power_supply_usb_type anx7411_psy_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_C,
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_PD_PPS,
> +};
> +
> +static enum power_supply_property anx7411_psy_props[] = {
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static int anx7411_psy_set_prop(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct anx7411_data *ctx = power_supply_get_drvdata(psy);
> +	int ret = 0;
> +
> +	if (psp == POWER_SUPPLY_PROP_ONLINE) {
> +		pr_info("[DEBUG] set prop -> %d\n", val->intval);
> +		ctx->psy_online = val->intval;
> +#ifdef CUST_SINK_CTRL_EN
> +		if (ctx->psy_online == ANX7411_PSY_HANG)
> +			anx7411_reg_write(ctx->tcpc_client,
> +					  TCPC_COMMAND,
> +					  SINK_CTRL_DIS);
> +		else if (ctx->psy_online)
> +			anx7411_reg_write(ctx->tcpc_client,
> +					  TCPC_COMMAND,
> +					  SINK_CTRL_EN);
> +#endif
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	power_supply_changed(ctx->psy);
> +	return ret;
> +}
> +
> +static int anx7411_psy_prop_writeable(struct power_supply *psy,
> +				      enum power_supply_property psp)
> +{
> +	return (psp == POWER_SUPPLY_PROP_ONLINE) ? 1 : 0;

        return psp == POWER_SUPPLY_PROP_ONLINE;

> +}
> +
> +static int anx7411_psy_get_prop(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct anx7411_data *ctx = power_supply_get_drvdata(psy);
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval = ctx->usb_type;
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = ctx->psy_online;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		val->intval = (ctx->psy_online) ?
> +			ctx->typec.request_voltage * 1000 : 0;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval = (ctx->psy_online) ?
> +			ctx->typec.request_current * 1000 : 0;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int anx7411_psy_register(struct anx7411_data *ctx)
> +{
> +	struct power_supply_config psy_cfg = {};
> +	const char *port_dev_name = dev_name(ctx->dev);
> +	size_t psy_name_len = strlen(anx7411_psy_name_prefix) +
> +				     strlen(port_dev_name) + 1;
> +	char *psy_name;
> +	struct power_supply_desc *psy_desc = &ctx->psy_desc;
> +
> +	psy_cfg.drv_data = ctx;
> +	psy_cfg.fwnode = dev_fwnode(ctx->dev);
> +	psy_name = devm_kzalloc(ctx->dev, psy_name_len, GFP_KERNEL);
> +	if (!psy_name) {
> +		dev_warn(ctx->dev, "unable to alloc psy memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	snprintf(psy_name, psy_name_len, "%s%s", anx7411_psy_name_prefix,
> +		 port_dev_name);
> +
> +	psy_desc->name = psy_name;
> +	psy_desc->type = POWER_SUPPLY_TYPE_USB;
> +	psy_desc->usb_types = anx7411_psy_usb_types;
> +	psy_desc->num_usb_types = ARRAY_SIZE(anx7411_psy_usb_types);
> +	psy_desc->properties = anx7411_psy_props,
> +	psy_desc->num_properties = ARRAY_SIZE(anx7411_psy_props),
> +
> +	psy_desc->get_property = anx7411_psy_get_prop,
> +	psy_desc->set_property = anx7411_psy_set_prop,
> +	psy_desc->property_is_writeable = anx7411_psy_prop_writeable,
> +
> +	ctx->usb_type = POWER_SUPPLY_USB_TYPE_C;
> +	ctx->psy = devm_power_supply_register(ctx->dev, psy_desc, &psy_cfg);
> +
> +	if (IS_ERR(ctx->psy))
> +		dev_warn(ctx->dev, "unable to register psy\n");
> +
> +	return PTR_ERR_OR_ZERO(ctx->psy);
> +}
> +
> +static int anx7411_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct anx7411_data *plat;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	plat = kzalloc(sizeof(*plat), GFP_KERNEL);
> +	if (!plat)
> +		return -ENOMEM;

Memory leak. I think you wanted to use devm_kzalloc() here, right?

> +	plat->tcpc_client = client;
> +	i2c_set_clientdata(client, plat);
> +
> +	mutex_init(&plat->lock);
> +
> +	ret = anx7411_register_i2c_dummy_clients(plat, client);
> +	if (ret) {
> +		dev_err(dev, "fail to reserve I2C bus\n");
> +		return ret;
> +	}
> +
> +	ret = anx7411_typec_switch_probe(plat, dev);
> +	if (ret) {
> +		dev_err(dev, "fail to probe typec switch\n");
> +		goto free_i2c_dummy;
> +	}
> +
> +	ret = anx7411_typec_port_probe(plat, dev);
> +	if (ret) {
> +		dev_err(dev, "fail to probe typec property.\n");
> +		ret = -ENODEV;
> +		goto free_typec_switch;
> +	}
> +
> +	plat->intp_irq = client->irq;
> +	if (!client->irq) {
> +		dev_info(dev, "no default interrupt IRQ, probe GPIO interrupt");
> +		anx7411_get_gpio_irq(plat);
> +	}
> +
> +	if (!plat->intp_irq) {
> +		dev_err(dev, "fail to get interrupt IRQ\n");
> +		goto free_typec_port;
> +	}
> +
> +	plat->dev = dev;
> +	plat->psy_online = ANX7411_PSY_OFFLINE;
> +	anx7411_psy_register(plat);
> +
> +	if (plat->intp_irq) {
> +		INIT_WORK(&plat->work, anx7411_work_func);
> +		plat->workqueue = alloc_workqueue("anx7411_work",
> +						  WQ_FREEZABLE |
> +						  WQ_MEM_RECLAIM,
> +						  1);
> +		if (!plat->workqueue) {
> +			dev_err(dev, "fail to create work queue\n");
> +			ret = -ENOMEM;
> +			goto free_typec_port;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, plat->intp_irq,
> +						NULL, anx7411_intr_isr,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"anx7411-intp", plat);
> +		if (ret) {
> +			dev_err(dev, "fail to request irq\n");
> +			goto free_wq;
> +		}
> +
> +		dev_info(dev, "registered irq %d handler\n", plat->intp_irq);
> +	}
> +
> +	anx7411_typec_check_connection(plat);
> +
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +
> +free_wq:
> +	destroy_workqueue(plat->workqueue);
> +
> +free_typec_port:
> +	typec_unregister_port(plat->typec.port);
> +	anx7411_port_unregister_altmodes(plat->typec.port_amode);
> +
> +free_typec_switch:
> +	anx7411_unregister_switch(plat);
> +	anx7411_unregister_mux(plat);
> +
> +free_i2c_dummy:
> +	i2c_unregister_device(plat->spi_client);
> +
> +	return ret;
> +}
> +
> +static int anx7411_i2c_remove(struct i2c_client *client)
> +{
> +	struct anx7411_data *plat = i2c_get_clientdata(client);
> +

Empty line.

> +	anx7411_partner_unregister_altmode(plat);
> +	anx7411_unregister_partner(plat);
> +
> +	if (plat->workqueue)
> +		destroy_workqueue(plat->workqueue);
> +
> +	if (plat->spi_client)
> +		i2c_unregister_device(plat->spi_client);
> +
> +	if (plat->typec.role_sw)
> +		usb_role_switch_put(plat->typec.role_sw);
> +
> +	anx7411_unregister_mux(plat);
> +
> +	anx7411_unregister_switch(plat);
> +
> +	if (plat->typec.port)
> +		typec_unregister_port(plat->typec.port);
> +
> +	anx7411_port_unregister_altmodes(plat->typec.port_amode);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id anx7411_id[] = {
> +	{"anx7411", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, anx7411_id);
> +
> +static const struct of_device_id anx_match_table[] = {
> +	{.compatible = "analogix,anx7411",},
> +	{},
> +};
> +
> +static struct i2c_driver anx7411_driver = {
> +	.driver = {
> +		.name = "anx7411",
> +		.of_match_table = anx_match_table,
> +		.pm = &anx7411_pm_ops,
> +	},
> +	.probe = anx7411_i2c_probe,
> +	.remove = anx7411_i2c_remove,
> +
> +	.id_table = anx7411_id,
> +};
> +
> +module_i2c_driver(anx7411_driver);
> +
> +MODULE_DESCRIPTION("Anx7411 USB Type-C PD driver");
> +MODULE_AUTHOR("Xin Ji <xji@analogixsemi.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION("0.1.4");

It seems that there are a few quality issues, and some duplication with
the tcpci.c driver.

thanks,

-- 
heikki
