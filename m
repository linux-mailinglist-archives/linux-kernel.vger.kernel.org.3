Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E05832B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiG0TDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiG0TCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:02:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB156265;
        Wed, 27 Jul 2022 11:19:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m7so13879101qkk.6;
        Wed, 27 Jul 2022 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/Gq00KE6z/WOdOuLSctfeQoLznSTYhNp0nMcDpDWKM=;
        b=a7ec0Df0WU4BEc4saTHyOMcGEysyY286feVLVf5B24fJZvP8xzpsHe+mGmneU3LSu5
         v9G3Twgw6iFdZ4HnV3LsK/QZshMgi+htdAkdwUXgWuDNdPLxhYrCuHMvR5kZFotMfmJT
         oRFT+6SEImtPYUjusbOtUu09v0n8xOFj8jYzZLcVotu+qUHOXQzvPa+zGsd5QXXZoMCu
         xCjkiwnSnOIzUHK6X3llezCA9XA6GR1p2PYrRBXsumVeV41EQhZk7V5rTfOrFSB96Q42
         nyTTV5DC8hgAU0Rr8DGYLKcTZWsHHHWJSbLP7E1a35NmsJJTW+R9mo0MJYOCXlPjchH0
         5i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/Gq00KE6z/WOdOuLSctfeQoLznSTYhNp0nMcDpDWKM=;
        b=kWtFxKhSIygKJXK1TG7qIYQ4eHbrJ87riJCoZOTxDT93tlTSRugvkTexHupZDOmylN
         FFAtq3jZH0WzHQHbRL6YP2GR0AylTx6FbF0tbXi1+lZxmNnM4Z/o+n0geeQXzux3+m1n
         hvTv4bz7xYEirFxyvXi/zDPx6jz5tevewECytMIvMwRJF5Xc1OEyPDzoX34yRvkTMxD6
         31k7jhxghk8GKmu8yU7FlHL7wG4W4BGUrkBkhg/HQaqFM5/Mf+RrtH+NHHyCrxkfxdSQ
         psolvDLXBD1DxKkHlQ/WGVChdiyrUrG4/nvEePUiYYCqwrUERcBo1YlIDzSOuESIOhAJ
         cIdg==
X-Gm-Message-State: AJIora8+1TDTzmQJrwIBzARsxNwtghEzSyUkBa0s1SlN5vnsGZUBHYZX
        +G1G54KyOoBlaXZhS4U8T/Q=
X-Google-Smtp-Source: AGRyM1tbhgMs3Q98l5Srs8NM1XqHrGMXA9rXr2Lf4Uv1t8WwwS/4p02rIeBaH07WYAyAb+ZQj0B8hA==
X-Received: by 2002:a05:620a:4306:b0:6a9:7122:edb2 with SMTP id u6-20020a05620a430600b006a97122edb2mr17710321qko.502.1658945968724;
        Wed, 27 Jul 2022 11:19:28 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id bk27-20020a05620a1a1b00b006af1f0af045sm13195972qkb.107.2022.07.27.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:19:28 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH 2/2] iio: Fix indentation for multiline conditional.
Date:   Wed, 27 Jul 2022 14:18:55 -0400
Message-Id: <20220727181855.589052-3-joetalbott@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727181855.589052-1-joetalbott@gmail.com>
References: <20220727181855.589052-1-joetalbott@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl make indentation match previous
conditional.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 47a6e97f8e48..228598b82a2f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -843,8 +843,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	 * to verify.
 	 */
 	if (remove_buffer && !insert_buffer &&
-		list_is_singular(&iio_dev_opaque->buffer_list))
-			return 0;
+	    list_is_singular(&iio_dev_opaque->buffer_list))
+		return 0;
 
 	modes = indio_dev->modes;
 
-- 
2.36.1

