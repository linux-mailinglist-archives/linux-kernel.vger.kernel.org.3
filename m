Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B63534CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbiEZJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiEZJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:59:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502EBC9ED6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:59:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BBA41474;
        Thu, 26 May 2022 02:59:39 -0700 (PDT)
Received: from [10.57.38.20] (unknown [10.57.38.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D523F70D;
        Thu, 26 May 2022 02:59:37 -0700 (PDT)
Message-ID: <f43d759d-dc07-e2cd-6865-32a91d8c4096@arm.com>
Date:   Thu, 26 May 2022 10:59:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
To:     Alexei Budankov <abudankov@huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        gregkh@linuxfoundation.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Budankov <alexey.budankov@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
 <853b6d52-da86-1c06-3604-3085ece331a4@huawei.com>
 <5dd1bd83-232a-07e4-8fde-e4f6cd0e5b8c@huawei.com>
 <93b92859-2229-8766-09d2-df16e1ebd4e8@huawei.com>
 <50c25ce8-15bc-80a8-59dc-a20571a6460a@huawei.com>
 <13ee708e-17a7-7e0d-7d24-827c3786f007@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <13ee708e-17a7-7e0d-7d24-827c3786f007@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi



On 26/05/2022 09:00, Alexei Budankov wrote:
> Hi,
> 
> On 26.05.2022 10:47, liuqi (BA) wrote:
>>
>>
>> On 2022/5/26 15:23, Alexei Budankov wrote:
>>> Hi Qi,
>>>
> <SNIP>
>>>
>>> Look like our server firmware should be upgraded, right?
>>
>> Yes, seems firmware should be upgraded first, and then you could test ETM device :)
> 
> I would appreciate if you could share some links to upgrade bits and docs, if possible,
> so we could use it to perform the upgrade.

Does your system use ACPI based firmware ? If that is
the case, we do not have the support for ETM with system instructions
at the moment. Anshuman is currently working on addressing
this.

Cheers
Suzuki

> 
> Thanks, > Alexei
> 

