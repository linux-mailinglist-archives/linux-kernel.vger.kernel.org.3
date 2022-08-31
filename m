Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8B5A7A78
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiHaJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHaJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1E2AD6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661939134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BjM4xyG7daZbpirGRwI132T1gBQB1USV7BeddXIUmE=;
        b=Th1p32tgRqC4uvxI+JHW28A3rSfA2Yyvcesw6+8JjmPzu9xQSufMKEhbob5vTW0GOc7WKa
        2WpWb5vf16CuSYtKTPIsrqyCZXcqzMtvsvb4v5Ad8SNuR5ycOBY56wWw7lWdS+8eEmt+wO
        3RCi05M01bE5YOIbjiFa5Ogjp5Yxnis=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-282-zOc6HV62MyCaHKCgdOUBYw-1; Wed, 31 Aug 2022 05:45:33 -0400
X-MC-Unique: zOc6HV62MyCaHKCgdOUBYw-1
Received: by mail-pl1-f200.google.com with SMTP id y9-20020a17090322c900b00174c881abaeso5375093plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8BjM4xyG7daZbpirGRwI132T1gBQB1USV7BeddXIUmE=;
        b=6W2xSk+FdjDz349Dt109QSS2f1aqLX9kMIVY7l7Xf4M9KD+7us96/Q0zIwdo5cNo0p
         Psusfcb3cOSCDZHjXaPOkZKrj3SUmnKwoCbI7Q9LeXijNiapeJaGReWRxUNo2OAfNuZ9
         kE9IgMSAi+lxR56QOTZLr5iryMTweqJ4d9E0uFczotbjM4VN5eXUmU7w9rxwNKUJ2YVk
         ltxQdm612oq7cot69YNgNjylCShnKaOGnubzMuaXqRrYUX9O1kcLweoHHijp37bbRDtZ
         j90rEWl4LTaazKvZTEkZSkS2beygQX/ZVTCeYZI3Q1Alo9y///ReSSsWpgStgWidws2u
         ABmw==
X-Gm-Message-State: ACgBeo0C3iwhRm5fEeHdf9Bv7bFg13YRtaJe6v39kRvaWLLbH4d7GQQE
        Pa/p+TdNdWNpiZytlNEtviG68KmaKMfgXdh2XApuQ0HmmCYkZHk++FQ2q0DLLYA6ybcg0tJIGxo
        PQor7LGDO1bi8nNugd8Tt/RRGQjVlWvgkje8ZKXTk
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id a10-20020a170902b58a00b0016ef91a486bmr25758677pls.119.1661939132192;
        Wed, 31 Aug 2022 02:45:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Yf4UonZlDiwXiKSwiH7oHW50Hs8/7xeQinhuJVNyS2dgutR/5NTCCg8Qc67SCEG/SaafmVqdUwxnkMcCZVco=
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id
 a10-20020a170902b58a00b0016ef91a486bmr25758660pls.119.1661939131904; Wed, 31
 Aug 2022 02:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220830195055.1812192-1-marcus.folkesson@gmail.com> <20220830195055.1812192-2-marcus.folkesson@gmail.com>
