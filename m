Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12BE52A845
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351061AbiEQQjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351035AbiEQQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:39:09 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E68344D2;
        Tue, 17 May 2022 09:39:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4C7520007;
        Tue, 17 May 2022 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652805546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJtYRAFDXyv5D+rHulqoB18CgiwzQYEhSBBo7r1UZLw=;
        b=PqMnphmKa+Oeky287RYM6Gq9ilrPz5qh6vlWGabmt0SxoEEMfRyJy6QaOyf/QenK1DHyuL
        QmOqnHWpZqIVA1obxIcKlkrO81q9Qh636+wv7kshjVm2jfxIMtAhW/ZFiDmp44tLGMeEee
        oEtkBtthnoNsPWdK+Upl0Kl5GbvHbXuB5ak+TBPYYCJh17n9F4ytJd9u1hdq+h6sK6idXH
        mX09Xz3HaojL85ZSnh2qDTWk1Cz1c4M3zF3AGPru+9foDCbsrGwG4O6bJb2mXr7zh/Kv1u
        cGkg7siIRlvwMEDEApgDBZUiChPcJvWIMUWuY5nOXiICKcD4ixk0pfxSYw6H+Q==
Date:   Tue, 17 May 2022 18:39:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>
Subject: Re: [PATCH v5 0/3] Add support for Sercomm partitions
Message-ID: <20220517183903.2b34819c@xps-13>
In-Reply-To: <20220516184217.4e2957fc@xps-13>
References: <20220516151228.885222-1-csharper2005@gmail.com>
        <20220516184217.4e2957fc@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

miquel.raynal@bootlin.com wrote on Mon, 16 May 2022 18:42:17 +0200:

> Hi Mikhail,
>=20
> csharper2005@gmail.com wrote on Mon, 16 May 2022 15:12:28 +0000:
>=20
> > This patch series add support for Sercomm mtd partition table parser. I=
t's
> > used in some Beeline, Netgear and Sercomm routers. The Sercomm partition
> > map table contains real partition offsets, which may differ from device=
 to
> > device depending on the number and location of bad blocks on NAND. =20
>=20
> Series applied in place of the previous version on mtd/next.

Actually we have a new robot warning, so I've dropped patch 3/3 and kept
the bindings for this release.

Thanks,
Miqu=C3=A8l
>=20
> >=20
> > Changes since:
> > v4:
> >  - Add Acked-by to the first patch
> >=20
> > v3:
> >  - Fix commit message of the first patch
> >  - Add Reviewed-by to the second patch
> >=20
> > v2:
> >  - Fix mistakes in dt-binding
> >  - Add patch for new vendor prefix
> >  - Add vendor prefix to scpart-id property
> >=20
> > v1:
> >  - Add dt-binding in a separate patch
> >  - Remove redundant braces and logical NOT operator
> >  - Define pr_fmt
> >  - Replace kcalloc by kzalloc
> >  - Use of_get_child_count() and alloc big enough array before the
> >    for_each_child_of_node()
> >=20
> > Mikhail Zhilkin (3):
> >   dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
> >   dt-bindings: mtd: partitions: Extend fixed-partitions binding
> >   mtd: parsers: add support for Sercomm partitions
> >=20
> >  .../mtd/partitions/fixed-partitions.yaml      |  55 +++-
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  drivers/mtd/parsers/Kconfig                   |   9 +
> >  drivers/mtd/parsers/Makefile                  |   1 +
> >  drivers/mtd/parsers/scpart.c                  | 240 ++++++++++++++++++
> >  5 files changed, 305 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/mtd/parsers/scpart.c
> >  =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

