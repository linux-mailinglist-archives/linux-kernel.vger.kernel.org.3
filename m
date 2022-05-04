Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710151B111
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378821AbiEDViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378650AbiEDVgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:36:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED55131A;
        Wed,  4 May 2022 14:33:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 695F81F44BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651699980;
        bh=jvWlCqU5BM5uSfYkfGx9KIBVQnJo5rwQWZiOEIDmon8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdPuIIeZWYeMSIgJd1Opz7ab7G2fZdI/z0515K9zE6Cxp51bWVmcTBn4XUY7wYzWb
         Fa7/oLxckC7J1pW7p/Syb5ZEJPPel+FGbXjrLC9egcj1s862t/+EtItN/CYPo0IbQ9
         ytXOM1Pa8fxrrb73gSTR26UGTPrQHUCjsf4m/q8/UPgWNZM+sZTZaGfi+NlBw7vIby
         odk8yJ+RM1E/uOB/pJgYqtBPw32Se4gkONQ+Lhtp4BZVoVSLWVqo57oI+rFCOzM/CX
         O8lHJp84UZX+LhJ7lW7PLKbQz7YhM/SbXHboqEfI8qH3Tz+POotft66+BgoxCgveAr
         hocrE8MtVAMug==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 573344819D6; Wed,  4 May 2022 23:32:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 17/21] dt-bindings: gpio: rockchip: add gpio-ranges
Date:   Wed,  4 May 2022 23:32:47 +0200
Message-Id: <20220504213251.264819-18-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504213251.264819-1-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
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

Allow usage of gpio-ranges with the rockchip gpio controller. The driver
already had support for this since it has been added to the mainline kernel
in the first place.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index d4e42c2b995b..affd823c881d 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -27,6 +27,8 @@ properties:
       - description: APB interface clock source
       - description: GPIO debounce reference clock source
 
+  gpio-ranges: true
+
   gpio-controller: true
 
   gpio-line-names: true
-- 
2.35.1

