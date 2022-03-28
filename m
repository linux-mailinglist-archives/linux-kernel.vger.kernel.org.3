Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F184EA10C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiC1UCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbiC1UBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639003AA61;
        Mon, 28 Mar 2022 13:00:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 806C31F4385C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497601;
        bh=+jEmz225xAmiHcP4mdC1OAJ4YlOO5CterzYv8eeAA5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyMq7dIKVPjnU9VEcGNat7wGGQwWR70hwnpinaQEVDKQ7OchlkgRT/CGTxaCw4T22
         cgBTQ0KZNS+Xni2qoiQV9aVafUgx/tPn9sM/X955kAokyAbl9NAYYq5GkBDWhSvm3p
         Efl+35d4w2rypramDPJlxs4fdmFqNRDCqEBsX5siFN7p210uMleMBw6swP46jS5qRw
         YSLqKmS4JtkWf5/9HVQfU3/16TUFgY9sevpMuZVBexeUva7PcARnb3RXzBo7kJs1CB
         GfO66jRmf3HnW1Fna7VnUxlUvFcBNMprMrbspBWJ3Q5q87wOsNnkF+3huQcKwFc00f
         TNCAilpx27h2g==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/24] media: v4l2-mem2mem: Fix typo in trace message
Date:   Mon, 28 Mar 2022 15:59:21 -0400
Message-Id: <20220328195936.82552-10-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On -> One

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 675e22895ebe..53c2332d5cbd 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -316,7 +316,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 	}
 
 	if (m2m_ctx->job_flags & TRANS_QUEUED) {
-		dprintk("On job queue already\n");
+		dprintk("One job queue already\n");
 		goto job_unlock;
 	}
 
-- 
2.34.1

