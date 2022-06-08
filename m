Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061A5542806
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiFHHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354413AbiFHGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52229F826E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=h42SDWHqUOya+eSDpvhVeQpEt2
        9ADF4krKMF5jdcrgjvBXITCwTRhrZLZ6iYaUQuXQpJ7Zr1vLIcbQdR7H7LkIe28W4msLY52phPlVO
        ejROhrPY9RwSUZIZY8L0WBTZE87iomsOLmFbpe0b2r27VHzf7Ewm/K/cvAuY0CmYrLkyDN37kSuHf
        VV4a/Bpp0PZBw16E7ISflbGGLngQVZoyVaAXXR+iFt3bpruMbYb3ANKjZuCm8prPfjGUhdzvqQ5EM
        3DMORyiKzN2N+Irm2ujvktgrv/NMEOlNsLBoL7q6I2vTwMAXDnkiJtCWJJ/hpzep39Ia37mhLIEx9
        m9S7Uhsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyotO-00BFHv-GV; Wed, 08 Jun 2022 06:10:10 +0000
Date:   Tue, 7 Jun 2022 23:10:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v5 4/6] mm: ioremap: Add ioremap/iounmap_allowed()
Message-ID: <YqA9Qg959W/INdh/@infradead.org>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <20220607125027.44946-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607125027.44946-5-wangkefeng.wang@huawei.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
