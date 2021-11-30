Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D188D462C92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhK3GJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhK3GIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:08:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DBC061574;
        Mon, 29 Nov 2021 22:05:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so82085622edu.4;
        Mon, 29 Nov 2021 22:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SaBbQQ+iVbFLZv+bV3xyo+jBT6xEtsPziI/bR6Dx7EU=;
        b=LdMmUWzQUwpgiYB3Jsqofrz70Mg2+hjUZwX1PkeP+snslr299u4zFJKsCmwy3BlKPH
         XmOFMDr13mdTffrafupY7dFnZ9xzBNoj1q1mBcQ6lgkbfN0uyMbIn4x6iWtDAss7p/JE
         283xiEB+XC7v/rYMC7TdnQH83Zv/G7lg69Oa8b2SsajOMqfvRgFktQA5ZbZ6DtT8Yks9
         kD8LX9GAVIEDAJKN/R/Qwtn8H5Ysr+fnVICL4hP/Lf0uodPggoPfUn6yxSAHYY+CQuOc
         SMriiQmZ2txIKEyHpLHvjrX3kKzuPo1ybDkX6mSOaQIXpBs4C2qvoyy4oG4oDA0tIZ5U
         +mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SaBbQQ+iVbFLZv+bV3xyo+jBT6xEtsPziI/bR6Dx7EU=;
        b=im84tBVYvqQfVc6CxeEMfF0Wr69oKxBHtLz0eCzfK5yxMwlQQC53RjNz1nHWCuMkVz
         AXlF4BsNyQ8PWKE+SipCWCmhNg9LEmdV+a3ExGpXoPg9nOnj0NIs2h6XY9HuuLScbqyY
         jHNPVDd6kSKhsPZWGgVR2U0a5mKI09eRgHsoCtVKRF20rSfrikSujGYWxNgioVx+sSOl
         Lwoqa4ftZlx/BBERVX6eQfQI1vt+smqEbi4Nn/iU+9CvnIqxKIuUtxtQnpyfK3Qj01sI
         8FjDcPpa/bq7LaD6+qgsVQinUs7IOv4TKr9zAs4Dgyv4dnNsJpVfl5d4gVjgR+oaRR2w
         KoxA==
X-Gm-Message-State: AOAM5335uP5tOC0xcrU/jDRab65KVucuWAxxTqdRQUrfiRnZw4EXfGy9
        dRbFX/bQiVW/s8KSvcjE2x9SMK9bryt0Y1Zj
X-Google-Smtp-Source: ABdhPJxxj43H0vVQPhE//sppbw84qhdveSuHVVjiq63kNbh0ybqpHotcemBsLl8Fv+rp5NpQwqL64A==
X-Received: by 2002:aa7:c04a:: with SMTP id k10mr79507513edo.308.1638252331653;
        Mon, 29 Nov 2021 22:05:31 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:31 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
Date:   Tue, 30 Nov 2021 06:05:16 +0000
Message-Id: <20211130060523.19161-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board bindings for the Amediatech X96-AIR STB which ships with
model variants distiguished by Ethernet configuration: models using
internal 10/100 PHY have a -100 suffix, while models using external
Gigabit PHY have a -1000 suffix.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 36081734f720..e9ab0ffe8be7 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -170,6 +170,8 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
+              - amediatech,x96-air-100
+              - amediatech,x96-air-1000
               - bananapi,bpi-m5
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
-- 
2.17.1

