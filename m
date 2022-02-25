Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07E94C4453
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiBYMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiBYMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:09:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B971DAC4C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a8so10427783ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUl1546N+qp10i0i36y2HdxIb4kjY3BH0Sd5jvSSiAU=;
        b=MucVjFGN8de3cOtGGWnhedk7OK8fbB31NNq0sfKJeVCZQUWHxMRMmOaQUuIpATk0sk
         PC4npTbP6dNGxkWrkFDtAdwRoMBEswV9bqjmrYsFAkRv+hVHoEq4A2Y4qazi3EKm0/Z6
         huZI7yMyhnA6oSYPX1mKz3xdYYmHzSaPTZcQRqp9VqwHZGYMAn3V1g1WIRlkvzqDwDQq
         SfkNAJpLu9b6GIvxtbYp57uGNrnqOnNfNXA7u+XQc5msEPmMS37Xo/VSoO52jFmdSB1k
         s6oFijzltf5sIq9L0pkC9rTHWDeuaj90abO2v36PvGzPu/yvWp2hR5MZStJ4kRIpFual
         2MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUl1546N+qp10i0i36y2HdxIb4kjY3BH0Sd5jvSSiAU=;
        b=kOYa2QPcnT6RSy94oQ18l4XLrWQIGAMCmnPn7Cuu6JfhIaTwiEISrkq9wCthrqUooX
         8M19Hb+vx4Ug/maV2FMsanNgvYauB+8ISnv1BUYdDClJbVY16Rhh741J9TtQXPHO8vfU
         N9pA7PgXvt2X/+SiysTn0eersT7BqG5vzCbR8XYuayeT04q8KWIVBwLThnqv8l1E30g2
         g829D3RnEuRlVVKbcOmQ6NM3as7ww0FWik1c5sobKKcvdrPLpfFzySoEmbB75qulQo/K
         fG6FY39nuTCyAmNMBkGDIpJ26hgxtpRJJ0gM7bmbhzsAKDD9SvQbO6PNuwt0YONNz6oh
         AveA==
X-Gm-Message-State: AOAM530DMU85HjO5bktFv2H0HOEQQObqxommVGuRj5u7FMVjtoFiSzIc
        ewVLV1JxFofopxztNtAX/OI=
X-Google-Smtp-Source: ABdhPJyJbU8MHsMilG18YpmMzfWdqShMcVy1zGY1he58NIZlERXIdUuCtFnXcblC8jExfLpQrWsp1g==
X-Received: by 2002:a17:906:b252:b0:6ce:41e2:5bb7 with SMTP id ce18-20020a170906b25200b006ce41e25bb7mr5824649ejb.179.1645790943024;
        Fri, 25 Feb 2022 04:09:03 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8d.dynamic.kabel-deutschland.de. [95.90.187.141])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00410a2e7798dsm1229418edr.38.2022.02.25.04.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:09:02 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: remove unused function prototype
Date:   Fri, 25 Feb 2022 13:08:41 +0100
Message-Id: <20220225120843.10674-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225120843.10674-1-straube.linux@gmail.com>
References: <20220225120843.10674-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype rtl8188e_query_rx_phy_status() is not used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index 0be9896eaf0f..87dd4152082a 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -42,7 +42,6 @@ s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
 void rtl8188eu_free_recv_priv(struct adapter * padapter);
 void rtl8188eu_recv_hdl(struct adapter * padapter, struct recv_buf *precvbuf);
 void rtl8188eu_recv_tasklet(unsigned long priv);
-void rtl8188e_query_rx_phy_status(struct recv_frame *fr, struct phy_stat *phy);
 void rtl8188e_process_phy_info(struct adapter * padapter, void *prframe);
 void update_recvframe_phyinfo_88e(struct recv_frame *fra, struct phy_stat *phy);
 void update_recvframe_attrib_88e(struct recv_frame *fra, struct recv_stat *stat);
-- 
2.35.1

