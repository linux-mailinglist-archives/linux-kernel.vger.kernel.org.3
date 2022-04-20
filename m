Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CCE5081BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359602AbiDTHKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:10:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B525C55
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:08:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 36FFD68AFE; Wed, 20 Apr 2022 09:08:01 +0200 (CEST)
Date:   Wed, 20 Apr 2022 09:08:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: refactor the i915 GVT support and move to the modern mdev API
 v3
Message-ID: <20220420070800.GB4417@lst.de>
References: <20220413154642.GA28095@lst.de> <871qy1geko.fsf@intel.com> <5af7726e-920e-603a-bad3-8adb09d2ba89@intel.com> <20220413232053.GA2120790@nvidia.com> <1c3aaab9-3bd4-95d4-9f9f-4be9e10e6516@intel.com> <20220414133427.GB2120790@nvidia.com> <87ilrbeqbo.fsf@intel.com> <20220414134321.GD2120790@nvidia.com> <abc0a953-8527-ba25-9987-d2f1284a7430@intel.com> <20220414143859.GE368031@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414143859.GE368031@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:38:59AM -0300, Jason Gunthorpe wrote:
> pull requests can flow through more than one tree concurrently. The
> purpose of the topic branch is to allow all the commits to be in all
> the trees they need to be in at once.
> 
> So you should send this branch as a PR to the next logical upstream
> tree gvt patches normally go through, in the usual way that you send
> PRs. Especially in this case where there is a small merge conflict
> internal to DRM to resolve. I'm assuming this is the drm-intel-next
> tree?
> 
> Once DRM is internally happy then VFIO can merge it as well. You can
> view VFIO as the secondary path to Linus, DRM as primary. Alex will
> mention in his pull request that VFIO has a 'shared branch with DRM
> for gvt'.

Where do we stand here?  The (somewhat misnamed) topic/for-christoph
branch looks fine to me now except for the mіssing "static inline" on
the intel_gvt_iterate_mmio_table stub.

When can we expect it in the i915 tree and linux-next?
