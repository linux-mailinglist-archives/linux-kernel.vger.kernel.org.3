Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B7479A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhLRLFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhLRLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:05:40 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 03:05:39 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 06EB6C01F; Sat, 18 Dec 2021 12:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639825537; bh=oatp1nrHc/N8983ifesjNQfkHoYyt7U2LCnk5a8+grI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgfGfMS5GpnDNacLaT4fA23UyUx8Ul38k3vtBuYaXJAQypNVsRs2AJlaSln8DY/ru
         u10fWksBg0MgUarHJsdB/911zDHaqXuQktgtHPUmg/XHoEjKPRjERvGxHJbcHQj/sr
         WvyKeFmh9h0ArnkgQtuDX/PS6INbPgrHBs25gAhZdfib3AdGnIPK1x17VkjsZ/f4SA
         mMRHuiXpGerzxVbDka9MsLHl0rtYVzGqFfJu1dKb4HAoHrKcXqFx2pMBG524Dhf9JB
         vpdyOjwG4/FP+eOImN+FjKDDUJQUbKCeojrn4OH66vP7mofZgEjLpd4cSjlmDRRZ/3
         faIykbL4Y4YpA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D494BC009;
        Sat, 18 Dec 2021 12:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639825536; bh=oatp1nrHc/N8983ifesjNQfkHoYyt7U2LCnk5a8+grI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltFl3vwvg6wUNK+U5lWHn+IwQA+hMGK5QYs7u0Axd1qOMx+GSy0aFmHkQvrshYnR8
         T7Oyw/kn+netdIew42FLJblXb2/KAu1cJzt/HBaU/8bsirlUiswdediiFBPAgkkoN6
         2ezji1ISGVQvEPsbHVXf1wllSeTQjACkQ6SEGNIZyyqlnMTi3EukUyOL5ls0d8ihU+
         oyqupxf2xplH3iJkcbw5hgZT3agUKj0R+nnwi5AvlZ4Bjg3bvC4ijsjeHkKXTxBive
         M3jgxYsMvWEK9yzXBRsod6oiQClQK7eKyxzxZ99Rbm1oofP/z2woezBcBMdxnWBWTf
         OJAyPCSCJMICw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 403b9c05;
        Sat, 18 Dec 2021 11:05:31 +0000 (UTC)
Date:   Sat, 18 Dec 2021 20:05:16 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jeff Layton <jlayton@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: fix unused-variable warning
Message-ID: <Yb3AbFhc9ApdHpcA@codewreck.org>
References: <20211203185816.796637-1-arnd@kernel.org>
 <YaqwdNGlZDBDcg5R@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YaqwdNGlZDBDcg5R@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Sat, Dec 04, 2021 at 09:04:04AM +0900:
> Arnd Bergmann wrote on Fri, Dec 03, 2021 at 07:58:06PM +0100:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The folio changes added a variable that is sometimes unused:
> > 
> > fs/9p/vfs_addr.c: In function 'v9fs_release_page':
> > fs/9p/vfs_addr.c:140:23: error: unused variable 'inode' [-Werror=unused-variable]
> >   140 |         struct inode *inode = folio_inode(folio);
> >       |                       ^~~~~
> > 
> > Make this clearer to the compiler by replacing the #ifdef
> > with an equivalent if(IS_ENABLED()) check.
> > 
> > Fixes: 78525c74d9e7 ("netfs, 9p, afs, ceph: Use folios")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks good to me, picking it up

Sorry it took me a while to actually do the picking up part, but this
appears to have been a patch for linux-next back then and I didn't
notice because the Fixes tag is incorrect (78525c74d9e7 didn't introduce
the inode variable, it actually fixes a patch that never has been merged)

David since then fixed the warning differently in v2 of the patch (he
moved the fscache_note_page_release() out of the ifdef), so I won't do
anything with this even if in principle I tend to agree that
if(IS_ENABLED()) lead to better compiler coverage

Thanks though!
-- 
Dominique
