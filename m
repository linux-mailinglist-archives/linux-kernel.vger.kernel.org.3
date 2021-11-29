Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5790B461D80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347283AbhK2SZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbhK2SXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:23:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72E3C08EDBE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:48:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so72874361edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FliCx0bGn3ubNIukwxtPju9wJWhhLzDslESrHIbYqAo=;
        b=T5bO4MKnctuYgq04joV/MQiUVVEk3hmYzplG0ZjO98tJW/kW6sEML0nYymOUR0No9t
         yp95FtM/KMKgCncy8BNa5Uk2y5phZDY4M0sCotbyYEJRXvN2DDgvMOquDt1AoCPqP+ke
         jCi2rAUF1Fn+4qzj9I9Y87PjYD90ebX5i5TGR9masR6KxTHk4NWwYeFPqVwfKC89upFQ
         wLLAIhgZfRm9ryQ7wuyvdeUt9vVIVhrnNYVFbyXHcP15W7FRj3PzeVes6RO682yiZuiB
         hZC4ndMG06gdjyDShQ/PMqljJ1R0uyt8Hi++geOOUjVQlycd7iXV4GJByJNMfa7uTQAV
         pgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FliCx0bGn3ubNIukwxtPju9wJWhhLzDslESrHIbYqAo=;
        b=gqJEKqvgr8AVtKeA/fHe/rcQgjr8whZnnxcW8ONT+nub4uG8nVpd5HcUD+5q+2Mgm5
         c/pOr1M4yybDzINghJ8RHkBCQoPzO8cwCihCsOOnB/72X/kbeJdidX1i6U0gd9+642JV
         zJNV0RgW/GVZ/eEnO+FSRHB006B26X/aNHEesuVNbQzpGqzPjEdIMDwwEBW79snhNNzY
         vcbk6yxxCj16Vha5ifgMMHaAzWJvcKOTxV4WyCN7Q2omNbxmo1EJpgx7mDbIJ/bRAHWC
         nJwstkJZTvIbAtKEIHAegNhPAK0TrMSPVSIvFskbna90aneSm6quzlANSdlLy3RkjEzl
         Vmvg==
X-Gm-Message-State: AOAM531HO343ZMKsz8sYcr6FcRiWzC0BergUvBu3mdZMkooorcRblpv2
        d0VMVQYil9ld1ceXhIZV4+2hqzdMcQn6NA0W8BEMmmkjz+Q=
X-Google-Smtp-Source: ABdhPJyTk9tBgZZcLKsO8X1xBSnPzQHAtxWc9m3uMq8MC/obS9TMbyGJRZgcFld8AAH0nMBtTbdYhfZnwQJLAwWXVbE=
X-Received: by 2002:a17:907:764b:: with SMTP id kj11mr59577045ejc.307.1638197314562;
 Mon, 29 Nov 2021 06:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20211128034823.6930-1-wangborong@cdjrlc.com>
In-Reply-To: <20211128034823.6930-1-wangborong@cdjrlc.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 29 Nov 2021 15:48:23 +0100
Message-ID: <CAHTX3dJuVVkxRtHQj9wfoqLpac2SuCHAQpBGca+Da8k03zyJCA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: fix typo in a comment
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ne 28. 11. 2021 v 4:51 odes=C3=ADlatel Jason Wang <wangborong@cdjrlc.com> n=
apsal:
>
> The double `was' is repeated in a comment. Consequently, remove one
> `was' from the comment.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/microblaze/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/sig=
nal.c
> index fc61eb0eb8dd..59f0af5ee042 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -11,7 +11,7 @@
>   *
>   * 1997-11-28 Modified for POSIX.1b signals by Richard Henderson
>   *
> - * This file was was derived from the sh version, arch/sh/kernel/signal.=
c
> + * This file was derived from the sh version, arch/sh/kernel/signal.c
>   *
>   * This file is subject to the terms and conditions of the GNU General
>   * Public License. See the file COPYING in the main directory of this
> --
> 2.33.0
>

Applied.
M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
