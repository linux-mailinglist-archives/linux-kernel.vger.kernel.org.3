Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0453B58AE57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbiHEQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiHEQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:47:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B4286F7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF00CB829CD
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05793C433D6;
        Fri,  5 Aug 2022 16:47:02 +0000 (UTC)
Date:   Fri, 5 Aug 2022 12:47:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
Message-ID: <20220805124701.4b44195d@gandalf.local.home>
In-Reply-To: <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
References: <20220803104936.7df810fd@gandalf.local.home>
        <CAHk-=wh+e1qcCnEYJ3JRDVLNCYbJ=0u+Ts5bOYZnY3mX_k-hFA@mail.gmail.com>
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

On Fri, 5 Aug 2022 09:40:25 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 3, 2022 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Changes to RTLA:  
> 
> Btw, I note that the error messages for missing libraries got fixed
> (already some time ago, not this pull), but didn't get around to
> actually building until now.
> 
> It says to do
> 
>     e.g., 'dnf install libtraceevent' on Fedora
> 
> but it's actually the devel packages that are needed for building, not
> the bare libraries.
> 
> So it should be libtraceevent-devel, and libtracefs-devel.

Thanks for the report (I obviously have them installed, and thus didn't see
this :-/). Not to mention, I always forget to add the -dev/-devel appendix
to my packages.

Daniel,

Can you send a fix?

Thanks!

-- Steve
