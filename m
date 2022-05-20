Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF552E829
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347468AbiETI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiETI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:58:56 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2425D029D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:58:55 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1B98A1E9; Fri, 20 May 2022 10:58:54 +0200 (CEST)
Date:   Fri, 20 May 2022 10:58:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, jon.grimm@amd.com,
        linux-kernel@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO
 page tables are in used
Message-ID: <YodYTZzSd9fZucLT@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org>
 <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org>
 <794e13dd-8eae-481d-711d-b5462fdbfb18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794e13dd-8eae-481d-711d-b5462fdbfb18@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:54:51AM +0100, Robin Murphy wrote:
> The .def_domain type op already allows drivers to do exactly this sort of
> override. You could also conditionally reject IOMMU_DOMAIN_PASSTHROUGH in
> .domain_alloc for good measure, provided that (for now at least*) SNP is a
> global thing rather than per-instance.

Yeah, that could work. I am just not sure the IOMMU core behaves well in
all situations when allocation IOMMU_DOMAIN_PASSTHROUGH suddenly starts
to fail. I would feel better if this is checked and tested :)

Regards,

	Joerg
