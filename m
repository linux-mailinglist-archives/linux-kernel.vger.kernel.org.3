Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC62A4856F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiAEQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbiAEQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:58:36 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE7C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 08:58:35 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g13so54863087ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7FCM7ExCLWgqCTqTGogExMuf/fiieL3PsozNySRBWtE=;
        b=UQxsz9w3fkWnSccar+KDsZ83AI6OixpNiN8xTU1b2sOqqEwdQhvx1yD4iYHi36ijhJ
         VGrV9Q6JhyM+5Pu3efTFQxkkCYMqjBuP5/ximPBM7M2Y7nm++Ncv2eFszDeLoRRSKBCA
         8zbrU/FJuSlgZptM/5bumFucFka3QxUvCyXoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7FCM7ExCLWgqCTqTGogExMuf/fiieL3PsozNySRBWtE=;
        b=Bg5AlUXr9SCfwsnFyxmrWsLVGbUzcJ4lrpjHkmChNNqd9yjmRtuf7Wr/qdWsl0Zb9p
         G74WAxawLVluLoXqIPBW6Ll4PVTRF4LeHkRP819SYqGWrK0W2KwYM35c99lj+UiiT+IW
         KhyL7yx1rc5eiS1iSkmaDxkpademUN1Qzg8WvdM+js6GquqF1gqbm5+fjv2J2qE9kQCS
         ZP2TDae6sDEWcyWbUyEyR//CDdMCme4yaH1AjlN6gn3Bx6eH++64TBrQV6adE1yRRiTn
         7uyIS/OIbAcg3nbsNUGufbD3WPPRuh5FrStNX29Mz3pVpNGmy9RlIdAKnB0JoesVIn42
         ZSSw==
X-Gm-Message-State: AOAM531FJX33BdE1SkiIUdp9Zlw5Hs57ahGWdfUmUFR48TE/7d25kjgy
        5QRn84as5AcsFRhp/pBORa3ZyoHmvlFYKAQpLDw8dcydC5HbiJcTwBLmwIJ2kYXS/z45cKAwc9I
        1s8EQVN8PuNWrvpl0yXgAjnnqq60ViYCYTujH2GIU0A==
X-Google-Smtp-Source: ABdhPJxf4kDEGFJZonps1Gx7Yh4NifjctN15yGaQUwO8Nwfvk3H6tGxsXvk8mhA5Lgq9rMS8JX0v8xF2HVqlxvXe9U4=
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr47426430ljk.309.1641401913827;
 Wed, 05 Jan 2022 08:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20220105093552.27542-1-pali@kernel.org>
In-Reply-To: <20220105093552.27542-1-pali@kernel.org>
From:   Roman Bacik <roman.bacik@broadcom.com>
Date:   Wed, 5 Jan 2022 08:57:09 -0800
Message-ID: <CAGQAs7xHpfftf4=_zyhdJhRHaN-P3BaY+n1NQ-ED8cFRJ1+EAA@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 1:36 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Register 0x43c in its low 24 bits contains PCI class code.
>
> Update code to set all 24 bits of PCI class code and not only upper 16 bi=
ts
> of PCI class code.
>
> Use a new macro PCI_CLASS_BRIDGE_PCI_NORMAL which represents whole 24 bit=
s
> of normal PCI bridge class.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> ---
> Roman helped me with this change and confirmed that class code is stored
> really in bits [23:0] of custom register 0x43c (normally class code is
> stored in bits [31:8] of pci register 0x08).
>
> This patch depends on patch which adds PCI_CLASS_BRIDGE_PCI_NORMAL macro:
> https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> ---
>  drivers/pci/controller/pcie-iproc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller=
/pcie-iproc.c
> index 3df4ab209253..2519201b0e51 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -789,14 +789,13 @@ static int iproc_pcie_check_link(struct iproc_pcie =
*pcie)
>                 return -EFAULT;
>         }
>
> -       /* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
> +       /* force class to PCI_CLASS_BRIDGE_PCI_NORMAL (0x060400) */
>  #define PCI_BRIDGE_CTRL_REG_OFFSET     0x43c
> -#define PCI_CLASS_BRIDGE_MASK          0xffff00
> -#define PCI_CLASS_BRIDGE_SHIFT         8
> +#define PCI_BRIDGE_CTRL_REG_CLASS_MASK 0xffffff
>         iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
>                                     4, &class);
> -       class &=3D ~PCI_CLASS_BRIDGE_MASK;
> -       class |=3D (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
> +       class &=3D ~PCI_BRIDGE_CTRL_REG_CLASS_MASK;
> +       class |=3D PCI_CLASS_BRIDGE_PCI_NORMAL;
>         iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
>                                      4, class);
>
> --
> 2.20.1
>

Acked-by: Roman Bacik <roman.bacik@broadcom.com>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.
