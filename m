Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7754647641E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhLOVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLOVC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:02:59 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD98FC061574;
        Wed, 15 Dec 2021 13:02:59 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j17so23279713qtx.2;
        Wed, 15 Dec 2021 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDf8L1xIrFciKx4PVgYUU1gFjdk1Lld2RBueXaQLg24=;
        b=hlHDC1W1PZGMkes3FOWjFsTerhBsRWGAMo82E/tZA8QxUEY/oxGrMeq92vwH2MzORG
         9IjPH7v6txbgQZXLB6nnWw2QiVJROEP0o3po6q213oYMZo7/33ptQ1jpQ2dHrmzKUcD0
         6NyIH4iE1IDVYSZxC8SBoCE4UUV928G5o3zLwDbYv/fBL5RdjlWlHMSt8yBHFUUca/AJ
         frNKexNrjxd80RqceR4MTmaOW6neT7YT/bxkdRi1AHWXgSfVc3M3mNDOfETpI1nRylrq
         pivxliDDXXfE3NOLTVHu5h2ciz2pi9VCYpSQyRt0RXNh+UAo0zoFrZ7ez8cQ/u0tioPG
         YgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QDf8L1xIrFciKx4PVgYUU1gFjdk1Lld2RBueXaQLg24=;
        b=z6u3JmY1UhgdOBUa0ON59G37wanPhWxN4DA1pN2TXXOWxGQ8pYW/ptjUDYn3Bt3gyA
         KVwwNwUz5w+AdlcnHF76YP3Fq7siELzeZDEX/uKrZKrjOF8tzbN3wdFHGgBlF4oCamvQ
         25b6e02zCM/sWvfibBsKl7EsymmnB7qxYM0z2qUpm62ogUxhV41cIuHMNOD9MltNzm7d
         8dX2f0VdHKYDD3tM3CmSPSTOFsUZf6EsuTkHEwvAaHjmmXdvT+XOTtSS790nGS189naG
         sU1XMVdQF1epapzK7FxNPR0BAxuej/c59KrCDJq0pllCUwAmwv9jgGH9BzO+yHVmJ7OC
         v4RA==
X-Gm-Message-State: AOAM531Sy5BDrN6itSWfZOZlNhbLs1nZ5kTf1omhc2BgUPtbrH8WmIOb
        9q4TgXJU1hBHYdKasU+3FTZenZhuz/AIiw==
X-Google-Smtp-Source: ABdhPJxNYLQhbWh35a7CkPw2Na7K1M2NsaZIjwG3yQXzNQsAU5+ZkhqlljxeFjs5C0WH7q1XUh0ZQQ==
X-Received: by 2002:a05:622a:1389:: with SMTP id o9mr14135725qtk.109.1639602178832;
        Wed, 15 Dec 2021 13:02:58 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:02:58 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
Date:   Wed, 15 Dec 2021 16:02:45 -0500
Message-Id: <20211215210252.120923-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation for the rk3568-usb2phy-grf node, which is separate
from the usb2phy node on this chip.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index dfebf425ca49..b2ba7bed89b2 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.25.1

