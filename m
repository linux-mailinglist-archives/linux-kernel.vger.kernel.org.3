Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81FD4E8FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiC1ID3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiC1ID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:03:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3D52E6F;
        Mon, 28 Mar 2022 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d0VXPuauj1NC7tAm6zgsLDfMy2KASlWbQpSjkiPdrCE=; b=iDZXiA0oYhJChsU9YwmV6krF+o
        M/oaLU4X4QBqH3CJrgPyvNbd0IhgF4BLBgoZEU7IT15Ou+4g1IfTayfTcyY39Dwd5W9kWVdLXVT/W
        YGaD6ark7eMqcqyOhmVs4ZTPWgOe/u1xgXLLBy9HF+ige45/+qjX3A7Ld88D+Q24B2dwYfzBxi5/n
        omq/BujzQzswLzee5gO6UL0kFTRgvjV32CfgnG9tZlFiQybMYMD7uowEYy02TFH9TCQdEN6O/HW58
        ksXisR6uIwbx1pgUVhYGYat/TYuEyZgzOrugXQ21Wd+1WNPgWlS993Vo5YJzEe2qRBagGT8GH/+Vc
        2XCVNX/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYkJd-00GivN-RH; Mon, 28 Mar 2022 08:01:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B514B9861F2; Mon, 28 Mar 2022 10:01:27 +0200 (CEST)
Date:   Mon, 28 Mar 2022 10:01:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/config: Make the x86 defconfigs a bit more
 usable
Message-ID: <20220328080127.GV8939@worktop.programming.kicks-ass.net>
References: <6PkRPjnHE@gmail.com>
 <164811181676.389.2059677983505845292.tip-bot2@tip-bot2>
 <20220324101833.GD8939@worktop.programming.kicks-ass.net>
 <YkC2E4HXlNN+ga8F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkC2E4HXlNN+ga8F@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 09:08:03PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Mar 24, 2022 at 08:50:16AM -0000, tip-bot2 for Ingo Molnar wrote:
> > > The following commit has been merged into the x86/urgent branch of tip:
> > > 
> > > Commit-ID:     aee8bf2d5aab5e7cc24fa90238930fd14d72e580
> > > Gitweb:        https://git.kernel.org/tip/aee8bf2d5aab5e7cc24fa90238930fd14d72e580
> > > Author:        Ingo Molnar <mingo@kernel.org>
> > > AuthorDate:    Thu, 24 Mar 2022 09:31:13 +01:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Thu, 24 Mar 2022 09:32:20 +01:00
> > > 
> > > x86/config: Make the x86 defconfigs a bit more usable
> > > 
> > >  - Use 'make savedefconfig' to refresh & regenerate the files
> > >  - Add in KVM boot enablers
> > 
> > We shouldn't duplicate kvm_guest.config.
> 
> I think x86-defconfig should be usable by itself - not just via the 
> somewhat obscure combination of:
> 
>   make defconfig
>   make kvm_guest.config
> 
> right?

Dunno, i've been using it forever (+- the kvmconfig rename thing, which
was really annoying).

But these days I have it scripted anyway, I also typically add
DEBUG_INFO to any .config that I end up booting.

> > >  - Enable the cgroup features most distros rely on
> > 
> > I've not yet had defconfig+kvm_guest.config fail to boot on debian
> > images (I occasionally grab one here:
> > https://cloud.debian.org/images/cloud/sid/daily/latest/ )
> 
> Systemd is rather negative about missing cgroup features - at a point it 
> used to insert 30(?) seconds delays during bootup warning about missing 
> cgroups support, etc.
> 
> Also the main Debian derived distros (Ubuntu, etc.) plus Debian itself has 
> most of cgroups enabled - so why should we test something that very few 
> users are using?

Yeah, don't mind. I just hadn't had problems booting anything.
