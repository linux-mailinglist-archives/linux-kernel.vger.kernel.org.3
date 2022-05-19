Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86E52E0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiESXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiESXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:51:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B040E7A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso506693pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDYfcoctfgGUpMYw9gQculc5eVEMZPLN1EPyBP/a9TM=;
        b=HljvQakYyYfi+0fM7rulr2lNCGasST40JGLLSaq280R0ouMVRg91Upwpa50fKNn+/w
         N5f83IHNriAN3kCyk5qhyWQ7hh2LK9yCbkDB+HcAixAvZunoso5OJJNdAHZZcnDGGOMM
         7oqCSim/qX+jB5HHwFiu9DFd+wzGZ7dvw3l+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDYfcoctfgGUpMYw9gQculc5eVEMZPLN1EPyBP/a9TM=;
        b=2fIZeUjTS1UdlXtP+UtWiYz+EsHXeBDuIvrQhKQVwKaoTORZy/SbwvzFnbcO2dNdWm
         A/ieg2m1xsHSIrZC+PM6zG77KxywLNJbtAmwgVCy9216twagk1FA+gUVHuXtD1QCko8M
         Iej15aRa05aT9XNllqutyFQvbr6Z51nEKIF/wg703aYJ3zFwiJnGZqI5JFOPuAoee9eV
         HUV2jLgcD7AIPv+N+yXJxkpA9kWdzmgqSUkIT7qsJCI55LuhtGZn5ZsccBKFRIAsFa/N
         39kZnxVptOsk5MM8Ifc2S7RmEoQW2jZsWODJe12CVdMMgrKsm7bYGQNuZA4mMePOhZwd
         e0Ow==
X-Gm-Message-State: AOAM530vrcx0B6RlvlkN3bgPoa0qn+JiTPSZW0/gATU3K6JcuvXCipp4
        XM21FW6b80/VwviAK5PbRFnd2g==
X-Google-Smtp-Source: ABdhPJxced5j+irHMBvMDaaCbqgm4kaRsuNLDDROWGXScg0zPskmeITG405M83EO8WbvdXflyKfaDA==
X-Received: by 2002:a17:90b:3506:b0:1dc:72c6:384d with SMTP id ls6-20020a17090b350600b001dc72c6384dmr8233598pjb.137.1653004290046;
        Thu, 19 May 2022 16:51:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:e45f:1f3c:299b:4d86])
        by smtp.gmail.com with ESMTPSA id m2-20020a6545c2000000b003c18ab7389asm4128992pgr.36.2022.05.19.16.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:51:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
Date:   Thu, 19 May 2022 16:51:07 -0700
Message-Id: <20220519164914.v3.3.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This copy-pastes compatibles from sc7180-based boards from the device
trees to the yaml file so that `make dtbs_check` will be happy.

NOTES:
- I make no attempt to try to share an "item" for all sc7180 based
  Chromebooks. Because of the revision matching scheme used by the
  Chromebook bootloader, at times we need a different number of
  revisions listed.
- Some of the odd entries in here (like google,homestar-rev23 or the
  fact that "Google Lazor Limozeen without Touchscreen" changed from
  sku5 to sku6) are not typos but simply reflect reality.
- Many revisions of boards here never actually went to consumers, but
  they are still in use within various companies that were involved in
  Chromebook development. Since Chromebooks are developed with an
  "upstream first" methodology, having these revisions supported with
  upstream Linux is important. Making it easy for Chromebooks to be
  developed with an "upstream first" methodology is valuable to the
  upstream community because it improves the quality of upstream and
  gets Chromebooks supported with vanilla upstream faster.

One other note here is that, though the bootloader effectively treats
the list of compatibles in a given device tree as unordered, some
people would prefer future boards to list higher-numbered revisions
first in the list. Chromebooks here are not changing and typically
list lower revisions first just to avoid churn.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v3:
- Split link to Chromebook boot doc into a separate patch.
- Added a note to desc about revision ordering within a device tree.

Changes in v2:
- Add link to doc about how Chromebook devicetrees work.
- Use a "description" instead of a comment for each item.
- Use the marketing name instead of the code name where possible.

 .../devicetree/bindings/arm/qcom.yaml         | 182 +++++++++++++++++-
 1 file changed, 181 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index df5230792b37..2269493a1b48 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -219,11 +219,191 @@ properties:
               - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
-      - items:
+      - description: Qualcomm Technologies, Inc. SC7180 IDP
+        items:
           - enum:
               - qcom,sc7180-idp
           - const: qcom,sc7180
 
