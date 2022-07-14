Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485D5752D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiGNQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbiGNQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:31:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C82C655BB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:31:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ez10so4326244ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p//OL3T6T+iN+FpDjfuUmP5riPz2KYcNknEDuB/63us=;
        b=HF8nglO6RLS42LhMGPwU417dT3o8bFVVjPZzDZcbanY06ClqopKuBKQQU1LZQUhO5S
         NEhS+aWaepXdOK0WvU3br7GmA/8ahc2XqAOmWNJ+LFIbL+RcEv2urYKmBw5ajgqOGkeh
         apYfB5DJYPJq5LTDksliy4vJFF53Ir7RVtrshF8wUK7A1xTELvEProa/y6yELs/e4LY8
         frplHjzR2nOycNk1RBKZBPcLuBQPOnjMfoqY3Tv+yo2z3BpQYuCcDhyl7sYevwjJr30D
         tDtvZwENa5izGVrK9Y4Y5+tbAIjm7w7cgNiSAYiIYQsaLhAPt3qGABGzy2VDl5VFQ4E6
         +uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p//OL3T6T+iN+FpDjfuUmP5riPz2KYcNknEDuB/63us=;
        b=RDLtyWh4SSMNh+RLrh54z/uT7JCs81vz5nXBbXQjjBpcrRdTfRqV6DUUDvxmCH4tLg
         6ChCKLG51V90fbWwX0Mxf2jan28MhQGhySKoKhVl07LlVRu+e7ZCXE+saFcWqOXuQX42
         YBTl0lDpaES7sl+8JO8ZNnkDpp02TzWzKXAWRZiuR+/Di0WMUxcVBCT5FUgERyN12Q0l
         Zq8wPzgO1mHe29VBSFpweBfr3gvNd+41chzONUqkbAFGCcdi4ua8EyOWtOPBcASsEsr6
         KVwnKTqA+yQQdBo92D/QNjtecIUllaD/22D+NxPoRYnRbhCMZHbG4DpKUG14Xn51i7xd
         rd5g==
X-Gm-Message-State: AJIora88slSYk0ct8A5ypqZDG4Lc6KF3xbtx2VgTSnenz4Ry4Y2/0Rpp
        rkVwrnonRTf6b3q+ZCH9WCw6ZIe+NLnpEF0XtoHS3w==
X-Google-Smtp-Source: AGRyM1tslEArlUfNDokY8EHUpH/4NgM51Pos2+EKbdCQr9xr2S3BEu6GusHrPhOhK5hSALoSNQmSxnTrARz8rLDib0A=
X-Received: by 2002:a17:906:9753:b0:722:f1e3:ec27 with SMTP id
 o19-20020a170906975300b00722f1e3ec27mr9415771ejy.355.1657816296819; Thu, 14
 Jul 2022 09:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220714160951.9364-1-pdk@semihalf.com>
In-Reply-To: <20220714160951.9364-1-pdk@semihalf.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 14 Jul 2022 09:31:25 -0700
Message-ID: <CABXOdTck1VSxf8r-NGW_YCvpMdLe7hx=7sGFzQVH9Ok51hfbQg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Update version on
 GET_NEXT_EVENT failure
To:     Patryk Duda <pdk@semihalf.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 9:09 AM Patryk Duda <pdk@semihalf.com> wrote:
>
> Some EC based devices (e.g. Fingerpint MCU) can jump to RO part of the
> firmware (intentionally or due to device reboot). The RO part doesn't
> change during the device lifecycle, so it won't support newer version
> of EC_CMD_GET_NEXT_EVENT command.
>
> Function cros_ec_query_all() is responsible for finding maximum
> supported MKBP event version. It's usually called when the device is
> running RW part of the firmware, so the command version can be
> potentially higher than version supported by the RO.
>
> The problem was fixed by updating maximum supported version when the
> device returns EC_RES_INVALID_VERSION (mapped to -ENOPROTOOPT). That way
> the kernel will use highest common version supported by RO and RW.
>
> Fixes: 3300fdd630d4 ("platform/chrome: cros_ec: handle MKBP more events flag")
> Cc: <stable@vger.kernel.org> # 5.10+
> Signed-off-by: Patryk Duda <pdk@semihalf.com>

Nice catch. That may explain some hung task issues. observed in
EC_CMD_GET_NEXT_EVENT handling

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> When Fingerprint MCU is rebooted (e.g. as a part of tests) it jumps to
> the RO image and performs RW image signature check. If kernel calls
> EC_CMD_GET_NEXT_EVENT FPMCU RO will respond with EC_RES_INVALID_VERSION
> because it's older than RW and supports up to version 1 of the command.
> As a result kernel keeps trying to get MKBP events and effectively
> blocks FPMCU from jumping to RW image.
>
> Before patch 3300fdd630d4 the driver called version 1 of the command.
> If the device responded with EC_RES_INVALID_VERSION, the driver would
> use version 0 of the command.
>
> Best regards,
> Patryk
>
>  drivers/platform/chrome/cros_ec_proto.c | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index ff767dccdf0f6..0a131045d50a9 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -750,6 +750,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
>         u8 event_type;
>         u32 host_event;
>         int ret;
> +       u32 ver_mask = 0;
>
>         /*
>          * Default value for wake_event.
> @@ -771,6 +772,37 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
>                 return get_keyboard_state_event(ec_dev);
>
>         ret = get_next_event(ec_dev);
> +       /*
> +        * -ENOPROTOOPT is returned when EC returns EC_RES_INVALID_VERSION.
> +        * This can occur when EC based device (e.g. Fingerprint MCU) jumps to
> +        * the RO image which doesn't support newer version of the command. In
> +        * this case we will attempt to update maximum supported version of the
> +        * EC_CMD_GET_NEXT_EVENT.
> +        */
> +       if (ret == -ENOPROTOOPT) {
> +               dev_dbg(ec_dev->dev,
> +                       "GET_NEXT_EVENT returned invalid version error.\n");
> +               ret = cros_ec_get_host_command_version_mask(ec_dev,
> +                                                       EC_CMD_GET_NEXT_EVENT,
> +                                                       &ver_mask);
> +               if (ret < 0 || ver_mask == 0)
> +                       /*
> +                        * Do not change the MKBP supported version if we can't
> +                        * obtain supported version correctly. Please note that
> +                        * calling EC_CMD_GET_NEXT_EVENT returned
> +                        * EC_RES_INVALID_VERSION which means that the command
> +                        * is present.
> +                        */
> +                       return -ENOPROTOOPT;
> +
> +               ec_dev->mkbp_event_supported = fls(ver_mask);
> +               dev_dbg(ec_dev->dev, "MKBP support version changed to %u\n",
> +                       ec_dev->mkbp_event_supported - 1);
> +
> +               /* Try to get next event with new MKBP support version set. */
> +               ret = get_next_event(ec_dev);
> +       }
> +
>         if (ret <= 0)
>                 return ret;
>
> --
> 2.31.0
>
