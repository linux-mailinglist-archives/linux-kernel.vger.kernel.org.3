Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFC6584D66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiG2Ibs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiG2Ibl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:41 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E683220
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:31:36 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E2AB7669; Fri, 29 Jul 2022 10:31:33 +0200 (CEST)
Date:   Fri, 29 Jul 2022 10:31:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        will@kernel.org, jsnitsel@redhat.com, vasant.hegde@amd.com,
        jon.grimm@amd.com
Subject: Re: [PATCH 0/2] iommu/amd: Misc Update for Virtual APIC support
Message-ID: <YuOa5Eyl4KLGoSRO@8bytes.org>
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 08:43:46AM -0500, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (2):
>   iommu/amd: Consolidate Virtual APIC (AVIC) Enablement
>   iommu/amd: Add support for AVIC when SNP is enabled

Applied, thanks.
