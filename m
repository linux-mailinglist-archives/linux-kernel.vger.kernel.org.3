Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3708A477326
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhLPNax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhLPNav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:30:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F73C061574;
        Thu, 16 Dec 2021 05:30:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FBAF61DE1;
        Thu, 16 Dec 2021 13:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC6DC36AE0;
        Thu, 16 Dec 2021 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639661450;
        bh=DFkxvtxMqMUzTPeD8ypKgs/NOnPrlmnUQy5+INh5uY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Buf8GtMlIjHdecx15IQgRj57NJaf2KpSeoYgXshUpjhmzB3RbVPB6W1HRxUvh0oS9
         S2xjsEbZnKoocxKrcBZQY3FGz+CMBvXZCp+2qrCFUzjDmIdhb2vOMMLJAwGDbaAxwk
         TNUTYwPS9hftZA+9Z4RzoMGT5fwBksq8e8STjIDU=
Date:   Thu, 16 Dec 2021 14:30:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH v3] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid
 identifiers
Message-ID: <Ybs/h3WAY3FFVC4/@kroah.com>
References: <12f38ebde4dcd8b1ecbd37df1b6ce2018426f6dd.1639657049.git.mchehab+huawei@kernel.org>
 <20211216123014.GA286@LAPTOP-UKSR4ENP.internal.baidu.com>
 <Ybs8eJOBwxw/Tj3o@kroah.com>
 <CAKXUXMwsxiUncxS4Fip=7iK-xrUZSXY61jNcO61bgMyQ0DYp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMwsxiUncxS4Fip=7iK-xrUZSXY61jNcO61bgMyQ0DYp6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 02:28:10PM +0100, Lukas Bulwahn wrote:
> On Thu, Dec 16, 2021 at 2:17 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Dec 16, 2021 at 08:30:14PM +0800, Cai Huoqing wrote:
> > > On 16 12月 21 13:17:35, Mauro Carvalho Chehab wrote:
> > > > Some files have been flagged with the new LGPL-2.1-or-later
> > > > identifier which replace the original LGPL-2.1+ in the SPDX license
> > > > identifier specification, but the identifiers are not mentioned as
> > > > valid in the LGPL-2.1 license file.
> > > >
> > > > Add it, together with the LGPL-2.1-only at the the license file.
> > > >
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  LICENSES/preferred/LGPL-2.1 | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
> > > > index 27bb4342a3e8..b73f9b6230f5 100644
> > > > --- a/LICENSES/preferred/LGPL-2.1
> > > > +++ b/LICENSES/preferred/LGPL-2.1
> > > > @@ -1,5 +1,7 @@
> > > >  Valid-License-Identifier: LGPL-2.1
> > > > +Valid-License-Identifier: LGPL-2.1-only
> > > >  Valid-License-Identifier: LGPL-2.1+
> > > > +Valid-License-Identifier: LGPL-2.1-or-later
> > > >  SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
> > > The URL is deprecated, do we need to update it together.
> >
> > No.
> >
> > > The same, GPL-2.0, LGPL-2.0
> >
> > Again, no.  We are using an older version of the SPDX specification,
> > this is fine.
> >
> 
> Mauro's patch just makes sure that spdxcheck.py does not complain
> about the SPDX License Identifiers from SPDX spec v2 and from v3. It
> really does not deprecate anything or implies that everything in the
> kernel needs to move to v3 (which might really be some crazy
> disturbing refactoring effort without a lot of gain), but it allows
> developers that want to use the tags from SPDX spec v3 can do so.
> 
> I would assume making the kernel/a tool in the kernel supporting
> something more while being backwards-compatible is the standard way we
> work... So, Greg, this patch is fine to be included, right?

Yes, this patch is fine, I will queue it up in a bit, thanks!

greg k-h
