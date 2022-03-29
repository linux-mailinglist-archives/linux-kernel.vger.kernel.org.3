Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89574EB00E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiC2PRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiC2PRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:17:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF802487AB;
        Tue, 29 Mar 2022 08:15:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2E3511F440E4;
        Tue, 29 Mar 2022 16:15:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648566937;
        bh=tRIkjtG4pbdks1OvKABedOH6x5n2i89uoA1nszYYfVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5O08sppqnofl1fgk7tEZZI+RkzIHj6AjKB49ryVMp2dQuY7iyTSLLk++5VxhgKHp
         gghpl6LO0jvK0jo/KfCeY6CGjK03oXQHF3ilp2xFvTWAnyoKVGhVYL7PlIdosLetah
         ia53bS63TZgxZv+Gc6PGZmz5UeK3Qpvt1ndDy5Va4c69ihkFT5rQ4AZITESGcoH6hJ
         COA+O951XSCJvcMqU6t7viNgvs2oTsvlfbgrkdTyYJuRzPIRE9iRTRM+DVAPCYjgoJ
         DxvGdNrBeXT3911sMqT9Sjc/9rPnTtFY6ytbOO7GbjQ44PrRkR4c44t6+nZPwFfZED
         uz7oheTxATbUg==
Date:   Tue, 29 Mar 2022 17:15:33 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/24] media: rkvdec: Stop overclocking the decoder
Message-ID: <20220329151533.2pl2mkuwdhqg7qhy@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-13-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-13-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>While this overclock hack seems to works on some implementation (some

s/implementation/implementations/

>ChromeBooks, RockPi4) it is also causing instability on other

s/causing/causes/

>implementation (notably LibreComputer Renegade, but saw more reports in

s/implementation/implementations/

s/but saw more reports/but there were more reports/

>the LibreELEC project, were this is already removed). While performance is

s/were this is/where this is/

>indeed affectied (tested with GStreamer), 4K playback still works as long

s/affectied/affected/

>as you don't operate in lock step and keep at least 1 frame ahead of time

s/lock step/lock step mode/

>in the decode queue.
>
>After discussion with ChromeOS members, it would seem that their
>implementation indeed synchronously decode each frames, so this hack was

s/decode each frames/decodes each frame/

>simply compensating for their code being less efficienti. This hack

s/efficienti/efficient/

>should in my opinion have stayed downstream and I'm removing it to ensure

s/This hack should in my opinion have stayed downstream/
   In my opinion, this hack should not have been included upstream/

>stability across all RK3399 variants.
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian

>---
> drivers/staging/media/rkvdec/rkvdec.c | 6 ------
> 1 file changed, 6 deletions(-)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>index c0cf3488f970..2df8cf4883e2 100644
>--- a/drivers/staging/media/rkvdec/rkvdec.c
>+++ b/drivers/staging/media/rkvdec/rkvdec.c
>@@ -1027,12 +1027,6 @@ static int rkvdec_probe(struct platform_device *pdev)
> 	if (ret)
> 		return ret;
>
>-	/*
>-	 * Bump ACLK to max. possible freq. (500 MHz) to improve performance
>-	 * When 4k video playback.
>-	 */
>-	clk_set_rate(rkvdec->clocks[0].clk, 500 * 1000 * 1000);
>-
> 	rkvdec->regs = devm_platform_ioremap_resource(pdev, 0);
> 	if (IS_ERR(rkvdec->regs))
> 		return PTR_ERR(rkvdec->regs);
>-- 
>2.34.1
>
