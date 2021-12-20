Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123F47AB06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhLTOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:07:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51202 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLTOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:07:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968166115C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F38C36AE8;
        Mon, 20 Dec 2021 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640009249;
        bh=tJSpd7OxeP1zNUKQ0WQ78sW5o/NiPCZfMRR35kmJmDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPW2npqWOpjWCmTFxyo5llNE8KwhpLtB/X9zMZfsEJeKC0A3XNOtPa6L4OjVHCPe6
         qHH2pmFPYTUEEL7Lj/jfxdGXDiICtMkjACdIV/bbsIl6V+tX0D278y7Gt9uwtGgNSv
         IUlHePoEtMVSlS0YqpO4Sd8qAxx9Ahp9FV9lAcZtdsULJWc1a5MEyUXRnYS4yV1tx7
         BmZ4Nm4oDEEyejl6xTCtQj1b5T84gW3W6xrVBl4fe3qrOMdesmqthe5vZHUaMkLkN3
         kn52Cm0WMED/Zoo65x4bn98t3f9MSoTSbH0SSI0bkmJiV9J+gsABEoofRajlWfYsKv
         +7r6aoAMWk45w==
Date:   Mon, 20 Dec 2021 15:07:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT PULL] arm64: Support dynamic preemption v3
Message-ID: <20211220140726.GB918551@lothringen>
References: <20211220140142.922323-1-frederic@kernel.org>
 <CAMj1kXEBWJVGtRVKRkxeJc5bj4Cbb9oA_67PyJDYhTwiaHc7jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEBWJVGtRVKRkxeJc5bj4Cbb9oA_67PyJDYhTwiaHc7jA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:03:36PM +0100, Ard Biesheuvel wrote:
> Hello Frederic,
> 
> On Mon, 20 Dec 2021 at 15:01, Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Hi,
> >
> > I haven't seen much comments on the static key based version from Mark
> > so I don't know which direction we'll eventually take. I still hope we
> > can focus on a unified static call based implementation, considering
> > there are other users waiting on arm64 static calls.
> >
> 
> Which other users are you referring to here?

I believe Android was interested in it?
