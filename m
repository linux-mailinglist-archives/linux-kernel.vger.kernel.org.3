Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2847768D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhLPQCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhLPQCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:02:51 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15EC061574;
        Thu, 16 Dec 2021 08:02:51 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id m12so39234135ljj.6;
        Thu, 16 Dec 2021 08:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNnl/SMgi+a1vZUFpRGO6B+ARNo01gzwBzD98+b1L5g=;
        b=qLgN00iHfIwpINS8s9PGlwsb6lZJctGBLXRl/BOjMq9Wm5/20axqduCVyBxE4T4ADt
         C6kbdM5jxuicE/l5/L7sAEmjjZ4wKmHmrHyhsdU5bO9/5bU4ag/wG+bt0CSZZg3KFwHW
         tp8J+AnPzHv+HLE0gP20Ho2oXRqcmsLo4GbmmEc/y5OsfpFddMspi4gCmNzR9aeuX++g
         z3fGPrJ1JkkpSOy0RFvLGHiDe6yD5sJ8Ch2RuT74ab3oyas2zfimLhho0+cg/3Rb6L1d
         8sr2ZTKW1RLqAWimU+r81cm3enjrteFAgsRzBawTIORWu+IEyG0sng5e05q5XXGCzbsd
         t+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNnl/SMgi+a1vZUFpRGO6B+ARNo01gzwBzD98+b1L5g=;
        b=ogINQz+ylv/HlqGW6VkQm9Klljvf5oPrDzwgWXH57akbbbnpAGrEvhX/A67otU3sg3
         4FBS74+KNNOuqTNI/zd2eqreytG1crpr05G+yJxvyi61aFBe06zrfHmQiSyH372pdA+4
         0CVFTt6gFhfgIPVh6KgBTBhP3fCkEuwV/Q4FwXYVmqB/cLviEs4aF/mswvJ0XeeeJXu/
         mXN9unr0gxpyFJUffKy0yMaW7pqBB6ugMJ/bSkz+z1bC37gWBacSEb0Xo7y/9E9z5ewF
         LjqE7lgLE7TS8UoGzlwrNsFbHLMbg+R68DQac4EvSAYdYDnr2KXyxjN4SlhJ2x5rDuN6
         OI4g==
X-Gm-Message-State: AOAM532MvwMKIA+VjuhUaS23aZn7oqMovlUBw6tDD9Y8aGVfPkI+tELJ
        6Lh8VhshWywZuq5s976EAqE=
X-Google-Smtp-Source: ABdhPJzgsEtNfuQPOiRiHdq8hgtrYwB6++vokZQp+eTOApx4GFQIVMVdOHDa4IlEFHEmnBmFPUjbSw==
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr16504562ljg.414.1639670568728;
        Thu, 16 Dec 2021 08:02:48 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id o15sm934802lfd.164.2021.12.16.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:02:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: sound: tegra-audio-rt5677: Correct example
Date:   Thu, 16 Dec 2021 19:02:29 +0300
Message-Id: <20211216160229.17049-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove non-existent properties from the example of the binding. These
properties were borrower from the old txt binding, but they were never
used in practice and aren't documented in the new binding. They aren't
reported by the binding checker because dtschema needs extra patch that
hasn't been upstreamed yet to make unevaluatedProperties work properly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml   | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
index 03ff691c26c8..a49997d6028b 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
@@ -92,9 +92,6 @@ examples:
         nvidia,audio-codec = <&rt5677>;
 
         nvidia,hp-det-gpios = <&gpio 143 0>;
-        nvidia,mic-present-gpios = <&gpio 132 1>;
-        nvidia,hp-en-gpios = <&rt5677 1 0>;
-        nvidia,dmic-clk-en-gpios = <&rt5677 2 1>;
 
         clocks = <&clk 216>,
                  <&clk 217>,
-- 
2.33.1

