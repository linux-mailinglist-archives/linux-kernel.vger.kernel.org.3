Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4A5B2B24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIIAm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIIAmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:42:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35997512
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A55F5B82346
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B7EC433C1;
        Fri,  9 Sep 2022 00:42:50 +0000 (UTC)
Date:   Thu, 8 Sep 2022 20:43:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220908204332.0cbd850c@gandalf.local.home>
In-Reply-To: <YxqF0bWoJPK4KFHb@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <YxDWlgulBijTzj3y@kroah.com>
        <YxEy8mTO1nZ1sxHV@google.com>
        <YxGYepQlLZTE84HB@kroah.com>
        <YxqF0bWoJPK4KFHb@google.com>
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

On Thu, 8 Sep 2022 17:16:17 -0700
Brian Norris <briannorris@chromium.org> wrote:

> I think I've covered all that in v2. The patch contents haven't changed
> -- just the metadata, and a link to a draft LTP test. As noted in v2, I
> plan to submit a PR for that once the kernel changes are in.

Instead of doing an LTP test, could you just write a script that could test
it in the kernel selftests?

See tools/testing/selftests/...

in the kernel repository.

Not exactly sure which directory it would go. Perhaps the "mounts"
directory?

If you create a tracefs one, it could go into the ftrace directory.

-- Steve
