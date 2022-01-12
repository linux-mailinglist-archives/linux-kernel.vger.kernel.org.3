Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5A48BD40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348734AbiALC1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348708AbiALC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:27:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B9C061763;
        Tue, 11 Jan 2022 18:27:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m4so3852672edb.10;
        Tue, 11 Jan 2022 18:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lwtwmf96/gMAlqBztuZshLJxZNPu7f/tp/LMHnINIs8=;
        b=b6KUy9WWAbDnyR9E/4suA0mWm75LgVPGhTPMj6f/wEsE4Ly9TnvhiOA5at1u+TM5aZ
         GEIu8XcMhyR2bX/9eGcN9OAC/9HKtvh4CSAkVqaTDCUm6s/uQYAhL/VjOgQ+5cuNxeQ2
         rzbAx+lEik+Fg1kD0cIZqDsfe9knuqTX6WxM/3vi7ciAb5fPZEJuR7ge411o09/Bt+/9
         ATjHjwd+tLLa5QZJ8UkLVAVMiWLM4M6ju8m7VNKQsNozBVoGk4A8o2gby8i+znpKMx2A
         r6HTe3RWkaCxDTOIlwI0Vt4hB/ffkdYL7+Uq9isWn3suIjx0OOd7WY/D6YMEx3Dgb41Q
         Hdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lwtwmf96/gMAlqBztuZshLJxZNPu7f/tp/LMHnINIs8=;
        b=wiY3rJN6PvpuZPI5PAYYFKYYeWDDU8SKJ2/y3rNln3XJp0GL420y5AXQHByrOXEHam
         bBV+5rcrX0Kir/Z/WuGecB+jLEa/IV409l6jGcpU/tqUZwrmG2kKIWZhVPd4pcXrJmIP
         8Fi99QNnzNHO+XrCJ36/fCsZXeH+BH0q5/M6w0sHUZDmwj7JRRiS6+90Ih5BLP0yE9QO
         624YO2MsU5K0vDOlkz3Wi8nCU3ceA5fRtBfwjmykKr1mB1W6Vg1z4dm0S5G+1ZErdNyJ
         J2uSu4nnR+mZuWXTm1bKF+7UzTPFFaA1EChrvcq70NPWIWcS1+RfPcyRLFG7NuhaYCnq
         celg==
X-Gm-Message-State: AOAM532K9aaqjV+ID5utXf3nabudfirBGwWouF6kO/i/XJ24YYtPUz2B
        uf7FzlYd5/dQKMedx0Um9c4=
X-Google-Smtp-Source: ABdhPJyiV1tkqBjNFkt+xyLax4kDjHBpIVMJbLQUyWPB3EuYuimo8MrTjOdV6Q3l03T5D5nwzgOEGw==
X-Received: by 2002:a05:6402:291f:: with SMTP id ee31mr7176827edb.194.1641954456664;
        Tue, 11 Jan 2022 18:27:36 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ky10sm4041772ejc.151.2022.01.11.18.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:27:36 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3 8/9] dt-bindings: arm: amlogic: add H96-Max bindings
Date:   Wed, 12 Jan 2022 02:27:12 +0000
Message-Id: <20220112022713.25962-9-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112022713.25962-1-christianshewitt@gmail.com>
References: <20220112022713.25962-1-christianshewitt@gmail.com>
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

