Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C04C23BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiBXFwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiBXFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:52:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68A2DF09;
        Wed, 23 Feb 2022 21:51:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE549106F;
        Wed, 23 Feb 2022 21:51:34 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA2083F66F;
        Wed, 23 Feb 2022 21:51:30 -0800 (PST)
Subject: Re: [PATCH 1/2] perf: Add more generic branch types
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-2-git-send-email-anshuman.khandual@arm.com>
 <YfpxzKa7JSlimA1i@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e9c4eab7-51b4-6794-0d02-2d325c300e33@arm.com>
Date:   Thu, 24 Feb 2022 11:21:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfpxzKa7JSlimA1i@FVFF77S0Q05N>
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



On 2/2/22 5:28 PM, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Fri, Jan 28, 2022 at 11:14:12AM +0530, Anshuman Khandual wrote:
>> This expands generic branch type classification by adding some more entries
>> , that can still be represented with the existing 4 bit 'type' field. While
>> here this also updates the x86 implementation with these new branch types.
> It looks like there's some whitespace damage here.
> 
>>From a quick scan of the below, I think the "exception return" and "IRQ
> exception" types are somewhat generic, and could be added now (aside from any
> bikeshedding over names), but:

Hi Mark,

I have sent a patch adding just PERF_BR_ERET and PERF_BR_IRQ which are generic
enough to be included now. The 'type' field still got 3 more places for future
use. Hence we should try and include two more branch types, before adding the
last entry for ABI expansion (e.g PERF_BR_EXTENDED).

https://lore.kernel.org/all/1645681014-3346-1-git-send-email-anshuman.khandual@arm.com/

- Anshuman
