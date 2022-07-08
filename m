Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83556BA0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiGHMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbiGHMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:50:02 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 05:50:01 PDT
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3121CFD8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:50:01 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C983A5C2954;
        Fri,  8 Jul 2022 14:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1657283485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqAvq/GhL5mtj7Qz9VEZ6cs8bwCibZT0jtcphktb7Bc=;
        b=M+qqPYFOdsYSXQGWnaduOOtfheVya7W5w4Y3/dNbxtIfcYzVrIwGkuMidKPTuZxgPJin/M
        cqmRiaxWCgRgrGzd+MpWgaioeHMlO4K7YTPMd4WoN52q2XnpmbClIGn70vg33yP8AWAqqW
        a/SKhNt3MYUbkW7OyKmYpCO7cHT6a7Q=
MIME-Version: 1.0
Date:   Fri, 08 Jul 2022 14:31:25 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     linus.walleij@linaro.org, aisheng.dong@nxp.com, festevam@gmail.com,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] MAINTAINERS: Update freescale pin controllers maintainer
In-Reply-To: <20220708100952.1998673-1-ping.bai@nxp.com>
References: <20220708100952.1998673-1-ping.bai@nxp.com>
Message-ID: <082e1f7cb783479edb34e2b3321eded7@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 12:09, Jacky Bai wrote:
> Add myself as co-maintainer of freescale pin controllers driver.

Acked-by: Stefan Agner <stefan@agner.ch>

While at it, can you remove myself from the list of maintainers? I don't
work with NXP hardware lately.

--
Stefan

> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..fbed6cc287b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15557,6 +15557,7 @@ M:	Dong Aisheng <aisheng.dong@nxp.com>
>  M:	Fabio Estevam <festevam@gmail.com>
>  M:	Shawn Guo <shawnguo@kernel.org>
>  M:	Stefan Agner <stefan@agner.ch>
> +M:	Jacky Bai <ping.bai@nxp.com>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
