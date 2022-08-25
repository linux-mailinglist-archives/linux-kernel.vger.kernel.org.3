Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F55A0DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiHYKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiHYKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:23:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE54F18A;
        Thu, 25 Aug 2022 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tnPAFjnvlVD7F6omr7d7Jf1+sV6a0bgO1MSet6Ch/mQ=; b=lkmkoN4iSClaaXFDh9FmYeOlQx
        e/MXCY42EF7WI+W1iliA3JtGlIsx3KC0nJNaK3umLIhTOaikX5TRCPKgtfF6776La+FZ+ere0G5+S
        w1o95MPXod8ihuR84kqgbHxsCEgM8ZmMP1GqOgqc9rb2zJNKPZEu2eP8pRYH9zvxwqxe7FC9hneg8
        yr+qhnQ5JbCiNGor+VNMf413/8IUITtAlJxQt2CRjGpNTljpFmsrbGatBSdBaRzewejiXFDtNKLXn
        J97IhP+KPVUksObRcl0UPet/59AF7Ds71GR1S1tyzrkoxYib+sW1wDyzRUTTNbRb3k+EVAOGZ6+Gd
        YJChPLPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRA0j-005ysD-3k; Thu, 25 Aug 2022 10:22:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD4AA98014D; Thu, 25 Aug 2022 12:22:51 +0200 (CEST)
Date:   Thu, 25 Aug 2022 12:22:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V7 0/8] perf: Expand perf_branch_entry
Message-ID: <YwdNe52eS6LO/KJe@worktop.programming.kicks-ass.net>
References: <20220824044822.70230-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824044822.70230-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:18:14AM +0530, Anshuman Khandual wrote:
> Anshuman Khandual (8):
>   perf: Add system error and not in transaction branch types
>   perf: Extend branch type classification
>   perf: Capture branch privilege information
>   perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

I picked up these first 4 and rebased them on top of the recent AMD LBR
patches.

They live in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core

for robot exposure. If all goes well they'll land in -tip.
