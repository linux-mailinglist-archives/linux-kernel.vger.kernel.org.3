Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C78588ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiHCK6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHCK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:58:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68F1A82B;
        Wed,  3 Aug 2022 03:58:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i14so12025627ejg.6;
        Wed, 03 Aug 2022 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1FIOHOmLG3ZAOn9JnnVVb/4WhmWslDALaYP6wwRvqo=;
        b=fqt8XPiSqidHdR+5+8rGKYuggGtr7ulGWqMK4Vn9jS73p+H5p4TOy9A9dz1MkmisKs
         QLTHZVDs5V3EzUAnRMTo5R6Vc90KdvkUC/Xzgesfvj0I7r+CDr+WsvHuUAh48Cq4VLHT
         hvXu6H6R+JEmVftc8kpcRKgB3xVBZ+d0IR1FODtnXMzz6HU8gvssntYt6M/c731aOP7/
         5KW7tNSFoFvUOblAKlQDz2oW6yqEELDFJlbR8GSrvU+9Fls5buAxYxCpMUvAGgOHjd3G
         Vet694tKXS8QgplcIlH+Y4dOhHkMyOw1O884X1hFFv2SLGAjjlFHmDsv8huPIk+p8FEU
         4+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1FIOHOmLG3ZAOn9JnnVVb/4WhmWslDALaYP6wwRvqo=;
        b=opBoLN2mtp62F43trDcoI+Fjqp97IfAUX4FoW0TiziXx4ttuIptRaH6KQ5uzMzJm+3
         nwoz85mIxparU2JpmUK+XgOKumECafirNjaDIZQrKvbS0jRTMutsfTAP+o5La+4CoGY2
         HcfEh+Fm3s2uwGb+9MeluPnFpzZ2Q5ZTWoihA9oaNPqq69D/N1ELj+fql9NsOXh982Az
         7sqitExHdUpoASZ5Gf/4x1lj19/sA9vIuOW31Yi6Qr80V7KAtsJz1JiApYvRfXUlaEj6
         RJDy7xMHtFYOiB/u/9qyYo0aaXt/Nvfezke9TIM5s64v2MvCLxkSBq59teWbTPToVVkT
         i3Xg==
X-Gm-Message-State: ACgBeo1bse5fIznR0n3+ZfV8Vm9liyn9/4oZBGmMoZqoSpRaUvoXXgvU
        2Y63PsGMzbctNWQ5nUO1O5+QVk6eED5ljesmRaFcVfxb3m8=
X-Google-Smtp-Source: AA6agR7H8JWRm5hObSDAE2iorsDN1qcSEerzGKlicv5cXzq9Cdv1Ij/V5v273OdQDFTkXBcthaLXVI/vAUgmKvTY1gw=
X-Received: by 2002:a17:907:c0e:b0:730:79ec:73a1 with SMTP id
 ga14-20020a1709070c0e00b0073079ec73a1mr12374767ejc.283.1659524300529; Wed, 03
 Aug 2022 03:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220803090218.1313187-1-kkamagui@gmail.com>
In-Reply-To: <20220803090218.1313187-1-kkamagui@gmail.com>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Wed, 3 Aug 2022 12:59:08 +0200
Message-ID: <CAGRyCJHX1X238TkiTaML3WJ+rdc1-m82_d3Ut4jCVDmuQ=cMOQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: cdc_mbim: adding Microsoft mobile broadband modem
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Oliver Neukum <oliver@neukum.org>,
        David Miller <davem@davemloft.net>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Seunghun,

Il giorno mer 3 ago 2022 alle ore 11:10 Seunghun Han
<kkamagui@gmail.com> ha scritto:
>
> Microsoft branded mobile broadband modems typically used in the Surface series
> don't work with the Linux kernel. When I query firmware information to the
> modem using the mbimcli tool, it always returns the Failure (0x02) value like
> below.
>
> === Start of the firmware id query ===
> $> mbimcli -d /dev/cdc-wdm4 --ms-query-firmware-id -v
> [26  Jul 2022, 05:24:07] [Debug] opening device...
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Queried max control message size: 4096
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Sent message...
> <<<<<< RAW:
> <<<<<<   length = 16
> <<<<<<   data   = 01:00:00:00:10:00:00:00:01:00:00:00:00:10:00:00
>
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Sent message (translated)...
> <<<<<< Header:
> <<<<<<   length      = 16
> <<<<<<   type        = open (0x00000001)
> <<<<<<   transaction = 1
> <<<<<< Contents:
> <<<<<<   max control transfer = 4096
>
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Received message...
> >>>>>> RAW:
> >>>>>>   length = 16
> >>>>>>   data   = 01:00:00:80:10:00:00:00:01:00:00:00:02:00:00:00
>
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Received message...Message Type 80000001
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 864
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 897
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 923
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 930
> [26  Jul 2022, 05:24:07] [Debug] [/dev/cdc-wdm4] Processing process_message 935
> [26  Jul 2022, 05:24:07] [Debug] getting open done result failed: closed
> error: couldn't open the MbimDevice: Failure
> === End of the firmware id query ===
>
> After kernel debugging, I found that the modem reported that the dwNtbInMaxSize
> value of ncm_parm was 16384 during the initialization sequence.
> So the cdc_ncm_update_rxtx_max() in cdc_ncm_bind_common() didn't send
> USB_CDC_SET_NTB_INPUT_SIZE command because the default input size was the same,
> 16384.
>
> It's good and proper behavior. However, Microsoft branded MBMs (including the
> latest one in Surface Go 3) fail until the kernel explicitly sets the input
> size.
>
> This patch adds a new table and code changes that explicitly send
> the USB_CDC_SET_NTB_INPUT_SIZE command to support Microsoft branded MBMs.
>

