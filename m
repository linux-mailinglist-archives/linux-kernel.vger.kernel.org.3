Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B765F50E454
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbiDYP1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbiDYP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:27:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A9E1275
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A446FB815E2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E9C385A4;
        Mon, 25 Apr 2022 15:24:19 +0000 (UTC)
Date:   Mon, 25 Apr 2022 11:24:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] ring-buffer: simplify if-if to if-else
Message-ID: <20220425112418.41e99be0@gandalf.local.home>
In-Reply-To: <71297b444533a2348b8cb211674453bf65848f82.camel@perches.com>
References: <20220424093442.102230-1-wanjiabing@vivo.com>
        <71297b444533a2348b8cb211674453bf65848f82.camel@perches.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 09:12:45 -0700
Joe Perches <joe@perches.com> wrote:

> the pr_info on two lines seems pointless and it's probably nicer
> just written on a single line.
> 
> 			pr_info(" With dropped events, recorded len and size may not match alloced and written from above\n");

Which makes it 86 characters long, and this test is run on my machine that
has a 80 character console.

Please keep the original line breakage.

-- Steve
