Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176F4E619D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349446AbiCXKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiCXKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:20:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4FA11150;
        Thu, 24 Mar 2022 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B3bkYc3AlnQe1jslr2zK5vysJSvF+v6B/J7q/7C5Sjo=; b=F89YBM9sOPp86uB3esgSHFda8l
        KhiI8HA7bzmyvz6MMF1/VVMQNeGVYOsq8dqBJkmkt/Z1zvLNj18S9qnr2G22sh3kzt35e0LUD0gCn
        ooyCUt1yd7ix8mkQjQ/+WmDLO99bokRk1rsYd9TZTwfGXqMsKQeIUGrk1Xrio+XzO/eK3HqxcKf5o
        ogLal64JB9RU+G851d6m/q4uXXn5cHCRGgTIl7i7eXDIP2tIAuat7Q5wiRnxvdZsNGyKqVU32W9M4
        aqIwv/6lDlGkZszqkcEjrrAUXKV34bW2XMKSfAPp4zTMHevNLFM7tlJQ0G+PNoOQKvLj2zwsE/vqo
        snNreXwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXKY7-00DKs2-3u; Thu, 24 Mar 2022 10:18:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E799986201; Thu, 24 Mar 2022 11:18:33 +0100 (CET)
Date:   Thu, 24 Mar 2022 11:18:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/config: Make the x86 defconfigs a bit more
 usable
Message-ID: <20220324101833.GD8939@worktop.programming.kicks-ass.net>
References: <6PkRPjnHE@gmail.com>
 <164811181676.389.2059677983505845292.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164811181676.389.2059677983505845292.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:50:16AM -0000, tip-bot2 for Ingo Molnar wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     aee8bf2d5aab5e7cc24fa90238930fd14d72e580
> Gitweb:        https://git.kernel.org/tip/aee8bf2d5aab5e7cc24fa90238930fd14d72e580
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Thu, 24 Mar 2022 09:31:13 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 24 Mar 2022 09:32:20 +01:00
> 
> x86/config: Make the x86 defconfigs a bit more usable
> 
>  - Use 'make savedefconfig' to refresh & regenerate the files
>  - Add in KVM boot enablers

We shouldn't duplicate kvm_guest.config.

>  - Enable the cgroup features most distros rely on

I've not yet had defconfig+kvm_guest.config fail to boot on debian
images (I occasionally grab one here:
https://cloud.debian.org/images/cloud/sid/daily/latest/ )
