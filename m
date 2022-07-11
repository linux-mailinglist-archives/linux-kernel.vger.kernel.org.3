Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5096456D6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiGKHco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGKHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:32:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E464B1A39F;
        Mon, 11 Jul 2022 00:32:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10DEA176B;
        Mon, 11 Jul 2022 00:32:43 -0700 (PDT)
Received: from [10.57.12.169] (unknown [10.57.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD26F3F70D;
        Mon, 11 Jul 2022 00:32:39 -0700 (PDT)
Message-ID: <9ade9d43-3ed1-1239-f26e-73145856275a@arm.com>
Date:   Mon, 11 Jul 2022 08:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Content-Language: en-US
To:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <CAB8ipk8w1=cMJV2_ZjWuX6T9RH9VXCMdUaZhLEkCziarhpy-5w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk8w1=cMJV2_ZjWuX6T9RH9VXCMdUaZhLEkCziarhpy-5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen,

On 7/11/22 08:21, Xuewen Yan wrote:
> Hi all
> 
> This deadlock is inevitable, any comment?

Could you tell me how to reproduce this?
Is there a need of special cgroup setup?

Regards,
Lukasz
