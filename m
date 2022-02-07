Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8D4AB6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbiBGIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350193AbiBGIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:35:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07781C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:35:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3862868AFE; Mon,  7 Feb 2022 09:35:36 +0100 (CET)
Date:   Mon, 7 Feb 2022 09:35:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support
 VFIO new mdev API
Message-ID: <20220207083535.GA25345@lst.de>
References: <20220127120508.11330-1-zhi.a.wang@intel.com> <20220207073247.GA24327@lst.de> <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:28:13AM +0000, Wang, Zhi A wrote:
> 1) About having the mmio_table.h, I would like to keep the stuff in a dedicated header as putting them in intel_gvt.h might needs i915 guys to maintain it.
> 2) The other one is about if we should move the mmio_table.c into i915 folder. I guess we need the some comments from Jani. In the current version that I am testing, it's still in GVT folder. Guess we can submit a patch to move it to i915 folder later if Jani is ok about that.

Yes, let's have Jani chime in on these.  They're basically one and the
same issue.  This code will have to be built into into the core i915
driver even with my planned split, which is kindof the point of this
exercise.  I think it makes sense to use the subdirectories as boundaries
for where the code ends up and not to declarare maintainership boundaries,
but it will be up to the i915 and gvt maintainers to decide that.
