Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACD50EAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbiDYUfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiDYUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:35:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D03ECCEC;
        Mon, 25 Apr 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sFLxX7FTHxnDRDtuXAaHigLWyZS/TxESdyP0wbN+vMY=; b=ORlXX/IpGxwfgY4pZbZTssEEsT
        +QSLfwPd6qmS3TrvRMB1zZ5rIy0khieIEYns1MPyCO89hjUuFh0rGAV6+WyHv9eWhyCFFElbDcRsJ
        ccur8cvYESiHWtklixCMcBSKsB69T8L8TFqtlCarmAKRN6AhmK6N1XEW4I/s4PAWNEfAEL3BBaglt
        ZLJg2XBgSi+r8Lz52aTW+G3KC+y5Jaq+48pbStPsKDVhbvQz1l5OXJr9kYJD2P1pI3RCihD1PrQNP
        b5gLZRHqs35F2xf/uTL6XS6ijbfFs058J3akvNaLqye+vTLfmhLflICqP01IF4NnEF7h82D/Iojxi
        V+dzbRfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj5Nh-0090VQ-0a; Mon, 25 Apr 2022 20:32:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87460980DCD; Mon, 25 Apr 2022 22:32:22 +0200 (CEST)
Date:   Mon, 25 Apr 2022 22:32:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, irogers@google.com, yao.jin@linux.intel.com,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com, rrichter@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 0/6] perf/amd: Zen4 IBS extensions support
Message-ID: <20220425203222.GN2731@worktop.programming.kicks-ass.net>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-1-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:13:17AM +0530, Ravi Bangoria wrote:
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 Miss Filtering capability. Both are
> indicated by CPUID_Fn8000001B_EAX bit 11.

Hi Ravi, could you perhaps also look at fixing this existing IBS
problem?

  https://lkml.kernel.org/r/YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net
