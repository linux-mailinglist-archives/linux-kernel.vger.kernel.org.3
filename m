Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA0462C94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhK3GJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbhK3GI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:08:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE4C061574;
        Mon, 29 Nov 2021 22:05:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so81904723edv.1;
        Mon, 29 Nov 2021 22:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eEwebxlJ0ADP5GA0lC7mVYWXiv0EHw+yI/77FMgWc6o=;
        b=DQtVRqc/ciupvjrdrtwv2VkmMt4gpL1o49wuYj6x3kDoY85VKnr1rC/wkutQRC8ztB
         bNaO5G+a5/WfUcD18pxU5W7KFU17u5+XcRdCpJFhVgO80mMaOkAjp5CrrpnEckqSHsY7
         H62ZlpSv1XHltib6xcD3ec1eiHETJOrXqerUHuH4/w2skdJO6PbSK0Dty/RUni92StSI
         dq10OaHsLzeRwuvrl8nsB6mQVaVEAJm/Fqz74x/HOX6N12HUOgdjnAE5u4FUQi6y9Su2
         5WwHox8AS+Jm20egbYtBN+TcWs3HEVEonKzNVDqY/kY6qbWE0mLQ+xzTHjhN63YHGmNH
         iJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eEwebxlJ0ADP5GA0lC7mVYWXiv0EHw+yI/77FMgWc6o=;
        b=PFhdfQSi3NeQgiOeshwdlncfEz3ZlpOtEb6TVIVYBAedbgwHJmbgB39OSzobZUEeS0
         Dv34DQ2O4P13uZR254gY4B5JQ83Mt4CuGvwkmbjY3vNddDXl8FxprpxVIT1WohU2nxEL
         swDZr2iupGFgWfV37Wdz3upyMsflGsK/2MoFJ+beMzji8rQooTm5xCYoNgRNV5kR4rsn
         r/vlGNbYK/b7QQBdckHeZxIbzl1mWo3/TNJGkJawOsmrbfGKR9guOdy2H0N48O7hkR9U
         cBVeI+GOFE8LUv9TxOIi3NNd4VaQ36/60sQYcd8jwOT2j2lqCj7g042MnKoYnFi2tAM1
         CnXQ==
X-Gm-Message-State: AOAM532LXBx3REPGD8GhruqT8wZve40avde+rQwjRCBBC1vSdDxpHi9D
        CFQ/DLL9nR16KX9nCEppJZk=
X-Google-Smtp-Source: ABdhPJz88fFv3/83546ZibuOpgkJDwZvx5tig36vWP5368FIDqjwQEexZW7ExPmvt89+ve3xpK9xyg==
X-Received: by 2002:a50:ff10:: with SMTP id a16mr79076109edu.275.1638252335940;
        Mon, 29 Nov 2021 22:05:35 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:35 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 4/9] dt-bindings: vendor-prefixes: add cyx prefix
Date:   Tue, 30 Nov 2021 06:05:18 +0000
Message-Id: <20211130060523.19161-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen CYX Industrial Co., Ltd are a manufacturer of Android
Set-Top Box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..f1b4afb2876a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -279,6 +279,8 @@ patternProperties:
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

