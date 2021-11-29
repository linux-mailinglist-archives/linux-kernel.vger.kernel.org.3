Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22847461CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350621AbhK2RtS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 12:49:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40994 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbhK2RrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:47:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D7E2B8159B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50DAC53FCD;
        Mon, 29 Nov 2021 17:43:56 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:43:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LEROY Christophe <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] recordmcount: Support empty section from recent
 binutils
Message-ID: <20211129124355.52474d90@gandalf.local.home>
In-Reply-To: <efc0e15e-fc93-fb59-068d-602f96ec7431@csgroup.eu>
References: <cd0f6bdfdf1ee096fb2c07e7b38940921b8e9118.1637764848.git.christophe.leroy@csgroup.eu>
        <efc0e15e-fc93-fb59-068d-602f96ec7431@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 08:43:23 +0000
LEROY Christophe <christophe.leroy@csgroup.eu> wrote:

> Le 24/11/2021 à 15:43, Christophe Leroy a écrit :
> > Looks like recent binutils (2.36 and over ?) may empty some section,
> > leading to failure like:
> > 
> > 	Cannot find symbol for section 11: .text.unlikely.
> > 	kernel/kexec_file.o: failed
> > 	make[1]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Error 1
> > 
> > In order to avoid that, ensure that the section has a content before
> > returning it's name in has_rel_mcount().  
> 
> This patch doesn't work, on PPC32 I get the following message with this 
> patch applied:
> 
> [    0.000000] ftrace: No functions to be traced?
> 
> Without the patch I get:
> 
> [    0.000000] ftrace: allocating 22381 entries in 66 pages
> [    0.000000] ftrace: allocated 66 pages with 2 groups

Because of this report, I have not applied this patch (even though I was
about to push it to Linus).

I'm pulling it from my queue until this gets resolved.

Thanks,

-- Steve
