Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D540515D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382661AbiD3NNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiD3NNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:13:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6ED8233A;
        Sat, 30 Apr 2022 06:09:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j6so20071930ejc.13;
        Sat, 30 Apr 2022 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VClD0JjqJ1dznREBaWcLhhbC2kgnGB54hOnuclDNuXE=;
        b=dHMEMmRpPmDTZ+NUoESXs/J0Az6QpNHY07JLGg+z55w3pfmyq7vq3TJ7HabuouYYTx
         CFxOlUhGB1NwL1dfnpwNOdbKZSa5IEXmus29LAiXBZ829bMl8qPFD69tvPwtTHENQCUN
         0fa6+KRGx4wpssjqDSu4lLKTm/6AcU5y9f5cVR8yEG3d942GnUcYx8VbmTci0tWuoGdS
         iKtthtjsm4nnMDSrSd63Ben0HAmCcViKYDiG5s/vvLRR1Koy0Rv7NLUY9L5SdGbG69bw
         ZdTqu/dKv2lxGjavZdEBxCKFuZ14qnWBLZ8CqoFyGeziVJsXLjiIS18/Dk1v0XPvnY2N
         HZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VClD0JjqJ1dznREBaWcLhhbC2kgnGB54hOnuclDNuXE=;
        b=dN5zexcG/gGL7rLapWx4g0wWmWg9Y0moECMNHKhwyJ9FC5ZM9n1yZWzoz4nGKhU1eT
         6jUpWpsqo7lfuCSsxNXoAxLKK+YYmueNuQnQ5Xp+37h1MH8nQjtctrwi7OWG1gwy+6NJ
         dzMZrKsO/imjfyTf8olTLzk8fPzUnkruH/EWXPsgQpZ+paDbd6tJ683z1qfUYao9pehM
         gFPhR0yOwlQuG2MKVEn+LpZm5cF9j4pc08czecYpakCChkSN4OhVqz0iGbnF8pmYKZ93
         NOEcnq2vg2iVlESBA1c63nYTZSLiWtj+FIwMsjqtK7MlmFG6tFIq3O7pdioGAgxUUdI8
         58wg==
X-Gm-Message-State: AOAM530HYrtPib4fdq5LOobI25UdMhRKA4XkjZDgPvOwOI4EgB1HrHDz
        bWSCrVXtpK10KJ4SkQ/aEcI=
X-Google-Smtp-Source: ABdhPJzBH5FHq2LwEjZGYkMaRJgWhWTcjz2zF5r9KGv55Vx5SLKmIBlOtmikrJLX/krVt9D0cCR6qA==
X-Received: by 2002:a17:907:3e0d:b0:6f4:1e55:da55 with SMTP id hp13-20020a1709073e0d00b006f41e55da55mr2095690ejc.219.1651324186962;
        Sat, 30 Apr 2022 06:09:46 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u5-20020a056402064500b0042617ba63a0sm4142404edx.42.2022.04.30.06.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:09:46 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 0/3] Krait Documentation conversion
Date:   Sat, 30 Apr 2022 08:01:22 +0200
Message-Id: <20220430060125.9124-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
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
The only change is an additional binding for the kpss-gcc Documentation
that require the #clock-cells when clock-output-names is used.

v2:
- Fix bot error by adding missing #clock-cells

Changelog for previous series "Modernize rest of the krait drivers"
that was split to smaller series (only Documentation changes):
v7:
- Rework kpss-gcc Documentation (split patch for pure conversion and
  tweaks)
v6:
- Address comments from Rob
- Fix warning from make dtbs_check
v5:
- Address comments from Krzysztof
v4:
- Fix more dt-bindings bug errors
v3:
- Split Documentation files for kpss and krait-cc
v2:
- fix missing new line on patch 16 (krait-cc patch)

Ansuel Smith (3):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
  dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 94 +++++++++++++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 ++++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 ++++++++++++
 6 files changed, 221 insertions(+), 127 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.34.1

