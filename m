Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F0B5615B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiF3JMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiF3JMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:12:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2219290;
        Thu, 30 Jun 2022 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fKhp50+9SIhJMYax6I+Xr+ALEZw4CNs891R7EBo08tc=; b=fvoqC2XxraUH4aFRYOsIg+7wBt
        tYrWYqJ8BIUpxouvnTFY22ZcSBNYguGyY6pJ8RKdvnzbJwug+MmqiGP4A2Ke9Vph/PC6/7+/QnytJ
        CQaaXHlVNe6PL+RfjSwzSaRagi5zMX0Zg41450e7Z+ZhGIYxsfx75JsD7HLpaMjhbhPLy+dI476er
        CK589w5tPp7RXXlEUFSBYDUMqM5rxcS9ZWcqFM4bcD+hEW3loyKvjaonJL96xOP6S0fM0vsqqmAht
        KIYATbS3Ecz77RG8fECsYyorNTwfqR+L2xcUJ8duwc8UpXAT45jIKuW4EWB4VOUHW3pN66/kyjtnh
        7HqZoKyw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6qDA-00DyDV-F4; Thu, 30 Jun 2022 09:11:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C53298000E; Thu, 30 Jun 2022 11:11:42 +0200 (CEST)
Date:   Thu, 30 Jun 2022 11:11:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: Skip for paranoid 3
Message-ID: <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
References: <20220629034007.332804-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629034007.332804-1-irogers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:40:07PM -0700, Ian Rogers wrote:
> Add skip tests for paranoid level being 3.
> Rather than skipping lines starting "Failed", skip lines containing
> "failed" - making the behavior consistent with the previous python
> version.

paranoid 3 is an out of tree patch.
