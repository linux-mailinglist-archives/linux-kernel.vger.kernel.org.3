Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7305AF9AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIGCDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIGCDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:03:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB78F97F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7136BB81A07
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4E1C433C1;
        Wed,  7 Sep 2022 02:03:07 +0000 (UTC)
Date:   Tue, 6 Sep 2022 22:03:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] tracing: Allow multiple hitcount values in
 histograms
Message-ID: <20220906220346.53a9a623@gandalf.local.home>
In-Reply-To: <166226474055.223837.13947085068863989044.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
        <166226474055.223837.13947085068863989044.stgit@devnote2>
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

On Sun,  4 Sep 2022 13:12:20 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Tom Zanussi <zanussi@kernel.org>
> 
> The hitcount is treated specially in the histograms - since it's
> always expected to be there regardless of whether the user specified
> anything or not, it's always added as the first histogram value.
> 
> Currently the code doesn't allow it to be added more than once as a
> value, which is inconsistent with all the other possible values.  It
> would seem to be a pointless thing to want to do, but other features
> being added such as percent and graph modifiers don't work properly
> with the current hitcount restrictions.
> 
> Fix this by allowing multiple hitcounts to be added.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>

Hi Masami,

When posting patches from other people, you still need to add your
Signed-off-by, as that denotes the people who processed the patch before it
made it into git.

-- Steve
