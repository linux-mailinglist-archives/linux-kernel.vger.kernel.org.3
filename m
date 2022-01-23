Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF24973BB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiAWRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:38:23 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:28058 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbiAWRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:38:19 -0500
Date:   Sun, 23 Jan 2022 17:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1642959497;
        bh=d8aEteS1vLPtPK73c29gz6XOUE0dP5YxsJD0H9DQlBc=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=mZ+s9tnheoo1GUEObKN8zjfsbDv0/yNMM6TJF0KSqRn1Bh0NyKAn23oqLQ2NR+W4p
         XDY2jHSKic/Ve9NlIprVTWoOA2DYhlHRWMiWCrj3LowVAxL/bJcf8EFNTeQTwQRgxN
         goUAqkESxCTIZl3K4p3EATtwQU1GZ2oq89g/YC6g=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Caleb Connolly <caleb@connolly.tech>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Alexander Martinz <amartinz@shiftphones.com>
From:   Caleb Connolly <caleb@connolly.tech>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 5/6] dt-bindings: vendor-prefixes: add vendor prefix for SHIFT
Message-ID: <20220123173650.290349-6-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SHIFT vendor prefix, SHIFT make various devices such as the SHIF6mq
phone.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index c48ce3c54951..68981e865396 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1058,6 +1058,8 @@ patternProperties:
     description: SGX Sensortech
   "^sharp,.*":
     description: Sharp Corporation
+  "^shift,.*":
+    description: SHIFT GmbH
   "^shimafuji,.*":
     description: Shimafuji Electric, Inc.
   "^shiratech,.*":
--
2.34.1


