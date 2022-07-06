Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC4567B54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGFBKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGFBKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:10:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EFB17E39
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 18:10:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so7966689wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MeZrF+fXW4l5esJnk9r1b/wD32Xz1hSKmtwgLlZ9RiE=;
        b=G3KI0q17WpJNaKsjNhQSmZfQxeHjSkcXcQt13xn8pqOyL9wlD5MbiC027203d/lJQN
         Rq9su7qeL0r1cE9bzKttpD7R3t8obDJBOH6O2dYw/hzgZJ7gzhDV9h0mG8SMpnKaMNvh
         5maY1Ah0AOCgUfe9fxSC+ouUiIM4tFMJd3Cus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeZrF+fXW4l5esJnk9r1b/wD32Xz1hSKmtwgLlZ9RiE=;
        b=KrCTnKeViFmevGu8rRZ2GXDgW/LY56B7aUEWFMASEGA10BU5lv3exyRcxCuCLSqF3W
         a07zUokmRNTuHVBW6gS7Or39dAUr5Vl+Q2sEXtAoEmqgcZPGa97gYdURjpod4SqwAOqw
         rcWp4RzNXRbpa5iAXC4HnT72MO7lSLTf6Svyx0CWozC4iQqjunESCtiv6TU7HLJfoEAa
         +cAqDQd0Jq1XdutgUQvrGcqbtCetCknieHAbSCin0f6ftDXICKpp1O8T8fYTAhQwRwwv
         62sHjjeZZXv/Vy4IdTLIP+e2swLDx+HIAtb6wRUrJStwZsubV5naABCTqK5SiH0/zmUm
         pbWw==
X-Gm-Message-State: AJIora+pX3QFqNDIVqsYBcFI3DQvGFOLPlvHyO2Nb/YB15VLcRQYnFst
        CuCg64xSQnDZa261UgNMSNkbR2L0kune9M7uBMA=
X-Google-Smtp-Source: AGRyM1vktHfnuXL5Anl54md0PtlVs1D+ae12aBNtQlRz7HBaaA/a9kGsCjaysgjjErUlY2s5RIglUfOEAEJmxPehRS4=
X-Received: by 2002:a05:600c:2315:b0:3a1:772e:b9a6 with SMTP id
 21-20020a05600c231500b003a1772eb9a6mr36093026wmo.34.1657069805107; Tue, 05
 Jul 2022 18:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220705152757.27843-1-luoxueqin66@gmail.com>
In-Reply-To: <20220705152757.27843-1-luoxueqin66@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 6 Jul 2022 01:09:53 +0000
Message-ID: <CACPK8Xd1vK2ap6AbDqpqQ_BLJT9b0APtbGRNEv5=9iK4ken59A@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] fsi: Fix typo in comment
To:     Luo Xueqin <luoxueqin66@gmail.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luo Xueqin <luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 5 Jul 2022 at 15:28, Luo Xueqin <luoxueqin66@gmail.com> wrote:
>
> From: Luo Xueqin <luoxueqin@kylinos.cn>
>
> Spelling mistake in comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Luo Xueqin <luoxueqin@kylinos.cn>

Thanks, applied.

> ---
>
> v2: add discoverers
>
>  drivers/fsi/fsi-master.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
> index cd6bee5e12a7..4762315a46ba 100644
> --- a/drivers/fsi/fsi-master.h
> +++ b/drivers/fsi/fsi-master.h
> @@ -51,7 +51,7 @@
>  #define FSI_MMODE_CRS1SHFT     8               /* Clk rate selection 1 shift */
>  #define FSI_MMODE_CRS1MASK     0x3ff           /* Clk rate selection 1 mask */
>
> -/* MRESB: Reset brindge */
> +/* MRESB: Reset bridge */
>  #define FSI_MRESB_RST_GEN      0x80000000      /* General reset */
>  #define FSI_MRESB_RST_ERR      0x40000000      /* Error Reset */
>
> --
> 2.25.1
>
