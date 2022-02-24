Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6844C36FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiBXUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiBXUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:44:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D8223229;
        Thu, 24 Feb 2022 12:43:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v21so1466956wrv.5;
        Thu, 24 Feb 2022 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mEAhCuaoIV97HkaNZsbX3GrLl1sFLr/guPaKUww8zk=;
        b=XBSTKnii7pne83sl4EOwkUH+qmSYWuvljSq0VDcy3BDLokCeN+6hkZNT9e38hBTGsP
         RAOVxTHu2TfEAsI4Rriac8Z3DwsmO5VKWF3F3HNPtFolheTq45IFK0hB6aBId77KAzKd
         NJuUEGOK78JKvFeYurfXnjvteGMp1ORo58GZxxrHiWyfs8imluue0/FO1Y/B0A+zUh5R
         mktCXbj7KxxaKX6wpAhsJpdEk18nEOxJbQw+IL+MPDNs/oD8lTkj9YZ+Qk24GpDWI4Ra
         i3fjzI8vqx63FRuW4GmVdCABQXth3swrr6/OA/UOmor02/LAkmAVWoPcWfFVQVC7L6RK
         P6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8mEAhCuaoIV97HkaNZsbX3GrLl1sFLr/guPaKUww8zk=;
        b=nrUyf2jGlpue5GqGIgAmqGXk9c5gM+98f7kVuj17oRpmdv1lZM1w+ZKWFKv4TGbrj3
         qPRGmXKkcv29Cix1YtBTmQfb7EU4TWiwWrX8jGmpZmGTnaaGli06c5xCQt6quGoYmj37
         WEkAflcMZl8AgZhVj3+b/zBULV7pPmydG0e2cTRYTSMNYxkAhEp4LAxEI6lOtnxgqHW8
         rq5wmO3jlWmBiP894EEt3/eRwbuCPh6ob5LY0LAwK4rBssPSXtoveBD+7XwcUsWvKiMb
         YiwOACusrMNtsrfZhO0J/xeEWNUl9TVr+sxFPihKxNx3loNHcbTtteBaCACpA+1CXFFf
         cWoQ==
X-Gm-Message-State: AOAM533qCgsZDKYrgwAvMsa9KvhlJNPr3Omkdm4LQwjoPuEJ8LX3+3Ea
        bF1JB6E+KngT5HzrmBFp5pYMIr8ELo8=
X-Google-Smtp-Source: ABdhPJzMAagSggYy4WRygZLfpIMu4jSRj8gs5smPqP5WkjJh9CF9wqplrzLNfwTbO2nyAnnxBMH3/Q==
X-Received: by 2002:adf:d1e3:0:b0:1ea:8085:b371 with SMTP id g3-20020adfd1e3000000b001ea8085b371mr3701073wrd.541.1645735429126;
        Thu, 24 Feb 2022 12:43:49 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b001e3139a79f9sm363599wrv.40.2022.02.24.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:43:48 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [GIT PULL] memory: tegra: Changes for v5.18-rc1
Date:   Thu, 24 Feb 2022 21:43:46 +0100
Message-Id: <20220224204346.2218994-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.18-memory

for you to fetch changes up to 572f08c0fd75aeb9a1c50a8fba887fdbf911eeee:

  memory: tegra: Add APE memory clients for Tegra234 (2022-02-24 21:38:25 +0100)

This contains the two memory controller driver patches that we talked
about earlier as well as the necessary dependencies to make these build
properly. I expect that for v5.19 we'll get a bunch more patches for
this driver, so having this in place should make things a bit simpler.

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v5.18-rc1

This contains the initial memory controller driver bits for the Tegra234
SoC as well as the addition of APE-related memory clients.

----------------------------------------------------------------
Akhil R (2):
      dt-bindings: Add headers for Tegra234 I2C
      dt-bindings: Add headers for Tegra234 PWM

Mohan Kumar (2):
      dt-bindings: Add HDA support for Tegra234
      dt-bindings: Document Tegra234 HDA support

Sameer Pujar (2):
      dt-bindings: Add Tegra234 APE support
      memory: tegra: Add APE memory clients for Tegra234

Thierry Reding (2):
      Merge branch 'for-5.18/dt-bindings' into for-5.18/memory
      memory: tegra: Add Tegra234 support

Vidya Sagar (3):
      dt-bindings: Add Tegra234 PCIe clocks and resets
      dt-bindings: power: Add Tegra234 PCIe power domains
      dt-bindings: memory: Add Tegra234 PCIe memory

 .../bindings/sound/nvidia,tegra30-hda.yaml         |   3 +
 drivers/memory/tegra/Makefile                      |   2 +
 drivers/memory/tegra/mc.c                          |   3 +
 drivers/memory/tegra/mc.h                          |   7 +-
 drivers/memory/tegra/tegra186-emc.c                |   3 +
 drivers/memory/tegra/tegra234.c                    | 101 +++++++++++++++
 include/dt-bindings/clock/tegra234-clock.h         | 135 ++++++++++++++++++++-
 include/dt-bindings/memory/tegra234-mc.h           |  75 ++++++++++++
 include/dt-bindings/power/tegra234-powergate.h     |  22 ++++
 include/dt-bindings/reset/tegra234-reset.h         |  45 ++++++-
 10 files changed, 392 insertions(+), 4 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra234.c
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h
