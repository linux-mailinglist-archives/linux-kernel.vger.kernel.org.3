Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575C5B0F70
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIGVru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiIGVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:47:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3BC4827
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 902DDCE1D93
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DA2C433D6;
        Wed,  7 Sep 2022 21:47:32 +0000 (UTC)
Date:   Wed, 7 Sep 2022 17:48:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220907174813.182df339@gandalf.local.home>
In-Reply-To: <20220907174604.06809ff2@gandalf.local.home>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
        <20220907174604.06809ff2@gandalf.local.home>
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

On Wed, 7 Sep 2022 17:46:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >   # Don't change /sys/kernel/tracing/ permissions on automount.
> >   umount /sys/kernel/debug/tracing/  
> 
> BTW, I noticed that the above doesn't do anything. That is,
> you cannot unmount tracefs from /sys/kernel/debug/tracing.

I just saw your new email. I guess that's just how you were triggering the
automount, by unmounting it. Right?

A lot of assumptions about what people may know ;-)

I never tried it, so I really didn't know what the result of that would be.

-- Steve
