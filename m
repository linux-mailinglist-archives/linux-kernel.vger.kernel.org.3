Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEF5769C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiGOWQ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Jul 2022 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiGOWQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:16:17 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B590F07
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:16:16 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 358A512095E;
        Fri, 15 Jul 2022 22:16:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 01E912000D;
        Fri, 15 Jul 2022 22:16:05 +0000 (UTC)
Message-ID: <f6ab40860cd4f8079e6e169c7d6465f211b8dbd3.camel@perches.com>
Subject: Re: [PATCH v2 24/39] drm/i915: dvo_sil164.c: use SPDX header
From:   Joe Perches <joe@perches.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 15 Jul 2022 15:16:05 -0700
In-Reply-To: <YtHdp6ju3IfjF8Bq@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
         <002a8d51244a70572744de86cacbdae293e7d503.1657699522.git.mchehab@kernel.org>
         <YtHdp6ju3IfjF8Bq@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 9shq7dagh5qa1dpwkohcwaxcpnds4xbk
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 01E912000D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19aezajI8aTJN8t18DoGrRvtF8w07Xpt2A=
X-HE-Tag: 1657923365-889008
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 17:35 -0400, Rodrigo Vivi wrote:
> On Wed, Jul 13, 2022 at 09:12:12AM +0100, Mauro Carvalho Chehab wrote:
> > This file is licensed with MIT license.	Change its license text
> > to use SPDX.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Not exactly the MIT license as it's missing "or copyright holders"
> 
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> > 
> >  drivers/gpu/drm/i915/display/dvo_sil164.c | 32 +++++------------------
> >  1 file changed, 6 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/dvo_sil164.c b/drivers/gpu/drm/i915/display/dvo_sil164.c
> > index 0dfa0a0209ff..12974f7c9dc1 100644
> > --- a/drivers/gpu/drm/i915/display/dvo_sil164.c
> > +++ b/drivers/gpu/drm/i915/display/dvo_sil164.c
> > @@ -1,30 +1,10 @@
> > -/**************************************************************************
> > +// SPDX-License-Identifier: MIT
> >  
> > -Copyright © 2006 Dave Airlie
> > -
> > -All Rights Reserved.
> > -
> > -Permission is hereby granted, free of charge, to any person obtaining a
> > -copy of this software and associated documentation files (the
> > -"Software"), to deal in the Software without restriction, including
> > -without limitation the rights to use, copy, modify, merge, publish,
> > -distribute, sub license, and/or sell copies of the Software, and to
> > -permit persons to whom the Software is furnished to do so, subject to
> > -the following conditions:
> > -
> > -The above copyright notice and this permission notice (including the
> > -next paragraph) shall be included in all copies or substantial portions
> > -of the Software.
> > -
> > -THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> > -OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > -MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
> > -IN NO EVENT SHALL THE AUTHOR

Missing "Authors or copyright holders"

> > BE LIABLE FOR
> > -ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
> > -TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> > -SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> > -
> > -**************************************************************************/
> > +/*
> > + * Copyright © 2006 Dave Airlie
> > + *
> > + * All Rights Reserved.
> > + */
> >  
> >  #include "intel_display_types.h"
> >  #include "intel_dvo_dev.h"
> > -- 
> > 2.36.1
> > 

