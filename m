Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684C65019A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiDNRKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245428AbiDNRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:07:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0722AE32
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB2AEB82AE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4770BC385A5;
        Thu, 14 Apr 2022 16:52:46 +0000 (UTC)
Date:   Thu, 14 Apr 2022 12:52:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20220414125245.400bdf4e@rorschach.local.home>
In-Reply-To: <CAEr6+EB61DZdga+74RXQufLvbXPZ-rJzTrhL+JC54N5-gQm8-Q@mail.gmail.com>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
        <20220208104806.5272f2ea@gandalf.local.home>
        <CAEr6+EANLuP1=PpGvB4G1j4a-iM-mM4c69Pvo7j8GtafKPhyPw@mail.gmail.com>
        <20220228110822.4b906204@gandalf.local.home>
        <CAEr6+EAJqM6py_8xtVyH3BZ9U+vODVecSUkLdZkKu3FN2ZkRtw@mail.gmail.com>
        <CAEr6+EB61DZdga+74RXQufLvbXPZ-rJzTrhL+JC54N5-gQm8-Q@mail.gmail.com>
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

On Mon, 11 Apr 2022 23:47:23 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Just don't want you to forget this patch series ;-)

I won't. I've just been super busy (on my way back home from Denver).
I'll try to get some time tomorrow to review them.

Thanks for being patient with me.

-- Steve
