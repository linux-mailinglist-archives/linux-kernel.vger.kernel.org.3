Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87296528ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbiEPQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiEPQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:42:23 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFFB1E3D3;
        Mon, 16 May 2022 09:42:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 88E3240004;
        Mon, 16 May 2022 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652719340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9S9+th7rU3Rsy/agoDwBNpYebT5h45qKTkkAgb5i+ow=;
        b=KqC5L1jBIVTcNdDQV9G0TZydeNYtFVoCqm2TPUfCvIAUrhXh69sueODdd86L3hlwI6p9Ls
        qVuDEJUzQEhxMlnqdf3cNvfuNYY+/ABTa2PaNMtdZ/kYMyichuOe4YTirJG/8o5qDE1+Vd
        +GlNM+KZz35lVt5i+evsEg+ywM2O4kmXzRrviG95I19+NG+gwC8McZbok1UKpcEJph26W1
        Ao1I6nZNvY0z6d8i6gLkuDbYTsGCpf2jUqYXMup8E0TWOTpU5Se9ocCu57MH9j243aM2o2
        faBADVnV+YGGceFzTyfv0NAJ6dWrjmmI+P7n3QXbXvbFBkKcPjDanxVIvvWDzA==
Date:   Mon, 16 May 2022 18:42:17 +0200
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
Message-ID: <20220516184217.4e2957fc@xps-13>
In-Reply-To: <20220516151228.885222-1-csharper2005@gmail.com>
References: <20220516151228.885222-1-csharper2005@gmail.com>
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

Hi Mikhail,

csharper2005@gmail.com wrote on Mon, 16 May 2022 15:12:28 +0000:

> This patch series add support for Sercomm mtd partition table parser. It's
> used in some Beeline, Netgear and Sercomm routers. The Sercomm partition
> map table contains real partition offsets, which may differ from device to
> device depending on the number and location of bad blocks on NAND.

Series applied in place of the previous version on mtd/next.

>=20
> Changes since:
> v4:
>  - Add Acked-by to the first patch
>=20
> v3:
>  - Fix commit message of the first patch
>  - Add Reviewed-by to the second patch
>=20
> v2:
>  - Fix mistakes in dt-binding
>  - Add patch for new vendor prefix
>  - Add vendor prefix to scpart-id property
>=20
> v1:
>  - Add dt-binding in a separate patch
>  - Remove redundant braces and logical NOT operator
>  - Define pr_fmt
>  - Replace kcalloc by kzalloc
>  - Use of_get_child_count() and alloc big enough array before the
>    for_each_child_of_node()
>=20
> Mikhail Zhilkin (3):
>   dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
>   dt-bindings: mtd: partitions: Extend fixed-partitions binding
>   mtd: parsers: add support for Sercomm partitions
>=20
>  .../mtd/partitions/fixed-partitions.yaml      |  55 +++-
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/mtd/parsers/Kconfig                   |   9 +
>  drivers/mtd/parsers/Makefile                  |   1 +
>  drivers/mtd/parsers/scpart.c                  | 240 ++++++++++++++++++
>  5 files changed, 305 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mtd/parsers/scpart.c
>=20


Thanks,
Miqu=C3=A8l
