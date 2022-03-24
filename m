Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A314E6AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355377AbiCXWag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbiCXWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:30:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F1427E1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F613B8250D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F13C340EC;
        Thu, 24 Mar 2022 22:28:57 +0000 (UTC)
Date:   Thu, 24 Mar 2022 18:28:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add arch/powerpc/kernel/trace to TRACING
Message-ID: <20220324182856.6f6a01d7@gandalf.local.home>
In-Reply-To: <8e2f707e2efa1fc1d1ffd2f9f6758e8c4a82c83e.1648132613.git.christophe.leroy@csgroup.eu>
References: <8e2f707e2efa1fc1d1ffd2f9f6758e8c4a82c83e.1648132613.git.christophe.leroy@csgroup.eu>
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

On Thu, 24 Mar 2022 15:38:28 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e127c2fb08a7..3b5943f34568 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19592,6 +19592,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>  F:	Documentation/trace/ftrace.rst
>  F:	arch/*/*/*/ftrace.h
>  F:	arch/*/kernel/ftrace.c
> +F:	arch/powerpc/kernel/trace/

Perhaps replace the above two with:
   F:   arch/*/*/ftrace*
   F:   arch/*/*/*/ftrace*

As we also have things like ftrace_32.S, ftrace_64.S

Maybe even add:

   F: arch/*/*/*_ftrace.*
   F: arch/*/*/*/*_ftrace.*

to catch the "entry_ftrace.S" and friends (needing the leading "_" to not
get confused by any "bpftrace" files).

?

But in reality, I'm only a reviewer for ftrace in the archs. It really is
maintained by the arch maintainers. But it is still good that I get Cc'd on
any ftrace arch related changes.

-- Steve


>  F:	fs/tracefs/
>  F:	include/*/ftrace.h
>  F:	include/linux/trace*.h

