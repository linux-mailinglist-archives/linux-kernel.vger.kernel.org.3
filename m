Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29C513540
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbiD1Nhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiD1Nhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:37:32 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B78F674C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:34:17 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 78C7F374; Thu, 28 Apr 2022 15:34:15 +0200 (CEST)
Date:   Thu, 28 Apr 2022 15:34:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <YmqX1kXee3FGGhXf@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <YmpfFA1iIQyGBipX@8bytes.org>
 <20220428115411.GA8364@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428115411.GA8364@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:54:11AM -0300, Jason Gunthorpe wrote:
> Can we get this on a topic branch so Alex can pull it? There are
> conflicts with other VFIO patches

Right, we already discussed this. Moved the patches to a separate topic
branch. It will appear as 'vfio-notifier-fix' once I pushed the changes.

Regards,

	Joerg
