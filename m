Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8E4FA8A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiDINjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiDINjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:39:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4271AECBA;
        Sat,  9 Apr 2022 06:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAF63B8006F;
        Sat,  9 Apr 2022 13:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F443C385A4;
        Sat,  9 Apr 2022 13:37:29 +0000 (UTC)
Date:   Sat, 9 Apr 2022 09:37:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] timekeeping: Introduce fast accessor to clock tai
Message-ID: <20220409093727.7dda6371@rorschach.local.home>
In-Reply-To: <20220409081300.4762-2-kurt@linutronix.de>
References: <20220409081300.4762-1-kurt@linutronix.de>
        <20220409081300.4762-2-kurt@linutronix.de>
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

On Sat,  9 Apr 2022 10:12:58 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

> ---
>  include/linux/timekeeping.h |  1 +
>  kernel/time/timekeeping.c   | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)

If the time keeping folks are OK with this and ack it, I'm happy to
take this through my tree.

-- Steve
