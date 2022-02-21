Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032334BD3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbiBUCma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:42:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbiBUCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:42:28 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2D6260
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:42:05 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p7so28361565qvk.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TlLzE0+Z9f/zQXYXTn0LbWvz/82kYt7+K45LYiLUD8g=;
        b=aM/nGeGj2Cw/Sg5naH3AG0eExU1E3BNoPjgvw/Ym2oUOZVKf6IaUoLy7KGr6EkKNVI
         eRfsYcc3FVB7cnRS7puxtFjCZIsUOhCMwPRZDaApWhMpOSnGs56PY6ERTRN/sRqcfZ4E
         UAL2Qm62TQ5SvifthIR9+nGSjSOByxZLtOCgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TlLzE0+Z9f/zQXYXTn0LbWvz/82kYt7+K45LYiLUD8g=;
        b=pKTGT7GX5B4wThrfG4rLEHaXZkUE2Ggiea/WtHJ9x1fo7In7zmEdRzHORQcwN9dwIH
         F9d/7ldG1RGrmteB0J4xu8RzV9UACwJh9190DdG3hQwy1edMGSColrXOGi1ap3qLxax7
         GDXHBTsvZNC1pxo/TSYuAR86EIItLfX3/WNuil5z0dZPYHnCbBLL7VCWSL+l2/UYKq6U
         glH8ofuMwaz/lLDQchNHPyFdCNJj7Ov6B7GQlhz2H89Fsjd0088BWOGNdxCbN2EQ71ic
         rFnZAgZZ+STTbgu1YtpfZOZ6s1b1JvJJfz1mBZCBpC6g8SndxKBIPbU2TaRKr3f5D38k
         a1QQ==
X-Gm-Message-State: AOAM531NNOy3rlLLkVmrx2CB2c0h/2zRPLQohUpvqdN7ZJ+sVZmEcgmG
        6XcJSSMa15ugkDD/5Ds6d563yTAAOH7/71b7sXc=
X-Google-Smtp-Source: ABdhPJw+t+Dvak8HmxG9pX/YksMp8WXygpwW/mHFt15cGwyshgtTb0mv8RXqWeJNUD9btZAWXGGmtas56rtTOr5Pxrc=
X-Received: by 2002:ac8:7f12:0:b0:2d2:24e5:95de with SMTP id
 f18-20020ac87f12000000b002d224e595demr16356767qtk.625.1645411324340; Sun, 20
 Feb 2022 18:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20220218160834.320200-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220218160834.320200-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 02:41:52 +0000
Message-ID: <CACPK8XfQV=3TOPj_osuk4fvQYwH8F7tOiEEiYb7mL1zXvUPT+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] MAINTAINERS: ARM/WPCM450: Add 'W:' line with wiki
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 at 16:08, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> The wiki is a useful source of 3rd-party information about the SoC,
> mostly hardware documentation.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

I've put this in the same branch as the dt changes you've already
sent. I'll send out a pull request this week:

https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git/log/?h=3Dnuvot=
on-dt-for-v5.18

Cheers,

Joel

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fbbd9fa88d86..39d9e2c6f94ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2350,6 +2350,7 @@ ARM/NUVOTON WPCM450 ARCHITECTURE
>  M:     Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>  L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:     Maintained
> +W:     https://github.com/neuschaefer/wpcm450/wiki
>  F:     Documentation/devicetree/bindings/*/*wpcm*
>  F:     arch/arm/boot/dts/nuvoton-wpcm450*
>  F:     arch/arm/mach-npcm/wpcm450.c
> --
> 2.30.2
>
