Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762E4AB874
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354794AbiBGKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245359AbiBGKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:08:34 -0500
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 02:08:33 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70C02C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:08:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A5256D;
        Mon,  7 Feb 2022 02:03:16 -0800 (PST)
Received: from [10.57.2.42] (unknown [10.57.2.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD5123F718;
        Mon,  7 Feb 2022 02:03:14 -0800 (PST)
Message-ID: <4f3d1563-0e85-5826-4602-090ec4ff3272@arm.com>
Date:   Mon, 7 Feb 2022 10:03:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/15] Make ETM register accesses consistent with
 sysreg.h
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220203120604.128396-1-james.clark@arm.com>
 <609d9678-e8c7-163f-86cf-0207c59db2c3@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <609d9678-e8c7-163f-86cf-0207c59db2c3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2022 05:51, Anshuman Khandual wrote:
> Hi James,
> 
> On 2/3/22 5:35 PM, James Clark wrote:
>> James Clark (15):
>>   coresight: Make ETM4x TRCIDR0 register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCIDR2 register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCIDR3 register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCIDR4 register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCIDR5 register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCCONFIGR register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCEVENTCTL1R register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCSTALLCTLR register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCVICTLR register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM3x ETMTECR1 register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCACATRn register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCSSCCRn and TRCSSCSRn register accesses
>>     consistent with sysreg.h
>>   coresight: Make ETM4x TRCSSPCICRn register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCBBCTLR register accesses consistent with
>>     sysreg.h
>>   coresight: Make ETM4x TRCRSCTLRn register accesses consistent with
>>     sysreg.h
> 
> The changes here are very similar to each other. But they are split
> into different patches according to register names just for better
> review process ? OR is there any other rationale ?

Yes just for the review process. I didn't see a way of reviewing them all
in one change because it's so big, and the only logical way to split it was
by register so I did it that way.

> 
> - Anshuman
