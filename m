Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7939B513BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351255AbiD1Sw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiD1Sw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D527CB0C;
        Thu, 28 Apr 2022 11:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91933B82F53;
        Thu, 28 Apr 2022 18:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1936AC385A9;
        Thu, 28 Apr 2022 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651171780;
        bh=vY7+ICt2zXsN4Qwq+crX7yjoKkOoFqIDxY4aJZFwEsQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Nig5Rqf3UEJzb9Q3KfjN+JuxLarhqSY1QFPSKADqWOJ8ol6NaGtVqkz9sfSQNc9IN
         akRt6wT1LJ7h7PfzvsEclLOBiNJaDSzsdjfddXhct6VI+G6M2LgylBHHX9tJMojnNk
         t3fjDWoquVxSqtSfDzKsudC02yuPPY+Pq+AMV04qmgSdx6ipv9WWVCWl1oEGqF6MTj
         EN3HOX+wX9Zk3cfCewPyYfALph3EAHYDBOpCyQLdXL85kP/aSJqXeHNVT00Ie81z9Y
         drWLEFlM7WOygV5xJMv7b/U0xVqwlkIfVZCc3bqIjytP27OlrMnIZFsUXxsEeYCYjP
         AnYKC4UFGY9jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A34CE5C0500; Thu, 28 Apr 2022 11:49:39 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:49:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>,
        linux-doc@vger.kernel.org, chao <chao@eero.com>
Subject: Re: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
Message-ID: <20220428184939.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220324221156.44813-1-jsavitz@redhat.com>
 <CAL1p7m4drKAz4yocoT7ovhmFC_cGBbAC+jPvsg+exYkwJ72POw@mail.gmail.com>
 <87levp59xh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87levp59xh.fsf@meer.lwn.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:39:54PM -0600, Jonathan Corbet wrote:
> Joel Savitz <jsavitz@redhat.com> writes:
> 
> > Friendly ping.
> 
> This was waiting for an ack from an RCU person.  Looking now, though, I
> see that you didn't copy any RCU people.  Adding Paul and the author of
> the patch you reference (and appending patch below).

Thank you for calling this to my attention.  ;-)

> Thanks,
> 
> jon
> 
> Joel Savitz <jsavitz@redhat.com> (March 24) (kernel lwn)
> Subject: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
> To: linux-kernel@vger.kernel.org
> Cc: Joel Savitz <jsavitz@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>, Eric Biggers <ebiggers@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Daniel Borkmann <daniel@iogearbox.net>, Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>, linux-doc@vger.kernel.org
> Date: Thu, 24 Mar 2022 18:11:56 -0400
> 
> commit dfe564045c65 ("rcu: Panic after fixed number of stalls")
> introduced a new systctl but no accompanying documentation.
> 
> Add a simple entry to the documentation.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 803c60bf21d3..4e48139b9a34 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -781,6 +781,13 @@ is useful to define the root cause of RCU stalls using a vmcore.
>  1 panic() after printing RCU stall messages.
>  = ============================================================
> 
> +max_rcu_stall_to_panic
> +======================
> +
> +When ``panic_on_rcu_stall`` is set to 1, this value determines the
> +number of times that RCU can stall before panic() is called.
> +
> +When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.
> 
>  perf_cpu_time_max_percent
>  =========================
