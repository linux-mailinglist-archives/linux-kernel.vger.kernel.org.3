Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7394F16B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358530AbiDDOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbiDDOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:06:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F914020;
        Mon,  4 Apr 2022 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649081056; x=1680617056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IaLjVCjn5OCwpTld4VqPhcL+KM4VHWB3lKaf3AttWrs=;
  b=M7MszzmEz+o3j8imtTXSYsClGfxDw/3rnolH1ZxA/IwnWx8LDKiVHpFT
   atawTdbIazPCvlSiF8329OVbFcNlak9An8CMTnBbU1wOtuYYArmjClujd
   DcDqDbJE5ZKAVdhJ0GuZOu0sGJixZIiv66ArcVwRIFsqX6reVzHFdfOBB
   GQD+qT4QV1zxYSQZL6rodEdlUTsciHxgMcLHyyhLdy5GjL9fBWxuyh72Q
   IgTCycnXF9ckNR/mFt95WhzBE28KMVPvyo6eg9yHlBgWkbJMC6tPwl0nK
   sYcd36iNJmKYEa+nFeINQiT4kBv7M4dsvL1UBRzGycIxGNTlQj75zDVaJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="285469767"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="285469767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 07:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696577924"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 07:03:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 17:03:51 +0300
Date:   Mon, 4 Apr 2022 17:03:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH 6/7] usb: typec: tipd: Add debugfs entries for customer
 use word
Message-ID: <Ykr6x/YwAwg/KUma@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-7-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317154518.4082046-7-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:45:17PM +0100, Sebastian Krzyszkowiak wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> This allows to verify that a sane firmware is on the device.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 65 +++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 874528b02a99..d3c70aaf1a0c 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -6,6 +6,7 @@
>   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> @@ -22,6 +23,7 @@
>  /* Register offsets */
>  #define TPS_REG_VID			0x00
>  #define TPS_REG_MODE			0x03
> +#define TPS_REG_CUSTOMER_USE		0x06
>  #define TPS_REG_CMD1			0x08
>  #define TPS_REG_DATA1			0x09
>  #define TPS_REG_INT_EVENT1		0x14
> @@ -99,10 +101,15 @@ struct tps6598x {
>  	struct power_supply *psy;
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
> +
>  	struct tps6598x_pdo terms;
>  
>  	u32 data_status;
>  	u16 pwr_status;
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dev_dentry;
> +	struct dentry *customer_user_dentry;
> +#endif
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -239,6 +246,62 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
>  	typec_set_data_role(tps->port, role);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +static struct dentry *rootdir;
> +
> +static int tps6598x_debug_customer_use_show(struct seq_file *s, void *v)
> +{
> +	struct tps6598x *tps = (struct tps6598x *)s->private;
> +	u64 mode64;
> +	int ret;
> +
> +	mutex_lock(&tps->lock);
> +
> +	ret =  tps6598x_block_read(tps, TPS_REG_CUSTOMER_USE, &mode64, sizeof(mode64));
> +	if (!ret)
> +		seq_printf(s, "0x%016llx\n", mode64);
> +
> +	mutex_unlock(&tps->lock);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(tps6598x_debug_customer_use);
> +
> +static void tps6598x_debugfs_init(struct tps6598x *tps)
> +{
> +	struct dentry *dentry;
> +
> +	if (!rootdir)
> +		rootdir = debugfs_create_dir("tps6598x", NULL);
> +
> +	dentry = debugfs_create_dir(dev_name(tps->dev), rootdir);
> +	if (IS_ERR(dentry))
> +		return;
> +	tps->dev_dentry = dentry;
> +
> +	dentry = debugfs_create_file("customer_use",
> +				     S_IFREG | 0444, tps->dev_dentry,
> +				     tps, &tps6598x_debug_customer_use_fops);
> +	if (IS_ERR(dentry))
> +		return;
> +	tps->customer_user_dentry = dentry;
> +}
> +
> +static void tps6598x_debugfs_exit(struct tps6598x *tps)
> +{
> +	debugfs_remove(tps->customer_user_dentry);
> +	debugfs_remove(tps->dev_dentry);
> +	debugfs_remove(rootdir);
> +	rootdir = NULL;
> +}
> +
> +#else
> +
> +static void tps6598x_debugfs_init(const struct tps6598x *tps) { }
> +static void tps6598x_debugfs_exit(const struct tps6598x *tps) { }
> +
> +#endif
> +
>  static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  {
>  	struct typec_partner_desc desc;
> @@ -995,6 +1058,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	}
>  
>  	i2c_set_clientdata(client, tps);
> +	tps6598x_debugfs_init(tps);
>  
>  	return 0;
>  
> @@ -1011,6 +1075,7 @@ static int tps6598x_remove(struct i2c_client *client)
>  {
>  	struct tps6598x *tps = i2c_get_clientdata(client);
>  
> +	tps6598x_debugfs_exit(tps);
>  	tps6598x_disconnect(tps, 0);
>  	typec_unregister_port(tps->port);
>  	usb_role_switch_put(tps->role_sw);
> -- 
> 2.35.1

-- 
heikki
