Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D6E473073
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhLMP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhLMP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:27:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:27:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o20so53751991eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cm0SYSCqaAV704uxpSzDvt1nRFuZ3CRiYvbWuGcdKkc=;
        b=isluoo5nzjF06w1lr/7F0p5BAiLz5biz2NCskX/0cSuvG95IHLgkjuDpG6dALFyrnn
         +ep62NDPGse46FX3qD4KkhxJEmsAf2nUpdpZe3ccXx+bpir+ZHN8KT/6+nv5a16KQ/iy
         mQYhfFXqGumNj2gabBanfFqJWppqPplohwhr9ZY/TKGsA78UqcLIGYlUs2gUnAe/d8np
         ue0yYy4bXKk34zHww3BWpwYhFR3WVemAcKohp9OxaZ2VBaipCfSFAWU/+ZSV5qUbrTZY
         LSdJsA1JbSANJU4lj7Py3/RtkY1nojAajNT7KIFZ+uQOlLVNIGJKO0b+CQmsetDmWyyh
         GoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cm0SYSCqaAV704uxpSzDvt1nRFuZ3CRiYvbWuGcdKkc=;
        b=rfn9p2Pmxy9YV1SKe+5H0zGkZ8QO3sV9F8eD2NfRtVls6toSs44fdsKDpjgGtV/A6E
         CjsbNryKzaoTYINDe/44dTk5ADanOZ+wCaOQXID8L/h2UGEe3aZqWsuGUMJt0ukkzCJN
         bUj2PwGfwPrhTsbvSw8m/fQWQtIRd1xlVXxOCQj3b/dubV47/QJDmimIP6BHadSHCPcN
         p9VLAdDwaRO4eNtsIrec3dBS8ND20n9t4gPPUPo/EW1Dso90Da+C0bmlI/kqEuppmyhm
         J24oO9b3sgUD96IhV0UtJwvBSrmQvCpWsRRgY396hJ0ZOfczK53dPvlUzflUas12cu51
         Xtvg==
X-Gm-Message-State: AOAM530jRXk7zFvyAklbZ57yLzRu/eIWU9pJKx18oaMjmwSKRW85BCca
        SOoCs1MvnP29ZSAIbvxcKJXyNzCx7jjhGUwH/H+/2Q==
X-Google-Smtp-Source: ABdhPJyGZgjg0vxX+v8sNkZsNaCZoIOenPRPrnD/cLx6lTpU1YiQ/JJlX8DfAUUB3yNTj/rSkRXpPexPzsOnWCSxf/c=
X-Received: by 2002:a17:907:7ea4:: with SMTP id qb36mr46184742ejc.146.1639409246296;
 Mon, 13 Dec 2021 07:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20211212141248.7134-1-wangxiang@cdjrlc.com>
In-Reply-To: <20211212141248.7134-1-wangxiang@cdjrlc.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 13 Dec 2021 16:27:15 +0100
Message-ID: <CAHTX3dJnM6=ygqH+vJr9WTNanHyeZX36UTPLALZq0eoQtQ5JoQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: add const to of_device_id
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux-arm <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ne 12. 12. 2021 v 15:13 odes=C3=ADlatel Xiang wangx <wangxiang@cdjrlc.com> =
napsal:
>
> struct of_device_id should normally be const.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  arch/microblaze/pci/xilinx_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilin=
x_pci.c
> index b800909ddccf..f4cb86fffcee 100644
> --- a/arch/microblaze/pci/xilinx_pci.c
> +++ b/arch/microblaze/pci/xilinx_pci.c
> @@ -27,7 +27,7 @@
>  #define PCI_HOST_ENABLE_CMD (PCI_COMMAND_SERR | PCI_COMMAND_PARITY | \
>                                 PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)
>
> -static struct of_device_id xilinx_pci_match[] =3D {
> +static const struct of_device_id xilinx_pci_match[] =3D {
>         { .compatible =3D "xlnx,plbv46-pci-1.03.a", },
>         {}
>  };
> --
> 2.20.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
