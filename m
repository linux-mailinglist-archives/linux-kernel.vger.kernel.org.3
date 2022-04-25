Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CC150E3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiDYPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiDYPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:08:01 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7F56218
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:04:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VBH15Sj_1650899090;
Received: from 30.32.75.239(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VBH15Sj_1650899090)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 23:04:53 +0800
Message-ID: <41b404c7-78cb-8b5f-2b89-8ab7bd13ded9@linux.alibaba.com>
Date:   Mon, 25 Apr 2022 23:04:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] sched/core: Skip sched_core_fork/free() when core
 sched is disabled
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <1650831454-101777-1-git-send-email-CruzZhao@linux.alibaba.com>
 <20220425081410.GA2731@worktop.programming.kicks-ass.net>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <20220425081410.GA2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/25 下午4:14, Peter Zijlstra 写道:
> On Mon, Apr 25, 2022 at 04:17:34AM +0800, Cruz Zhao wrote:
>> As __put_task_struct() and copy_process() are hot path functions,
>> the call of sched_core_fork/free() will bring overhead when core
>> sched is disabled, and we skip them in these cases.
> 
> Only if you have profile data.. mostly these functions do whole lot of
> nothing.

Many thanks for suggestion, I'll test it.

Best wishes,
Cruz Zhao
