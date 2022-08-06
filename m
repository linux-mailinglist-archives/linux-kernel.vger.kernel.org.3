Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89FB58B7E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiHFTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiHFTXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:23:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A1DFB2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8034ECE0A52
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 19:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E734AC433C1;
        Sat,  6 Aug 2022 19:23:18 +0000 (UTC)
Date:   Sat, 6 Aug 2022 15:23:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
Message-ID: <20220806152317.2f2e59c4@gandalf.local.home>
In-Reply-To: <CAHk-=wiiu13cO3NR5Ub3oW+V3iJoNwq67QM2Un7xcfNak8UdcA@mail.gmail.com>
References: <20220803104936.7df810fd@gandalf.local.home>
        <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
        <20220805124701.4b44195d@gandalf.local.home>
        <12638499-5079-95b0-7861-fb06ef3d2522@kernel.org>
        <CAHk-=wj3zXDnXUHb-EKAkk74GUixO8ojUZMt-rkTsXSxALpi_g@mail.gmail.com>
        <20220806142203.3c133322@gandalf.local.home>
        <CAHk-=wiTRbL22B=-SJ0fwqpiXZnGe2LGPs8DjToUk=ezKsKVjg@mail.gmail.com>
        <20220806145159.686794d8@gandalf.local.home>
        <CAHk-=wiiu13cO3NR5Ub3oW+V3iJoNwq67QM2Un7xcfNak8UdcA@mail.gmail.com>
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

On Sat, 6 Aug 2022 12:05:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> It looks very 90s to me. "cowsay" and all that..
> 
> But it's not like I care deeply about the retro look.

I thought it would bring back some nostalgia. ;-)

As I'm pretty much the same age as you, it's probably why I tend to like it.

-- Steve
