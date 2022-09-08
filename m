Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1305B1FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiIHN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIHNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:55:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57462A3D61;
        Thu,  8 Sep 2022 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Lr/PQpeByMLLN+ILQwpeyfV6Da7XXJFl68gYJENbuhA=; b=WaIQZNhzo4T0/dmF2oe0ILT0HB
        CMkPKTAxWhcnd+P/yjg6F/XIDQOm3O0bDRDNkZMgX8RfD7lqJqsHfceFPCWmQhtBABiQvLndRpJhb
        JTSIV/pudRsBHWkWiD+TNDcxPAId5Ncnuqd/l0tyv4l3uqp5V/2O/0xaVbeslLx2eXx4tYKvSUQ1e
        igqXW4oRiY3Upcx3iBJCHG7uj9WAUQw7s1qbip9HcpKuj/1CRq5B3azRsvJpAEKPHSGe1BOGqAxKu
        wXNHgvYoeo/R8G3xOb83I46mByV8wQ4vWzWRituBIhHhkV3C9ZAX1x3JoNtLq0QXZxBfc6mtAru7D
        hCJtBsJA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWI0U-004E9Q-Pp; Thu, 08 Sep 2022 13:55:50 +0000
Message-ID: <530783de-fc1b-bfc3-1027-bcec919ac3ab@infradead.org>
Date:   Thu, 8 Sep 2022 06:55:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] media/i2c: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908123000.15066-1-wangjianli@cdjrlc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220908123000.15066-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/22 05:30, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/media/i2c/adv7175.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/adv7175.c b/drivers/media/i2c/adv7175.c
> index b58689728243..bc8f8bbedb45 100644
> --- a/drivers/media/i2c/adv7175.c
> +++ b/drivers/media/i2c/adv7175.c
> @@ -209,7 +209,7 @@ static int adv7175_s_std_output(struct v4l2_subdev *sd, v4l2_std_id std)
>  		/* This is an attempt to convert
>  		 * SECAM->PAL (typically it does not work
>  		 * due to genlock: when decoder is in SECAM
> -		 * and encoder in in PAL the subcarrier can

		               is in

> +		 * and encoder in PAL the subcarrier can
>  		 * not be synchronized with horizontal
>  		 * quency) */
>  		adv7175_write_block(sd, init_pal, sizeof(init_pal));

-- 
~Randy
