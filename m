Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640748DDD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiAMSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:47:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37840 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237622AbiAMSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:47:51 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20DIlYOX017627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 13:47:35 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2108115C40F6; Thu, 13 Jan 2022 13:47:34 -0500 (EST)
Date:   Thu, 13 Jan 2022 13:47:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeBzxuO0wLn/B2Ew@mit.edu>
References: <20220113160115.5375-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113160115.5375-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 05:01:15PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Commit
> 
>   eac616557050 ("x86: Deprecate a.out support")
> 
> deprecated a.out support with the promise to remove it a couple of
> releases later. That commit landed in v5.1.
> 
> Now it is more than a couple of releases later, no one has complained so
> remove it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Let's pour one out for being able to run Minix binaries on Linux.  :-)

Speaking of which, if we're doing this, are there some old system
calls that we could remove at the same time?

      	       	       	     	  - Ted