In-Reply-To: <20220830195055.1812192-2-marcus.folkesson@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 31 Aug 2022 11:45:21 +0200
Message-ID: <CAO-hwJ+34yUM0nkp8HPnubf8-aHX7RXWt=m5u2qFgXByGg0+Ng@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: Add driver for VRC-2 Car Controller
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 9:46 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> VRC-2 is 2-axis controller often used in car simulators.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  MAINTAINERS            |   6 +++
>  drivers/hid/Kconfig    |   9 ++++
>  drivers/hid/Makefile   |   1 +
>  drivers/hid/hid-vrc2.c | 100 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 drivers/hid/hid-vrc2.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 216b9f021f72..33010f93c993 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8919,6 +8919,12 @@ F:       drivers/hid/hid-sensor-*
>  F:     drivers/iio/*/hid-*
>  F:     include/linux/hid-sensor-*
>
> +HID VRC-2 CAR CONTROLLER DRIVER
> +M:     Marcus Folkesson <marcus.folkesson@gmail.com>
> +L:     linux-input@vger.kernel.org
> +S:     Maintained
> +F:     drivers/hid/hid-vrc2.c
> +
>  HID WACOM DRIVER
>  M:     Ping Cheng <ping.cheng@wacom.com>
>  M:     Jason Gerecke  <jason.gerecke@wacom.com>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index d8313d36086c..518e0a5a7852 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -481,6 +481,15 @@ config HID_VIEWSONIC
>         help
>           Support for ViewSonic/Signotec PD1011 signature pad.
>
> +config HID_VRC2
> +       tristate "VRC-2 Car Controller"
> +       depends on HID
> +       help
> +        Support for VRC-2 2-axis Car Controller

maybe "Support for VRC-2 which is a 2-axis controller often used in
car simulators." to be a little bit more explicit.

> +
> +        To compile this driver as a module, choose M here: the
> +        module will be called hid-vrc2.
> +
>  config HID_XIAOMI
>         tristate "Xiaomi"
>         depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 85d50ab352ee..32ab85b1a776 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -137,6 +137,7 @@ obj-$(CONFIG_HID_XINMO)             += hid-xinmo.o
>  obj-$(CONFIG_HID_ZEROPLUS)     += hid-zpff.o
>  obj-$(CONFIG_HID_ZYDACRON)     += hid-zydacron.o
>  obj-$(CONFIG_HID_VIEWSONIC)    += hid-viewsonic.o
> +obj-$(CONFIG_HID_VRC2)         += hid-vrc2.o
>
>  wacom-objs                     := wacom_wac.o wacom_sys.o
>  obj-$(CONFIG_HID_WACOM)                += wacom.o
> diff --git a/drivers/hid/hid-vrc2.c b/drivers/hid/hid-vrc2.c
> new file mode 100644
> index 000000000000..43c98607b837
> --- /dev/null
> +++ b/drivers/hid/hid-vrc2.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * HID driver for VRC-2 2-axis Car controller
> + *
> + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +/*
> + * VID/PID are probably "borrowed", so keep them locally and
> + * do not populate hid-ids.h with those.
> + */
> +#define USB_VENDOR_ID_VRC2     (0x07c0)
> +#define USB_DEVICE_ID_VRC2     (0x1125)
> +
> +static __u8 vrc2_rdesc_fixed[] = {
> +       0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
> +       0x09, 0x04,        // Usage (Joystick)
> +       0xA1, 0x01,        // Collection (Application)
> +       0x09, 0x01,        //   Usage (Pointer)
> +       0xA1, 0x00,        //   Collection (Physical)
> +       0x09, 0x30,        //     Usage (X)
> +       0x09, 0x31,        //     Usage (Y)
> +       0x15, 0x00,        //     Logical Minimum (0)
> +       0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
> +       0x35, 0x00,        //     Physical Minimum (0)
> +       0x46, 0xFF, 0x00,  //     Physical Maximum (255)
> +       0x75, 0x10,        //     Report Size (16)
> +       0x95, 0x02,        //     Report Count (2)
> +       0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
> +       0xC0,              //   End Collection
> +       0x75, 0x08,        //   Report Size (8)
> +       0x95, 0x03,        //   Report Count (3)
> +       0x81, 0x03,        //   Input (Cnst,Var,Abs)
> +       0xC0,              // End Collection
> +};
> +
> +static __u8 *vrc2_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +                               unsigned int *rsize)
> +{
> +       if (*rsize == 23)
> +               return rdesc;

This test is not required. probe() returned -ENODEV for this
interface, so we are sure we have the correct one when we are there.

> +
> +       hid_info(hdev, "fixing up VRC-2 report descriptor\n");
> +       *rsize = sizeof(vrc2_rdesc_fixed);
> +       return vrc2_rdesc_fixed;
> +}
> +
> +static int vrc2_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +       int ret;
> +
> +       /*
> +        * The device gives us 2 separate USB endpoints.
> +        * One of those (the one with report descriptor size of 23) is just bogus so ignore it
> +        */
> +       if (hdev->dev_rsize == 23)
> +               return -ENODEV;
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "parse failed\n");
> +               return ret;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "hw start failed\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void vrc2_remove(struct hid_device *hdev)
> +{
> +       hid_hw_stop(hdev);
> +}

I am pretty sure you can remove that vrc2_remove(), hid-core should be
able to call hid_hw_stop() for you.

> +
> +static const struct hid_device_id vrc2_devices[] = {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_VRC2, USB_DEVICE_ID_VRC2) },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(hid, vrc2_devices);
> +
> +static struct hid_driver vrc2_driver = {
> +       .name = "vrc2",
> +       .id_table = vrc2_devices,
> +       .report_fixup = vrc2_report_fixup,
> +       .probe = vrc2_probe,
> +       .remove = vrc2_remove,
> +};
> +module_hid_driver(vrc2_driver);
> +
> +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> +MODULE_DESCRIPTION("HID driver for VRC-2 2-axis Car controller");
> +MODULE_LICENSE("GPL");
> --
> 2.37.1
>

Cheers,
Benjamin

