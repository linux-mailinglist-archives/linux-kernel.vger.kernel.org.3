Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985B25096FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384555AbiDUFue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384548AbiDUFub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:50:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC161208F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:47:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9154768B05; Thu, 21 Apr 2022 07:47:38 +0200 (CEST)
Date:   Thu, 21 Apr 2022 07:47:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PULL v2] gvt-next
Message-ID: <20220421054738.GA20772@lst.de>
References: <5a8b9f48-2c32-8177-1c18-e3bd7bfde558@intel.com> <20220420164351.GC2120790@nvidia.com> <20220420114033.7f8b57c7.alex.williamson@redhat.com> <20220420174600.GD2120790@nvidia.com> <20220420200034.GE2120790@nvidia.com> <55cb46db-754e-e339-178c-0a2cfaf65810@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55cb46db-754e-e339-178c-0a2cfaf65810@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:57:34AM +0000, Wang, Zhi A wrote:
> Is it possible that I can send two different pull based on the same branch?
> I was thinking I can remove this line in the original patch and then add a
> small patch to add this line back on the top. Then make two different tags
> before and after that small patch, send one pull with tag that includes that
> small patch to i915 and the other pull with tag that doesn't includes it to
> VFIO?

Yes, you can do that as long as the small fixup commit is the very last
one.
