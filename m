Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4554DA42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358943AbiFPGJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358992AbiFPGJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:09:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D752AE31;
        Wed, 15 Jun 2022 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EUNYA924dE1kBloksUiFIzNuxX
        328ixiccG2CcCT44imvDYy+6VPszCoLYmb3ucxBUbUJmfZ3Ilg1wiU9SVl2HWYBh9Pv41ZXTlxrze
        1d+uwFrNgZiphuhxwxDIZBVe64pQ5VN2Bcf/pfOAV4gwBVmLN8+uDv1yHlI+4ienCQ6oNAR0dfYpg
        SoSYMW4kgZ3xU3rRfZBN/Lcs1Nfmhxub03u1qKKd3IUTWcqFpF7IfH3NlfVKrR1x37mc6eyLyXv4h
        35sutpP4BHVarMWcP3pDb/aeL6zmkxHZc1k/JgFKjaFOXUoBxToVRSTk+iyS2ZIzHNqDlr2HPHCB/
        h03tlGhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1igi-000gaY-Vx; Thu, 16 Jun 2022 06:09:05 +0000
Date:   Wed, 15 Jun 2022 23:09:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, bvanassche@acm.org
Subject: Re: [PATCH v4] scsi: support packing multi-segment in UNMAP command
Message-ID: <YqrJAO3q8DM4o28A@infradead.org>
References: <20220616013617.2284341-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616013617.2284341-1-chao@kernel.org>
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
