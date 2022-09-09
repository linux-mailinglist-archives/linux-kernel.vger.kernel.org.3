Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E045B2BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIIBau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIIBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:30:27 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6512C2777
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:30:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VP6wCSJ_1662686961;
Received: from 30.221.129.5(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VP6wCSJ_1662686961)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 09:29:22 +0800
Message-ID: <ed4247e0-78ec-6312-9a8f-797400a85442@linux.alibaba.com>
Date:   Fri, 9 Sep 2022 09:29:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] fs/ocfs2: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, mark@fasheh.com,
        jlbec@evilplan.org, akpm <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220908130036.31149-1-wangjianli@cdjrlc.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220908130036.31149-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/22 9:00 PM, wangjianli wrote:
> Delete the redundant word 'to'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/refcounttree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index b2ebaec86ddc..365025ab2726 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -2614,7 +2614,7 @@ static inline unsigned int ocfs2_cow_align_length(struct super_block *sb,
>  }
>  
>  /*
> - * Calculate out the start and number of virtual clusters we need to to CoW.
> + * Calculate out the start and number of virtual clusters we need to CoW.
>   *
>   * cpos is vitual start cluster position we want to do CoW in a
>   * file and write_len is the cluster length.
