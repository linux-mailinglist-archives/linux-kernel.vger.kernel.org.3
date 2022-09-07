Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9985AFF66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIGIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIGIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:41:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF4A5C6F;
        Wed,  7 Sep 2022 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=YGqqWOkIlp4wL4QvSg1QvGSDJs
        7BsBuJd2vZloqmqZVYag6GUx8MgGcG6k7N6Pa6WmrLW2v0P3Feauq1+vLQ+SwrwlRqvINZJTOwBl0
        wxhU0qzT+TzCCWV4LS0+r0cG+EYsK+DYZQ3sjYAUWpcdmCUSBkcq7yVYgDJB9tmNVHEcj/tNk/8qu
        Zas15dUPp2A0MEg+269FxCrDmahwz7NCf5U+096527uMjhfymAT6htBZOWtUlPACwRzC2Uh3xjDRb
        38qUztzbGAsOSLShnevqSC1PVtIy2CBEGw05PdksfYfFhjkIJA01cvmGQEPnCpudRLstViBDIDa9+
        BE6aP28g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVqbG-004OIZ-BZ; Wed, 07 Sep 2022 08:39:58 +0000
Date:   Wed, 7 Sep 2022 01:39:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, iommu@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
Message-ID: <YxhY3nOLlRsDi6dj@infradead.org>
References: <20220829232934.3277747-1-yuzhao@google.com>
 <20220831063818.3902572-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831063818.3902572-1-yuzhao@google.com>
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

Thanks, applied.
