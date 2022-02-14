Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936DD4B539E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355286AbiBNOpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:45:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBNOpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:45:22 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904F4AE3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:45:14 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A0171374; Mon, 14 Feb 2022 15:45:12 +0100 (CET)
Date:   Mon, 14 Feb 2022 15:45:11 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mst@redhat.com, jasowang@redhat.com,
        robin.murphy@arm.com, xieyongji@bytedance.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com
Subject: Re: [PATCH v2] iommu/iova: Separate out rcache init
Message-ID: <Ygpq9zvzGsFu/FZ1@8bytes.org>
References: <1643882360-241739-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643882360-241739-1-git-send-email-john.garry@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:59:20PM +0800, John Garry wrote:
> Currently the rcache structures are allocated for all IOVA domains, even if
> they do not use "fast" alloc+free interface. This is wasteful of memory.
> 
> In addition, fails in init_iova_rcaches() are not handled safely, which is
> less than ideal.
> 
> Make "fast" users call a separate rcache init explicitly, which includes
> error checking.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied, thanks.
