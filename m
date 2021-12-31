Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EAB4822CA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbhLaIW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 03:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLaIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:22:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401FC061574;
        Fri, 31 Dec 2021 00:22:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l5so72021139edj.13;
        Fri, 31 Dec 2021 00:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyG7F3GdrDJKWY8eEfULl873wU4wHKuuioOu/o/7Pyg=;
        b=mkKbfvzLgF55wWXJhcr7pCG7rLOzH2Ecm/DXt5W74TZW/RswduqkpsR3ATTHTxvp6d
         MgmDfmvajrZFVFHq2FOVIPQxBo2+IiuMtU3c3HiePBHdLiAeBJoz/xT4roLKuS/O1Jqe
         03wxPpT7vwcTN3D8p4jk/AcOnxxtTTjWVO8hyiEgmJ6EpxKZqqh7SIAB/t4CIVmzL+Ts
         ogVPN0atspGBJLSn9cXADgGdFtlX3dg2j13r3VUvy9uj5WGKZ8KPQlS0Ga5SKJzYP8jA
         fUkmxCdSCQXV5yi7Ixv684P0NUVhEYxGcjhzrNem89/VRm4bVY05D1TqeDOkfZ1mfd/Q
         IHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyG7F3GdrDJKWY8eEfULl873wU4wHKuuioOu/o/7Pyg=;
        b=3e5IfvgNAcO/DkfUK9P8YUoYSFnYqv+BXDO4SYN4RM83+7LuG0U7pMs7LaSOgpagtV
         9NPDHIbwzfG8gNUvUZ29GrkS5F/yBB/EY/EQYrGwQPU/q1Db/PV769CxfojxjCFKARdK
         P21PUjIeluPOPS7sSAnqiGmyUdr3atAW5qbQtiodTmqnE+9+Mehr6Q/vLcHcvjTfbyUl
         JcC4F0+NeyNhQLkwQO91g2oBQjMLS24OxAhCIsN58hp+PQ9HlmiRJRSRoH1lcVBM/G6E
         hFezmoRcpsMUrZIwdZN3/rh1XHROF/W5k7qoZtJoS3B3uKmaKfP16r3TxEClnupZmj4/
         tjnw==
X-Gm-Message-State: AOAM530wDw5iAtJT2FkcqyiRYMoC4R9InJLsXwn5nI9PmJy/qGhoTh68
        vqO723ImSTLinTonyOLDVZ0=
X-Google-Smtp-Source: ABdhPJw2lufwRqvKLSx+NUsyU75lGaMKIC8BYqcKl+pAqk33YZzW8DjErdh+TResgty5tz98g9iukg==
X-Received: by 2002:a17:907:3ea2:: with SMTP id hs34mr70106ejc.403.1640938976213;
        Fri, 31 Dec 2021 00:22:56 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 26sm8225400ejk.138.2021.12.31.00.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 00:22:55 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, yifeng.zhao@rock-chips.com
Cc:     robh+dt@kernel.org, vkoul@kernel.org, kishon@ti.com,
        p.zabel@pengutronix.de, michael.riesch@wolfvision.net,
        kever.yang@rock-chips.com, cl@rock-chips.com, wulf@rock-chips.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7] dt-bindings: soc: grf: add naneng combo phy register compatible
Date:   Fri, 31 Dec 2021 09:22:49 +0100
Message-Id: <20211231082249.5075-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211230084815.28110-2-yifeng.zhao@rock-chips.com>
References: <20211230084815.28110-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Naneng combo phy register compatible.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index b2ba7bed8..5079e9d24 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,8 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
-- 
2.20.1

