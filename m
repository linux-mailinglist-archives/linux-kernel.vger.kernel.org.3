Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DB533A66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiEYKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiEYKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:06:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A7CE18B10;
        Wed, 25 May 2022 03:06:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72851FB;
        Wed, 25 May 2022 03:06:16 -0700 (PDT)
Received: from [10.57.38.12] (unknown [10.57.38.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103723F73D;
        Wed, 25 May 2022 03:06:14 -0700 (PDT)
Message-ID: <8fed7c83-40ad-065a-847f-1faa491d44a0@arm.com>
Date:   Wed, 25 May 2022 11:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3 0/4] coresight: Add config flag to enable branch
 broadcast
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, mike.leach@linaro.org
Cc:     leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511144601.2257870-1-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220511144601.2257870-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,



On 11/05/2022 15:45, James Clark wrote:
> Apologies for the delay.
> 
> Changes since v2:
> 
>   * Pick up some of Mike's review tags
>   * Add a comment explaining rationale for not opening the event when BB isn't
>     supported
>   * Extend docs to say that Perf doesn't support decode when binaries are
>     modified
>   * Drop Perf side patches that were already merged
> 
> Thanks
> James
> 
> James Clark (4):
>    coresight: Add config flag to enable branch broadcast
>    Documentation: coresight: Turn numbered subsections into real
>      subsections
>    Documentation: coresight: Link config options to existing
>      documentation
>    Documentation: coresight: Expand branch broadcast documentation


The series looks good to me. Apologies, this missed the 5.19 window.
I will queue this for 5.20 at -rc1.


Suzuki

> 
>   .../coresight/coresight-etm4x-reference.rst   | 17 +++++-
>   Documentation/trace/coresight/coresight.rst   | 56 +++++++++++++++++--
>   .../hwtracing/coresight/coresight-etm-perf.c  |  2 +
>   .../coresight/coresight-etm4x-core.c          | 14 +++++
>   include/linux/coresight-pmu.h                 |  2 +
>   5 files changed, 85 insertions(+), 6 deletions(-)
> 

