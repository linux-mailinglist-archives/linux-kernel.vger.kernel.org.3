Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D25B1FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiIHOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIHOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:00:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F726AE9;
        Thu,  8 Sep 2022 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OUSyiJccN0JA1RsOFWJ93C9GLO3AD1GM6cOow/MREUY=; b=RHxqGZlFjGgB7VylinpVrXWz/a
        xG7T9QQ8JiAKslaMiYcQiLLPHaprY3k+mHcyomForOeXvw0fEVKNn2EEj/K/UOpodFsA6mhiKOjVm
        IjHP7TKkAwfnQpAxpdM7ZaA+dgkSpiH8fQTEDcrdghK/UoQbXtoMTadkiPI8tjRnRxHDIpUh6cxJr
        hheR8HaUXvGozuO4xBwC3EvOGBJhrn8vueSiuMiKzXt3iIh58OcWH/yx5ms933aG986mYikoqKZBz
        2Wc5t5ywIou1z856RxPWkB4ex+37SxIKgwzuLr+2fYGKwdYoSVYRCAhicfQifJGVZVpeHxzrPAZXh
        UzhCUZSw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWI4D-004IoF-Km; Thu, 08 Sep 2022 13:59:41 +0000
Message-ID: <279a33de-219e-b7fa-aad3-215a81327660@infradead.org>
Date:   Thu, 8 Sep 2022 06:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] atomisp/pci: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220908125246.27419-1-wangjianli@cdjrlc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220908125246.27419-1-wangjianli@cdjrlc.com>
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

Hi,

On 9/8/22 05:52, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/staging/media/atomisp/pci/ia_css_irq.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

For all of these, I would s/in in/is in/.
Thanks.

> diff --git a/drivers/staging/media/atomisp/pci/ia_css_irq.h b/drivers/staging/media/atomisp/pci/ia_css_irq.h
> index 26b1b3c8ba62..8f2e876a0b2b 100644
> --- a/drivers/staging/media/atomisp/pci/ia_css_irq.h
> +++ b/drivers/staging/media/atomisp/pci/ia_css_irq.h
> @@ -84,11 +84,11 @@ enum ia_css_irq_info {
>  	IA_CSS_IRQ_INFO_ISP_BINARY_STATISTICS_READY   = BIT(17),
>  	/** ISP binary statistics are ready */
>  	IA_CSS_IRQ_INFO_INPUT_SYSTEM_ERROR            = BIT(18),
> -	/** the input system in in error */
> +	/** the input system in error */
>  	IA_CSS_IRQ_INFO_IF_ERROR                      = BIT(19),
> -	/** the input formatter in in error */
> +	/** the input formatter in error */
>  	IA_CSS_IRQ_INFO_DMA_ERROR                     = BIT(20),
> -	/** the dma in in error */
> +	/** the dma in error */
>  	IA_CSS_IRQ_INFO_ISYS_EVENTS_READY             = BIT(21),
>  	/** end-of-frame events are ready in the isys_event queue */
>  };

-- 
~Randy
