Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D107659FCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiHXOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiHXOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5604598580;
        Wed, 24 Aug 2022 07:04:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B78021FB;
        Wed, 24 Aug 2022 07:04:32 -0700 (PDT)
Received: from [10.57.15.162] (unknown [10.57.15.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F7913FAF5;
        Wed, 24 Aug 2022 07:04:27 -0700 (PDT)
Message-ID: <2e450753-ab11-ad4f-830d-3da12f3846b0@arm.com>
Date:   Wed, 24 Aug 2022 15:04:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] docs: scheduler: Update new path for the sysctl knobs
Content-Language: en-US
To:     YanTeng Si <siyanteng@loongson.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, peterz@infradead.org,
        Tang Yizhou <yizhou.tang@shopee.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220816121907.841-1-lukasz.luba@arm.com>
 <325e126b-14e7-79fa-1348-53d71fd98728@loongson.cn>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <325e126b-14e7-79fa-1348-53d71fd98728@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/22 03:23, YanTeng Si wrote:
> 
> 在 2022/8/16 20:19, Lukasz Luba 写道:
>> Add missing update for the documentation bit of some scheduler knob.
>> The knobs have been moved to /debug/sched/ location (with adjusted 
>> names).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Tested-by: Yanteng Si <siyanteng@loongson.cn>
> 

Thanks for testing it!

Regards,
Lukasz

> 
> CC Yizhou
> 
> 
> Thanks,
> 
> Yanteng
> 
