Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA64A98D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiBDMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:02:20 -0500
Received: from foss.arm.com ([217.140.110.172]:39440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbiBDMCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:02:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A003F1480;
        Fri,  4 Feb 2022 04:02:17 -0800 (PST)
Received: from [10.57.88.9] (unknown [10.57.88.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A782A3F40C;
        Fri,  4 Feb 2022 04:02:15 -0800 (PST)
Message-ID: <0c235c48-49b3-42ee-f65b-0043b599bcd3@arm.com>
Date:   Fri, 4 Feb 2022 12:02:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2] coresight: trbe: Move check for kernel page table
 isolation from EL0 to probe
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        coresight@lists.linaro.org
References: <20220203190159.3145272-1-sudeep.holla@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220203190159.3145272-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 19:01, Sudeep Holla wrote:
> Currently with the check present in the module initialisation, it shouts
> on all the systems irrespective of presence of coresight trace buffer
> extensions.
> 
> Similar to Arm SPE perf driver, move the check for kernel page table
> isolation from  EL0 to the device probe stage instead of the module
> initialisation so that it complains only on the systems that support TRBE.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: coresight@lists.linaro.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks, I have now queued this.

https://git.kernel.org/coresight/c/ebbce265bba164c4f0d5271c277a540bd3b2fd3c

Kind regards
Suzuki
