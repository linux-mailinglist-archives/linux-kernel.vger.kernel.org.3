Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB249C253
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiAZDxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:53:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60958 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiAZDxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:53:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E47F0B81074;
        Wed, 26 Jan 2022 03:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E96C340E3;
        Wed, 26 Jan 2022 03:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643169178;
        bh=Z4j5apsYZYGHDeczIZCsY+w13MmU7QmVZw89phNr4hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZP6fE/3ZapE9PvHytfpbE4akWjM7BdznGZyRP6TkZr3AZGI6amrvp9vOC7LMc10fy
         lZh9ah5WrcuapzjO8qVFfUOl8WIYSp3MAHL1ft6CXfm7GEeUBDfy1IWw3SZsvEiK74
         6Xbjw7c4ajRAYfemga1949J3jr1KKmfV4xada5lqXZIloFdZoY0ku3QlQwOznyZUW6
         uGGOvy6udlOOscW8SzVPCrMswgZ4sGwmMgb471T44gTN6PkoM6dzcp4C6SUMqiB0zO
         Vvw+ksO0rRLyPHZYyJwMbSUf1ZYFqSHjFA3fzmvWB4NQ2lKW31ekCynWjR1y6sO2yl
         RNe06cdw0HLLA==
Date:   Wed, 26 Jan 2022 12:52:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-Id: <20220126125252.2ef18d786cfaf4a135a2d10f@kernel.org>
In-Reply-To: <20220125201634.698cc777@gandalf.local.home>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
        <20220125162859.2b3cc8a0@gandalf.local.home>
        <202201251402.0FB08DB@keescook>
        <20220125172114.6807ed8f@gandalf.local.home>
        <20220126093538.893fb44a7cb0a7cd840c7fdb@kernel.org>
        <20220125201634.698cc777@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 20:16:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Jan 2022 09:35:38 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > I think Kees' idea seems better. If you and Beau are good, I will update
> > the macros for __rel_loc. (This requires to change some user-space
> > application which Beau is making too.)
> 
> If Beau is OK with it, I'm OK with it too. I need to release a new version
> of libtraceevent anyway, and I can make the update for that too.
> 
> Who's adding the patch (if Beau says it's OK), you or Kees?

This will update the __rel_loc spec, so I'll do it :)

Thank you,
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
