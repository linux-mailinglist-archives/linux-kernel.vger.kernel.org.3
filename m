Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A094966C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiAUVDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiAUVDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E891C06173B;
        Fri, 21 Jan 2022 13:03:52 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p15so3327659ejc.7;
        Fri, 21 Jan 2022 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5rstHin1kw6kgXvm7+bH6Fbg4Ln/NveudB174otKCU=;
        b=oDnXoI5HZ2FD3zmgkb1g+wnyX1nDEvet/DJ6NoZLQa464G3N83smvJBMAzC44UptlR
         7XUfIO5ot7Bb7X1eQLMqfYrHfhaqpMlhPo0snEVG+zSlPLwQeM235Lpur0vXwxg6JWHv
         LsLAboNyHo/5Z75H6w/saM5TCVjEFfxXCce8eFAqhHO6ou/ER6JL4nefe91Be9OzJXfh
         R+W3rc5P4VAx07CPLE28INBpaUoIlsq6Hs3dGyDL1KiCYwILKRWrA6KXEHUuDW3/Z5uz
         5CHxStT7RTcLNlpvpd9RQaCcttGD+znQONNVBMrQ9rmAZv5RRy+m46ijGxOqZvXWiIWU
         Dl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5rstHin1kw6kgXvm7+bH6Fbg4Ln/NveudB174otKCU=;
        b=Js6XO6ch+OlPS/nv8y6EvZnV+XF41Vz7CTNqwy1hc3160iFq6FdA0zIo5BRvGk9/Mk
         IREYGSfJo3FKq4D7R7w2LS4Wa8S+HizFSUYllzwj944bPeaZDZYLAnPSQ4rCfCUgYwz5
         NboQ8DIwOqOnLdKHXWZYW+ON+5kBxz1j+ydwzlkjeybqBe7Nt+XnlS4osPKNjlntTrRw
         fMwumvwOQvql9xV4yMBakNGMsMQNKEbrre33kkVLCMZhzSKLotp0I7vLw87ifzeOYGWJ
         mZKhH+9IebX93IV5j7+5HlqmcL6Th+WOQucyIvgpoKLrGadmtJwqN6r7Du4pNMjSFdDP
         b4ww==
X-Gm-Message-State: AOAM531ZQ8+GjpuwvHORDt0IdAQFPirAaG8GiLNEcUDR6GIuF0WNg1Uj
        etZY00cwHu+NI/bt9t3jbtI=
X-Google-Smtp-Source: ABdhPJyzcBV/4K6CB90XZPXGQiWG0UMeA75+/J8qi9N26HAgafq+vJQgjkN/0evm9ycT0K4SRF1XLw==
X-Received: by 2002:a17:906:e282:: with SMTP id gg2mr4857545ejb.607.1642799030387;
        Fri, 21 Jan 2022 13:03:50 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:49 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] Multiple addition and improvement to ipq8064 gcc
Date:   Fri, 21 Jan 2022 22:03:25 +0100
Message-Id: <20220121210340.32362-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt in making the ipq8064 SoC actually usable. Currently
many feature are missing for this SoC and devs user off-the-tree patches
to make it work (example patch for missing clock, patch for cpufreq
driver, patch to add missing node in the dts)

I notice there was some work in modernizing the gcc driver for other
qcom target but this wasn't done for ipq806x. This does exactly this, we
drop any parent_names stuff and we switch to the parent_data way. We
also drop the pxo and cxo source clk from gcc driver and we refer to the
dts for it.

This also add all the missing feature for the nss cores and the
cryptoengine in them. It does also introduce the required flags to make
the RPM actually work and NOT reject any command. There was an attempt
in declaring these clock as core clock in the dts but this ends up in no
serial as the kernel makes these clock not accessible. We just want to
make the kernel NOT disable them if unused nothing more.

At the end we update the ipq8064 dtsi to add the pxo and cxo tag and
declare them in gcc and also fix a problem with tsens probe.

v3:
- Rework Documentation with Rob suggestions
v2:
- Fix error from Rob bot.
- Add additional commits to make qcom,gcc.yaml a template
- Squash parent_hws patch with the modernize patch
- Create gcc_pxo instead of using long define.

Ansuel Smith (15):
  dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
  dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
  dt-bindings: clock: Document qcom,gcc-ipq8064 binding
  drivers: clk: qcom: gcc-ipq806x: fix wrong naming for
    gcc_pxo_pll8_pll0
  drivers: clk: qcom: gcc-ipq806x: convert parent_names to parent_data
  drivers: clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
  drivers: clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
  drivers: clk: qcom: gcc-ipq806x: add additional freq nss cores
  drivers: clk: qcom: gcc-ipq806x: add unusued flag for critical clock
  drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
  dt-bindings: clock: add ipq8064 ce5 clk define
  drivers: clk: qcom: gcc-ipq806x: add CryptoEngine clocks
  dt-bindings: reset: add ipq8064 ce5 resets
  drivers: clk: qcom: gcc-ipq806x: add CryptoEngine resets
  ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064

 .../bindings/clock/qcom,gcc-apq8064.yaml      |  29 +-
 .../bindings/clock/qcom,gcc-common.yaml       |  42 ++
 .../bindings/clock/qcom,gcc-ipq8064.yaml      |  76 +++
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  31 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |   8 +-
 drivers/clk/qcom/gcc-ipq806x.c                | 638 +++++++++++++-----
 include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
 include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
 8 files changed, 615 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

-- 
2.33.1

