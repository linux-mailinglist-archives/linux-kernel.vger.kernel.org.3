Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2225AB755
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiIBRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiIBRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:16:17 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C1DE39AF;
        Fri,  2 Sep 2022 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=49sOK8rTAQ4C6g4afuJZ0iDVLIkKGyM8k5dbP5h4iQM=; b=IaDL6DUTJYPDdvwWPLpZ4VUAFx
        juyS13S9v2gknLyjXta+ALYV0DQaiVkMy/1GUR7CvUP0un+5GhLLCwvS5yqTsEmLKB6/3yIyCbgLd
        Sea/Kt5VBa2XTvOpTmQorokOW/EcNoKI0wLkwIxdWv8TXBjWUfE1KaomY1GEAVwwsEYMzXjSiB+Y/
        a73jVBDfreYUpz9ov2Z6HQV7xqiz8LwdkALi/Q8EHjEZItL1a9rgj5JKhspyWoPCokmt9zWIA9c5q
        FiEiKG1FMLN3mQq06BtxU+JualpZ5SgrrNDxwTnOiYvj4wi27ikJtynXBpdFPfyRFGYdbSvRcxSW1
        ndW7c63Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oUAH8-00Ejne-GW; Fri, 02 Sep 2022 11:16:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oUAH6-00065r-Pe; Fri, 02 Sep 2022 11:16:12 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  2 Sep 2022 11:16:07 -0600
Message-Id: <20220902171609.23376-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 0/2] Couple more bug fixes from recent commits
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

We've managed to track down some hard to hit bugs that were introduced
in two relatively recent commits. The fixes are both one liners.

Thanks,

Logan

--

David Sloan (1):
  md/raid5: Remove unnecessary bio_put() in raid5_read_one_chunk()

Logan Gunthorpe (1):
  md: Remove extra mddev_get() in md_seq_start()

 drivers/md/md.c    | 1 -
 drivers/md/raid5.c | 1 -
 2 files changed, 2 deletions(-)


base-commit: 526bd69b9d330eed1db59b2cf6a7d18caf866847
--
2.30.2
