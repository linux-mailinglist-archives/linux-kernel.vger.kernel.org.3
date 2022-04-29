Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437B3514963
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359200AbiD2MfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359142AbiD2MfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:35:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDAC8BCB;
        Fri, 29 Apr 2022 05:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECBE0B83512;
        Fri, 29 Apr 2022 12:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50100C385A7;
        Fri, 29 Apr 2022 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651235501;
        bh=exjKm3VFVKzVcumY92xZaKOxxHTCyDMi2gjz1DFJ8rI=;
        h=From:To:Cc:Subject:Date:From;
        b=fEVj3LnRk4lpWxmpWy999am5gzNGlO8qKegbzHsH+//u6y0djwIHdkjluyMUX9JrV
         HF3X49/Mag5U/1atxeTQgCYNO1zkGoIw/Ws+76Mk/narioQwQktdkDV2IF8WGnTbOE
         QUjuL+GF43eLDcUDF/SId3MOE8J8kmIiuB9rRjl5ufQbrDUygLkCoC6qJLDM2mtSvX
         BikcctCmr3NSJC5C1B0JFtDBuqDqjWHU2UYYED1aAabNk4PfsQWPQJsqO5vlbK74Lq
         kCQsoFBB0pKKFmhVaKTSRUEgnb2s3ZiIdfr1iglryq/Wq+RJmZVpOesY22KL7EUEpB
         GJhTiJFurpD+g==
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Delete MT8192 msdc gate (was "clk: mediatek: Delete MT8192 msdc gate")
Date:   Fri, 29 Apr 2022 14:31:30 +0200
Message-Id: <20220429123133.28869-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>


The mt8192-msdc clock is only a single clock gate. This gate is accessed
from the mmc driver directly. With
4a1d1379ebf6 ("arm64: dts: mt8192: Add mmc device nodes")
the only consumer of this binding was deleted. Delete the binding
decription and the clock driver bound to it.

Changes in v2:
- Delete compatible in binding descprition as well
- add Reviewed-by tag

Matthias Brugger (2):
  dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
  clk: mediatek: Delete MT8192 msdc gate

 .../arm/mediatek/mediatek,mt8192-clock.yaml   |  8 -------
 drivers/clk/mediatek/clk-mt8192-msdc.c        | 21 -------------------
 2 files changed, 29 deletions(-)

-- 
2.34.1

