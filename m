Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F2C48BD33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348608AbiALC12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348579AbiALC1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:27:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC7EC06173F;
        Tue, 11 Jan 2022 18:27:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a18so3926598edj.7;
        Tue, 11 Jan 2022 18:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PlEFAgayS9wvBGnQ35xlD13lbXEhQawx9H/2jDhZVwA=;
        b=F0Idtq4w4h43y6NnTkDYnTEIMGQHuSUhcX3rwRiRz9x7nmBJdDvz5GnCF/nsLlxQrz
         6aYk7Fsm+q4lqOEVcmlhqW8z6k+ouMmj1qM8y0D4WMO25tGOzHBOl5+ZwgKhvc1nuuLG
         efML83vyRad8peiDHiAKR/vkYEqF7DfrI3LHAmeq6HQZWlTZBCnrkbFUo5r8cWDdKJn+
         dFJMTUkggngKSzlmCCr9mol7pJPgLr2oeLIJ6yFmC0Q1LRry5FP6kEIRMm6NmePgRqth
         yE8nqAo9EWGI05dVWSpT38aEOT9OF1JTwsEEeeZaI6EH7jXZLTkay/hf+dl1RvweyOTf
         DNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PlEFAgayS9wvBGnQ35xlD13lbXEhQawx9H/2jDhZVwA=;
        b=AgiRHy+jVEW6vp6AvoQBKWO7E77Wcu2kqUJm60Nd8UVhNOOUmYvqZD7vhq/H//BMrW
         FJub0m/UOvzmS4y46KWe6Dmq7eejj5q4eRKLoiS1Pb/JW4F1vSImYWaRArWS+Ypka/PW
         InmFW89GnRNI7GrtPjpAHCvKDmDtndlCfE9tQiJEiYlvO3/S4Q+f23Xc/UF7SwAGbpnM
         51vIwe8MI9RWW1/HiT8QhD3O1D99lUjvOdDpMQsYS5JKq9OAlg1BlJpTfxz/+tltp5kz
         U2Y4cPeJZT+fnGKCqcZ7/N1+PJAWgDdnRrID1oEr10mS2cBvnghSQz9VYVSLLEN2u1U0
         Y9Sw==
X-Gm-Message-State: AOAM531/UcCE8wGM6xvlxk/IbPuxcC3a/VOVSMB7NXe2K9zZUmiEZD0h
        MrQDScsYWc1CqJm4cpHHXqc=
X-Google-Smtp-Source: ABdhPJzTiHwbHLI71BjtGxzLm805TbVAX7FBwbUpBy5XGiKkY749qvqTq2C7hLMdYFfc2YtkBI3ghg==
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr7165583edt.180.1641954442963;
        Tue, 11 Jan 2022 18:27:22 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ky10sm4041772ejc.151.2022.01.11.18.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:27:22 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
Date:   Wed, 12 Jan 2022 02:27:06 +0000
Message-Id: <20220112022713.25962-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112022713.25962-1-christianshewitt@gmail.com>
References: <20220112022713.25962-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board bindings for the Amediatech X96-AIR STB which ships with
model variants distiguished by Ethernet configuration: models using
an external Gigabit PHY have a -gbit suffix, while models using an
internal 10/100 PHY have no suffix.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 31df120d73b0..b5b995941d3b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -170,6 +170,8 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
+              - amediatech,x96-air
+              - amediatech,x96-air-gbit
               - bananapi,bpi-m5
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
-- 
2.17.1

