Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54959FDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiHXO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiHXO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA38B995;
        Wed, 24 Aug 2022 07:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F4A16186D;
        Wed, 24 Aug 2022 14:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1818FC433D7;
        Wed, 24 Aug 2022 14:58:02 +0000 (UTC)
Message-ID: <c7d0fcdf-7eb0-f543-d1e4-a8895955d570@xs4all.nl>
Date:   Wed, 24 Aug 2022 16:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media/i2c: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824131803.55374-1-yuanjilin@cdjrlc.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220824131803.55374-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of these patches you correctly mention the driver it applies
to, and for others (like this one) you do not.

A media/i2c prefix suggests a media/i2c-wide patch, which this isn't.

Please repost with a proper prefix.

Regards,

	Hans

On 24/08/2022 15:18, Jilin Yuan wrote:
>  Delete the redundant word 'in'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/media/i2c/adv7175.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/adv7175.c b/drivers/media/i2c/adv7175.c
> index 1813f67f0fe1..945068c12763 100644
> --- a/drivers/media/i2c/adv7175.c
> +++ b/drivers/media/i2c/adv7175.c
> @@ -209,7 +209,7 @@ static int adv7175_s_std_output(struct v4l2_subdev *sd, v4l2_std_id std)
>  		/* This is an attempt to convert
>  		 * SECAM->PAL (typically it does not work
>  		 * due to genlock: when decoder is in SECAM
> -		 * and encoder in in PAL the subcarrier can
> +		 * and encoder in PAL the subcarrier can
>  		 * not be synchronized with horizontal
>  		 * quency) */
>  		adv7175_write_block(sd, init_pal, sizeof(init_pal));
