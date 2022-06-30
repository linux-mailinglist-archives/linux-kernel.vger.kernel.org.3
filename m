Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18C85619BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiF3L7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiF3L66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:58:58 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FBD52393
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:58:57 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1o6sor-0008S7-1B; Thu, 30 Jun 2022 13:58:49 +0200
Date:   Thu, 30 Jun 2022 13:58:49 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: r8188eu: remove unneeded semicolon
Message-ID: <20220630115848.hkzavd67cwjubjq4@viti.kaiser.cx>
References: <20220630090937.4983-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630090937.4983-1-yang.lee@linux.alibaba.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Yang Li (yang.lee@linux.alibaba.com):

> Eliminate the following coccicheck warning:
> ./drivers/staging/r8188eu/hal/HalPwrSeqCmd.c:70:2-3: Unneeded semicolon

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
> index b5f6d41464db..5b0f66573d94 100644
> --- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
> +++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
> @@ -67,7 +67,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, enum r8188eu_pwr_seq seq)
>  		break;
>  	default:
>  		return false;
> -	};
> +	}

>  	do {
>  		pwrcfgcmd = pwrseqcmd[aryidx];
> -- 
> 2.20.1.7.g153144c

Thanks for spotting this.

Fixes: df8d0a55047b ("staging: r8188eu: make power sequences static")
Reviewed-by: Martin Kaiser <martin@kaiser.cx>
