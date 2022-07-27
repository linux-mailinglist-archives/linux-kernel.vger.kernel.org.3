Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30709583366
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiG0TVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiG0TVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:21:04 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D01EAFA;
        Wed, 27 Jul 2022 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=B8UfPTZBVLqH6QmIgOzYFBHiqW23uV4wdWGVT/uzYT0=; b=VsWP1OF+3nKsRvQkkJAb15Q8mN
        Nr6FcVIi4S4iS1cYiQ0pGOkDV8n4I1hzzJkR/EnucPu8hzt9soVGR2TggP7//DnxtPA9Kj75XEF+0
        VCS+XW4sLzloOK2xbZOvFO6f3sjZpnZ8UToLv/IJ4QTnXGbjRf72APncdGcioEBC4Yu/uk8QOauol
        QD5XqYM1yDQd9fgqniFa3wLPdC1AdoJ1Kbuwtk44bnBw3e8oq7d8eJVQo3mxHoIME6Z+kdDJKU+GJ
        p3RrlFxSzRG4zwwvdCWJZTOFrvgIFM0mTsDUI5ebnzVwZ0FZMnnXFsRBnhmJ+jBsIl1Bky6822G4t
        1rmp2K5Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGmVB-001nxM-TX; Wed, 27 Jul 2022 13:15:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGmVA-000Ur2-B9; Wed, 27 Jul 2022 13:15:24 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 27 Jul 2022 13:15:22 -0600
Message-Id: <20220727191522.118559-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: hch@lst.de, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, sfr@canb.auug.org.au, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] dma-mapping: Reformat comment to suppress htmldoc warning
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make html doc reports a cryptic warning with the commit named below:

  kernel/dma/mapping.c:258: WARNING: Option list ends without a blank
                                     line; unexpected unindent.

Seems the parser is a bit fussy about the tabbing and having a single
space tab causes the warning. To suppress the warning add another
tab to the list and reindent everything.

Fixes: 7c2645a2a30a ("dma-mapping: allow EREMOTEIO return code for P2PDMA transfers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

 kernel/dma/mapping.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index a9ce5d728231..49cbf3e33de7 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -249,15 +249,15 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  * Returns 0 on success or a negative error code on error. The following
  * error codes are supported with the given meaning:
  *
- *   -EINVAL	An invalid argument, unaligned access or other error
- *		in usage. Will not succeed if retried.
- *   -ENOMEM	Insufficient resources (like memory or IOVA space) to
- *		complete the mapping. Should succeed if retried later.
- *   -EIO	Legacy error code with an unknown meaning. eg. this is
- *		returned if a lower level call returned DMA_MAPPING_ERROR.
- *   -EREMOTEIO	The DMA device cannot access P2PDMA memory specified in
- *		the sg_table. This will not succeed if retried.
- *
+ *   -EINVAL		An invalid argument, unaligned access or other error
+ *			in usage. Will not succeed if retried.
+ *   -ENOMEM		Insufficient resources (like memory or IOVA space) to
+ *			complete the mapping. Should succeed if retried later.
+ *   -EIO		Legacy error code with an unknown meaning. eg. this is
+ *			returned if a lower level call returned
+ *			DMA_MAPPING_ERROR.
+ *   -EREMOTEIO		The DMA device cannot access P2PDMA memory specified
+ *			in the sg_table. This will not succeed if retried.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)

base-commit: 0d06132fc84bd91379300768c75a19474e06d0c5
--
2.30.2
