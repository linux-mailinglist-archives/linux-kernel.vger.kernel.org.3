Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA34ABF50
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442805AbiBGNJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442248AbiBGMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:20:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC77DF8E3E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:06:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B19FC68AA6; Mon,  7 Feb 2022 13:06:47 +0100 (CET)
Date:   Mon, 7 Feb 2022 13:06:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support
 VFIO new mdev API
Message-ID: <20220207120647.GA28851@lst.de>
References: <20220127120508.11330-1-zhi.a.wang@intel.com> <20220207073247.GA24327@lst.de> <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com> <20220207083535.GA25345@lst.de> <877da7rlzr.fsf@intel.com> <5c916187-8a8c-323a-adb4-8bce141180cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c916187-8a8c-323a-adb4-8bce141180cc@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 06:57:13AM -0500, Zhi Wang wrote:
> Hi Christoph and Jani:
>
> Thanks for the comments. It would be nice that people can achieve a 
> agreement. I am OK with both of the options and also moving some files into 
> different folders doesn't needs me to do the full test run again. :)

The way I understood Jani he agrees that the mmio table, which needs to
be part of the core i915 module should not be under the gvt/ subdiretory.
I.e. it could be drivers/gpu/drm/i915/intel_gvt_mmio_table.c.  The
declarations could then go either into drivers/gpu/drm/i915/intel_gvt.h
or drivers/gpu/drm/i915/intel_gvt_mmio_table.h.
