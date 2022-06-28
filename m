Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF355E9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiF1Qd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiF1Qc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:32:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD912A8D;
        Tue, 28 Jun 2022 09:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0FE8CE217B;
        Tue, 28 Jun 2022 16:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B86C3411D;
        Tue, 28 Jun 2022 16:24:43 +0000 (UTC)
Date:   Tue, 28 Jun 2022 12:24:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v11 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220628122442.5e3af503@gandalf.local.home>
In-Reply-To: <20220628162122.v7s3z24icwavur6y@ava.usersys.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
        <20220310102413.3438665-11-atomlin@redhat.com>
        <20220627235612.4796c837@gandalf.local.home>
        <20220628162122.v7s3z24icwavur6y@ava.usersys.com>
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

On Tue, 28 Jun 2022 17:21:22 +0100
Aaron Tomlin <atomlin@redhat.com> wrote:

> If I understand correctly, there is absolutely no need to explicitly
> disable preemption in this context. I will use: rcu_read_lock() and
> rcu_read_unlock(), respectively, which will then be suitable for the
> preemptible RCU implementation.

Yes, thank you very much :-)

-- Steve
