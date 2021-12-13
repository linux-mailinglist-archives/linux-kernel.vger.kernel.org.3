Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA347228A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhLMI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhLMI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:27:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CBC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so48908243edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nx2k/Z7zXaHDEmILWiW6Gfo7Sovd555lCUGQrDZv1B4=;
        b=GRizKnCZzX4XIZWXwe1fB83XbndD7/QihySjOEbyZNuabUOz8HGjbO+wfgwY0T16MV
         UR7gF8NbIMN04a8DE+abCipUbDfVk+cvGE3tCAmJYcDR2AUFdhJwF+la0FSUzwpMdfQ1
         cExq2O1ZjjpDvVp1K+KBAHwpFiXJPqlXlp2n7C65pA6PbteyusrOQVWqfouq5tB1eavk
         j9E0KbXJBWuunFZ7gs8KRq+8ycrVk0WjDQ54nMPjcdblsxlSrq+WrBffeCIjwVAsXyQR
         vjgTLQKqc3LUVO8DdXKmHB3HmWUTcba1umhWqCN8PWs5p07eQVxamcRNPXH+V2ahe82/
         xf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx2k/Z7zXaHDEmILWiW6Gfo7Sovd555lCUGQrDZv1B4=;
        b=jiM7fG1+GYk1yAmEMB7kU3b9B+VrHu6P1pmw4pEg/wYis5SBHc/i66GYlboBJxgCyU
         KV8fjyYq5t37bGkIYAnD8xRNeOq8bU4S0qdNW0Zvs7xZadwmhZjuwUKlIKcTklYG91VI
         2N23VrPIx9cr1TSOZXVIQ2+sYU2J8uGYWIpVB5eDk7WNwT4I0IFH/DRUJiPPamlNejuG
         gvIiLFNK2zDciypkOGKS0n6XxET9CpvDkUUy87WCVwiI3SyZntbz0NG2tDfbphx8oVv8
         yyA+PlnMn194VpJr6GnB8h0/uF+DvNqZSoHtmPZ8vDIlQj/pJQ4Mk3AU8X5WyVuq/Vie
         qLcw==
X-Gm-Message-State: AOAM532vXPNqG1yILTC3ihiwnlZeRGgQRXr12XHWGJv5PemxpDRxch39
        DWq3DTX9Od0syj0UzgzkniIs6qYPeGgID7p7VVw=
X-Google-Smtp-Source: ABdhPJwc8O3GyxL3m5uw07gi57MsjGEjsBsmLY/+KmZbUmFN/YdDjU9HlK6mY71lXx8b9isj79j5RA==
X-Received: by 2002:aa7:dad5:: with SMTP id x21mr61383134eds.280.1639384032749;
        Mon, 13 Dec 2021 00:27:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id b11sm6062432ede.62.2021.12.13.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:27:12 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] dt-bindings: firmware: scm: Add SM6350 compatible
Date:   Mon, 13 Dec 2021 09:26:03 +0100
Message-Id: <20211213082614.22651-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082614.22651-1-luca.weiss@fairphone.com>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree compatible for SCM on SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index d7e3cda8924e..1fc14f64e318 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -26,6 +26,7 @@ Required properties:
  * "qcom,scm-sc7280"
  * "qcom,scm-sdm845"
  * "qcom,scm-sdx55"
+ * "qcom,scm-sm6350"
  * "qcom,scm-sm8150"
  * "qcom,scm-sm8250"
  * "qcom,scm-sm8350"
-- 
2.34.1

