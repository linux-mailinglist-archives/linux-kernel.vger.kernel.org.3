Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7F576B67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 05:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiGPDEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 23:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGPDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 23:04:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F017056
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 20:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F134B82EEA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 03:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA81C34115;
        Sat, 16 Jul 2022 03:04:43 +0000 (UTC)
Date:   Fri, 15 Jul 2022 23:04:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 30/30]
 include/linux/cpumask.h:95:42: warning: function
 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf'
 format attribute
Message-ID: <20220715230441.64c89d63@gandalf.local.home>
In-Reply-To: <202207160905.GmOfByea-lkp@intel.com>
References: <202207160905.GmOfByea-lkp@intel.com>
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

On Sat, 16 Jul 2022 09:09:15 +0800
kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>):
> 
>    In file included from include/trace/define_trace.h:102,
>                     from samples/trace_events/trace-events-sample.h:608,
>                     from samples/trace_events/trace-events-sample.c:12:
>    samples/trace_events/./trace-events-sample.h: In function 'trace_event_get_offsets_foo_bar':
> >> include/linux/cpumask.h:95:42: warning: function 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]  
>       95 | #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
>          |                                          ^~~~~~~

Please quiet the gnu_printf warning. I actually missed a real build issue
from the kernel test robot in the last patch set because it was the needle
in the gnu_printf haystack :-p

That is, after having 10 of these warnings, I missed the one that actually
mattered.

-- Steve
