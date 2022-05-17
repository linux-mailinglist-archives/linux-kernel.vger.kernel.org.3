Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1577852A479
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbiEQOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiEQON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362B94F465;
        Tue, 17 May 2022 07:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF833615E7;
        Tue, 17 May 2022 14:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E63AC385B8;
        Tue, 17 May 2022 14:13:52 +0000 (UTC)
Date:   Tue, 17 May 2022 10:13:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, linux@armlinux.org.uk, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] kernel: Ftrace seems to have functions to improve
 performance through optimization  through optimization
Message-ID: <20220517101351.273b385f@gandalf.local.home>
In-Reply-To: <20220513021314.59480-1-kunyu@nfschina.com>
References: <20220512110725.22e69e3c@gandalf.local.home>
        <20220513021314.59480-1-kunyu@nfschina.com>
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

On Fri, 13 May 2022 10:13:14 +0800
Li kunyu <kunyu@nfschina.com> wrote:

> Subject: [PATCH] kernel: Ftrace seems to have functions to improve performance through optimization  through optimization

Did you forget to add a subject line. The above looks to be the beginning
of the paragraph below.


> Date: Fri, 13 May 2022 10:13:14 +0800
> Message-Id: <20220513021314.59480-1-kunyu@nfschina.com>
> 
> such as ftrace_ARCH_code_*, return 0, so the FTRACE_* check is not required

And even combined, the above makes no sense.

This patch is not an optimization patch. If it were, the optimization
provided is so small, it's not worth adding it.

Just state that it's a clean up (I already told you this). Here, I'll do
the work for you (but I expect a proper patch):

  Subject: [PATCH v2] ftrace: Remove return value of ftrace_arch_modify_*()

  All instances of the function ftrace_arch_modify_prepare() and
  ftrace_arch_modify_post_process() return zero. There's no point in
  checking their return value. Just have them be void functions.

There, that's what I would like to see.

-- Steve


> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
