Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF54F480A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376578AbiDEVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391535AbiDEPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4525EDD5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07321B81C87
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62999C385A0;
        Tue,  5 Apr 2022 13:42:04 +0000 (UTC)
Date:   Tue, 5 Apr 2022 09:42:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: Typical PREEMPT_RT .config?
Message-ID: <20220405094202.0823ce48@gandalf.local.home>
In-Reply-To: <20220405094048.30a75670@gandalf.local.home>
References: <20220404231654.GA3445712@paulmck-ThinkPad-P17-Gen-1>
        <20220405094048.30a75670@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 09:40:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 4 Apr 2022 16:16:54 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > OK, now that PREEMPT_RT is mostly into mainline, I should probably create
> > an rcutorture scenario more closely reflecting it.  The closest at the
> > moment is probably tools/testing/selftests/rcutorture/configs/rcu/TREE03,
> > but I figured that before beating on it I should check to see if you
> > already have a PREEMPT_RT rcutorture scenario file.  
> 
> I don't have one.

And now reading the subject line and not just the body, are you asking
about what configs are normally added? I had several I used for testing,
but will have to go back and look at them.

-- Steve
