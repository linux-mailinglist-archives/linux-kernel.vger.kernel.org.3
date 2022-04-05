Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58524F49D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451485AbiDEWaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391188AbiDEPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:34:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81984C411
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F01BB81D69
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D400BC385A0;
        Tue,  5 Apr 2022 13:40:49 +0000 (UTC)
Date:   Tue, 5 Apr 2022 09:40:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: Typical PREEMPT_RT .config?
Message-ID: <20220405094048.30a75670@gandalf.local.home>
In-Reply-To: <20220404231654.GA3445712@paulmck-ThinkPad-P17-Gen-1>
References: <20220404231654.GA3445712@paulmck-ThinkPad-P17-Gen-1>
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

On Mon, 4 Apr 2022 16:16:54 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> OK, now that PREEMPT_RT is mostly into mainline, I should probably create
> an rcutorture scenario more closely reflecting it.  The closest at the
> moment is probably tools/testing/selftests/rcutorture/configs/rcu/TREE03,
> but I figured that before beating on it I should check to see if you
> already have a PREEMPT_RT rcutorture scenario file.

I don't have one.

-- Steve
