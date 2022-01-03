Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B974834E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiACQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiACQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D671AC061784;
        Mon,  3 Jan 2022 08:40:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q14so130197847edi.3;
        Mon, 03 Jan 2022 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p4Yz6c1pIbz2ITxrOQWOyCbFEZFiExtqlrCSzsvDykI=;
        b=J+ZdGNr8AkYghMKpIa3F7mCPljZx6ryO68WZ/pbDDoJKaq+8z75X1JhzdzfDrCkrPJ
         Na/ttxLv3itVV+pn2WmtFRFE3oIpf/YJv9j+yqs5S372C9ENGcWVTtn9OfP2Ong10qSh
         pWoQumzkRURyZ4n/P+sOlQih7n4BQkdVlORGRdihGvCiMFbXiBDUE9LFEM6yr+KIV89l
         BfPGRDTqh5Y0GDvInLBoMEXkLie3G7TxkCe1IE5wSRa6J7iZc2kiWI9PUv+FxYepMHu7
         NhMFtpD6Y+EuoCt7T4k6Xi2NlVpfytm8IKLWAFMl6H4KNIE6jZTA+WrBRHFCEpOhY8gP
         oHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p4Yz6c1pIbz2ITxrOQWOyCbFEZFiExtqlrCSzsvDykI=;
        b=z7avpY9H5Triklmo9Dh5sAvRU2vPqUhTYx3vCvtkPfmpKB4TFvBZJDsZ8ampGUZaQM
         nbiiRNiC/x4h1TPYvzXhQOxZkth7Y7gniTT5ENlqksS+nWEvV2dW2HNLRVOHOcUUKEso
         nM1ppX/jzYN5Y29VC2DVCw4G6BkaG8pLh5r7BgUlTdsWcOTw9J3XcMWT2raCmc+B+eZE
         CMttAlGHj3V5EwGDm291ITl85651I6Q8rm3dg1v1xIbpnW3D2IpfoqbD2gg7dq5yjR71
         58Ls3ylNIpU6pvccDSX9csrCiBCmXr13i9W9GPJW0KD74bL9ypw5utI9jIgi8eEJkLzZ
         6qwA==
X-Gm-Message-State: AOAM530K8kpDk2yLVnC+2SGjIWj1AqYfLVf9WqL9+UeGykDA8VqLUsU6
        aoPwYCU7hNQbyHPvomdZ+aM=
X-Google-Smtp-Source: ABdhPJw/HvxGgBV0K7DCOi4nqHrbVeEoolbUJBcxbFkyLN8rxGHcFEo1XNTiTLe3POPYhr7uCOey9Q==
X-Received: by 2002:a50:fc91:: with SMTP id f17mr45465632edq.252.1641228009502;
        Mon, 03 Jan 2022 08:40:09 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:09 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 4/9] dt-bindings: vendor-prefixes: add cyx prefix
Date:   Mon,  3 Jan 2022 16:39:51 +0000
Message-Id: <20220103163956.6581-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen CYX Industrial Co., Ltd are a manufacturer of Android
Set-Top Box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index eb8ab0d82198..c9202a101d71 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -281,6 +281,8 @@ patternProperties:
     description: CUI Devices
   "^cypress,.*":
     description: Cypress Semiconductor Corporation
+  "^cyx,.*":
+    description: Shenzhen CYX Industrial Co., Ltd
   "^cznic,.*":
     description: CZ.NIC, z.s.p.o.
   "^dallas,.*":
-- 
2.17.1

