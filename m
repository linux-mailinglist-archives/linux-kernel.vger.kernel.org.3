Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF25519E97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiEDL5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiEDL5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:57:19 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500EE21E37
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:53:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 160893FA; Wed,  4 May 2022 13:53:42 +0200 (CEST)
Date:   Wed, 4 May 2022 13:53:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jan Stancek <jstancek@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, bgoncalv@redhat.com
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
Message-ID: <YnJpQiEJWNjyOyji@8bytes.org>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
 <20220504075356.GA2361844@janakin.usersys.redhat.com>
 <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, May 04, 2022 at 12:14:07PM +0100, Robin Murphy wrote:
> Oof, this can probably be hit with vfio-noiommu too, and by the look of
> things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
> up as well. Does the patch below work for you?

Thanks for the quick patch! I am delaying to send iommu-fixes upstream
for now in the hope the fix can make it into the branch asap. Please
send it out as a separate patch as soon as it is successfully tested.

Regards,

	Joerg