+      - description: HP Chromebook x2 11c (rev1 - 2)
+        items:
+          - const: google,coachz-rev1
+          - const: google,coachz-rev2
+          - const: qcom,sc7180
+
+      - description: HP Chromebook x2 11c (newest rev)
+        items:
+          - const: google,coachz
+          - const: qcom,sc7180
+
+      - description: HP Chromebook x2 11c with LTE (rev1 - 2)
+        items:
+          - const: google,coachz-rev1-sku0
+          - const: google,coachz-rev2-sku0
+          - const: qcom,sc7180
+
+      - description: HP Chromebook x2 11c with LTE (newest rev)
+        items:
+          - const: google,coachz-sku0
+          - const: qcom,sc7180
+
+      - description: Lenovo Chromebook Duet 5 13 (rev2)
+        items:
+          - const: google,homestar-rev2
+          - const: google,homestar-rev23
+          - const: qcom,sc7180
+
+      - description: Lenovo Chromebook Duet 5 13 (rev3)
+        items:
+          - const: google,homestar-rev3
+          - const: qcom,sc7180
+
+      - description: Lenovo Chromebook Duet 5 13 (newest rev)
+        items:
+          - const: google,homestar
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (rev0)
+        items:
+          - const: google,lazor-rev0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (rev1 - 2)
+        items:
+          - const: google,lazor-rev1
+          - const: google,lazor-rev2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (rev3 - 8)
+        items:
+          - const: google,lazor-rev3
+          - const: google,lazor-rev4
+          - const: google,lazor-rev5
+          - const: google,lazor-rev6
+          - const: google,lazor-rev7
+          - const: google,lazor-rev8
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (newest rev)
+        items:
+          - const: google,lazor
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev1 - 2)
+        items:
+          - const: google,lazor-rev1-sku2
+          - const: google,lazor-rev2-sku2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev3 - 8)
+        items:
+          - const: google,lazor-rev3-sku2
+          - const: google,lazor-rev4-sku2
+          - const: google,lazor-rev5-sku2
+          - const: google,lazor-rev6-sku2
+          - const: google,lazor-rev7-sku2
+          - const: google,lazor-rev8-sku2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
+        items:
+          - const: google,lazor-sku2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE (rev1 - 2)
+        items:
+          - const: google,lazor-rev1-sku0
+          - const: google,lazor-rev2-sku0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE (rev3 - 8)
+        items:
+          - const: google,lazor-rev3-sku0
+          - const: google,lazor-rev4-sku0
+          - const: google,lazor-rev5-sku0
+          - const: google,lazor-rev6-sku0
+          - const: google,lazor-rev7-sku0
+          - const: google,lazor-rev8-sku0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE (newest rev)
+        items:
+          - const: google,lazor-sku0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 (rev4 - rev8)
+        items:
+          - const: google,lazor-rev4-sku4
+          - const: google,lazor-rev5-sku4
+          - const: google,lazor-rev6-sku4
+          - const: google,lazor-rev7-sku4
+          - const: google,lazor-rev8-sku4
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 (newest rev)
+        items:
+          - const: google,lazor-sku4
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen (rev4)
+        items:
+          - const: google,lazor-rev4-sku5
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen (rev5 - rev8)
+        items:
+          - const: google,lazor-rev5-sku5
+          - const: google,lazor-rev5-sku6
+          - const: google,lazor-rev6-sku6
+          - const: google,lazor-rev7-sku6
+          - const: google,lazor-rev8-sku6
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen (newest rev)
+        items:
+          - const: google,lazor-sku6
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 (rev1)
+        items:
+          - const: google,pompom-rev1
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 (rev2)
+        items:
+          - const: google,pompom-rev2
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 (newest rev)
+        items:
+          - const: google,pompom
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 with LTE (rev1)
+        items:
+          - const: google,pompom-rev1-sku0
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 with LTE (rev2)
+        items:
+          - const: google,pompom-rev2-sku0
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 with LTE (newest rev)
+        items:
+          - const: google,pompom-sku0
+          - const: qcom,sc7180
+
+      - description: Google Trogdor (newest rev)
+        items:
+          - const: google,trogdor
+          - const: qcom,sc7180
+
+      - description: Google Trogdor with LTE (newest rev)
+        items:
+          - const: google,trogdor-sku0
+          - const: qcom,sc7180
+
       - items:
           - enum:
               - qcom,sc7280-crd
-- 
2.36.1.124.g0e6072fb45-goog

