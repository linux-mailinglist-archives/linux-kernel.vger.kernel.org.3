Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A047D6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhLVS3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:29:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37978 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLVS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:29:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B0A61C16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 18:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4447C36AE5;
        Wed, 22 Dec 2021 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640197770;
        bh=Dzz7G24qyVXjSVU8hHAPxbOdtyKWWZYtLkcqLAPDjZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewrmGtHl2QnzfCcxN8nz0fs9JMPbi84n8j5iE83xBlpR5g4/RzdkBv8UDd0Znx6du
         ZPVf5nnn/q2a1GzAEXPQT512vBSuN2WRAT0WQX1q4kaaqis1IAX3qKPKPoNmWacmgy
         FbRqj1AIX5R2lXO6MGrJFLGQA3rSXUqTawOzfHqBrB1cih+TxuRtmXAJawvrGj7q1W
         zcaIZ5o1adkeqHqu3bF2/8vGOgRn6/v0nVWNdbVY8Grcmsu3o8Tm5BsRfs3LfV3z74
         KxkJHvRzsU3+UCI3vn4btXUkOiKVljydlQSDaT1K3wpOU/k68PwWKENdCgr8TSdimA
         9ze1W1XJbOjCg==
Date:   Wed, 22 Dec 2021 20:29:20 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jackie Liu <liu.yun@linux.dev>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] memblock: fix memblock_phys_alloc() section mismatch
 error
Message-ID: <YcNugPLzA0S65m41@kernel.org>
References: <YcNltr7TxsAe+fzP@kernel.org>
 <CAHk-=wg+Dv9XwquznVFN7Sw5x=DZ1EuZP3tqSS6KmSEQ8Hpnzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+Dv9XwquznVFN7Sw5x=DZ1EuZP3tqSS6KmSEQ8Hpnzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:23:49AM -0800, Linus Torvalds wrote:
> On Wed, Dec 22, 2021 at 9:52 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock fixes-2021-12-22
> 
> No such thing.
> 
> I see the 'fixes' branch that contains that commit, but not the tag
> you're pointing to. Forgot to push out?
 
Yep, only run push -n for the tag...
It's there now.

>           Linus

-- 
Sincerely yours,
Mike.
