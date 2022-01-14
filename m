Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E672B48E3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiANFsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiANFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:48:20 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9554FC061574;
        Thu, 13 Jan 2022 21:48:20 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id l15so15141343uai.11;
        Thu, 13 Jan 2022 21:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw5VqmvNL3k1jJQQQbGaXNvj5XSRqtlp9D4vgHkw/c0=;
        b=IG28mpDjgzbLms9QAXnXHhwMNNxPyMyxcvHLTWa79mRjP9Vaq1ptEAgslAouC15JZ/
         9SiPbbWGDT5ZmXXog2kL6YbyMmkC47PjdUDiOmmCmqRD8L7HHv0mGjrhvPB7y5IR2r3m
         tfTj4iZ+gIrFkLKm4CO9MRlTyYXp8l+e4vDhBZBBhReVMz0dDn4Vf6xhmIXJWeBwUwut
         uoE8CrheRcI6RlHuNp5GqhsOyeHEeG684RtZkG5JygGy3SgswT6KnSFLDYQy5F+e56rq
         Gu07/W5rxgpZobvZsS19VyIGcffF4eaYvS8EW2Ub92c61ORniGuo5CU4OddOifntiDlL
         Efnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw5VqmvNL3k1jJQQQbGaXNvj5XSRqtlp9D4vgHkw/c0=;
        b=qm+IIDUu28qNsXj4ZeDWLCjeCCsHE5zL4W1zhMOhKVOZQ2ED/hpsCFA/0do3bOxOFa
         /bVGfiSjIGbBglwP/5Aev+SLE/wlqpWxkRCv6O40Eb0+mMsxqG3ZRu08AqpQ148sTtOw
         0HQXOw8g4WcLZlAsMMM6oQ7SHldwITMOhkhaDBFDMM7NFzpUWuAplnF+mhU6ev8GC6mZ
         6vvQOpgkQjkRIauauGG9rQgM5sXH+PJE+g9ze8Le9awcn3h7E4tLAv1fyKP2fNNh41sh
         zs2zGJXrx9Rjuzqe0xoVvsR7HK45+5STEotUEMzVMTZ7r3ltH+93xFF2SDBiBwbp6MxO
         32Lw==
X-Gm-Message-State: AOAM5301nhuPVIxCL3D38AXRedc2KcaG0AVGXjZStQIZLRFSY0jAsZJA
        M8M0LDt6clqfBkY3ztkH1RkFucT8nc4vWMwLMjk=
X-Google-Smtp-Source: ABdhPJxl26pHbfZ87cHKBVt3NQQRmW9HH+elz1W+utZKazS3s6zpYQOcm2S7iYqHRQlOA4WSRe3B+0MTHxjuCqCTE/s=
X-Received: by 2002:ab0:270b:: with SMTP id s11mr3795278uao.98.1642139299729;
 Thu, 13 Jan 2022 21:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20220114104547.55e2f188@canb.auug.org.au>
In-Reply-To: <20220114104547.55e2f188@canb.auug.org.au>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 14 Jan 2022 06:48:08 +0100
Message-ID: <CAMhs-H_u42MSPpkwFEQCVghHWVjMqdJ1aKXXhbhxKWrejZLqRA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jan 14, 2022 at 12:45 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pci tree got a conflict in:
>
>   drivers/pci/controller/Kconfig
>
> between commit:
>
>   aa50faff4416 ("PCI: mt7621: Convert driver into 'bool'")

This was a temporary fix for v5.16 since driver was not ready to be
compiled as a module yet and some MIPS architecture dependent code was
remaining.

>
> from Linus' tree and commit:
>
>   44ddb791f8f4 ("PCI: mt7621: Allow COMPILE_TEST for all arches")

The changes in Kconfig here are the good ones removing MIPS dependency
and allowing the driver to be compiled as a module.

>
> from the pci tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/pci/controller/Kconfig
> index aec8c9a3488b,f7e44d9c6965..000000000000
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@@ -332,8 -332,8 +332,8 @@@ config PCIE_APPL
>           If unsure, say Y if you have an Apple Silicon system.
>
>   config PCIE_MT7621
>  -      tristate "MediaTek MT7621 PCIe Controller"
>  +      bool "MediaTek MT7621 PCIe Controller"

This should be tristate.

> -       depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> +       depends on SOC_MT7621 || COMPILE_TEST

This is correct,

>         select PHY_MT7621_PCI
>         default SOC_MT7621
>         help

Best regards,
    Sergio Paracuellos
