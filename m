Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C954E7135
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358863AbiCYKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbiCYKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:32:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A039C55A9;
        Fri, 25 Mar 2022 03:30:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 95DAF1F460E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648204251;
        bh=EiA1iDx9YmxE8MFwmqTLJfc1I076Y74pNJdixG290U0=;
        h=From:To:Cc:Subject:Date:From;
        b=RLRFeLfGDiY2fSDtenJv7SW8Npipip+CMwsDdOrTf1ABsLaGyTpLkM/9bBeZggOSm
         1XUBSWn8/cJ6AFZi8aY1YRe2QlCtM3S/Oy1SNq2iL/nV4MyrXz57FZysOyO7GZj3QZ
         PT4+4AGuVYmaNpESnvxkH42vZtTh2cHRhLcClVn8fJvc6vwvnZx10ZaBI+VvGX9reg
         paAgNwLxwDX1Il29OHoSC5uP8lDki9a96fT03OS+Gym1M9FkgdDzjxoJh7U/jIMyaM
         Iu/je90qHHAGDbJwhGR9E2UvUsN51lTZWxxfjpJGiuNYctzU81FTNmFM3r437dId63
         4XN08CCp/wvBQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 0/3] Add LTRF216A Driver
Date:   Fri, 25 Mar 2022 16:00:11 +0530
Message-Id: <20220325103014.6597-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ltrf216a Ambient Light Sensor
and documents the DT bindings for the same.

Shreeya Patel (3):
  dt-bindings: vendor-prefixes: Add 'ltr' as deprecated vendor prefix
  dt-bindings: Document ltrf216a light sensor bindings
  iio: light: Add support for ltrf216a sensor

 .../bindings/iio/light/liteon,ltrf216a.yaml   |  42 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/ltrf216a.c                  | 334 ++++++++++++++++++
 5 files changed, 390 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

