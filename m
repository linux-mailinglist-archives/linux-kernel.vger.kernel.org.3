Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCB506220
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbiDSC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbiDSC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C92C130
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 007A660A75
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DD1C385A1;
        Tue, 19 Apr 2022 02:26:27 +0000 (UTC)
Date:   Mon, 18 Apr 2022 22:26:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] trace: Add trace any kernel object
Message-ID: <20220418222625.3e0c5ff8@rorschach.local.home>
In-Reply-To: <20220418214400.2ab7f932@rorschach.local.home>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220204035644.734878-2-xiehuan09@gmail.com>
        <20220418214400.2ab7f932@rorschach.local.home>
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

On Mon, 18 Apr 2022 22:14:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> We need to consolidate the code a bit, and add helper functions to
> share between them, instead of just cut and pasting and tweaking.
> That's a maintenance nightmare.

And I forgot that Tom started to do this and I haven't applied his
patches yet. I'll start applying them now.

  https://lore.kernel.org/all/cover.1644010575.git.zanussi@kernel.org/

So when that is done, you can look at rebasing on top of it. Which will
hopefully make the code a bit simpler.

-- Steve
