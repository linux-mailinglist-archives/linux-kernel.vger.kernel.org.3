Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59473462C98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhK3GJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbhK3GJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:09:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89EC061758;
        Mon, 29 Nov 2021 22:05:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so81995563eda.12;
        Mon, 29 Nov 2021 22:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mSfwdTuowBoVvuvpRcPGqlDXwM2nxJRRXCyIh9InCYY=;
        b=AwRntRmqbHGcyAGSEwqYxzYsQkgRGQ4aCUr3PAhSxnxArRGceB8+aa2dJDN4FqS8BH
         MxR7Nyip14QhNvQRz78w2RD9BZEtkGPENYll6q9/TSJuDonHZ5reNn0V2SlGwM2W8qZJ
         oIVephMDsxdh+8u7PCG06YDxCZZlSYnnETcK5OsuVdLjB50HFkhw4YkcQPkTZoZdmI9R
         zAZAllYUystEU2gHLxqaDOxpoght1XYSjR6Yqiwl9II7BOdQRHQToLDs7MyH89cQ9zCq
         Ou3Oeztnlx4dHMqQg0OQwDYlZ8p71A1/6o70+TRW6ImeKS3CygZuWAOhV8RS5RNqAVc+
         ABdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mSfwdTuowBoVvuvpRcPGqlDXwM2nxJRRXCyIh9InCYY=;
        b=HtNUNlDKoGFo0xTHmB4KxRKJJmhlQbS7yPGW2qP1VjOyI9+EflWbRvQ1bJ0/AUAsPg
         XcgXtCyuzoIYukuid5GSFQzyz1zwgkmEHMlDlChkhLwThvyBuZaSJ6Zftje+I/tWGrY5
         Ifr8W9OZNmWXO2zf5eGFrjRZIddZghA9TFr0V0gWiNikcsChI2OSeNnRwy2vHcssKesK
         5jkjxuOe6BCNgtKzPQBhoZ1FURDw4184xwV/bTYapS+CWnP9zJE7jvnrD4kQi3NTtRrj
         FTos2vz34VPhYda1lNNq/ya7GaKTPrugzB5p9p+mwmRefXXhGVyCKVg0zklt51iVdzCi
         4fQA==
X-Gm-Message-State: AOAM533ATPvPhOlj9TcEmCyprvl0q7kSVhBZJSCVGR7iJMRikrVGvKl6
        9LMmTHTlL6s+LTMb7UOCDJs=
X-Google-Smtp-Source: ABdhPJya5IYgjH/dB/ngpX/Q8OqWzRA0PfqqnZW3uKZVnfaIikNkbhxKkxoDZ/X1QyHMEN3iF3QtLw==
X-Received: by 2002:a17:906:2f09:: with SMTP id v9mr66363303eji.163.1638252344669;
        Mon, 29 Nov 2021 22:05:44 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:44 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 8/9] dt-bindings: arm: amlogic: add H96-Max bindings
Date:   Tue, 30 Nov 2021 06:05:22 +0000
Message-Id: <20211130060523.19161-9-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board binding for the Haochuangyi H96-Max STB device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 1dc793eb35f4..1e792feecc69 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -177,6 +177,7 @@ properties:
               - cyx,a95xf3-air-1000
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
+              - haochuangyi,h96-max
               - khadas,vim3l
               - seirobotics,sei610
           - const: amlogic,sm1
-- 
2.17.1

