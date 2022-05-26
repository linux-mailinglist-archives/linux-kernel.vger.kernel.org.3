Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784B535375
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbiEZSiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348433AbiEZSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:38:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E98B6A051;
        Thu, 26 May 2022 11:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB464B821AA;
        Thu, 26 May 2022 18:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B9AC385A9;
        Thu, 26 May 2022 18:38:46 +0000 (UTC)
Date:   Thu, 26 May 2022 14:38:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     sunliming <sunliming@kylinos.cn>, mingo@kernel.org,
        linux-tip-commits@vger.kernel.org, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
Subject: Re: [PATCH V2] x86/idt: traceponit.c: fix comment for irq vector
 tracepoints
Message-ID: <20220526143844.2d5c8741@gandalf.local.home>
In-Reply-To: <8f3be3c2-dcd0-1646-b5bd-0a6597e7ca2e@intel.com>
References: <20220526110831.175743-1-sunliming@kylinos.cn>
        <8f3be3c2-dcd0-1646-b5bd-0a6597e7ca2e@intel.com>
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

On Thu, 26 May 2022 09:24:31 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 5/26/22 04:08, sunliming wrote:
> > 
> > diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
> > index fcfc077afe2d..065191022035 100644
> > --- a/arch/x86/kernel/tracepoint.c
> > +++ b/arch/x86/kernel/tracepoint.c
> > @@ -1,9 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Code for supporting irq vector tracepoints.
> > - *
> >   * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
> > - *
> >   */
> >  #include <linux/jump_label.h>
> >  #include <linux/atomic.h>  
> 
> While I'm also generally careful about removing others' copyrights, Mr.
> Aguchi only touched this file once and all of the code from that one
> touch appears to be gone to me.  Shouldn't we just zap the whole comment?

Perhaps, but that's a different change than this is addressing. This is
only addressing fixing the comments about the removal of the code.

But looking at the history of this file. Seiji created it, but the only
code that remains in the file was mostly added by Thomas. The only lines
that Seiji has now is the whitespace and the brackets.

I would still have the removal of the copyright as a separate patch.

-- Steve
