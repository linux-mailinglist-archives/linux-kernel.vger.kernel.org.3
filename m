Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FE59FC74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiHXN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiHXN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:59:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98DB33BF;
        Wed, 24 Aug 2022 06:59:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D444ED1;
        Wed, 24 Aug 2022 06:59:22 -0700 (PDT)
Received: from [10.57.15.80] (unknown [10.57.15.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5075B3FAF5;
        Wed, 24 Aug 2022 06:59:16 -0700 (PDT)
Message-ID: <d79df47e-e7b2-8492-7425-bd6030679b57@arm.com>
Date:   Wed, 24 Aug 2022 14:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] coresight: etm4x: docs: Add documentation for
 'ts_source' sysfs interface
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org
References: <20220823160650.455823-1-james.clark@arm.com>
 <20220823160650.455823-3-james.clark@arm.com>
 <fc054b1c-b3c8-f627-d4c1-d916a2d286ca@gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <fc054b1c-b3c8-f627-d4c1-d916a2d286ca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/08/2022 03:54, Bagas Sanjaya wrote:
> On 8/23/22 23:06, James Clark wrote:
>> +:Example:
>> +    ``$> cat ts_source``
>> +
>> +    ``$> 1``
>> +
> 
> Shouldn't literal code block be used instead for example snippet
> above?
> 

It's consistent with the rest of the file. I think consistency for
something like this is more important than accuracy otherwise the new
entry would appear out of place.

Maybe they should all be changed to a different style, but that would be
a separate change unrelated to this set.

James
