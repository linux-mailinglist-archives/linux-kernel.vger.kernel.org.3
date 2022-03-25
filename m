Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F474E727E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357601AbiCYL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiCYL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:56:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A894FAE75
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yQdKl6aB8FDFCTa+tk3Ng8QCZiooicWQwcAW+Sq6gwQ=; b=nxX/aztogBEnty8Lx3qvl6c8BK
        dYtYdXzaK+xtAN6QiTn0OyKVqpihvk6n6P7BogdL+CrWNzkkUzLGZVQuEgzaEk06Q1SFemDyeIWqu
        00rdDFKkz/zdX5UGRHkpf5xOS3noiLeR7AbC/QxqmavUnO+aCGFa8++reChoFVZzeJgQl6KsbfBIl
        gOIgXH1wzcIrE620lJs/gAbJkz/Z+FoXZAhBe48ov6jTfflaGemaVA7LeksBUvKfc6jhqRWkQzuEg
        zl+/TMZPUcTZcNxDgOwq0N7vvToA/4nSzzkO0tnyZ2Suhdk4G8dscotpzf1zPzeB+jCbQQPFXbMEQ
        L4gN9N1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXiWm-004MZZ-1d; Fri, 25 Mar 2022 11:54:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36F07987D26; Fri, 25 Mar 2022 12:54:46 +0100 (CET)
Date:   Fri, 25 Mar 2022 12:54:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
Message-ID: <20220325115446.GP8939@worktop.programming.kicks-ass.net>
References: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
 <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
 <24dd031a-8ea7-5f01-4d80-3fb30d212c8a@intel.com>
 <20220324175801.GJ8939@worktop.programming.kicks-ass.net>
 <2d37183b-e0d5-dd37-11c7-9b0e415daaf4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d37183b-e0d5-dd37-11c7-9b0e415daaf4@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 06:45:24PM +0800, Chen, Rong A wrote:

> > Oh *PLEASE* never report a branch as building if there's errors.
> > It could be I (force) push a branch multiple times before I get any
> > 0day reports back (0day has gotten *soooo* slow) so I only ever look at
> > the latest report -- possibly days later.
> 
> Hi Peter,
> 
> Sorry for the bad experience, I'm not sure the meaning of "a branch as
> building", is there a way to know the branch is not ready, or we can
> postpone the test for a branch by a day?

I was just commenting in general; never send a mail with "SUCCESS" in
the subject (as per this thread) when there are errors/warns with it,
supressed or otherwise.

If you do want to supress warnings (I'm not sure why; a few more emails
in my inbox really aren't going to make a difference) then please state
so explicitly with a link to the email with the report.

The thing I worry about is that I often wait for a SUCCESS mail from
0day robot before I push code to tip. If the SUCCESS is unreliable, this
is not good.
