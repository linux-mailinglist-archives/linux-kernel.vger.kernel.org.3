Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA056874A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiGFLum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiGFLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:50:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2946286F7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD472B81C0D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43FFC3411C;
        Wed,  6 Jul 2022 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657108237;
        bh=pIkja7u4jVh70cjtOcr/icdaQPCTUe5JoMbq34s2vCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZcs/8PQUqBcCYbonWkSDNfeylddwt8DzSYGJceY9yQoymUm1LGtSSG4b7LjShl/7
         WZ2qs49p9ECdbmNoFL8nhUg0Q0m7QIs0zLU37eHfOGr1GFyMoHEh8juucfoVjyMmIR
         ajvq7TmLNCUyZHv4keoy/mTWt3SOqE0iwG5syLwvpZymYoObj/wihM6BGcOawmgbrz
         9uQ1gruOt4q9DFe5vAQv1ino7n6NpOQ+V3+FOiz3OSXF0FdnoZ5C9r6yFG2643vVpN
         9/N7yibHBWvj1Zmjy0dc0nHzxgb9JO/SxG+7fIHDKcyvqfDrpbhM0h+SSJGjUP1So6
         OMmUMmPsp7dHw==
Date:   Wed, 6 Jul 2022 12:50:31 +0100
From:   Will Deacon <will@kernel.org>
To:     yf.wang@mediatek.com
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 0/2] iommu/mediatek: TTBR up to 35bit support
Message-ID: <20220706115028.GC2403@willie-the-truck>
References: <20220630092927.24925-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630092927.24925-1-yf.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:29:24PM +0800, yf.wang@mediatek.com wrote:
> This patchset adds MediaTek TTBR up to 35bit support for single normal zone.
> 
> Changes in v12:
> - Update [PATCH 1/2]: remove GENMASK(31, 7)
> - Update [PATCH 2/2]: remove MMU_PT_ADDR_MASK definition.

For both patches:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick these up for 5.20?

Thanks,

Will
