Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ADA5008B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiDNIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiDNIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:50:35 -0400
X-Greylist: delayed 1529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 01:48:11 PDT
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AF11EAEC;
        Thu, 14 Apr 2022 01:48:10 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 866091B001CF;
        Thu, 14 Apr 2022 11:48:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1649926088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwUGtzT4Ya5DJOi91TQOaG6spJ7XBSP7OpQSwUZss98=;
        b=EdC/gE0hA/6Fdl3DmUDyB2l0ulqvfwYlI2I6scFIHxmzsLSys89Y7mHwozeSVArPbXdbEL
        rdf2l1pK/jgSs7m5Etecjp9NThoYbgDaOq2GjBL4SkyowaYisPAZ6nyf3wVl6aA03ynomm
        FnF92dxVua5fjqKl3s0veFPwEN3Zcka98F4tauaC23RAIeQDojh1fyQxEgtQ7VnHi6oHVC
        EnS6LMF7+wBPMEvZnaXkLhzUsvwKuSqpp0vhpkLGC7F1j6ct5tEiOkBRvl8BQcofjlz/NG
        8lUNwpyOOSzEIT99XWRQnym8GvaQErgd2LOwjXgR2JAtD7oq9bCV65LIeyn7OA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3664A634C91;
        Thu, 14 Apr 2022 11:48:08 +0300 (EEST)
Date:   Thu, 14 Apr 2022 11:48:08 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Shunqian Zheng <zhengsq@rock-chips.com>,
        kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/30] media: i2c: ov5695: fix typos in comments
Message-ID: <YlffyFr5pgdeBtD2@valkosipuli.retiisi.eu>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
 <20220314115354.144023-10-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314115354.144023-10-Julia.Lawall@inria.fr>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1649926088; a=rsa-sha256;
        cv=none;
        b=CdM10Dj5w6c6AifGUuTLWi4GKdhe71NKcZjgOVfP9p632bcCZAIAfZaaKzS5+Xc8hwMr1r
        GAWQRBY+S8hpfV/grjiy/KI+fWIjUl6bFLSDp12v40OJRtzni6ArbiYUQhpj8vF2RHYvut
        PfSCiT47VLq3EH2LZWeJY65I8OCZVvqjEfZA/z/64Jv6CkUbhnP8MidcqHOPjfspgfkyr7
        9RRz3FxKsIRt2SoLKJfEYQdLcW+VCCz0wGfo8H0vwF8JfFjkNz627ziGSs2mln57VkoC0t
        1B8VzVK9toqtnd6ZX7Zq6rEi39JtL9Y58CzFvxfA3XEGb8rWJOHsuTx1Erms5g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1649926088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwUGtzT4Ya5DJOi91TQOaG6spJ7XBSP7OpQSwUZss98=;
        b=wJPCzT71qx5KQ17MNk0VM85QDNLRK3UrOPfpuHhqtfMdTszmmWw99YwirdLBMMNi2i2K0Y
        Xxqi2Cu1/PuZemZ7FvHmpe3iIr/7x/tvGHTW19ou4vwoBuBqMgWw9wH608vajaSQhUNKqJ
        SDxi/AoGriUAunbT5NZXThqe3Ol212JByQMV8k3195CZfkbNKG4ay42OmxBUVgc8/irVFu
        418EAnl6sdW/4fClu4RRMRvaD7AflChZdOw3D6apHriPAwHu/TJUeFPlpPgc40opjl+OY+
        yCPv0HMLWixpoRroZ5ik4kDWVvW49FbGDqXmBVfERF1wkjXF39kjn+q79hMEWA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 12:53:33PM +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/media/i2c/ov5695.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
> index 439385938a51..910309783885 100644
> --- a/drivers/media/i2c/ov5695.c
> +++ b/drivers/media/i2c/ov5695.c
> @@ -1122,7 +1122,7 @@ static int ov5695_set_ctrl(struct v4l2_ctrl *ctrl)
>  
>  	switch (ctrl->id) {
>  	case V4L2_CID_EXPOSURE:
> -		/* 4 least significant bits of expsoure are fractional part */
> +		/* 4 least significant bits of exposure are fractional part */
>  		ret = ov5695_write_reg(ov5695->client, OV5695_REG_EXPOSURE,
>  				       OV5695_REG_VALUE_24BIT, ctrl->val << 4);
>  		break;

Applied, thanks!

-- 
Sakari Ailus
