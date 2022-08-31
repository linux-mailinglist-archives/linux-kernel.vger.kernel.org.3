Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF865A72F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiHaAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiHaAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:49:00 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE44DA4054;
        Tue, 30 Aug 2022 17:48:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNoHDv4_1661906930;
Received: from 30.227.181.248(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNoHDv4_1661906930)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 08:48:51 +0800
Message-ID: <d81db7ff-6c5a-ff8c-ca1e-6d08474c202b@linux.alibaba.com>
Date:   Wed, 31 Aug 2022 08:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
 <0001ab1d-b4c0-2ac1-f902-c61216204aef@nvidia.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <0001ab1d-b4c0-2ac1-f902-c61216204aef@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/30 20:48, Chaitanya Kulkarni wrote:

> On 8/30/22 02:45, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> Change "bio_set_ioprio" to inline to avoid calling overhead.
>>
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> for performance overhead please provide quantitative data
>
> -ck
>
This is a small adjustment, and even if performance comparison data is 
obtained
for targeted design use cases, it is not universal. If the inline by the 
compiler is
successful, the number of instructions will be reduced.

Thanks

>
