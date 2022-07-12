Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4643F57108F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiGLDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGLDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:04:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFFE9255B7;
        Mon, 11 Jul 2022 20:04:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 213BC1A25;
        Mon, 11 Jul 2022 20:04:09 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C053F792;
        Mon, 11 Jul 2022 20:04:06 -0700 (PDT)
Message-ID: <06670b4a-7888-f0a8-87f4-dfe9c7138aa2@arm.com>
Date:   Tue, 12 Jul 2022 08:34:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] perf/core: Add macros for possible
 sysctl_perf_event_paranoid values
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
References: <20220701063949.1769434-1-anshuman.khandual@arm.com>
 <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com>
 <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
 <d03e334a-ec7e-cd87-7f0b-ac7564266d3a@arm.com>
 <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
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



On 7/11/22 17:49, Peter Zijlstra wrote:
> On Mon, Jul 11, 2022 at 02:55:12PM +0530, Anshuman Khandual wrote:
>> Enumerating [-1, 0, 1, 2] paranoid range values in kernel too, does not add
>> much value as well ?
> 
> That's what the user-interface requires as well. How is obscuring the
> values the user has to explicitly poke in help things?

Right, users still have the write raw numbers into the sysfs file.
