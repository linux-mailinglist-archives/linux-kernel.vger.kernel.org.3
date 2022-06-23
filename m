Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E929B557CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiFWNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiFWNZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:25:30 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2249CAA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:25:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5928D1BF208;
        Thu, 23 Jun 2022 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655990728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TGuR++xPPjUWlLqJbPCBw/3UC+BNkBSB+PamTH3u9dY=;
        b=l8+lepEVs9tKAI5uK/0Tqe3etENaFcdsvFOqPkEKq2RcOlq1qlRjIS6WKL5nitbwjZ6lA4
        Loaw5Z8Iluy7oxsNuT/NlFg2OILde8ottq77k0xBbwOe779NY/T5bR/3tlnPi2hYH4UU40
        X6oPOzJQlmJOgQTMlAN80Tu7sOU9L2Aaqgr13BCAPxXWkogbw9q26Qf5Ab57CU372lh++T
        J8DaXBZp5XMe7OUlR35do7SWP+rdp8EWcH/hAZDZ8Wa09km7/wSzBin8TpzLbG2gXyB+pE
        Aqk8Ic3Hb/N1Slou2uqh/YpZmVQk2NTNDbvW3+EzgJMCu0WfTAuXODSp1F0eGA==
Date:   Thu, 23 Jun 2022 15:25:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubi: remove unexpected word "the"
Message-ID: <20220623152524.3970e49c@xps-13>
In-Reply-To: <20220621093656.73074-1-jiangjian@cdjrlc.com>
References: <20220621093656.73074-1-jiangjian@cdjrlc.com>
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

Hi Jiang,

jiangjian@cdjrlc.com wrote on Tue, 21 Jun 2022 17:36:56 +0800:

> there is an unexpected word "the" in the comments that need to be removed
>=20
> * @dev: device object to make use of the the Linux device model
> * @dev: UBI device object to use the the Linux device model
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/mtd/ubi/ubi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index 078112e23dfd..d9039e7f6703 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -281,7 +281,7 @@ struct ubi_eba_leb_desc {
> =20
>  /**
>   * struct ubi_volume - UBI volume description data structure.
> - * @dev: device object to make use of the the Linux device model
> + * @dev: device object to make use of the Linux device model
>   * @cdev: character device object to create character device
>   * @ubi: reference to the UBI device description object
>   * @vol_id: volume ID
> @@ -439,7 +439,7 @@ struct ubi_debug_info {
> =20
>  /**
>   * struct ubi_device - UBI device description structure
> - * @dev: UBI device object to use the the Linux device model
> + * @dev: UBI device object to use the Linux device model

For this kind of trivial change I suggest that you gather changes in a
given subsystem and group them in a very limited number of patches sent
as a single series.

>   * @cdev: character device object to create character device
>   * @ubi_num: UBI device number
>   * @ubi_name: UBI device name


Thanks,
Miqu=C3=A8l
