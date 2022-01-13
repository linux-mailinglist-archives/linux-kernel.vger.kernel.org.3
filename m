Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2284A48D5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiAMK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiAMK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:29:30 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF53C06173F;
        Thu, 13 Jan 2022 02:29:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so21296727edd.5;
        Thu, 13 Jan 2022 02:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rfGbNDKY/fIxJCRNBm0/WLDV1Lyrt5azwFyh372QBXk=;
        b=PbMwyik70G1dLP8/qQBLhvyXa9su8EMx9bSql6fbQOifbi8tra8ReNKpVaLKSRWgCI
         zQT2wVGHA4JC3EC68Ic2L/PdTz55iqGkDQ05xQFmOWijoQBAZ4QCgy/bEz2keUJrznWw
         /iCtRm/YbeHjPYxHpoQmalTftx7FRpE2cVVF9LBxVTp9Fg57vPzV+uN6VjVjkr0n5/a3
         mK6ZQqvpQM6asysXtv+h3sianYbf3Q0vBVdzj1oYQAxM1993SzHnwjnW55H1gvQ9mr2k
         8mykC6zmctLhz5hI6rcXaLkyWQvVCZexycMc+ZFLFiSUGkryETsko8XBE9nHIQSpu9Z8
         OaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rfGbNDKY/fIxJCRNBm0/WLDV1Lyrt5azwFyh372QBXk=;
        b=ftkw45IELNa3VTZMNNM+NsmgVPWO5J/mQlGIfTV3RSruRRz+EWV16FSXz6e6PWOCCi
         Rim2C4XcJgxZ1xtlzfql3wLbBvgwXzP6JXCz1DB+wgtuDq0QD6lZKH6pInY822SjC5RZ
         o//da9N44EViQpIKyBdo0AfarTxXn0S6sj/Z5IHey1K+WQMZr4el/Squcr2VD3sAZ9qq
         nOJ7m2kJ915FPK1RrEsURRaK2t1169Gq83NFeT3ulj+09wJesvZfCzpYNQ9ecgO+JN+T
         tOt0BNelNpwzIneT/E/i23Y4ONf+ai6q34/6tiefmPuHu8lbPBpCBgPOab/EY4bHwugY
         pePA==
X-Gm-Message-State: AOAM532iHS5nVIfmtMUA3uaT1yIeSY411R6UoM+vKLw1y8PBokjwXoci
        lu4mVgikAuQCwH2MQGLJxXu7etPVHxQ=
X-Google-Smtp-Source: ABdhPJxcCNNzbZHYcYkYWMOEjBelotGbkDC4bHY1Khg/tstn40KrgrU6iQM5CQSgA1H1bciTZ77LcQ==
X-Received: by 2002:a17:906:ca48:: with SMTP id jx8mr1644548ejb.78.1642069768789;
        Thu, 13 Jan 2022 02:29:28 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id qk10sm718821ejc.116.2022.01.13.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:29:28 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:29:26 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: vendor-prefixes: add F(x)tec
Message-ID: <20220113102926.GA4388@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix for F(x)tec [1] is used in device tree [2], but was
not documented so far. Add it to the schema to document it.

[1] https://www.fxtec.com/
[2] arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in v2:
  - Reworked patch description
  - Rebase on next-20220113

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b3de81e8290f..ff59ce74f4d1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -443,6 +443,8 @@ patternProperties:
     description: Freescale Semiconductor
   "^fujitsu,.*":
     description: Fujitsu Ltd.
+  "^fxtec,.*":
+    description: FX Technology Ltd.
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateworks,.*":
-- 
2.25.1

