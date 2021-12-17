Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116984787CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhLQJfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhLQJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:35:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:35:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c6so1383816plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLi6N94MnCVB9ARnc0eEzCARITtk4gVOxNAAwPj43QQ=;
        b=OMTJeOjcj1XpgOhCtKqXK0zWxh/x5nrFmIlZwqscjJEGOb4C021MjtSgxmGYtGxsPq
         skm8UlTj6Z9U5mevQS7gq8eNPMcal2cGgEUQNdO6aq8kG0g/ipqkpRxV/sUlzLYZyS3o
         fLpI1nt03c+JhpPeNxBwABRL2nrucpESRK8O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLi6N94MnCVB9ARnc0eEzCARITtk4gVOxNAAwPj43QQ=;
        b=guBG2lp7vg+rfACN5aWXO1cuwtjWpCOhs7QiCEpTP34x49rIWJRGBmc8f8yXb8J92k
         kdhiiulx2kb2yUqwJEe4g/rXHn90PeApCJ280ezccB42wjYqtOd01gghKc1094Q44MhY
         Eo0+0BLIWsYJ/zUkY3xEaGyOzkLBeoX1YdoHz7qqNFtigFEwCZgd2tcJXMZDpoToGGTp
         XJSmHeVO9e+IKVbErsVPfkrjTxIXpf6rahOZszFn/r3HlCDgJY4ECNjQmR0g/dVTL/lF
         abl71TgTv6RDn6Plo6/e3uR4TApQKyNJ1efO+lC1XURQ7f0OCxWHIhNRRdTEuFPZta3U
         vjgA==
X-Gm-Message-State: AOAM533mWw+5B/5uFlyCLveiX9V+AE5jNpWK68m2VbQhJHWNyt8JEQDl
        1WTTA/OnXNGWkvEp9xzSpdeuhw==
X-Google-Smtp-Source: ABdhPJwjfofJlRSoHzSk6XAQ1y4RXRcjsbeTWGB36hJAAfde6/UiEFSfrmruZFE0o8kXKeo6DZuvtQ==
X-Received: by 2002:a17:902:db01:b0:148:a2f7:9d51 with SMTP id m1-20020a170902db0100b00148a2f79d51mr2555518plx.112.1639733732685;
        Fri, 17 Dec 2021 01:35:32 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id o9sm7650143pgs.65.2021.12.17.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 01:35:32 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, romain.perier@gmail.com, livelwh@outlook.com
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for 100ask
Date:   Fri, 17 Dec 2021 18:35:08 +0900
Message-Id: <20211217093510.3674590-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217093510.3674590-1-daniel@0x0f.com>
References: <20211217093510.3674590-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

100ask is Linux SBC/module/training provider.
Add a prefix for them.

Link: https://www.100ask.net
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 To Rob: One thing I have noticed is that dtbs_check
 seems to be complaining about the prefix starting with
 a digit. If it's a problem I can change the prefix I think.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..f0fc682d3680 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -23,6 +23,8 @@ patternProperties:
   "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
 
   # Keep list in alphabetical order.
+  "^100ask,.*":
+    description: Baiwen.com (100ask).
   "^70mai,.*":
     description: 70mai Co., Ltd.
   "^abb,.*":
-- 
2.34.1

