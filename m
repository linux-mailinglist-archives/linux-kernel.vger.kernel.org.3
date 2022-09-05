Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62105ACD5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiIEIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiIEIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:04:17 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149047BA6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:04:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VOOS-JL_1662365052;
Received: from 30.221.132.103(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VOOS-JL_1662365052)
          by smtp.aliyun-inc.com;
          Mon, 05 Sep 2022 16:04:13 +0800
Message-ID: <e099ea78-cc1d-41d3-4ca7-99d5f723f440@linux.alibaba.com>
Date:   Mon, 5 Sep 2022 16:04:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] fs/ocfs2/suballoc.h: fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>, mark@fasheh.com,
        jlbec@evilplan.org, akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220905061656.1829179-1-13667453960@163.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220905061656.1829179-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/22 2:16 PM, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/suballoc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
> index 5805a03d100b..9c74eace3adc 100644
> --- a/fs/ocfs2/suballoc.h
> +++ b/fs/ocfs2/suballoc.h
> @@ -106,7 +106,7 @@ int ocfs2_claim_clusters(handle_t *handle,
>  			 u32 *cluster_start,
>  			 u32 *num_clusters);
>  /*
> - * Use this variant of ocfs2_claim_clusters to specify a maxiumum
> + * Use this variant of ocfs2_claim_clusters to specify a maximum
>   * number of clusters smaller than the allocation reserved.
>   */
>  int __ocfs2_claim_clusters(handle_t *handle,
