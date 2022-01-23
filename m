Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D454973B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiAWRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:37:55 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:55235 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiAWRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:37:49 -0500
Date:   Sun, 23 Jan 2022 17:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1642959463;
        bh=K+JiOICSsVFVePfPQjsbxLe613aRT6uvJVoIQ0XNrYw=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=GGPpt8Gw3kEEQNBrYUApxZ6eQOgxWxisExq117ltBn7vbRN8Fl1v1taps+tX7mlbN
         f3hPjPSvfZkZ4rOs6GMPbhhUWatTV2Y488G5FVpQIa/csVDNo/1lJiNT+Atvc0wSdf
         WhGDRYL8AoKQGEtuMG3ga2StEdL/kux5eHEV3mlw=
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
Subject: [PATCH 3/6] dt-bindings: display: visionox-rm69299: document new compatible string
Message-ID: <20220123173650.290349-4-caleb@connolly.tech>
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

Document a new compatible string for the second panel variant.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../devicetree/bindings/display/panel/visionox,rm69299.yaml   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm692=
99.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.=
yaml
index 076b057b4af5..b02ca75756a7 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
@@ -17,7 +17,9 @@ allOf:

 properties:
   compatible:
-    const: visionox,rm69299-1080p-display
+    enum:
+      - visionox,rm69299-1080p-display
+      - visionox,rm69299-shift

   vdda-supply:
     description: |
--
2.34.1


