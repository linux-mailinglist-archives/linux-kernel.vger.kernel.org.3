Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D634B23C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbiBKKxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:53:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiBKKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:53:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E3D8D;
        Fri, 11 Feb 2022 02:53:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w11so14539168wra.4;
        Fri, 11 Feb 2022 02:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BjDFuVI1diXeHGjfeYh1Ru7NnwWu54G5DixYVQkN3LQ=;
        b=IPUH1MM4F2bcCEyH9Dk48Ibm3Ays+j2Rb9w/3XdESqiobx05n0iuIVd/fq9xu6q9Uv
         Ka7b8rG90UVojUOr5HzN6mw6hCXnq3VMD/1VBTw/edAjzy1wCeEwYZ67nZhFSAAUNute
         Zo845Ka+/CfLdBsTaC+l1qKvKBoHquJ53WRaFE0AsU6Gkm3Mlh8lGtnnr+Gq/fyxcZc/
         N2om/1XVYvH6CdqhKMHQ/JuE72JD31MXkdOwp2TdkUyNHhnG9tcoY+SIxrU7A7W/6EF3
         oJ/HmVmOntbB3MtRhaAZq29ZVGb5CL6hqbJmnAdeNUN7VH//vKPN9/XkGuvRimtpeXRg
         zw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjDFuVI1diXeHGjfeYh1Ru7NnwWu54G5DixYVQkN3LQ=;
        b=Im3TuHIlpSmNM3+zy3YDJIwRmc96VXEAefGZo60kIiQ9LoFQTfbWwwtXPvnIZS67qE
         MsSpKwRUxvbIKQUUBE3LeftYLmI9SfLVwUW/LWd7LUI6wB9c0mLGerF9r+0cVJWa8Heh
         6DKBgqN94D9S37po2f/yMN/bxpiklAfzHpKxyA2jUVJUmchNG7q6ygpt00ItQku2yDhs
         9Tyb2JfynbiSj+9q9Oxw0wBiNX/NClVi2t48Lsm+O1oMWfCD16K7dwx+xMPyA/mC4FXe
         DFDfZTsB6oKM/4sEx1BxS8heBkb7pB0UjP0feVuxJUbl8MkDvlsTD+R9EBancrqJnntv
         GtGQ==
X-Gm-Message-State: AOAM530HAfXgXoWflPXwGKA/+M6CoSLD1SYVEsdmnK13NDsyEy4RZBZ7
        VcFAzlhKUF/GaRgpqia/QPbIkcJhX8EQPA==
X-Google-Smtp-Source: ABdhPJwxqr3gewkoJ0yU25BYbz0IFxPTaIIJdfOtrWTNsHnhSnNj02uxBL4KfOIDDfZscEFSz+BgMw==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr878215wrq.283.1644576798930;
        Fri, 11 Feb 2022 02:53:18 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b4sm13382374wrw.100.2022.02.11.02.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:53:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add osmc prefix
Date:   Fri, 11 Feb 2022 10:53:09 +0000
Message-Id: <20220211105311.30320-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211105311.30320-1-christianshewitt@gmail.com>
References: <20220211105311.30320-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open Source Media Centre (Sam Nazarko Trading Ltd.) are a manufacturer
of Linux Set-Top Box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 52ff63248892..b97fd8dfe601 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -882,6 +882,8 @@ patternProperties:
     description: Ortus Technology Co., Ltd.
   "^osddisplays,.*":
     description: OSD Displays
+  "^osmc,.*":
+    description: Sam Nazarko Trading Ltd. (Open Source Media Centre)
   "^ouya,.*":
     description: Ouya Inc.
   "^overkiz,.*":
-- 
2.17.1

