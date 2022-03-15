Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177BD4D967E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbiCOIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiCOIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:43:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C391E4CD62;
        Tue, 15 Mar 2022 01:42:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68DAF1474;
        Tue, 15 Mar 2022 01:42:17 -0700 (PDT)
Received: from [10.57.22.32] (unknown [10.57.22.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706CD3F766;
        Tue, 15 Mar 2022 01:42:15 -0700 (PDT)
Message-ID: <99845680-c2a5-2538-a57c-6fbf395faa8b@arm.com>
Date:   Tue, 15 Mar 2022 08:42:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3] coresight: core: Fix coresight device probe failure
 issue
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220309142206.15632-1-quic_jinlmao@quicinc.com>
 <a1790ad9-b5e0-9a00-debc-fc8ef2c757cb@arm.com>
 <9cbb2e86-640f-4b5d-22ff-00c63a1b9743@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9cbb2e86-640f-4b5d-22ff-00c63a1b9743@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 08:36, Jinlong Mao wrote:
> On 3/10/2022 5:10 PM, Suzuki K Poulose wrote:
>> Hi Jinlong
>>
>>
>> On 09/03/2022 14:22, Mao Jinlong wrote:
>>> It is possibe that probe failure issue happens when the device
>>> and its child_device's probe happens at the same time.
>>> In coresight_make_links, has_conns_grp is true for parent, but
>>> has_conns_grp is false for child device as has_conns_grp is set
>>> to true in coresight_create_conns_sysfs_group. The probe of parent
>>> device will fail at this condition. Add has_conns_grp check for
>>> child device before make the links and make the process from
>>> device_register to connection_create be atomic to avoid this
>>> probe failure issue.
>>>
>>> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Suggested-by: Mike Leach <mike.leach@linaro.org>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>
>> Thanks for the rework. The patch looks good to me.
>>
>> Suzuki
> Thanks Suzuki.
> 
> Hi Mathieu & Mike,
> 
> Could you please help to review and provide your comments for the PATCH 
> V3 ?

Thats what I just said above. The patch looks good to me, I can queue
this in the next cycle.

Kind regards
Suzuki

> 
> Thanks
> Jinlong Mao

