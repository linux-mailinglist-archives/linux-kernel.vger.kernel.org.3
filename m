Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873445992D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbiHSB5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHSB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:56:58 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA4DEB7D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:56:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMdxZUX_1660874213;
Received: from 30.240.99.21(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMdxZUX_1660874213)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 09:56:54 +0800
Message-ID: <5bc7f671-ad41-6a0c-535e-861b130992d9@linux.alibaba.com>
Date:   Fri, 19 Aug 2022 09:56:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH V2 2/2] mm/damon/lru_sort: Remove struct of
 damon_lru_sort_ram_walk_arg
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220818172322.51705-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220818172322.51705-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/19 上午1:23, SeongJae Park 写道:
> Hi Xin,
>
> On Thu, 18 Aug 2022 18:57:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> The struct of 'damon_lru_sort_ram_walk_arg' is the same with struct of
>> 'damon_addr_range', so, there no need to redefine it, just use struct of
>> 'damon_addr_range' instead.
> Reducing code is always good, thanks.  However, I think the type of the 'start'
> and 'end' fields of 'struct damon_addr_range' might be changed in a future.
OK,  get it.
> It's very unlikely, though.  Also, we might add some more fields to the struct
> in a future.  After all, the purpose of 'struct damon_addr_range' is not saving
> the 'start' and 'end' fields of 'struct resource'.  I'd like to avoid making
> any possible dependency here, sorry.
>
>
> Thanks,
> SJ
>
> [...]
