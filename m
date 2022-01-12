Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4627448BD39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbiALC1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348569AbiALC1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:27:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A8C061748;
        Tue, 11 Jan 2022 18:27:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u25so4027976edf.1;
        Tue, 11 Jan 2022 18:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TdcRcebw4SvOthXu2rFCYk88sYFR3tnI4UNhHT/FyYo=;
        b=SlIlVzuYDKFVsnBzR+BtVz21bXoXn33JJFVd46+S5Cem2t7Zw7+Esg2e60lLF87V4o
         7G8XXMVqJmhmCWZ6rA9Lc9gu7TdeYuNprtFTLCL+rYmhPkKxZDYPW7AFktYFAC5tzAi2
         8GE0YzgQ6k5pO7MxeV9qQzckyFuZQ3g9f5PA1UcWHG0SxJqO8HXJrKbHh8D90AMC2PBF
         GGZgI0r6/8u2jknBi0/2okvLygcOzQgdBDuu6/auy/oViGtF+sTVHf/lJKQGB0/1fjnn
         3G3jQr8hlpj4QZBfAf2YtxnVm3+DMQa4/aXAWtvGZDrAGilYkxmFtvL9PxralCvjl9P4
         tHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TdcRcebw4SvOthXu2rFCYk88sYFR3tnI4UNhHT/FyYo=;
        b=XghlAa2b0R4jVCvNfs5uKF8F7TzrHmqKqpBH6eq9KxsmHXvs4qMG2v9RFPuhqdYx5C
         Ii+JW2XIdwL2mU+5cGBRrRjYU+PbUmK7ixE78WCSpp7ofeqjDk/pNSqPb8A9ZuhAgpi2
         Vg+7wTBub/Oza8wQl0D2upMvnHw6F0h7NlrksHWRqM/quZHnD2WnrO2CcCItxfRVvX+7
         R4fWciNCXvq3d7XODUr7L6FFU4fLljH74r+523t7fOb6Du22uVLE2L2Ayidj1FsdnCoK
         zpX442NxfcqkGta7IpfaelhVv8uxO80ERV5I3wu5xYoEzicl7hQ254EAgZFsQUf0POX8
         u0ow==
X-Gm-Message-State: AOAM532xNWvJqvDtpKgGxw/ZSXEDQ7SSy27UXUtc+thZYnz1zcHLx1+h
        PmwopttLTczu9fEd2F2dAR8=
X-Google-Smtp-Source: ABdhPJwHd2wCly/wHSIXwpSJqlTKVldumK4kGG3oxJA3rDOrnwI7Ax7usG1lWfxPT4cWwHu9z5HgUQ==
X-Received: by 2002:a17:906:81c8:: with SMTP id e8mr5764659ejx.600.1641954449829;
        Tue, 11 Jan 2022 18:27:29 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ky10sm4041772ejc.151.2022.01.11.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:27:29 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3 5/9] dt-bindings: arm: amlogic: add A95XF3-AIR bindings
Date:   Wed, 12 Jan 2022 02:27:09 +0000
Message-Id: <20220112022713.25962-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112022713.25962-1-christianshewitt@gmail.com>
References: <20220112022713.25962-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board bindings for the CYX A95XF3-AIR set-top box which ships
with model variants distinguished by Ethernet configuration: models
using external Gigabit PHY have a -gbit suffix, while models using
an internal 10/100 PHY have no suffix.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b5b995941d3b..2027ce81a834 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -173,6 +173,8 @@ properties:
               - amediatech,x96-air
               - amediatech,x96-air-gbit
               - bananapi,bpi-m5
+              - cyx,a95xf3-air
+              - cyx,a95xf3-air-gbit
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - khadas,vim3l
-- 
2.17.1

