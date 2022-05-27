Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01570535E95
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351204AbiE0Kqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351104AbiE0Kp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:45:58 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB25158F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:45:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A5F8100009;
        Fri, 27 May 2022 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653648326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JB0mhdnR46lzp5SeNAr4p9Ad8iU4Z1hWgOymRKFoU7o=;
        b=eklpqcblb0aQr6N+ca93ufY/mFI+iOkxU18x8X7BkHSFlRBSL5barbpNunBdKp0r99+NdM
        V/EbLal3hBn+A1frcq4sefFFud94fx6Zf7uZMvez3ZDKdmC98VFxmfuW1gckLSJSmh3SaO
        uPyByhZrvS5KRx4WcgvAdpv6qyPm97p6dacCM6oir8kBXGgRcW18apvT4Nh6DwEObhl8v1
        AbqOWz/MfNax4E0ocwykm6TbgyPDMGE5RS2Ik9zXawCJR5+jmu1/0B3Shvrl6WwqMl1F4v
        NJTYyBeBtHD73G63T4SZAgR8yopyWFgjDN60ZryN/xypJ50LLD/0GC+ynLUuTQ==
Date:   Fri, 27 May 2022 12:45:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: drop the useless LIST_HEAD in
 __mtd_del_partition()
Message-ID: <20220527124521.15ac865e@xps-13>
In-Reply-To: <1653645678-29049-1-git-send-email-baihaowen@meizu.com>
References: <1653645678-29049-1-git-send-email-baihaowen@meizu.com>
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

Hi Haowen,

baihaowen@meizu.com wrote on Fri, 27 May 2022 18:01:18 +0800:

> Drop LIST_HEAD where the variable it declares is never used.
>=20
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

The title seems wrong. A fixes tag would be appropriate.

> ---
>  drivers/mtd/mtdpart.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index d442fa94c872..976e9c30244e 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -326,7 +326,6 @@ static int __mtd_del_partition(struct mtd_info *mtd)
>  static int __del_mtd_partitions(struct mtd_info *mtd)
>  {
>  	struct mtd_info *child, *next;
> -	LIST_HEAD(tmp_list);
>  	int ret, err =3D 0;
> =20
>  	list_for_each_entry_safe(child, next, &mtd->partitions, part.node) {


Thanks,
Miqu=C3=A8l
