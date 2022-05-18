Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65E52B7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiERKWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiERKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:21:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D085D1AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D5su1PH4MS8/+9/EKhxkkfjE2by65ByPf20zlRylZEo=; b=Ap6baPuJktqxMXClC/fPPIRN/4
        ofhBooysvBqIBE80O+Oga4syoGCoyWCnnhxhSnr3XW2Jd252dS6ixpk0c2kPEyeg8m4uyRQglYnAv
        tIbdSEXFxSMwHzjJvQCP1XVckp6mEO0RJ9qeJI+80ni+057kYS64yaN/XUao9w9BEfzL3zhB9EiLJ
        k3M/nlfw5GhkwsWOLtxkYvJOIBk3XPCWw4MN3BtUdWddWyXqRNsy3Ygw0Tv1pOMHIduxk77KEqw2T
        bH91MEzqOE0ZHZv72pb+VkOmIhQaOzQiXYoKAEVW1aGfaLpiFBo+FUY/YuA7xiwXMyhv5mKsmJUrP
        drM8J4Rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrGoH-00BgfE-Tm; Wed, 18 May 2022 10:21:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FD69980DFF; Wed, 18 May 2022 12:21:40 +0200 (CEST)
Date:   Wed, 18 May 2022 12:21:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fam Zheng <fam.zheng@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        zhouchengming@bytedance.com,
        Vincent Guittot <vincent.guittot@linaro.org>, fam@euphon.net,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH] sched: Enable root level cgroup bandwidth control
Message-ID: <20220518102140.GF10117@worktop.programming.kicks-ass.net>
References: <20220518100841.1497391-1-fam.zheng@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518100841.1497391-1-fam.zheng@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:08:41AM +0100, Fam Zheng wrote:
> In the data center there sometimes comes a need to throttle down a
> server, 

Why?
