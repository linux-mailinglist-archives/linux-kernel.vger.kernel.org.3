Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348BF4F222F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiDEEft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiDEEfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:35:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E975639C;
        Mon,  4 Apr 2022 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/BsWeG/6wYrl48co3t4RGKYFq46T2Oi2x4e+kmDSTmI=; b=wwDha9rTgvl/6W8ZszMKGVD7us
        D8JCrWtgcKNdv8o/EeDCZU82/S3AJeS7PPDk64uG5RYAVissjA97hin0jKDI8NwEZagmSq87Q3Mjg
        z+WbqiQqR9nHIIrnfYBN+KTotXkPTeMCCtjcCeT+S592d9jdqubyjuGG/jhZpQY8Jx+yMrS3WJApH
        RvQMY3u/ZN+pM5evMbxaYxCCIV0Qi9+/OHubH2gsbNrADSBkRQE11Xp2drjQhix9Y+kqrY3UHPxgd
        7PUNojVQcSGtYNbHyN6Y5rruT95E+LidQ1EjnEM2GeRwCgv/qYShB1zhdZOdWRtUeN8ylnRifYfPv
        SVv0pbsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbasx-00H50A-4X; Tue, 05 Apr 2022 04:33:43 +0000
Date:   Mon, 4 Apr 2022 21:33:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
 configuration item back
Message-ID: <YkvGp7c8QLf5i/j0@infradead.org>
References: <20220404200202.9388-1-mario.limonciello@amd.com>
 <20220404200202.9388-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404200202.9388-2-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 03:02:02PM -0500, Mario Limonciello wrote:
> CONFIG_SATA_LPM_MOBILE_POLICY was renamed to CONFIG_SATA_LPM_POLICY in
> commit 4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
> configuration item").
> 
> This caused some pain as users would invisibly lose configuration policy
> defaults when they built the new kernel.  To help alleviate that, switch
> back to the old name (even if it's wrong).

Note that for this to be useful it would have to go into 5.18.
