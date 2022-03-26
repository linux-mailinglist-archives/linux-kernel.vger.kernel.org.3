Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65754E8131
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiCZN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiCZN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4800E70;
        Sat, 26 Mar 2022 06:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8593CB80978;
        Sat, 26 Mar 2022 13:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5756CC340EE;
        Sat, 26 Mar 2022 13:54:31 +0000 (UTC)
Date:   Sat, 26 Mar 2022 09:54:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/3] bootconfig: Support embedding a bootconfig file
 in kernel
Message-ID: <20220326095420.2060aae3@rorschach.local.home>
In-Reply-To: <20220326214040.07d4c8b99d7b83229509340d@kernel.org>
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
        <164724892075.731226.14103557516176115189.stgit@devnote2>
        <20220316191649.GA11547@pswork>
        <20220318101445.fdb151efe58c6c3a1c572500@kernel.org>
        <CAK7LNAQKrybg7iAzPowqG5SuT6r5Y0v++96CKppM1=Ob4FG+bg@mail.gmail.com>
        <20220326214040.07d4c8b99d7b83229509340d@kernel.org>
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

On Sat, 26 Mar 2022 21:40:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > BTW, it is already possible to embed kernel parameters
> > into the kernel.
> > Is this another implementation of CONFIG_CMDLINE?

If one changes CONFIG_CMDLINE, does it require a rebuild of vmlinux?

> 
> Yes, it is the bootconfig version of the CONFIG_CMDLINE.
> Since some boot-time tracing feature depends on the bootconfig (those can
> not be set via kernel cmdline), we need this feature for those features
> on non-initrd boot system.

Yes, the kernel command line has a fixed size, and with tracing
options, we can easily go over it.

bootconfig is a way to have an unlimited size and also be able to have
a better and more reasonable formatting to express options for things
like tracing.

-- Steve
