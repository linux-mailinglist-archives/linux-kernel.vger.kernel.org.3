Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD357B5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiGTLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiGTLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:45:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956A86159;
        Wed, 20 Jul 2022 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658317506; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5bKwE+toAiomkN28VXesGLY//goBv768kEOswtqRRQc=;
        b=iPOLvHJP61X03hKCV3JDE9Avz79NmZ86qy+0oo4GA87LC/bMQ97tlxIfISaH7PVeiLHkdM
        NAhXKKpypxISh8bpoREB2L4MulLLvN4jy7zFOyD1wbImWpeHwTPtrDCj5pMaeYjgAmFX8O
        dGeON8yfLT6I3AthNIreGYPV4kq7nf8=
Date:   Wed, 20 Jul 2022 12:44:51 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 02/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <RYHBFR.1MXJ3WUJSHEG3@crapouillou.net>
In-Reply-To: <20220708160244.21933-3-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven., juil. 8 2022 at 17:02:35 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This isn't used and doesn't need to be in the private data struct.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 576f31f9d734..adf896333584 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -98,7 +98,6 @@ struct i2s_soc_info {
>  };
>=20
>  struct jz4740_i2s {
> -	struct resource *mem;
>  	void __iomem *base;
>=20
>  	struct clk *clk_aic;
> --
> 2.35.1
>=20


