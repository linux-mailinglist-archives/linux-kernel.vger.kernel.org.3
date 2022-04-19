Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E85063FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbiDSFrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348688AbiDSFrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:47:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC32A700
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2H+hRY4SLyCYScycpRFvm0NMdB
        xE3fXwvaCNaoRyjUQpPD56pNbDAoJiIr2d+5TKQIDKbRwi6UCdwloWaXeD25CTY9NX/kMGv5pUKdo
        ekEsKzM2ZFezIebNcwFKsyqboYRy0dr8D36fkyFlSYUckaPFLMLvbhugm/o3Sx4X4wATF4ghGTFKq
        6HZ2nXr2VLCg4mhf3MHJ73jPDe8NoAnYNfbSLISWy6F+18IJd8LA5G9nbvqpYNIGd6f6GGMz3X4Ow
        HNoVEEX4iIDty5jvBmoW+5pG8+pYHMHDiTcOEmn661c+GJ6Jdi+HxZEpvt8e+k5qAjOXOao/7Oh+w
        H2uMlOmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nggfG-001cHH-Ph; Tue, 19 Apr 2022 05:44:38 +0000
Date:   Mon, 18 Apr 2022 22:44:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Fold dmar_insert_one_dev_info() into
 its caller
Message-ID: <Yl5MRgCOZ97WGHWh@infradead.org>
References: <20220416120423.879552-1-baolu.lu@linux.intel.com>
 <20220416120423.879552-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416120423.879552-3-baolu.lu@linux.intel.com>
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
