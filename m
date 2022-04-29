Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7F514917
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359028AbiD2MXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiD2MXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:23:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619301581C;
        Fri, 29 Apr 2022 05:20:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so15068357ejj.10;
        Fri, 29 Apr 2022 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7dL/+VZLaVUt5wUNxW4Ik+wlho9LkARjWYWndO/Mro=;
        b=PY/65KPfyC8yRsWjvXlITjG7mJeESXMzEUiATZTp88CKL6xH4FPzUig3zy0Ooi+Iza
         sffwJUrhwqDBIogUAMj979EMMaMa1nDWLKgaN9t/zzAxdcJ6AEd8FS0iTZZGlsFnwR/p
         e3d1Si1roOHer+nKrUog2XMLP5JA0Pa5CKTrJlqfPOJ0K5y5eMdVPkhaxSN4pEVlPCY3
         tj9IBYoFw6LWAgfY/5HJ03EmfXflyS4SPQHMo5NakqekM0MoJbhe0Z7K5aSa2g/cCtRd
         KC6283ZRvtn8HO9YRm6ZAzfm0pD4kei7EOzvpjzGbWDEF7xX+pn5oqmVTD+poSdcpC8F
         qNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7dL/+VZLaVUt5wUNxW4Ik+wlho9LkARjWYWndO/Mro=;
        b=rv+YvHkdfVsBCCFXwyB/0oabHn1uxiFrBm1ZT1RMBkCFXcua9T1Dp/T+8RwdPB8sp6
         uDX06aaObQ+o3idjF68xF6DTKfw5WX/KHP119KAWtyNvtjLNu9ahBvbBo+wlI85okh3h
         aAkwvZ84WQoTyVdGSZhYtj4OmZbCgyuO9ajQFBFuRXW0o81JGbIomNIHasSwC/AFIoEe
         k8dMMy2MvQK3ibo6CJ40gR9RHtIi0bW9tCpFMl1lSiCoQvNPSvI14uQ8rxRW98hM+M47
         WEPrTp8tvhG89Prp/3vl42+TaYavEvlzyLmzfP7/og3D43pYHZVgztn5fjE9X7Q3o86J
         z3Lg==
X-Gm-Message-State: AOAM533MKM+gKzgM3rhniJfjPxsQtKhsSk1KVGENyx72jtXS/GkoHBxG
        J/hBZYXwF5gWFcXN9DIabdJfWSoYeBA=
X-Google-Smtp-Source: ABdhPJxGrtVVGu869LXVrVu8bVEy2calmisJ4Jv4hPwq7maHZolNdLun7MI5qvCzu80eyQoOfW2/dg==
X-Received: by 2002:a17:907:94ca:b0:6da:e637:fa42 with SMTP id dn10-20020a17090794ca00b006dae637fa42mr36277625ejc.347.1651234813770;
        Fri, 29 Apr 2022 05:20:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e10sm602694ejc.118.2022.04.29.05.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:20:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/3] Krait Documentation conversion
Date:   Fri, 29 Apr 2022 14:17:36 +0200
Message-Id: <20220429121739.28584-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert the krait-cc and the kpps-acc/gcc Documentation to
yaml.

This series comes form a split of a bigger series that got too big and
now hard to review.

While they are still more or less wrong and doesn't really reflect real
driver implementation, they are converted to prepare for a fixup later
when dts and driver are finally fixed. For now make a 1:1 conversion.

Ansuel Smith (3):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
  dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 94 +++++++++++++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 63 +++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 ++++++++++++
 6 files changed, 216 insertions(+), 127 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.34.1

