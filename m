Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6204C44DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiBYMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiBYMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:47:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFD3B3F1;
        Fri, 25 Feb 2022 04:47:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48D251F388;
        Fri, 25 Feb 2022 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645793229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0Jgkj0o/pjaVvIXmGdmCJrgzQNnkwWbTVpY8Ut4X+M=;
        b=muFGoS6TT6rdJ2IFCGCdcuFdbPk38xM7txkn4titYeG/gqFxYZRiyYGXdVJMfPySgUP3/J
        qRNzeiYXTmqCKB9BEdYNPSN/G8uurZTRdL6Rwhd1W4zCKA+8sTwb7YLd4Z93N1s/BcnnLa
        CbdHB13kv1/BQ6sk/ovB5zy+NWEywvk=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A369A3B83;
        Fri, 25 Feb 2022 12:47:08 +0000 (UTC)
Date:   Fri, 25 Feb 2022 13:47:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, davem@davemloft.net,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sumit.garg@linaro.org,
        kernelfans@gmail.com, yj.chiang@mediatek.com
Subject: Re: [PATCH 1/5] kernel/watchdog: remove WATCHDOG_DEFAULT
Message-ID: <YhjPyCl7Rjh6acQN@alley>
References: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
 <20220212104349.14266-2-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212104349.14266-2-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-02-12 18:43:45, Lecopzer Chen wrote:
> No reference to WATCHDOG_DEFAULT, remove it.

It would be enough to mention the link to the previous
version in the cover letter.

> this commit reworks from [1].
> 
> [1] https://lore.kernel.org/lkml/20211014024155.15253-2-kernelfans@gmail.com/
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
