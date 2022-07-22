Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6157D806
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiGVBd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVBd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:33:27 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD33915FDB;
        Thu, 21 Jul 2022 18:33:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VK2qCxt_1658453602;
Received: from 30.227.66.27(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VK2qCxt_1658453602)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 09:33:22 +0800
Message-ID: <9e8b39ec-bfda-2e60-2626-f55ec95bd268@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 09:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] ocfs2: Fix a typo in a comment
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        akpm@linux-foundation.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
References: <cover.1658436259.git.christophe.jaillet@wanadoo.fr>
 <4d4a6786e8ad522bfad6d2401b7f6634f8af0e5d.1658436259.git.christophe.jaillet@wanadoo.fr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <4d4a6786e8ad522bfad6d2401b7f6634f8af0e5d.1658436259.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/22 4:49 AM, Christophe JAILLET wrote:
> s/heartbaet/heartbeat
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> v1 -> v2
> - this patch is new in the serie
> ---
>  fs/ocfs2/heartbeat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
> index dd29d60af154..22da768e65b7 100644
> --- a/fs/ocfs2/heartbeat.c
> +++ b/fs/ocfs2/heartbeat.c
> @@ -2,7 +2,7 @@
>  /*
>   * heartbeat.c
>   *
> - * Register ourselves with the heartbaet service, keep our node maps
> + * Register ourselves with the heartbeat service, keep our node maps
>   * up to date, and fire off recovery when needed.
>   *
>   * Copyright (C) 2002, 2004 Oracle.  All rights reserved.
