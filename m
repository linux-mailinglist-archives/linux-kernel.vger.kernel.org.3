Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9373C464E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbhLAM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbhLAM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:56:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:53:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 415DBCE1DEE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21FC53FAD;
        Wed,  1 Dec 2021 12:53:18 +0000 (UTC)
Date:   Wed, 1 Dec 2021 13:53:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH V2] ipc: add set_ownership() and permissions() callbacks
 for posix mqueue sysctl
Message-ID: <20211201125314.mhx7z4nhg2ei2eof@wittgenstein>
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
 <20210827101206.5810-1-ran.xiaokai@zte.com.cn>
 <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
 <6142a2ac.1c69fb81.6dcc6.61f8@mx.google.com>
 <20211004105313.k55766idkyoo6jvt@wittgenstein>
 <61a720eb.1c69fb81.80210.02b6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61a720eb.1c69fb81.80210.02b6@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:14:50AM +0000, CGEL wrote:
> On Mon, Oct 04, 2021 at 12:53:13PM +0200, Christian Brauner wrote:
> > On Thu, Sep 16, 2021 at 01:49:31AM +0000, CGEL wrote:
> > > esOn Mon, Sep 13, 2021 at 04:40:47PM +0200, Christian Brauner wrote:
> > > > On Fri, Aug 27, 2021 at 03:12:06AM -0700, CGEL wrote:
> > > > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > > > 
> > > > > When a non-root user process creates a user namespace and ipc namespace
> > > > > with command "unshare -Ur -i", and map the root user inside
> > > > > the user namesapce to the global owner of user namespace.
> > > > > The newly created user namespace OWNS the ipc namespace,
> > > > > So the root user inside the user namespace should have full access
> > > > > rights to the ipc namespace resources and should be writable to
> > > > > the ipc mqueue sysctls.
> > > > > 
> > > > > v2:
> > > > >   - update commit msg.
> > > > >   - fix the coding style issue.
> > > > > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > > > ---
> > > > 
> > > > David,
> > > > 
> > > > are you happy with this too? If so I'd pick this up.
> > > > 
> > > 
> > > Hi Christian,
> > > 
> > > Is there a xx-next branch for this kind patch?
> > > We will try to fixes other issues like this, so we could tag the follow-up
> > > patches with the branch name.
> > 
> > Hm, sorry that message slipped through the pre-mid-and post-conference
> > cracks.  I'll added the patches now for testing. See:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.fixes
> > 
> > Christian
> 
> Hi Christian,
> 
> How the the testing goes on? 

I'll plan to send this for the next merge window.

Thanks!
Christian
