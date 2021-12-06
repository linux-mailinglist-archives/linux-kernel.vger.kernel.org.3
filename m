Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9189E46A32F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbhLFRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:44:49 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40766 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243816AbhLFRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:44:43 -0500
Received: by mail-ot1-f43.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so14588500otj.7;
        Mon, 06 Dec 2021 09:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQ33NtO+h5cZWHcbJoRJUG8vZRwMRqm+nEu5OuGtqj4=;
        b=3cp2y/HpEhbBHSl1twnkPFD8WgKA7g1r+h/fWGQV6//AObyqUxbWXgqyJrpy6B7Zi3
         ZZwP7t6Xj8WM1XNfx43jmKlyYpSwRqE27x1qiS9qnfrewsBhD44DpT6a391YS+IY3Wiw
         emV0YL/hB9hXuDvKkSBl3Qrji0UnD5cZi7LEbuIzTWQxgor7iwBPiQGg576qKExeWLHf
         bTpuQ29lXx51HsYUd2xCB0CjNfWj6/2lXqkprfve5hIAXYuwzSLDn7WkJmHK0aAd8BNc
         95GwcXYJNUTAqpDUXD00P+iRFOIHT6amQrXt3jvN5bDo+G2ve8rkPHIUP8j1IrsV+1d6
         FrqQ==
X-Gm-Message-State: AOAM5302eamlNvN8cWI6b+d8kBdUr3lkfmyuDw/iUgDm4WP1fshUpg1E
        J2q++Dr7CSZ9euoJzKnuywLvCKDxSw==
X-Google-Smtp-Source: ABdhPJx0lG9PCFZcxI7gLJWj+yGSzIhTwjC2Jd33+kjsEJVijXchlmG64wFDVT2jbKUK5mzQevmMiw==
X-Received: by 2002:a05:6830:928:: with SMTP id v40mr31422669ott.203.1638812474415;
        Mon, 06 Dec 2021 09:41:14 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id v2sm2310243oto.3.2021.12.06.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:41:13 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: Add missing properties used in examples
Date:   Mon,  6 Dec 2021 11:41:12 -0600
Message-Id: <20211206174113.2295616-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, the following warnings
are generated in the usb examples:

Documentation/devicetree/bindings/usb/intel,keembay-dwc3.example.dt.yaml: usb: usb@34000000: Unevaluated properties are not allowed ('reg' was unexpected)
Documentation/devicetree/bindings/usb/snps,dwc3.example.dt.yaml: usb@4a030000: Unevaluated properties are not allowed ('reg' was unexpected)

Add the missing property definitions.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/intel,keembay-dwc3.yaml         | 3 +++
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml        | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml b/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
index 43b91ab62004..d3511f48cd55 100644
--- a/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
@@ -13,6 +13,9 @@ properties:
   compatible:
     const: intel,keembay-dwc3
 
+  reg:
+    maxItems: 1
+
   clocks:
     maxItems: 4
 
diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 25ac2c93dc6c..d29ffcd27472 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -36,6 +36,9 @@ properties:
         - const: synopsys,dwc3
           deprecated: true
 
+  reg:
+    maxItems: 1
+
   interrupts:
     description:
       It's either a single common DWC3 interrupt (dwc_usb3) or individual
@@ -65,6 +68,9 @@ properties:
         - enum: [bus_early, ref, suspend]
         - true
 
+  iommus:
+    maxItems: 1
+
   usb-phy:
     minItems: 1
     items:
-- 
2.32.0