Just for reference, are you allowed to disclose which chipsets these
modems are based on?

Thanks,
Daniele

> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> ---
>  drivers/net/usb/cdc_mbim.c  | 24 ++++++++++++++++++++++++
>  drivers/net/usb/cdc_ncm.c   |  2 +-
>  include/linux/usb/cdc_ncm.h |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
> index c89639381eca..c0c23cfc02a7 100644
> --- a/drivers/net/usb/cdc_mbim.c
> +++ b/drivers/net/usb/cdc_mbim.c
> @@ -618,6 +618,22 @@ static const struct driver_info cdc_mbim_info_avoid_altsetting_toggle = {
>         .data = CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE,
>  };
>
> +/* Microsoft branded modems do not work properly without setting the input size
> + * explicitly in cdc_ncm_bind_common.
> + * CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY flag is used to set the input size
> + * during initialization.
> + */
> +static const struct driver_info cdc_mbim_info_set_input_size_explicitly = {
> +       .description = "CDC MBIM",
> +       .flags = FLAG_NO_SETINT | FLAG_MULTI_PACKET | FLAG_WWAN | FLAG_SEND_ZLP,
> +       .bind = cdc_mbim_bind,
> +       .unbind = cdc_mbim_unbind,
> +       .manage_power = cdc_mbim_manage_power,
> +       .rx_fixup = cdc_mbim_rx_fixup,
> +       .tx_fixup = cdc_mbim_tx_fixup,
> +       .data = CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY,
> +};
> +
>  static const struct usb_device_id mbim_devs[] = {
>         /* This duplicate NCM entry is intentional. MBIM devices can
>          * be disguised as NCM by default, and this is necessary to
> @@ -665,6 +681,14 @@ static const struct usb_device_id mbim_devs[] = {
>           .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
>         },
>
> +       /* Some Microsoft branded mobile broadband modems used in the Surface
> +        * seires are known to fail unless the input size is set explicitly.
> +        * Applying it to all Microsoft branded MBMs.
> +        */
> +       { USB_VENDOR_AND_INTERFACE_INFO(0x045e, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
> +         .driver_info = (unsigned long)&cdc_mbim_info_set_input_size_explicitly,
> +       },
> +
>         /* default entry */
>         { USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
>           .driver_info = (unsigned long)&cdc_mbim_info_zlp,
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 8d5cbda33f66..915e29c987cb 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -407,7 +407,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
>         val = cdc_ncm_check_rx_max(dev, new_rx);
>
>         /* inform device about NTB input size changes */
> -       if (val != ctx->rx_max) {
> +       if (val != ctx->rx_max || ctx->drvflags & CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY) {
>                 __le32 dwNtbInMaxSize = cpu_to_le32(val);
>
>                 dev_info(&dev->intf->dev, "setting rx_max = %u\n", val);
> diff --git a/include/linux/usb/cdc_ncm.h b/include/linux/usb/cdc_ncm.h
> index 2d207cb4837d..a24f84b31a54 100644
> --- a/include/linux/usb/cdc_ncm.h
> +++ b/include/linux/usb/cdc_ncm.h
> @@ -88,6 +88,7 @@
>  #define CDC_NCM_FLAG_NDP_TO_END                        0x02    /* NDP is placed at end of frame */
>  #define CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE  0x04    /* Avoid altsetting toggle during init */
>  #define CDC_NCM_FLAG_PREFER_NTB32 0x08 /* prefer NDP32 over NDP16 */
> +#define CDC_MBIM_FLAG_SET_INPUT_SIZE_EXPLICITLY        0x10    /* Set input size explicitly during init */
>
>  #define cdc_ncm_comm_intf_is_mbim(x)  ((x)->desc.bInterfaceSubClass == USB_CDC_SUBCLASS_MBIM && \
>                                        (x)->desc.bInterfaceProtocol == USB_CDC_PROTO_NONE)
> --
> 2.30.2
>
