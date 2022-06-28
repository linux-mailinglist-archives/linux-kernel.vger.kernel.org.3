Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9633E55EC46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiF1SK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiF1SKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF3017E2E;
        Tue, 28 Jun 2022 11:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E21761ADB;
        Tue, 28 Jun 2022 18:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18346C3411D;
        Tue, 28 Jun 2022 18:10:51 +0000 (UTC)
Date:   Tue, 28 Jun 2022 14:10:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 06/20] tools/rv: Add dot2c
Message-ID: <20220628141050.6d4ff81b@gandalf.local.home>
In-Reply-To: <5b1e664b0c33f4da0430922718adc71a5d58d86c.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
        <5b1e664b0c33f4da0430922718adc71a5d58d86c.1655368610.git.bristot@kernel.org>
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

On Thu, 16 Jun 2022 10:44:48 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> +    def __create_matrix(self):
> +        # transform the array into a dictionary
> +        events = self.events
> +        states = self.states
> +        events_dict = {}
> +        states_dict = {}
> +        nr_event = 0
> +        for event in events:
> +            events_dict[event] = nr_event
> +            nr_event += 1
> +
> +        nr_state = 0
> +        for state in states:
> +            states_dict[state] = nr_state
> +            nr_state = nr_state + 1
> +

Hmm, do you just like inconsistency?

		nr_event += 1

		nr_state = nr_state + 1

??

-- Steve
