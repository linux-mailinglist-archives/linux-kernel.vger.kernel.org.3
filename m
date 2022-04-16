Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203155033F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiDPCKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiDPCGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:24 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76A520F6D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:02:12 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id D339C20CEC;
        Sat, 16 Apr 2022 01:46:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id EE61D18;
        Sat, 16 Apr 2022 01:46:34 +0000 (UTC)
Message-ID: <5ee2984b7c0130df1ddbe8b8fc72b66331b214b0.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add x86 unwinders entry
From:   Joe Perches <joe@perches.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 15 Apr 2022 18:46:33 -0700
In-Reply-To: <7b9eb43c029d20676d9173ec5b2c675b43e2a99c.1650068519.git.jpoimboe@redhat.com>
References: <7b9eb43c029d20676d9173ec5b2c675b43e2a99c.1650068519.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EE61D18
X-Stat-Signature: ubzc3wqkb7tiax4f8u94tmjtmfko4cfi
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+YcY7w3GORf4nfwzYsd2KDqiL8xe83Fuk=
X-HE-Tag: 1650073594-354967
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 17:22 -0700, Josh Poimboeuf wrote:
> Create a new section for x86 unwinder maintenance.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -21434,6 +21434,15 @@ F:	arch/x86/include/asm/uv/
>  F:	arch/x86/kernel/apic/x2apic_uv_x.c
>  F:	arch/x86/platform/uv/
>  
> +X86 UNWINDERS
> +M:	Josh Poimboeuf <jpoimboe@redhat.com>
> +M:	Peter Zijlstra <peterz@infradead.org>
> +S:	Supported
> +F:	arch/x86/include/asm/unwind*.h
> +F:	arch/x86/kernel/dumpstack.c
> +F:	arch/x86/kernel/stacktrace.c
> +F:	arch/x86/kernel/unwind_*,c

Should be a period not a comma.

F:	arch/x86/kernel/unwind_*.c


