Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0932554A63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiFVM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiFVM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:59:23 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D7E2F386
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:59:21 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4140D2D0; Wed, 22 Jun 2022 14:59:20 +0200 (CEST)
Date:   Wed, 22 Jun 2022 14:59:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Message-ID: <YrMSJ6AGwn3PxSIH@8bytes.org>
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 04:12:10PM +0100, Robin Murphy wrote:
> firmware bindings by now. Let's be brave and default it to off in the

I don't have an overall good feeling about this, but as you said, let's
be brave. This is applied now to the core branch.

If it causes too much trouble we can still revert it (and re-revert it
later, ...)

Thanks,

	Joerg
