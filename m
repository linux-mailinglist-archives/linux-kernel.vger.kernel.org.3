Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFA4491310
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiARBBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiARBBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:01:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B132C061574;
        Mon, 17 Jan 2022 17:01:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j7so24188037edr.4;
        Mon, 17 Jan 2022 17:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMbUXnlXrYfrptT0mf0bThPWAfEsSUq23gTPVz2dBvA=;
        b=fnj1lMLP0tFz0HACv2eaJP3YXmDx9xFeDYq+r2Nr81ymAxtayXX8mEIzlB8sAig4bj
         T1xtW+x6xl5LVWCrgv3RpGr1LTslapiCpYullIn0udcqyiuvQRFF+cOnT6fD5Rs4MDtN
         eDaMLkedWv5LiFNoD8x/BSMTww+QlFGWja5AXw4zUZaiBzFOlpXsC8X5Oit/jULlGqHW
         rUlxo//07UdSavuzUXYqcDd1pn4+eCGZae5YZDq89o4XPA4f5e0E1n29a2TSxxAZCPMc
         AWQpfHPS0kwg5PbF7NlsVaq1nw7JA6mrEDlF7OoyV2g7oDH0QFYcmXkJ/mhXutqZ/Ahm
         Rg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMbUXnlXrYfrptT0mf0bThPWAfEsSUq23gTPVz2dBvA=;
        b=n4QZYcmhWuwxwVtOqg/qkVHzJcOtLhfMYrJHkYKPsQE2wWcA0iZRXSiihJ3Esntj+g
         dyB5VOJ4Z6f59pfr2azjc1ityVOKWIJ9ui+dZbJS/3qxuSIZwtOnj8eOFrm7ZKA0OcIL
         VtVH+O9VsOKv78JX8WU8nM8BiKOYIuOJaLuZazHTugdwi+Wh0QJw7zkMZTCkOhWM5naf
         F98MkWOzG8LdsY/P8pQfY8hZSy7mY/Ce4H3Pm8tCDXEB8u42crWfKoEisl5pQouBz7HF
         mJOzLku7zVcgYA30Bd75iLWYSsAOBb83rOElahADlcCCA1FH5Tb+hgsYM9Urs2cGja1B
         imNw==
X-Gm-Message-State: AOAM530a5+E+ITjWWaPCKeuV1NWLx0j9GrFZYUMTdz5tHMsHdobIJOZa
        bNQ9DBNuAJE1l3NAmzBxnPQ=
X-Google-Smtp-Source: ABdhPJy4z/N0k/zpeMZUB8m0e+KV5FKi9gJ3kDCvlY/NNnMpli9f6fn2wOoWdzJH7zQ01luKeVSbZQ==
X-Received: by 2002:a05:6402:450:: with SMTP id p16mr6080138edw.113.1642467711956;
        Mon, 17 Jan 2022 17:01:51 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:51 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] Multiple addition and improvement to ipq8064 gcc
Date:   Tue, 18 Jan 2022 01:44:20 +0100
Message-Id: <20220118004434.17095-1-ansuelsmth@gmail.com>
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

Ansuel Smith (14):
  dt-bindings: clock: Document qcom,gcc-ipq8064 binding
  drivers: clk: qcom: gcc-ipq806x: fix wrong naming for
    gcc_pxo_pll8_pll0
  drivers: clk: qcom: gcc-ipq806x: convert parent_names to parent_data
  drivers: clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
  drivers: clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
  drivers: clk: qcom: gcc-ipq806x: use parent_hws where possible
  drivers: clk: qcom: gcc-ipq806x: add additional freq nss cores
  drivers: clk: qcom: gcc-ipq806x: add unusued flag for critical clock
  drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
  dt-bindings: clock: add ipq8064 ce5 clk define
  drivers: clk: qcom: gcc-ipq806x: add CryptoEngine clocks
  dt-bindings: reset: add ipq8064 ce5 resets
  drivers: clk: qcom: gcc-ipq806x: add CryptoEngine resets
  ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064

 .../bindings/clock/qcom,gcc-ipq8064.yaml      |  67 ++
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |   8 +-
 drivers/clk/qcom/gcc-ipq806x.c                | 652 +++++++++++++-----
 include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
 include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
 5 files changed, 567 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

-- 
2.33.1

