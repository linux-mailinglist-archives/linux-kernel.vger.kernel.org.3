Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9533598771
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbiHRP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbiHRP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A1EC00CA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AAC3B8203A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A40C433D7;
        Thu, 18 Aug 2022 15:26:34 +0000 (UTC)
Date:   Thu, 18 Aug 2022 11:26:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Subject: Re: [PATCH v14 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20220818112644.40da65bf@gandalf.local.home>
In-Reply-To: <CAEr6+ECutZuYZNYzv-oD7Ss5nfg8eFAdwDG75E5NhM3UtkmH1A@mail.gmail.com>
References: <20220628145552.349839-1-xiehuan09@gmail.com>
        <CAEr6+EDVhMwF1cok1StkYPSd_AMdMsn9Kw9U+Bt5p9i7CYZG4A@mail.gmail.com>
        <20220705134946.01cff121@rorschach.local.home>
        <CAEr6+ECutZuYZNYzv-oD7Ss5nfg8eFAdwDG75E5NhM3UtkmH1A@mail.gmail.com>
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

On Thu, 18 Aug 2022 23:05:19 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Hi steve,
> 
> I would like to ask whether this patch set may be merged into v6.1  ;-)
> The kernel development is indeed very different from what I originally imagined.
> I originally thought that objtrace would soon enter the kernel
> community, but I know
> it may take one to two years, or longer or discarded, I have slowly
> come to accept this reality ;-)

As, sorry for the late reviews (trying to get through all the other patches
too). I'll see if I can look at it this week.

-- Steve
