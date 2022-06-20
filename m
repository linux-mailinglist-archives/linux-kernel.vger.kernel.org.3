Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C1A551351
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiFTIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiFTIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:51:00 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264012D05;
        Mon, 20 Jun 2022 01:50:58 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5DC0961EA1928;
        Mon, 20 Jun 2022 10:50:55 +0200 (CEST)
Message-ID: <7dde0710-411d-52ef-df83-dcb3d667a9dc@molgen.mpg.de>
Date:   Mon, 20 Jun 2022 10:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] pinctrl: aspeed: Fix typo in comment
Content-Language: en-US
To:     Xiang Wang <wangxiang@cdjrlc.com>
Cc:     andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, joel@jms.id.au,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20220618130854.12321-1-wangxiang@cdjrlc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220618130854.12321-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Xiang,


Am 18.06.22 um 15:08 schrieb Xiang wangx:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Should this be Xiang Wang?

> ---
>   drivers/pinctrl/aspeed/pinmux-aspeed.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
> index 4d7548686f39..aaa78a613196 100644
> --- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
> +++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
> @@ -632,7 +632,7 @@ struct aspeed_pin_desc {
>   	SIG_EXPR_LIST_ALIAS(pin, sig, group)
>   
>   /**
> - * Similar to the above, but for pins with a dual expressions (DE) and
> + * Similar to the above, but for pins with a dual expressions (DE)
>    * and a single group (SG) of pins.
>    *
>    * @pin: The pin the signal will be routed to

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards

Paul
