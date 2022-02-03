Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97024A8397
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiBCMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:10:17 -0500
Received: from foss.arm.com ([217.140.110.172]:42926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240219AbiBCMKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:10:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8725C11D4;
        Thu,  3 Feb 2022 04:10:15 -0800 (PST)
Received: from [10.57.89.13] (unknown [10.57.89.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431953F774;
        Thu,  3 Feb 2022 04:10:14 -0800 (PST)
Message-ID: <30df2340-c3b6-a5f2-5e7e-32eb89a51b68@arm.com>
Date:   Thu, 3 Feb 2022 12:10:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 1/1] coresight: no-op refactor to make INSTP0 check more
 idiomatic
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220203115336.119735-1-james.clark@arm.com>
 <20220203115336.119735-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220203115336.119735-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 11:53, James Clark wrote:
> The spec says this:
> 
>    P0 tracing support field. The permitted values are:
>        0b00  Tracing of load and store instructions as P0 elements is not
>              supported.
>        0b11  Tracing of load and store instructions as P0 elements is
>              supported, so TRCCONFIGR.INSTP0 is supported.
> 
>              All other values are reserved.
> 
> The value we are looking for is 0b11 so simplify this. The double read
> and && was a bit obfuscated.
> 
> Suggested-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks, Queued.

Cheers
Suzuki
