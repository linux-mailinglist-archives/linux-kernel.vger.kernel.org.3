Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7007459FDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiHXPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiHXPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:01:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA063CBF0;
        Wed, 24 Aug 2022 08:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6555B8238B;
        Wed, 24 Aug 2022 15:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D2C433D6;
        Wed, 24 Aug 2022 15:01:22 +0000 (UTC)
Message-ID: <42384aba-d519-1a98-80dc-00a997e7243f@xs4all.nl>
Date:   Wed, 24 Aug 2022 17:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] i2c/cx25840: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824131619.54027-1-yuanjilin@cdjrlc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220824131619.54027-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a duplicate of:

https://patchwork.linuxtv.org/project/linux-media/patch/20220821151552.58514-1-wangjianli@cdjrlc.com/

Please check for similar patches first in the future.

Why is seemingly everyone suddenly chasing errors like this?

I don't mind taking such patches since typos like this annoy me, but
having to figure out which patches are duplicates is getting old quickly...

I'll try to go through your patches and see which are duplicates, but
next time I'd appreciate it if you would check this first.

Regards,

	Hans

On 24/08/2022 15:16, Jilin Yuan wrote:
>  Delete the redundant word 'of'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/media/i2c/cx25840/cx25840-ir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/cx25840/cx25840-ir.c b/drivers/media/i2c/cx25840/cx25840-ir.c
> index 9d7d1d149f1a..8cef9656c612 100644
> --- a/drivers/media/i2c/cx25840/cx25840-ir.c
> +++ b/drivers/media/i2c/cx25840/cx25840-ir.c
> @@ -196,7 +196,7 @@ static u32 clock_divider_to_resolution(u16 divider)
>  {
>  	/*
>  	 * Resolution is the duration of 1 tick of the readable portion of
> -	 * of the pulse width counter as read from the FIFO.  The two lsb's are
> +	 * the pulse width counter as read from the FIFO.  The two lsb's are
>  	 * not readable, hence the << 2.  This function returns ns.
>  	 */
>  	return DIV_ROUND_CLOSEST((1 << 2)  * ((u32) divider + 1) * 1000,
