Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08C0462C95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhK3GJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhK3GI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:08:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E80C06174A;
        Mon, 29 Nov 2021 22:05:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l25so81793939eda.11;
        Mon, 29 Nov 2021 22:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhTDv3wvRjYkhYbESwOqZReRkMnLEhVyw3DHRR6Xuck=;
        b=KpbqwAn5Z0lawhOucXoKDZ/XCtv/rYicMvFaUJ2fXEXzwg0PfiBgJ0hLbVqZwFVbBI
         nAh7bOkSmpmNWo/L9f8RSYGHQV5aDEdhEcPBB43718yJM7wqsO0b2Ln2ec7fhgt0Zg8X
         nWD4oOCZFbPnL8+fl5zdVrzChUY4vpUVC/vqB88NLQwwKJgkZSmYPoBnIU1fsoPYLEjv
         MVPoX9ygkne013satmqo6CUSQx0yCm5N2hsFojQVszkKE3Sl7etixS8JW3BIIxuLfPnM
         FB7p8tyQRBjECA+eKs2a6MtmHTQd3A1fT3WqyvbqyZ4Icw4MIFZLjj8A+jp1LuWnM8KF
         tUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhTDv3wvRjYkhYbESwOqZReRkMnLEhVyw3DHRR6Xuck=;
        b=i4Cr38Js9495q/sRqn9IgM8NWcmJLmb2hQfNsKSwBsj0EXgUm3ZiJd37zWIL/XwwcE
         992Gi1HXklItn2r4hT1F4vudG3krflZ0G3gMbjNIgRmzpSHE0/H4RssAzX2lr4DyHKAs
         p5gmgqnnEeF5obw38/EU+82EASff8AxXCrW0oCnWyDtkanYyg7yTwJGI6cPilFrBPSzH
         8vynlZyRQsI62GSveTjqj7ZTQ21jzm7kYxVStSqs9u4VwN1Ja3SIFRby0lT9t6wnGPsk
         CcxdIW3OFNKx/8OR5fwzv9fpKUFDVskgVNnDTj6sUi8M2UqAkNzYdSwA8vvAfZHu9+/u
         3bgA==
X-Gm-Message-State: AOAM531N+UEc/zm+De3s9Kmjd+K0xj9Wgv5BMVps6DkyTXlSFdpi4Cbl
        XOheejbldSOEtQvf8JEEtDQ=
X-Google-Smtp-Source: ABdhPJxOrRZu4k6fgFsml/oxxHiCjdC3djHe9nVzQD7uvyQTXlZw45wlEA/8GwV5iUYnF2yQXsKxIg==
X-Received: by 2002:a17:906:3408:: with SMTP id c8mr65133295ejb.41.1638252338107;
        Mon, 29 Nov 2021 22:05:38 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:37 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 5/9] dt-bindings: arm: amlogic: add A95XF3-AIR bindings
Date:   Tue, 30 Nov 2021 06:05:19 +0000
Message-Id: <20211130060523.19161-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board bindings for the CYX A95XF3-AIR set-top box which ships
with model variants distiguished by Ethernet configuration: models
using internal 10/100 PHY have a -100 suffix, while models using
external Gigabit PHY have a -1000 suffix.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index e9ab0ffe8be7..1dc793eb35f4 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -173,6 +173,8 @@ properties:
               - amediatech,x96-air-100
               - amediatech,x96-air-1000
               - bananapi,bpi-m5
+              - cyx,a95xf3-air-100
+              - cyx,a95xf3-air-1000
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - khadas,vim3l
-- 
2.17.1

