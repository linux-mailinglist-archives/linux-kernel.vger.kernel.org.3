Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602DF497C39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiAXJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:40:43 -0500
Received: from verein.lst.de ([213.95.11.211]:54890 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbiAXJkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:40:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA27D68C4E; Mon, 24 Jan 2022 10:40:05 +0100 (CET)
Date:   Mon, 24 Jan 2022 10:40:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH v4 1/2] i915/gvt: Introduce the mmio_info_table.c to
 support VFIO new mdev API
Message-ID: <20220124094004.GA23537@lst.de>
References: <20211129123832.105196-1-zhi.a.wang@intel.com> <20211130164622.GA15150@lst.de> <e183b95f-89d1-3a2f-27e2-82aa2b10e8fc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e183b95f-89d1-3a2f-27e2-82aa2b10e8fc@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 08:52:53AM +0000, Wang, Zhi A wrote:
> Sorry for the late reply as I am supporting the customers recently. I 
> will refresh this after the christmas.

Did you find some time to look into it?  Do you want some help?
