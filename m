Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC036484DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiAEFcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiAEFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:32:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE523C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 21:32:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j18so80538785wrd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 21:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyKdpGefYFFOFD9kVS+oP2K2si5fUOgQ52v0uyd9pA8=;
        b=8PpUC0zFweopHzrULaOC3gVD+dSXrVl+H4G0c5mIiKWfbC66qZitkP8HPhwjWloGBd
         qu1WOfd7Q/2/FF72B3kkh+WOWUJKHIVP+J38XGI7SJ02oOkA25rl/1wvULdqEt+whOQN
         QKMJoRPoP5VeWa6i1wr3oLmfGDBLdsSxc4qUIGKY2476hNgxraPmv6Ecufb0KGDuScXn
         /SiJGxO8RJo7kZ9wxHmgmWGweM+vLCjJvgmuc3wLH2xIV542NwkPW3188VtSa8lH2+Nb
         Vlrd1QLpqfYC0Xp+jVmHSt3BPhGdAV+OSGBVYTmZdilwnYnk1aDA5iTi9VXsd73p/1Im
         BASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyKdpGefYFFOFD9kVS+oP2K2si5fUOgQ52v0uyd9pA8=;
        b=hIyWeQuR6YxaCw140KAVwkUToK5e6U7tRyklmk5EkHoEfM4Vxu8f7Zeho7NhceupaV
         t4vh0dzCgINq4GX118ZGWAws0ajUpnAnb8aHKZQCz7DcyerakcXiq89S9vXJf44nVpSJ
         RWEEf9lsbjzQbe1/ccipNjR98aMZD23GjM0RO8d0BpqIqB0ATFS9PW+VX/Th9utV46lw
         fpLoWlNXtYm2POjaI3GGoxET9M8F1u5YVOtdlKPdrLtsMlDjesniLjYMTdUeyXirx6XF
         p6e5TnZUrtDcMOnf3h2afsdSUBabd9d3BFolLac9a4+oTXsTRgRaVURCqK0vxHQRhBHj
         2HTg==
X-Gm-Message-State: AOAM533LyWQ5yPwwQ7Fb3j9VTJLEYqKQGT9CocH5sWvdiYhi3E0O1IxM
        RM+R7a/T8/sSVfH/W80OQy9zmjII6x92R9dro+Bclw==
X-Google-Smtp-Source: ABdhPJxE5vBqctq502istUxJV2WKAH761fcAHe/HtCGUURQL+//adPXVuixTykX5RjKTx6DU2MpLaST80BYgsDaEzcA=
X-Received: by 2002:adf:c843:: with SMTP id e3mr45254548wrh.38.1641360771949;
 Tue, 04 Jan 2022 21:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20220105003718.19888-1-zev@bewilderbeest.net>
In-Reply-To: <20220105003718.19888-1-zev@bewilderbeest.net>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Wed, 5 Jan 2022 13:32:40 +0800
Message-ID: <CAGm54UF31f4CVzE6FtEVuZ+rkuy1thbMDiw3HrMNLtoeqvCKug@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] [PATCH] ARM: dts: Fix OpenBMC flash
 layout label addresses
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Troy Lee <troy_lee@aspeedtech.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 8:37 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> We've ended up with some inconsistencies between the addresses in the
> DT node labels and the actual offsets of the partitions; this brings
> them back in sync.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 529022738c8e ("ARM: dts: Add OpenBMC flash layout")
> Fixes: 8dec60e7b8d0 ("ARM: dts: aspeed: Grow u-boot partition 64MiB OpenBMC flash layout")
> ---
>  arch/arm/boot/dts/openbmc-flash-layout-64.dtsi | 2 +-
>  arch/arm/boot/dts/openbmc-flash-layout.dtsi    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> index 31f59de5190b..7af41361c480 100644
> --- a/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> +++ b/arch/arm/boot/dts/openbmc-flash-layout-64.dtsi
> @@ -28,7 +28,7 @@ rofs@a00000 {
>                 label = "rofs";
>         };
>
> -       rwfs@6000000 {
> +       rwfs@2a00000 {
>                 reg = <0x2a00000 0x1600000>; // 22MB
>                 label = "rwfs";
>         };
> diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
> index 6c26524e93e1..b47e14063c38 100644
> --- a/arch/arm/boot/dts/openbmc-flash-layout.dtsi
> +++ b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
> @@ -20,7 +20,7 @@ kernel@80000 {
>                 label = "kernel";
>         };
>
> -       rofs@c0000 {
> +       rofs@4c0000 {
>                 reg = <0x4c0000 0x1740000>;
>                 label = "rofs";
>         };
> --
> 2.34.1
>

Reviewed-by: Lei YU <yulei.sh@bytedance.com>

-- 
BRs,
Lei YU
