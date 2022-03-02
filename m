Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8797E4CB0FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiCBVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbiCBVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C439DCE2B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1229511wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4ln3wZSFy5ygWivBAZ51NJDAFnU2GvQHlM0R2GzsJk=;
        b=bJIL0p9pOk2OYxkv4MgssHYy583tVP3qI9kh5i+J6fdhzIZaUQ6qV4dRNmXg2nOoAV
         xGSU6184/6Papd9QxDjUVh2EMscFRMunogHDJshyMBup66uO0h5hs7IC5zmLDZhfDRVz
         u6jvoIYBvzLyRZ9Pd89jakr/6bSunhJdg+6Msfz/2kbIOIjmQ3281yto6xsdt/h1k1w5
         zvwxgHvW3BzdVIi2abn69Ple0W+TStSeOSdyRVYxOjxZvmlT0YVbGPsLq0tH98fmrEmY
         gwKLmyNEPJVwBI+CR/4UeH9aFBn09hn35MDX8HI3/mPBpEW+jJD+dry/n78x1rZ+YD+v
         9eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4ln3wZSFy5ygWivBAZ51NJDAFnU2GvQHlM0R2GzsJk=;
        b=SeJGlmIR8otujSjhC8xixi2PRb0avuJm8cp/PssNlgP8xqHXrdylsJ3mfQexGdnvsy
         iIB6xS9Z0WILa8jYazgxycLyFid7LdlEDvbe4cFcAe0UKe37A4AZvMNyHYwMrqBTrDb8
         CNsjPAIF/b6mVlxpX1/x0YafRB8TFyiLMFnEjY2r05z3GdmIbgwNqK8PSh/v3SkQB6q8
         r1wOgXUJopZ2uSbfInNY7HxTfOMoZE4ZBvmRheLQlEkEheCrChh8oGebTO+rSrk1ijLV
         3oCzOKTmS93VBtquf31aB6Q8U70UNEHB0aq9Z2PibwLsKfLOK1f8xc1MCTGfTqtjTxa7
         gRKg==
X-Gm-Message-State: AOAM533zILHCCh/WDfHL/Ll2bw4dUJJC4p8Ndhd2cOEcTwkeZwjruEGM
        HuTL51AqXL1BHdQWq+IF4eYgIA==
X-Google-Smtp-Source: ABdhPJwJBTQ00m+t9wxyzB1cXj8n/0LaZCqu4MpcCdI94b0Fd6Skv6Vca/UH6uS9c3TZZ8GgpF704w==
X-Received: by 2002:a7b:c455:0:b0:380:a646:eb0e with SMTP id l21-20020a7bc455000000b00380a646eb0emr1350654wmi.170.1646255481699;
        Wed, 02 Mar 2022 13:11:21 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:21 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 00/18] crypto: rockchip: permit to pass self-tests
Date:   Wed,  2 Mar 2022 21:10:55 +0000
Message-Id: <20220302211113.4003816-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The rockchip crypto driver is broken and do not pass self-tests.
This serie's goal is to permit to become usable and pass self-tests.

This whole serie is tested on a rk3328-rock64 with selftests (with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)

Regards

Changes since v1:
- select CRYPTO_ENGINE
- forgot to free fallbacks TFMs
- fixed kernel test robots warning
- add the PM patch

Corentin Labbe (18):
  crypto: rockchip: use dev_err for error message about interrupt
  crypto: rockchip: do not use uninit variable
  crypto: rockchip: do not do custom power management
  crypto: rockchip: fix privete/private typo
  crypto: rockchip: do not store mode globally
  crypto: rockchip: add fallback for cipher
  crypto: rockchip: add fallback for ahash
  crypto: rockchip: better handle cipher key
  crypto: rockchip: remove non-aligned handling
  crypto: rockchip: rework by using crypto_engine
  crypto: rockhip: do not handle dma clock
  ARM: dts: rk3288: crypto do not need dma clock
  crypto: rockchip: rewrite type
  crypto: rockchip: add debugfs
  crypto: rockchip: introduce PM
  arm64: dts: rockchip: add rk3328 crypto node
  dt-bindings: crypto: convert rockchip-crypto to yaml
  crypto: rockchip: add myself as maintainer

 .../crypto/rockchip,rk3288-crypto.yaml        |  64 +++
 .../bindings/crypto/rockchip-crypto.txt       |  28 --
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/rk3288.dtsi                 |   4 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  11 +
 drivers/crypto/Kconfig                        |  12 +
 drivers/crypto/rockchip/rk3288_crypto.c       | 307 +++++-------
 drivers/crypto/rockchip/rk3288_crypto.h       |  69 ++-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 222 +++++----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 452 +++++++++++-------
 10 files changed, 648 insertions(+), 527 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

-- 
2.34.1

