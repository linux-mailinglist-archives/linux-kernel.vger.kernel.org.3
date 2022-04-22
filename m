Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9D50B1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444998AbiDVHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444953AbiDVHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:45:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA47517D2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zSqHUgEVMUUrtuWlOF2NDDSNE5XJ9us1wmUF0MxnCNI=; b=nuBsSqypxuryf9DqRLsNYv1QvR
        33ixnJ+glkh0T7z6H0hI+KxGtQRPVyQ8NetYAyEtWnvMR3yJ9aGWPjV9/QYGMW2df+8GGwIwfNc7i
        ZRj3m7WATV+bHf1riEV38US70ziwPEETn397sMP5KSXQywQcS85FYfoqaKIziDPZzdDjuzPujUMx4
        bfPb5zmeYrAxArjyYXGCaWvwYe1BBQCt6pybhZvrpAx8QbeNzNh+I6bOB6SZU9DwEosU7drRS4zjT
        jN3XxIg4WZbjDY8uIfPsbeEoe7EuSy4YC7uwzUdiNeYy3ntnY5Kz51xWMF4wbOp0KivFTgO8I+spv
        OkYd24EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhnwC-005rcA-EB; Fri, 22 Apr 2022 07:42:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 050699861C4; Fri, 22 Apr 2022 09:42:43 +0200 (CEST)
Date:   Fri, 22 Apr 2022 09:42:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ashamedbit <muralianiruddhan@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: x86/vdso/vdso2c: Memory Leak fix, Fix leak of
 variable name in vdso2c.c
Message-ID: <20220422074243.GU2731@worktop.programming.kicks-ass.net>
References: <20220422070922.14765-1-muralianiruddhan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422070922.14765-1-muralianiruddhan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 03:09:22AM -0400, ashamedbit wrote:
> The file vdso2c.c contains a memory leak of variable 'name'.
> This leak was detected by ASAN(AddressSanitizer) on local  builds.
> A tool called AddressWatcher automatically attempts to fix memory
> leaks suggested by ASAN. The fix has been inserted to stop the
> memory leak in the file vdso2c.c.

I think you need to fix your tool, this is 3 lines before the program
terminates. Please explain how that is a leak?
