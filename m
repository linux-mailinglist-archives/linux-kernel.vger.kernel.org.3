Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0403C4A83AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiBCMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:17:23 -0500
Received: from foss.arm.com ([217.140.110.172]:43324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241756AbiBCMRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:17:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD3311D4;
        Thu,  3 Feb 2022 04:17:22 -0800 (PST)
Received: from [10.163.44.35] (unknown [10.163.44.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6D03F774;
        Thu,  3 Feb 2022 04:17:19 -0800 (PST)
Subject: Re: [PATCH] coresight: trbe: Move check for kernelspace unmapped at
 EL0 to probe
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org
References: <20220201122212.3009461-1-sudeep.holla@arm.com>
 <01a43ba2-a633-f215-a688-2bda293b5a47@arm.com>
 <20220203101111.mx3o5kmo2bkjirn4@bogus>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8fe55cd3-489c-4826-c3dd-a6a4641c47da@arm.com>
Date:   Thu, 3 Feb 2022 17:47:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220203101111.mx3o5kmo2bkjirn4@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/22 5:34 PM, Sudeep Holla wrote:
>> Could you please add a similar comment like SPE driver regarding how
>> the TRBE buffer will be inaccessible, if kernel gets unmapped at EL0
>> and trace capture will terminate.
>>
> Sure I can add that. But if the device probe fails, will you be able to even
> start the trace capture, sorry I didn't get what you mean by "trace capture
> will terminate". I assume it must be "trace capture is not possible or not
> allowed" IIUC.

I guess the comment should be framed like - what might happen if the following
code block which checks for arm64_kernel_unmapped_at_el0() is not present. If
TRBE gets enabled along with kernel unmapping at EL0 supported, trace capture
will terminate.
