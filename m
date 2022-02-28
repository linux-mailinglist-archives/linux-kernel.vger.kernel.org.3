Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A004C714F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiB1QJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiB1QJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:09:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E732046
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EAFEBCE1736
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCE1C340F0;
        Mon, 28 Feb 2022 16:08:24 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:08:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20220228110822.4b906204@gandalf.local.home>
In-Reply-To: <CAEr6+EANLuP1=PpGvB4G1j4a-iM-mM4c69Pvo7j8GtafKPhyPw@mail.gmail.com>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
        <20220208104806.5272f2ea@gandalf.local.home>
        <CAEr6+EANLuP1=PpGvB4G1j4a-iM-mM4c69Pvo7j8GtafKPhyPw@mail.gmail.com>
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

On Sun, 27 Feb 2022 00:01:06 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Congratulations on joining google.  Just check out this series when
> you are free.
> 
> Please don't get me wrong, I'm not pushing anyone.
> It just doesn't feel good that I haven't responded to emails for a long time ;-)

And keep responding ;-) I want to look at this series, and your emails do
remind me (it's still in my patchwork queue, so it wont be forgotten, but
it is getting crowded in that queue of "todo"s).

Yeah, I'm hoping to start being able to do more upstream, but I'm still a
bit in the flux of figuring out what I'm suppose to be doing at work ;-)

-- Steve
