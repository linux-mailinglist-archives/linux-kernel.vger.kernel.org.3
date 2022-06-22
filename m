Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1005545F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiFVKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356506AbiFVKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:43:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1DA167C4;
        Wed, 22 Jun 2022 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d9qh4ClogxgC0O6hF1eUSJPidsyvY/LbjmD7UJqICRw=; b=effxifTebkgcG6rotJpwJVDCEb
        zxQ0vXZ8GXZVYpoyvSB61V6hix18oqpmTo90l9csCV6ATv+Pk5ieUQHdhOIdf47JOA0//38Gf5qcN
        +jWUcehjbts8XSqtewFPNB1gT0HkHI07OrEc0IyqY8pa7JCbLaghfQtJ1HaGGalSBsAtgdwVgpDZa
        cZJxQ0Kn7Ahhmy4ugrHuqxjX16mwkf6uZry8P3xVjNa4AsfUfsOURPtZCwuC/P1t81bzrtsN4q+VU
        qC6NxfSLsSchTAyeOWpPZAJVDP4jvPMxwpqA28hLJF0jL/Omn3EzS0NFAeOsvMgfSRH0Bdn9obc/n
        r50sqR7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3xpj-009yMX-Ac; Wed, 22 Jun 2022 10:43:39 +0000
Date:   Wed, 22 Jun 2022 03:43:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        hch@infradead.org, m.szyprowski@samsung.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        corbet@lwn.net
Subject: Re: [PATCH v1 0/4] swiotlb: some cleanup
Message-ID: <YrLyWzL48no3a6cS@infradead.org>
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611082514.37112-1-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I've applied all 4 to the dma-mapping tree for Linux 5.20.
