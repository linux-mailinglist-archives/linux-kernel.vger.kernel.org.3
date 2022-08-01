Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D238586398
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiHAErP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiHAErN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:47:13 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327BA194
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:47:12 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id b81so4988641vkf.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=Lw6ftY/TKlMb6+me9g+W5uZ99+C7bnz14lMwnr8n6c4=;
        b=BivyfpXPh+b5BrckNjDolRmC/G0BCa132qwkYm/uOKn0qBhRgcfnEGfELdMx74doVO
         NWjYAZ+hUT4OSrptv7Nafz/y4Mo7nXoTpKgsOj7YIPXHbXpTbGpdL81j3aIz9UxZVUhq
         OIRZKaW+j4qXI8C7riokWIyOjiC30f2otq93U9ZLTccOpwgqJPfoZ5rr/rgP1Bxu+PYm
         EHvyL4fw31d0BKURn3Ivz/le3NSEcHiGCNPOM+PQUxa8s2egUdPIpamSVu7mrrnEy7mW
         g+Co3xuU+IWGzAQHti29kkt4PYVMe+gvvhl2gjgsPRT2KUJvsFM9zpYDELCeHCbe6PFN
         jvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=Lw6ftY/TKlMb6+me9g+W5uZ99+C7bnz14lMwnr8n6c4=;
        b=16pRMIrAoS9IltdHF6Fd2oMUc62hgfgSav3mHO8ytaPxWbzzdRRnkEtsRTE8ADj4Hd
         MCrDyscQgdJM4irHQl5CPF5NrCX6lCe5Vk5D4zn5gRvdm8I0ulmcgGUjv5aiVDHKgBCb
         teUxLVTEv9/PTKQ2lDA9e8d0OcY/KpkboSGP6jzcRIMzdB9v+l+8ahiGv8awP/x1ab1a
         CdyHTo9dSf7kRjuFH85JVANKRtNACym3AmVD47xVSZzlXP8fCj7BgQHXpgLCfEsUmmOG
         TfXpVO9Grf2p4+E+8ErrB6bjDrQQvUR8tAIsHDWKfhn9FrdvbnNQv5iNnvpgqLZtHoID
         mD2Q==
X-Gm-Message-State: ACgBeo16Gg3klysMFWZbjcAdBttLwBmN82pk++TyI1sW+wnY/gOjN0Qa
        BnqiY3YyCNXUm+joTBYGKxTwJ/XOtObmt13BMDY=
X-Google-Smtp-Source: AA6agR6BBWM7q0N4oPiUYv0EGCG/OK3dmvKCfZPyMNQt8ZobjEPOOwF15DS7dBfG3tpXHcif9HtzVL92A6o+Qt952ak=
X-Received: by 2002:a1f:34d8:0:b0:377:142f:3e2f with SMTP id
 b207-20020a1f34d8000000b00377142f3e2fmr4440588vka.27.1659329231324; Sun, 31
 Jul 2022 21:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220227205608.30812-1-cristian.marussi@arm.com> <20220227205608.30812-15-cristian.marussi@arm.com>
In-Reply-To: <20220227205608.30812-15-cristian.marussi@arm.com>
Sender: getarunks@gmail.com
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Mon, 1 Aug 2022 10:17:00 +0530
X-Google-Sender-Auth: xqremnycBgmRgYu3Ngu8pLSRFS8
Message-ID: <CAKZGPANYh4aS47WH8UBPiTVdE9sOstZD+yZgHkPcUAWX=Gc-dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 14/16] firmware: arm_scmi: Add testing Voltage
 protocol support
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Mon, Feb 28, 2022 at 4:23 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> firmware: arm_scmi: Add testing Voltage protocol support
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../arm_scmi/scmi_test_driver/Makefile        |  2 +-
>  .../arm_scmi/scmi_test_driver/scmi_test.c     |  2 +
>  .../arm_scmi/scmi_test_driver/test_common.h   |  1 +
>  .../arm_scmi/scmi_test_driver/test_voltages.c | 51 +++++++++++++++++++
>  4 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
>
> diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
> index 68a3d94a6a88..3b7df18de250 100644
> --- a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
> +++ b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o test_sensors.o \
> -       test_powers.o
> +       test_powers.o test_voltages.o
>  obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver.o
>
> diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
> index df0d3e572010..2ca9f82c5bf3 100644
> --- a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
> +++ b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
> @@ -26,6 +26,7 @@ int (*scmi_test_init[SCMI_MAX_PROTOCOLS])(struct scmi_test_setup *) = {
>         [SCMI_PROTOCOL_POWER] = scmi_test_power_init,
>         [SCMI_PROTOCOL_CLOCK] = scmi_test_clock_init,
>         [SCMI_PROTOCOL_SENSOR] = scmi_test_sensor_init,
> +       [SCMI_PROTOCOL_VOLTAGE] = scmi_test_voltage_init,
>  };
>
>  static void
> @@ -125,6 +126,7 @@ static int scmi_testing_probe(struct scmi_device *sdev)
>  }
>
>  static const struct scmi_device_id scmi_id_table[] = {
> +       { SCMI_PROTOCOL_VOLTAGE, "__scmi_test-voltage" },
>         { SCMI_PROTOCOL_CLOCK, "__scmi_test-clock" },
>         { SCMI_PROTOCOL_SENSOR, "__scmi_test-sensor" },
>         { SCMI_PROTOCOL_POWER, "__scmi_test-power" },
> diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
> index 9f3d35ba4477..338b65da593f 100644
> --- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
> +++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
> @@ -102,6 +102,7 @@ int scmi_test_release(struct inode *ino, struct file *filp);
>
>  int scmi_test_clock_init(struct scmi_test_setup *tsp);
>  int scmi_test_sensor_init(struct scmi_test_setup *tsp);
> +int scmi_test_voltage_init(struct scmi_test_setup *tsp);
>  int scmi_test_power_init(struct scmi_test_setup *tsp);
>
>  #endif /* __SCMI_TEST_COMMON_H */
> diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
> new file mode 100644
> index 000000000000..ab91080e3a0f
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SCMI Testing Driver - Voltage Protocol
> + *
> + * Copyright (C) 2022 ARM Ltd.
> + */
> +
> +#include <linux/dcache.h>
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include "test_common.h"
> +
> +struct scmi_voltage_data {
> +       unsigned int version;
> +       int count;
> +};
> +
> +int scmi_test_voltage_init(struct scmi_test_setup *tsp)
> +{
> +       struct scmi_voltage_data *vdata;
> +       struct device *dev = &tsp->sdev->dev;
> +       const struct scmi_voltage_proto_ops *voltage_ops;
> +
> +       vdata = devm_kzalloc(dev, sizeof(*vdata), GFP_KERNEL);
> +       if (!vdata)
> +               return -ENOMEM;
> +
> +       voltage_ops = tsp->ops;
> +       vdata->version = voltage_ops->version_get(tsp->ph);
> +       vdata->count = voltage_ops->num_domains_get(tsp->ph);
> +
> +       if (vdata->count <= 0) {
> +               dev_err(dev, "number of voltage doms invalid: %d\n",
> +                       vdata->count);
> +               return vdata->count ?: -EINVAL;
> +       }
> +
> +       dev_info(dev, "Found %d voltage resources.\n", vdata->count);
> +
> +       tsp->priv = vdata;
> +       debugfs_create_x32("version", 0400, tsp->parent, &vdata->version);
Any particular reason, why we are not creating debugfs entires for
regulator level_get/level_set like it was done for
clocks(rate_get_set)?
> +
> +       return 0;
> +}
> --
> 2.17.1
>
