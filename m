Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0A47CF60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhLVJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLVJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:36:32 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835C3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:36:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b22so1874072pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sgwNBG2Cny1fVZO0hlT3ohe+sFdmqVc2UDvfjIkF6eM=;
        b=Gtw64aYKGZsQ+dMlQmcTSBpB89iTplIsqutgq9KDlrnM+hli46Z2Ro7tachGGxM7w4
         oUHUisn4R+tgsDxHmxWzg/LEExczh+vNBt6gBCVzH9qgcomJ4JklY7E38fQ+HmXH9HHc
         eg2Uwx83TBMqxyE0lJyNBg71kv7DbhicLgTHhAmTtGgukQa6l5rvw0p/aS98bodqL36y
         T3DVarvdhCMZjo+ddhF8fX7JF++uK//sTAFFRAMbLqv627qG2eQiwOzNM5TZeFFE+ITH
         MWRmvG4cCUo+5gxWrK3LbO7iNauV6aqEwHEn832cG6ta7EdEYLBuG1LmqJ4qRwlqTIqV
         iAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sgwNBG2Cny1fVZO0hlT3ohe+sFdmqVc2UDvfjIkF6eM=;
        b=xetR+L9Q+FbyJO/wm1wYXeAqJs1IgNwjhKuwNU+NyxEKkb5nT8UzvdqEarQuZYKuqX
         76hNCWAMLdRZyWrAzMDPiA+8o86JsxO5JoYT01fssUH5iSSCV/hiYg7iDDivaCDWke6x
         7u8EY10OAS8yhvRCSgvb03fWTSfrWsO6XlaUhXRN8t1jjlXSGMI5jSFA6CSbAAL9Cs9o
         ew0PdRJO6UGn4dLqh1eqhupnn8uiVv8WqYUYU7AsOUQkq9dXTG/5ovAt6ldF/nwhv4FC
         i4FiLGIwni8vPMavecHYRhmFTs40ZWHmntwRcsRiVEiEJxOwosW0r9RgpYfqja5zVjVk
         qTkg==
X-Gm-Message-State: AOAM533FUKIev79GZNNk14HXSNa5HDmGUQq3pRTAje6kEXb4p+DK+6bL
        EGuff1Hch/7X7mtXO68OSu8Dpm7Lzr9tRg==
X-Google-Smtp-Source: ABdhPJyERfHYaADMDkqmMfs0w+6zK8q5UnftfZAI+ylhVVB8Anx7cAHpS4amJepVdBH9A76ZpOYUQQ==
X-Received: by 2002:aa7:8e52:0:b0:4a1:5820:d9cc with SMTP id d18-20020aa78e52000000b004a15820d9ccmr2060919pfr.49.1640165792078;
        Wed, 22 Dec 2021 01:36:32 -0800 (PST)
Received: from localhost.localdomain (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id s207sm1616088pgs.74.2021.12.22.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:36:31 -0800 (PST)
Date:   Wed, 22 Dec 2021 22:36:26 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        paulo.miguel.almeida.rodenas@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: add comment to rx_lock mutex definition
Message-ID: <20211222093626.GA13332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reports: CHECK: struct mutex definition without comment.
Fix this by documenting what rx_mutex struct is used for in pi433 driver.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 29bd37669059..aa0ecb3788c6 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -92,6 +92,7 @@ struct pi433_device {
 	u32			rx_bytes_to_drop;
 	u32			rx_bytes_dropped;
 	unsigned int		rx_position;
+	/* rx read and config operations can only be served one at the time */
 	struct mutex		rx_lock;
 	wait_queue_head_t	rx_wait_queue;
 
-- 
2.25.4

