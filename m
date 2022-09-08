Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D55B1FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIHNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIHNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:55:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824CA7645C;
        Thu,  8 Sep 2022 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=EyfNfLo5vV2B3+XKBz4A9NHtFJoeyAoyzFNjxdeTbE4=; b=auWoYLQvbVXNMIP5X1T5DoiNw6
        zZg4ee7r8fLRHXpIFnWxYeRN1W77Ni+sIgJfeUmE5ww1xvi0LWLWRzOGMBVtRS5BnwLSp6yf/vDBM
        4WDFf1fE+2pSyhjhKlWJB51Dtc1z5YjX93Bx9Y36394MPQhlbDVkFuIDfmY9CIklm7BSUoFab3hcl
        naoPUHeOG5djeyW4lBDMWsZO0PIuA46DO3v1gtXKTPrA87bQKIk8cUkklulKTNPd1UdnPtsLACPGo
        QH1wUkMQKzPcCVw9bzZ9FAbg/s7RjszqzwapANiA5EKHJ8niCevED1vnV3BIDtz/KWwReJx7vMQMk
        pg78iAUw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWI01-004DPv-8y; Thu, 08 Sep 2022 13:55:21 +0000
Message-ID: <670e8810-0646-f57e-ac14-f7e441cf5cd3@infradead.org>
Date:   Thu, 8 Sep 2022 06:55:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] input/serio: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908122835.13888-1-wangjianli@cdjrlc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220908122835.13888-1-wangjianli@cdjrlc.com>
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



On 9/8/22 05:28, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/input/serio/q40kbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
> index a1c61f5de047..fd25679af251 100644
> --- a/drivers/input/serio/q40kbd.c
> +++ b/drivers/input/serio/q40kbd.c
> @@ -81,7 +81,7 @@ static void q40kbd_stop(void)
>  
>  /*
>   * q40kbd_open() is called when a port is open by the higher layer.
> - * It allocates the interrupt and enables in in the chip.

                                     enables it in the chip.

> + * It allocates the interrupt and enables in the chip.
>   */
>  
>  static int q40kbd_open(struct serio *port)

-- 
~Randy
