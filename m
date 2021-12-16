Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50E84772FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhLPNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhLPNRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:17:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB09C061574;
        Thu, 16 Dec 2021 05:17:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB2DB8230C;
        Thu, 16 Dec 2021 13:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E106C36AE0;
        Thu, 16 Dec 2021 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639660666;
        bh=RXJSJUNjCddqB7i9e0oX0EbESmbM41nI6+hbp4GOdBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOLw/vmr/cdUo/h/X6Kfc0kEsXmWfR1NwkmmEUD5j5KzuhCJsdtHvj3kA2l8P6gGR
         bqDT2sIAg2hHYwVpgW3KwI1V/fS3671gwwnUi0PzSP4EvEjRLm/0HljmnZArOsM+It
         aOxr3x8ECjmh5yQwTy30eEq0MMi/s8uWE4P8aQxA=
Date:   Thu, 16 Dec 2021 14:17:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: Re: [PATCH v3] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid
 identifiers
Message-ID: <Ybs8eJOBwxw/Tj3o@kroah.com>
References: <12f38ebde4dcd8b1ecbd37df1b6ce2018426f6dd.1639657049.git.mchehab+huawei@kernel.org>
 <20211216123014.GA286@LAPTOP-UKSR4ENP.internal.baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211216123014.GA286@LAPTOP-UKSR4ENP.internal.baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:30:14PM +0800, Cai Huoqing wrote:
> On 16 12月 21 13:17:35, Mauro Carvalho Chehab wrote:
> > Some files have been flagged with the new LGPL-2.1-or-later
> > identifier which replace the original LGPL-2.1+ in the SPDX license
> > identifier specification, but the identifiers are not mentioned as
> > valid in the LGPL-2.1 license file.
> > 
> > Add it, together with the LGPL-2.1-only at the the license file.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  LICENSES/preferred/LGPL-2.1 | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.1
> > index 27bb4342a3e8..b73f9b6230f5 100644
> > --- a/LICENSES/preferred/LGPL-2.1
> > +++ b/LICENSES/preferred/LGPL-2.1
> > @@ -1,5 +1,7 @@
> >  Valid-License-Identifier: LGPL-2.1
> > +Valid-License-Identifier: LGPL-2.1-only
> >  Valid-License-Identifier: LGPL-2.1+
> > +Valid-License-Identifier: LGPL-2.1-or-later
> >  SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
> The URL is deprecated, do we need to update it together.

No.

> The same, GPL-2.0, LGPL-2.0

Again, no.  We are using an older version of the SPDX specification,
this is fine.

thanks,

greg k-h
