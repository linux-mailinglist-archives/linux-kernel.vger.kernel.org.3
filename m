Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4EA5A52FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH2RRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiH2RRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:17:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF1380343;
        Mon, 29 Aug 2022 10:17:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2AB892E0;
        Mon, 29 Aug 2022 17:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2AB892E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661793452; bh=hpFnyRp0GSiap9UKKqsLCUe2WDepAjQkPBTYBDtSZx4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sDaqgwqL3MltUnueike4HQN9coKG9RpCbpgXiD8R3a1VCl+MC22JqZpbStsNfTQhB
         iyGd+IBPS1nTPIjQiNWGXUG0h8yaMJmuxfNTT901NaIeFNBhcH4QHgWPxA3Eyyl1Kz
         irAQ/fX1PvONca74YW79Tczeok4D6d8fXVxbPdZpehmECqj1T6aae+vMLgW+aBU6MJ
         u+F92zLI7SwaO0d/Kclr70XA9OCFMENqx38ausElCC21glRSfuq/GDqt00we5iC3YL
         z3K96xdVSk15R99z+pBFMmgxtT1QsUqcU5V7vXWtPH3kRdonxuJU9BNXVQDuWEoUxs
         syZ57GK0ZWUjw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akhil Raj <lf32.dev@gmail.com>, skhan@linuxfoundation.org
Cc:     Akhil Raj <lf32.dev@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete duplicate words from kernel docs
In-Reply-To: <20220829065239.4531-1-lf32.dev@gmail.com>
References: <20220829065239.4531-1-lf32.dev@gmail.com>
Date:   Mon, 29 Aug 2022 11:17:31 -0600
Message-ID: <87wnarnf4k.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akhil Raj <lf32.dev@gmail.com> writes:

> I have deleted duplicate words like
>
> to, guest, trace, when, we
>
> Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
> ---
>  Documentation/RCU/checklist.rst         | 2 +-
>  Documentation/RCU/lockdep.rst           | 2 +-
>  Documentation/bpf/instruction-set.rst   | 2 +-
>  Documentation/trace/histogram.rst       | 2 +-
>  Documentation/trace/timerlat-tracer.rst | 2 +-
>  Documentation/virt/kvm/x86/mmu.rst      | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks,

jon
