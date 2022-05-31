Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D5F539404
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345732AbiEaP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbiEaP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:29:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63219AE41
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:29:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654010966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M8nDsARGY3Fc80g22CpSVj5Zjfvb/1jo5XkxSnuNwQ=;
        b=CV9ettHS9ewdYtx0xhTE0OhL12rDAEoHCNXc09UzfOw6g4I6yzQUM2GUUP09UmAwrTQxaU
        fJNJoQIghQ1DtKHeTyPtlILWZs2Cz+sQyJGbBFCVGbuOMkFR/mXf+4gp6y+iFdQxm/rl3i
        VBk9+3rmmWR2BFqCIkQZN4Ai2f0R3mnesZLv4UA5UGPdSq6+1CwcQdEvsAuRXgf1qp0Ona
        Zz/aMYjDZvDlGwSlJxLCkcmvBCELQOwMgWQmu2g4E4qFiZOQSmZjbnWKiZewW7hOgkdXIQ
        0ikiZHZmgZAG2kO7XJD5tTaDkAStrsX8DZJCFc8fkXlD6pfBqniLgZy8K364HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654010966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M8nDsARGY3Fc80g22CpSVj5Zjfvb/1jo5XkxSnuNwQ=;
        b=VPbtVH9o+8QGAFk8trWPy6GvHcwT8wjVtgHpNf5Quoz50xO8SrKD58wlfFv6BC1EJjY4lT
        qt9ld61dYNzG4mCw==
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [printk]  8e27473211: hwsim.ap_ft_pmf_bip_cmac_128.fail
In-Reply-To: <20220531033052.GD17663@xsang-OptiPlex-9020>
References: <20220531033052.GD17663@xsang-OptiPlex-9020>
Date:   Tue, 31 May 2022 17:35:26 +0206
Message-ID: <874k15n2jt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

I am having great difficulties trying to reproduce this test. It seems I
need to setup real hardware with multiple access points. Can you point
me to some detailed documentation about preparing this test? Thanks.

John Ogness

On 2022-05-31, kernel test robot <oliver.sang@intel.com> wrote:
> (please be noted we reported
> "[printk]  8e27473211: hwsim.ap_ft_pmf_bip_gmac_256.fail"
> on
> https://lore.kernel.org/all/20220430143056.GA27004@xsang-OptiPlex-9020/
> when this commit is on linux-next/master
> now we noticed there are other hwsim tests failures while
> ap_ft_pmf_bip_gmac_256 problem is still existing, after this commit is on
> mainline now.
> FYI)
