Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72E74683F5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbhLDKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbhLDKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:19:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CAC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:16:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so21718196edd.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dN/oUTilGDj3oSXc/q4PkakZnOiuYdXeFtx+QhztwZA=;
        b=QZkgxOOa/GICNARrrQMFysa/639SFGfT5VLuY3Sr7X59mjlh7Zw79O+BHJAlPn73R0
         bT9wfgAYoCw+sqnqY+aZQTLXNbJwumTP9utTA0Az6kKhvEcWWLXcTFHtNxkmK7lgw9sN
         FXSVGX+DFAbS2ATE09pjoyTFuabtpkgNDclcqdDzWaKOkBvPKTUqNpXLtFOzXNRIJl3b
         r4jQNjjyMBIg5XrpE9+SwqQa06x2JcHURzndIvKT5cn43zWk/9mJT7QmOUvgSTVUovan
         mQ/9vx0NxzSTGUkR5xHNH/q0Tdk9Nmb0spYfustwtfTDRsPnyuRWvUL5dHEFtxvSZ7QL
         M0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dN/oUTilGDj3oSXc/q4PkakZnOiuYdXeFtx+QhztwZA=;
        b=Q+0E3Ufi5JXzDT0QQCeWO34q0/LjSXAZsMzU+JfnJ6lhSPexVxP1xoP5mePOwO0sKC
         8aJgRLGt4GOqexwoOyP2mij2viYQmQ/E2fGWV1ICeBT7vF2+YaMd6wnqd7hFxuNx68FL
         kN16ECf1QREMV8YILjQFJ11IuhbX9rE6qGUJGiqz68USTCEHsF4cdfO4pMNQR2iD+b/O
         kYlGXa8p69XBB4hqIpuGOaE53B+vk/ga7o1mI6C+9gu3Fj+0No5ViCD7PTLhBKyaCl2G
         xaKQR+FYtX4q3bONNMnAbkmzv8pOzpscRBZdQEoH0XwbsOjlhM22PcfWCqQ+IKGMpB1B
         7Igg==
X-Gm-Message-State: AOAM533qQYEQnKy06mB8jqVh5V9BekX9KNpf4zXjv+q8y5kqU0v+L7sw
        tAyir0M+ToAC7ig3G1WcVS0=
X-Google-Smtp-Source: ABdhPJwVLDiOANQkH4Ll5oiEzFwfCG34wXuP1nXwD1GDPPlHp5IGj+n4Tq50NJRFRjph8q1z78iINQ==
X-Received: by 2002:a17:906:d550:: with SMTP id cr16mr30655646ejc.544.1638612967289;
        Sat, 04 Dec 2021 02:16:07 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id d18sm3534450edj.23.2021.12.04.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:16:06 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: remove unused variable byMaxChannel
Date:   Sat,  4 Dec 2021 11:15:28 +0100
Message-Id: <20211204101531.3924430-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but not used variable byMaxChannel.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/vt6655/device.h      | 1 -
 drivers/staging/vt6655/device_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 245f992e5a23..bf2698056c55 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -201,7 +201,6 @@ struct vnt_private {
 	unsigned char byTopCCKBasicRate;
 
 	unsigned char byMinChannel;
-	unsigned char byMaxChannel;
 
 	unsigned char preamble_type;
 	unsigned char byShortPreamble;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 37a82550ca82..cf8d9a05734d 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -229,7 +229,6 @@ static void device_init_registers(struct vnt_private *priv)
 
 	/* Get Channel range */
 	priv->byMinChannel = 1;
-	priv->byMaxChannel = CB_MAX_CHANNEL;
 
 	/* Get Antena */
 	byValue = SROMbyReadEmbedded(priv->port_offset, EEP_OFS_ANTENNA);
-- 
2.25.1

