Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF814DABE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354229AbiCPHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344568AbiCPHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:40:44 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66D60A8A;
        Wed, 16 Mar 2022 00:39:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l2so2868744ybe.8;
        Wed, 16 Mar 2022 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=swtTTbB0/7kDb8ObR/4u+rhxApKEqsoQzZfjkFe/2yw=;
        b=IFzOPYesNDI8IpfStramA+lqrEuYAiDx5VbbrOiCN+cLiV+96W3WC5867wf4E84JBZ
         nthUlmDCCGJWZKrm/apHJGw2Wz/mKFt31tNKTOtf3N4feYLkvCD16KFgnNWUeqsPL+Ql
         7Ye3ouZURRDBkTOU/hCax98L5kOsxSBY5P+Ylb3V20V/TYXaSgEkg6FeKO7EifrGkFRi
         EpnN1i7l6xWGpleJpcecqjzQp2yV481WgVSUNAb+ztbvBanoSUQ3tI2dYQkD6kxqZMa0
         xSba992dWBK4y+G1p+HMjdipywPMx8AAaM8fSKC3VZUZnf38T7iqdgWroCVTRSto4YTo
         pskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=swtTTbB0/7kDb8ObR/4u+rhxApKEqsoQzZfjkFe/2yw=;
        b=keQqlC43NhbrJi1hht3+0ThrboNR0M0YIFTVg8NBHoyWIXS76HB3AwYV0zoDyUeJl3
         9jNqGlyEI1TlGQeRYIQUa+HEG0pQj2+PAQ7kiD6+nFUuEpBEXGcKUCR8yRTdr078qhUC
         3Ez+DBdtFYTJ6mR4Rd0CCz5hCBkCtsnyGtmNTZrMZP7NmWsZx5Hm3VZizpqUMV7XBagR
         x9ni+k9SCWVs89TUDMwDR1bkCvcMPs8Lzy71aDL8pGQN2kkBmdkvNOV/NPqj5bko5qVi
         5tjCrCF2nWFL5sc2lAAAQxxE7ik5hR7DIz7iZNnv+HMtySv46HWxSGdMQX7xKQu1z784
         g4Zw==
X-Gm-Message-State: AOAM53256LIJ+DphS7Vki5JHkR0qkUX2GvPRV4oSx1TS8hEXJQTdTwFf
        bEn7nsNEr0UE+6z9nDlQImmVppk+3cgKzgitmr9twFmAZl+HZHGd
X-Google-Smtp-Source: ABdhPJy8oqY4tE9p/N4UpFjHe3zrTDZYZ2rFzS7OhGQ6cQJOdQxLpcuk9wkRcPFbe7uLntThDwRM4MdCybfytNNvhF0=
X-Received: by 2002:a05:6902:20b:b0:628:61fa:520c with SMTP id
 j11-20020a056902020b00b0062861fa520cmr27108609ybs.408.1647416370463; Wed, 16
 Mar 2022 00:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647373009.git.vilhelm.gray@gmail.com> <3917721e792d362ee108b2f12cd2223675449d05.1647373009.git.vilhelm.gray@gmail.com>
In-Reply-To: <3917721e792d362ee108b2f12cd2223675449d05.1647373009.git.vilhelm.gray@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Wed, 16 Mar 2022 13:09:18 +0530
Message-ID: <CACG_h5pDbAi1M=8A9b5z6xiOX+UV8aW5NXdYW+=N-KaBg4PUaQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/6] counter: 104-quad-8: Add COMPILE_TEST depends
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 1:09 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> 104_QUAD_8 depends on X86, but compiles fine on ARCH=3Darm. This patch
> adds support for COMPILE_TEST which is useful for compile testing code
> changes to the driver and Counter subsystem.
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Link: https://lore.kernel.org/r/20220105094137.259111-1-vilhelm.gray@gmai=
l.com
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 3dcdb681c4e4..5edd155f1911 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -14,7 +14,7 @@ if COUNTER
>
>  config 104_QUAD_8
>         tristate "ACCES 104-QUAD-8 driver"
> -       depends on PC104 && X86
> +       depends on (PC104 && X86) || COMPILE_TEST
>         select ISA_BUS_API
>         help
>           Say yes here to build support for the ACCES 104-QUAD-8 quadratu=
re
> --
> 2.35.1
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>

Thanks
