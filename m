Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279324D96B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbiCOIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbiCOIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:49:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5D4B430
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:48:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8ED868AA6; Tue, 15 Mar 2022 09:48:17 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:48:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH v6 1/3] i915/gvt: Introduce the mmio table to support
 VFIO new mdev API
Message-ID: <20220315084817.GA4105@lst.de>
References: <20220208111151.13115-1-zhi.a.wang@intel.com> <871r0dqtjf.fsf@intel.com> <20220209072805.GA9050@lst.de> <4e2faf7b-383e-58b3-8ae9-8f8d25c64420@intel.com> <20220315075217.GA2830@lst.de> <87a6drvc02.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6drvc02.fsf@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:46:53AM +0200, Jani Nikula wrote:
> On Tue, 15 Mar 2022, Christoph Hellwig <hch@lst.de> wrote:
> > Just curious, what is the state of this seris?  It would be good to
> > have it ready early on for the next merge window as there is quite
> > a backlog that depends on it.
> 
> Can't speak for the status of the series, but for drm the deadline for
> changes headed for the merge window is around -rc5/-rc6 timeframe
> i.e. this has already missed the upcoming merge window.

I know.  I meant the next one, not the one ending now.  And I don't
want to miss another one.
