Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FA4834EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiACQk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiACQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF169C061784;
        Mon,  3 Jan 2022 08:40:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u25so16718479edf.1;
        Mon, 03 Jan 2022 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lwtwmf96/gMAlqBztuZshLJxZNPu7f/tp/LMHnINIs8=;
        b=XbtcbTk+0d63MTgRvVyftAW36gvzcgjXx8885TYnDKLlok8FoWRzRMEOthwRgZJYP3
         qtiBdxbGzc/VAS54GMCABUfv4mkgK83VOnA/pO3tJb4C6Zb3prz66UYrihUA0m5RwiHO
         azfnxhZSu0ozVmrn6WKl/RIehFJof/xk7M1KR9j/JZYOUiljpjcKSf2qE9VIv8S24Z6c
         gY9RNVWOofahQ+UcQbI1jkZ/VxIK0mEBgPzgHKH6ExVft4d5EYrSVgTNYqddJM3K1J/i
         G+haxZ/N7Y9TDhiRLkFNbNEh22wxLDG6toEz58XPh2C6SgRDTQgNr9TKIv7OaNSehwV8
         7/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lwtwmf96/gMAlqBztuZshLJxZNPu7f/tp/LMHnINIs8=;
        b=igvJvPBChjueM9PogRXavaaJABznYYAqdRgULtG3pxj09Se6O5Icj3x20Js1p5kWc6
         ilaFv4nTcMStD4+jrVMJQQXC4CTO38Zxzu+UIwBLaGwxWCW2gnioFuYRzyzjo5CodYz2
         7Bkzgu9lYZrgEsqWLo2BVY868VLTQSQnIqvT343UKnQkirWv1TA9ZwBg6T1cleFz0H2k
         ERjHlW1UwEsAGluVeyRbf6Y2pH2ybFpJPsnqOAjLWdsSHqfk/6V+Ez8gAP4ozmXDsKIQ
         WgJVW7II5vNeqTN654TuhNtlXw/8PPrJQG7C+ZPu2JLpgbyYvg7ll2+B1AK2lzkjD5zN
         CRvQ==
X-Gm-Message-State: AOAM532GwVfSqoNegvElsKuTYM3intFDhLkRdtaR+wr+M16qqpLrs+sd
        ZtWIaZrGnTFNf4SgSOQTbQoSHDnjL40BcK2G
X-Google-Smtp-Source: ABdhPJzb/Uq+kRSb6JYITiI0nFa6uoJLnm2TtaLrnM2Z1tMdcL8KyLIwHS4BmP5sx3vWQBAZ1c1lTw==
X-Received: by 2002:aa7:d5c5:: with SMTP id d5mr45597097eds.251.1641228018404;
        Mon, 03 Jan 2022 08:40:18 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 8/9] dt-bindings: arm: amlogic: add H96-Max bindings
Date:   Mon,  3 Jan 2022 16:39:55 +0000
Message-Id: <20220103163956.6581-9-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board binding for the Haochuangyi H96-Max STB device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 2027ce81a834..a073a959232c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -177,6 +177,7 @@ properties:
               - cyx,a95xf3-air-gbit
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
+              - haochuangyi,h96-max
               - khadas,vim3l
               - seirobotics,sei610
           - const: amlogic,sm1
-- 
2.17.1

