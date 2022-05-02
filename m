Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731DF516AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358114AbiEBGkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiEBGkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:40:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D32A728
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:37:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b19so18300830wrh.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqqCEyfMCT8g6ihYPN3c3rDxb/wJWFaanCdyLGSbofU=;
        b=2WnuCcoaj1zLGADQHs8IXhgD6hpbCwl5RamfyzN8zd/SAuO9u8WvTCdE9O+TBu7lMm
         B0ytTiHMC/mm2tuTHlyxkxmpK8JXZ4N6d4uiCpJsxAbMDe/0FF6KTk2irVz1PiyKgBXH
         HhN/VKXfMQQ6Z9vRX2PWROA2nsIFRwPwrZ96njSPVgA+ECrhkwOwZIVZLTFe6JIeX8J9
         CK6bOW0X0s2Bxil/bH9llGOcThWz/El/TIftqFBvuKKd2jM1nE6HstcXVCYsk+AItZtg
         USk5W+csevFt1ewjlfl5tGR0cifCGD2GIVbDBl1xJfELConQl1E//MuwiHYUKrPF7Ghy
         hW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqqCEyfMCT8g6ihYPN3c3rDxb/wJWFaanCdyLGSbofU=;
        b=l7IVTtjOnLdWpugZPglc0++aUatFDvQOBCRrsduGF0FcySR3HjA1WAxw3tNRnRc5We
         0+G2/Fca+wNNatEgnpHcW6f1zJSA2OP4Jo5sZtXJt3oLSgmsC6S+KT6FTfay4eG3Q47H
         WLo/MUCrIBv4rNTuCr92d8akO7PhPcEnjBWQ6mU1TU2fiu6Eny+i0vU6zyLlj/pdx5hQ
         O/jlgewL8ZZb4kZ8NSoDlMTlhhAjHOWQeIuK8yzwqFZDwRw6zoeJDVbi5+ivvVflHwOq
         QxOI/cjwbyy/9Ck4pTvkzxTGV3nBihMvDJUCPb/BgrIKxP8j7wPEBGriAbzQKKSTS1k1
         wyGA==
X-Gm-Message-State: AOAM531Y01bjDeTC8Sh9HLhQWDdLTaXoOUpe2a77dfqalAv0IyE46OOa
        iAA6OGf8RBslp4076azPiixEB15KkPCxHhZnyNWWlw==
X-Google-Smtp-Source: ABdhPJwpPQE8alJj1PBNj490CuPPiNIk7vOjwqy2KWqj0S7oLz5DWpq7/yjXUrnDNAoSrmec3sfribhidOQw65cr29w=
X-Received: by 2002:adf:b35b:0:b0:20a:dd58:ef60 with SMTP id
 k27-20020adfb35b000000b0020add58ef60mr8246697wrd.647.1651473420807; Sun, 01
 May 2022 23:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220430191122.8667-1-Julia.Lawall@inria.fr>
In-Reply-To: <20220430191122.8667-1-Julia.Lawall@inria.fr>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 2 May 2022 08:36:49 +0200
Message-ID: <CAHTX3dKbmF1-hPi9D-D53Gfze4s=1-kyeBqgLpZ=2jDH=M3OpQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so 30. 4. 2022 v 21:11 odes=C3=ADlatel Julia Lawall <Julia.Lawall@inria.fr>=
 napsal:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  arch/microblaze/kernel/kgdb.c |    2 +-
>  arch/microblaze/lib/memmove.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/microblaze/kernel/kgdb.c b/arch/microblaze/kernel/kgdb.=
c
> index 130cd0f064ce..df4b9d0112e5 100644
> --- a/arch/microblaze/kernel/kgdb.c
> +++ b/arch/microblaze/kernel/kgdb.c
> @@ -31,7 +31,7 @@
>  #define GDB_RTLBLO     55
>  #define GDB_RTLBHI     56
>
> -/* keep pvr separately because it is unchangeble */
> +/* keep pvr separately because it is unchangeable */
>  static struct pvr_s pvr;
>
>  void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
> diff --git a/arch/microblaze/lib/memmove.c b/arch/microblaze/lib/memmove.=
c
> index 2e49d0ef1e07..c1f08c484e20 100644
> --- a/arch/microblaze/lib/memmove.c
> +++ b/arch/microblaze/lib/memmove.c
> @@ -78,7 +78,7 @@ void *memmove(void *v_dst, const void *v_src, __kernel_=
size_t c)
>
>                 i_dst =3D (void *)dst;
>                 /* Choose a copy scheme based on the source */
> -               /* alignment relative to dstination. */
> +               /* alignment relative to destination. */
>                 switch ((unsigned long)src & 3) {
>                 case 0x0:       /* Both byte offsets are aligned */
>
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
