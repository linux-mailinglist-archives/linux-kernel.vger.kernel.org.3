Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55CD5097DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384963AbiDUGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384938AbiDUGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:43:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDD13F81
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523236; x=1682059236;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:cc:subject:to:from:message-id:date;
  bh=71JJ0eHi2arpf9/f536F1pmq5dhuMhUNGfpsM7vmudQ=;
  b=klU8dIX5s+VaBkI8S2cVPJv5c3zMLq8QR6ER20DrZwe8oqkquTt03KcB
   yrM7gO7y//lkNrVsmspfHTzZ3qcmH7Z3VMFJIpHFmYFf29O8TrrJnD+P0
   CCjc4edURrL+u5EhT/2Mxen7uFraeZiU/gEX5Higyh7JdmCp9DgjHFZ3n
   oVlSmUZOZnnvzR7nRzMe/3INtGYUYq2QTjpg2M2B7QaSg6gyUqbsMMULc
   eNa2noZcCK6Ykwxfu3qQBiBhgtDxTZzvKaaQebW/FSlYMpAHxy5xLv2ta
   hobLM1h1j6KFUf8HEnh5GVOMuTgp/I1tMsuShysaEHJbu2FNd7rAsyGvw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289368858"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289368858"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="555608128"
Received: from hyeongju-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.54.203])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:31 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220413144548.GR2120790@nvidia.com>
References: <20220411141403.86980-1-hch@lst.de> <20220411141403.86980-6-hch@lst.de> <20220411152508.GH2120790@nvidia.com> <87zgkrha7c.fsf@intel.com> <20220411165121.GA26801@lst.de> <877d7tgo33.fsf@intel.com> <e8cdc103-f683-0b73-70a7-807f6fee0280@intel.com> <20220413134307.GC368031@nvidia.com> <86ee8fcc-e021-bb9f-fda6-a8e85cb1d9b4@intel.com> <20220413144548.GR2120790@nvidia.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/34] drm/i915/gvt: cleanup the Makefile
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <165052322868.6597.3051928698772494571@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 21 Apr 2022 09:40:28 +0300
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tvrtko

Quoting Jason Gunthorpe (2022-04-13 17:45:48)
> On Wed, Apr 13, 2022 at 02:26:23PM +0000, Wang, Zhi A wrote:
> > On 4/13/22 1:43 PM, Jason Gunthorpe wrote:
> > > On Wed, Apr 13, 2022 at 01:39:35PM +0000, Wang, Zhi A wrote:
> > >=20
> > >> It seems Jani's makefile clean patch has already included this one, =
I can
> > >> just simply drop this one so that Christoph won't need to re-send ev=
erything.
> > >>
> > >> For the branch to move on, I am merging the patches and will re-gene=
rate the
> > >> gvt-staging branch, which combines the newest drm-tip vfio-upstream =
and other
> > >> gvt branches.
> > >>
> > >> If you are in a rush of re-basing the patches of non-GVT-g stuff, yo=
u can use
> > >> gvt-staging branch until my pull request landed in drm-intel-next.
> > >>
> > >> Also our QA will test gvt-staging-branch before the pull request. I =
suppose
> > >> it will take one or two days.
> > >=20
> > > When you are wrangling the branches it would be great if Christoph's
> > > series and it's minimal dependencies could be on a single branch that
> > > could reasonably be pulled to the VFIO tree too, thanks
> > >=20
> > > Jason
> > >=20
> >=20
> > Hi Jason:
> >=20
> > I am thinking about the process of merging process. Here are the depend=
ence:
> >=20
> > 1) My patches depend on one patch in drm-intel/drm-intel-next. So it ha=
s to
> > go through drm.
> > My patches of GVT-g will go through drm-intel-next -> drm -> upstream. =

> >=20
> > 2) Christoph's patches depends on my patches, but part of them are for =
VFIO.
> >=20
> > a. If they are fully going through VFIO repo, they might have to wait my
> > patches to get landed first.
> >=20
> > b. If only the GVT-g parts goes through GVT repo, and rest of them goes
> > through VFIO, the rest part still needs to wait.
> >=20
> > What would be a better process?
>=20
> You should organize everything onto one simple branch based on a rc to
> make this all work.
>=20
> Make your #1 patch as a single patch PR based on rc to drm-intel so it
> gets to the right tree
>=20
> Make your MMIO series as PR on the branch above that first PR and merge to
> the gvt tree
>=20
> Make Christoph's series as a PR on the branch above the second PR's
> MMIO series and merge to the gvt tree
>=20
> Merge the gvt toward DRM in the normal way - ie the main merge path for
> this should be through DRM.
>=20
> Then ask Alex to merge the 3rd PR as well.
>=20
> I don't see any intel-next stuff in linux-next yet so hopefully it is
> early enough to get #1 OK.
>=20
> Jason
