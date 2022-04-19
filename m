Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C745070E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353513AbiDSOp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353523AbiDSOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:45:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C88329B8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 212EBB81A3C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94C2C385A7;
        Tue, 19 Apr 2022 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650379334;
        bh=8U3kOAkP8r3tY5esyIBlcm2h6NMZv9H6akvf7zELYMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WS1kZShIt+dmp/9oGVSwk8nSf3Iw3FCqZ8foPjBQyglkkYKSV4P+xNqXGCmJ/F0kL
         YIuwELlsokI8JHK5+R0hpc/1R2SMAMT9utdQGJJfOfb3DuqVQlwPb1lP2jQqwG4Cec
         o5QIEOeMxhoxOfnh4j6sjSvav36p77IypYkuXgvDv9marwj+XNQDCHDfcDB3ITl++S
         7jIpEpORO8XtUbchC7jmN1eHH6EOOcqchG+pOcWmcqE3c8KM7z9oEKAiJdjHAQltzr
         C9Qf/WO6G5hJ2tANjbrf7xWZcPA+iE8G/680dD9yBUyePB75nEj6MPZDcZiYBn5UJr
         C3QDeywlaYbFg==
Date:   Tue, 19 Apr 2022 15:42:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] iommu/arm-smmu-v3: Clean up bus_set_iommu()
Message-ID: <20220419144207.GB6186@willie-the-truck>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <4c55ff48992ee8c2a81a38c859dc817ecacd8517.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c55ff48992ee8c2a81a38c859dc817ecacd8517.1649935679.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:42:34PM +0100, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
> the probe failure path accordingly.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 +--------------------
>  1 file changed, 2 insertions(+), 51 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
