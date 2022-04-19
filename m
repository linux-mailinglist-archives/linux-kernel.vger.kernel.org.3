Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452A5063FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348683AbiDSFrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiDSFrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:47:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B627FD7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TnEQll+eBh1Ey36hApYxQP6G3m
        LebYE2b1XUMVcgoLDnyseSbU7/gZOXXYm4XTqddXV3kI357H8g3Bqp2aoTEVbyynMuy2YUh/DoGWC
        H+GQO9xwetNjyex6+qCowERgtJgMGM+7tyd6sujsINdniJvcOjmAvt3SmTMpeuubdesZQT+InRcq4
        XwV3pAeziYH1fALhc+enIPm9lcvJ6+Yndxbea8QYEFpnbKUJ6RIbhHGlVyvol+D5YqsU601t+qA56
        L2rsQ0FrmVw/LKOaoJRbqAQoKbMcOSzxZqHe9ZBIr9hmnoa8W84uRhPjPi9vqwy9v2qYAl5WqNvgy
        gSkf9q7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nggf5-001cFR-Fu; Tue, 19 Apr 2022 05:44:27 +0000
Date:   Mon, 18 Apr 2022 22:44:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Message-ID: <Yl5MOxKAyNY1AXag@infradead.org>
References: <20220416120423.879552-1-baolu.lu@linux.intel.com>
 <20220416120423.879552-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416120423.879552-2-baolu.lu@linux.intel.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
