Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56931574C42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiGNLgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiGNLf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:35:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C55A454
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pWWr+CNJ0cQocSfh7mVD9aljzboIEN1MtG2d+Nh6VXE=; b=wBD/U+pNNNfnbPWdIYpx2B6pcP
        qTBaOSdL0xfBDJBTqBobEbYmgTj5qwhtnWpETyvn75zHWCNRQnTRXdlM0JRMhJ66sU5CbUwa6c7MT
        C2qFSoYuizbfR/EjDomkHzVsBCZu8zP2YCymslzlaz5YnwNmsVpKWx+f5vr7d32YEGQPF5CeWAq67
        W62XyTn0/HY3nXZcAo+TG9V/32M1d2qQR1guurfrk9oOxJRSdyFz8/8P7mfOjHcZQuQyVu6CgKf0R
        9Pkj35bPnC58819DnyIgkvGu0wftoAAWrKdBgcBJSBn5K7krUFTq5ILHAR3lWXXHixShngOE9cKsH
        LG+bqdYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBx8F-009KTI-DD; Thu, 14 Jul 2022 11:35:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9CA098016F; Thu, 14 Jul 2022 13:35:46 +0200 (CEST)
Date:   Thu, 14 Jul 2022 13:35:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <Ys//ktD6VYE2uGpw@worktop.programming.kicks-ass.net>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711224704.1672831-1-libo.chen@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 03:47:04PM -0700, Libo Chen wrote:
> [1]: https://lkml.org/lkml/2021/11/5/234

Please use lore.kernel.org based links that contain the MsgID of the
email in question, I think this wants to be:

https://lkml.kernel.org/r/20211105105136.12137-1-21cnbao@gmail.com

Right?
