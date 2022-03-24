Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E914E65C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiCXPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbiCXPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:00:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96119C31
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fNkhJPcfnwKXRpNQLK5phJ4WkPDI8JXNcw51Ms0xwTY=; b=pfyS14sT9Qs9UuQS+WF0fLisKY
        AIdPveX/veJHmzWhtpC1xeagdhdbX1KRYixvN4ZIIbaEaOJaJS2+AG9TxDtZpVSKoZuK6V/BRmN+1
        pdlsuu7P/jbEPyEneKZrF2yiJkytdGV9FNK9oq9WdPJnxPiJ0VKKIMdZR+cw9HusLu/xjzCOBq1PT
        4MDgfyzozhZF2GwwdrZ2TRzOb5VLiBwJWEjdYqfTCPrrregTwVfsO8AI6O3XBsU2qigXDsBtp+gSw
        YXpLZ+KHTcdGrGviA50jpYqEDi1q9k801YDbI3K+pe3bGdjIql5CDmgIakjJ+CiJXd+5YdjX3iOmz
        +8u0OydQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXOvX-00DWjW-5c; Thu, 24 Mar 2022 14:59:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C99A9986205; Thu, 24 Mar 2022 15:59:02 +0100 (CET)
Date:   Thu, 24 Mar 2022 15:59:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        rafael@kernel.org, ravi.bangoria@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling
 support
Message-ID: <20220324145902.GG8939@worktop.programming.kicks-ass.net>
References: <20220322221517.2510440-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:15:04PM -0700, Stephane Eranian wrote:
> V7 makes the following changes:
>    - rebased to 5.17-rc8
>    - Restrict BRS to be used only with RETIRED_TAKEN_BRANCH event in order to
>      avoid adding more skid to other events in case that are monitored
>      concurrently
>    - fixed bugs in the perf tool enhanced error handling for IBS and BRS

But afaict you failed to pick up the build fixes I did in my tree :/ Let
me try and be careful preserving those while munging this in.
