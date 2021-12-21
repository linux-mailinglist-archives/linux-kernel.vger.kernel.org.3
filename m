Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D947C96E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhLUWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:55:38 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:51776 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234711AbhLUWzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
        t=1640127328; bh=Z3XgLHjAf088z/zfmUp4THy27dkMGAzwhF+T7mi3USY=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=nChWFmlgVb8u3xuzYDY1dvsH4bvAjxs1zwdAtj2UwULtwqoGz2GW7VmmbtFiHipyX
         +hS62Q1+HHF5U9SAOAnd2J7pK/VuL42kyQNXCJEFJGsrQEcU66AhxxbkL8pX5Zwd+w
         LB7b1HBCZiaXOt609KuO9wUGkyUmpqaKVSHlb4DM=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 21 Dec 2021 23:55:28 +0100 (CET)
X-EA-Auth: 50xHEfD6a45Ok/sI0eIZ65w53xITxc7GoonMu+iHpYSDDO0bez/eu3pWH9ffZYiVCwd3/766v0U8Lz1VzOD6+4xlI1GXFAbV
Date:   Tue, 21 Dec 2021 23:55:26 +0100
From:   Claudio Suarez <cssk@net-c.es>
To:     dri-devel@lists.freedesktop.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2] drm: fix error found in some cases after the patch
 d1af5cd86997
Message-ID: <YcJbXva93zJJBGbE@gineta.localdomain>
References: <YaC7zXW119tlzfVh@gineta.localdomain>
 <20211128142015.GB5295@xsang-OptiPlex-9020>
 <YaUpsaP7hng6zpFh@gineta.localdomain>
 <YaXi803g7iv9MxWR@phenom.ffwll.local>
 <YaiVfZWNyMkG8uED@gineta.localdomain>
 <YaiXEARd8z2C463h@gineta.localdomain>
 <YcBKbn/9oqD2taCk@phenom.ffwll.local>
 <YcC5Qxnj8PvqnS6f@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcC5Qxnj8PvqnS6f@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 06:11:31PM +0100, Daniel Vetter wrote:
> On Mon, Dec 20, 2021 at 10:18:38AM +0100, Daniel Vetter wrote:
> > On Thu, Dec 02, 2021 at 10:51:12AM +0100, Claudio Suarez wrote:
> > > The patch d1af5cd86997 ("drm: get rid of DRM_DEBUG_* log
> > > calls in drm core, files drm_a*.c") fails when the drm_device
> > > cannot be found in the parameter plane_state->crtc.
> > > Fix it using plane_state->plane.
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Fixes: d1af5cd86997 ("drm: get rid of DRM_DEBUG_* log calls in drm core, files drm_a*.c")
> 
> My scrip complained about the fixes line, so I fixed it. I guess you've
> used the sha1 from your tree, not from upstream?

Yes, my bad, sorry. Thanks for the advice.

> Please always use
> upstream sha1 when referencing commits.
> 
> Anyway patches are now pushed.

Thank you!

Best regards.
Claudio Suarez.



