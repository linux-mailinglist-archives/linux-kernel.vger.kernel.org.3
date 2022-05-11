Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0352385B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbiEKQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243534AbiEKQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75F2317D;
        Wed, 11 May 2022 09:16:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g8so2409189pfh.5;
        Wed, 11 May 2022 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/F+UplkDIwqCQhOSjnvO6kFNp+CMNMp/7h16RlfZuc=;
        b=M9+x/J4LgddCI29gHcE13YurFaETXEOT6sVdzKPRVZaJPBrqp4ZsdDBOWNcJ76311y
         U3gpILNCWwFREbHgftBraQ4HgDb7qfkbfslboYuvzxnbzD10EcGcpiCArA9cw+xL+wp/
         HtTra6bcLKBP2VwZF3EpUsyTnJdJToQpIAIdDHpGHGw65salxriXUB57IHitxKpbWRnJ
         j4pZYkEwkiwvX8QLjmOSNwxXTniybWYlBLKmW5ApkxUU1P/zwBBLWmu0zT82kGAi8zdV
         lfy8xRRjMjl2ld83wW5wQwS0VhRdL5OSCwb4WBt22eKRbhxatW1V0OJ+/OPSmEXXVzU2
         TUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/F+UplkDIwqCQhOSjnvO6kFNp+CMNMp/7h16RlfZuc=;
        b=AT9LntQOlGtAUdYvFWPu8GiumbNHbbwJ19qkcbZzxHPNczfjC1iO0mzNOieUjGd5xJ
         /LWaPg5/nksgD9uWDE6Sbz5ewyBFTf+zAoha36vajDuAtHxCAK2KqoJhcbpcGD/GpeW+
         NIJKJikln18C36lhyLKQtLrdI2rudhEnrv9LQqof1QnscTnHRzd5pHOu4wrQ/+0ARw39
         usZhmBAX0vOVcvIfJoFG6jbd09NIKG7puu6F8dR8hdtrze0rVAnU5ys84F5jp5mzB+U1
         XHa/2Q9W9C3awqhluIgCM+BEd94JRd202OzN/2zWmBQNr+dN4UoI6XIfqjbnjGEFBSj8
         0ToQ==
X-Gm-Message-State: AOAM533sSc9p+P4NvuiyejiibkaeRhuNwQwugdKiv2X0TOyVGCBFvpWm
        NjJJVA5kvc9raJeOcToFEPn3cVg8dB4356k7
X-Google-Smtp-Source: ABdhPJzO1qvU1JiGX6Brj/VPaJ5dul5SDjo8MFHaHCLX0a1jwpw0M2DCKL4vV6DasdU5wPPTg6yi2Q==
X-Received: by 2002:a63:6981:0:b0:3db:1a89:8849 with SMTP id e123-20020a636981000000b003db1a898849mr4093377pgc.505.1652285777491;
        Wed, 11 May 2022 09:16:17 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:16 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH 0/9] Add support for remoteprocs on the MSM8953 platform
Date:   Wed, 11 May 2022 21:45:53 +0530
Message-Id: <20220511161602.117772-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds support for the audio DSP (q6v5_pas), modem
(q6v5_mss), and WiFi (wcnss-pil) subsystems found on the MSM8953
platform. Device tree bindings for MSS and WCNSS have been converted to
YAML. The relevant nodes have also been added to the MSM8953
device tree.

Sireesh Kodali (8):
  remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
  remoteproc: qcom: q6v5-mss: Add modem support on MSM8953
  dt-bindings: remoteproc: qcom: wcnss: Convert to YAML
  dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
  dt-bindings: remoteproc: qcom: mss: Convert bindings to YAML
  dt-bindings: remoteproc: qcom: mss: Add MSS on MSM8953
  dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953
  arm64: dts: qcom: msm8953: Add remote processor nodes

Vladimir Lypak (1):
  remoteproc: qcom: qcom_wcnss: Add support for pronto-v3

 .../bindings/remoteproc/qcom,adsp.yaml        |   5 +
 .../bindings/remoteproc/qcom,q6v5.txt         | 302 --------
 .../bindings/remoteproc/qcom,q6v5.yaml        | 727 ++++++++++++++++++
 .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 -----
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 230 ++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 378 +++++++++
 drivers/remoteproc/qcom_q6v5_mss.c            |  64 +-
 drivers/remoteproc/qcom_q6v5_pas.c            |  31 +
 drivers/remoteproc/qcom_wcnss.c               |  13 +
 9 files changed, 1442 insertions(+), 485 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

-- 
2.36.0

