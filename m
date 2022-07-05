Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB85675FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiGERtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGERtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74B1836D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B1346160B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D9EC341C7;
        Tue,  5 Jul 2022 17:49:47 +0000 (UTC)
Date:   Tue, 5 Jul 2022 13:49:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Song Chen <chensong_2000@189.cn>
Subject: Re: [PATCH v14 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20220705134946.01cff121@rorschach.local.home>
In-Reply-To: <CAEr6+EDVhMwF1cok1StkYPSd_AMdMsn9Kw9U+Bt5p9i7CYZG4A@mail.gmail.com>
References: <20220628145552.349839-1-xiehuan09@gmail.com>
        <CAEr6+EDVhMwF1cok1StkYPSd_AMdMsn9Kw9U+Bt5p9i7CYZG4A@mail.gmail.com>
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

On Tue, 5 Jul 2022 23:30:46 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Hi Steve,
> 
> I'm curious if you have any comments on this patchset ;-)

Hi Jeff,

I haven't forgotten you. You're still in the queue (which is finally
moving forward). I have a few other patch sets ahead of yours that I
need to go over. Yes, those patches have been waiting longer :-p

-- Steve
