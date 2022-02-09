Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860C34AEB14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiBIHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiBIHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:32:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA92C0612C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:32:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE25668BFE; Wed,  9 Feb 2022 08:32:24 +0100 (CET)
Date:   Wed, 9 Feb 2022 08:32:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     hch@lst.de, jgg@nvidia.com, jani.nikula@linux.intel.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhi Wang <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v6 3/3] i915/gvt: Use the initial HW state snapshot
 saved in i915
Message-ID: <20220209073223.GC9050@lst.de>
References: <20220208111151.13115-1-zhi.a.wang@intel.com> <20220208111151.13115-3-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208111151.13115-3-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:11:51AM -0500, Zhi Wang wrote:
> The code of saving initial HW state snapshot has been moved into i915.
> Let the GVT-g core logic use that snapshot.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
