Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415DC4AB401
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiBGFy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbiBGFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 00:51:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5AEFC0401D8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 21:51:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C40ED6E;
        Sun,  6 Feb 2022 21:51:22 -0800 (PST)
Received: from [10.163.45.31] (unknown [10.163.45.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CEE43F718;
        Sun,  6 Feb 2022 21:51:19 -0800 (PST)
Subject: Re: [PATCH v2 00/15] Make ETM register accesses consistent with
 sysreg.h
To:     James Clark <james.clark@arm.com>, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220203120604.128396-1-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <609d9678-e8c7-163f-86cf-0207c59db2c3@arm.com>
Date:   Mon, 7 Feb 2022 11:21:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220203120604.128396-1-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/3/22 5:35 PM, James Clark wrote:
> James Clark (15):
>   coresight: Make ETM4x TRCIDR0 register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCIDR2 register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCIDR3 register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCIDR4 register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCIDR5 register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCCONFIGR register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCEVENTCTL1R register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCSTALLCTLR register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCVICTLR register accesses consistent with
>     sysreg.h
>   coresight: Make ETM3x ETMTECR1 register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCACATRn register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCSSCCRn and TRCSSCSRn register accesses
>     consistent with sysreg.h
>   coresight: Make ETM4x TRCSSPCICRn register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCBBCTLR register accesses consistent with
>     sysreg.h
>   coresight: Make ETM4x TRCRSCTLRn register accesses consistent with
>     sysreg.h

The changes here are very similar to each other. But they are split
into different patches according to register names just for better
review process ? OR is there any other rationale ?

- Anshuman
