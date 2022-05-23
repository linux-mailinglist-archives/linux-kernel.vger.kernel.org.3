Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBC530E33
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiEWKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiEWKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BF403E8;
        Mon, 23 May 2022 03:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75544611E3;
        Mon, 23 May 2022 10:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C4C385AA;
        Mon, 23 May 2022 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653301426;
        bh=RKbhgRnFKOvcisV3ozO+bwt7WBkGZfXPEVSqBRPTwl0=;
        h=From:To:Cc:Subject:Date:From;
        b=MDRR+57dQIAYgbRtJ8m+9znwxcwJ94g+YoVvJ6g5GIMJubu5S4asMBLg9evoNasU7
         DJALQ0fCZbumlYu7Rls1Hv2rCWrpJN8LxkR88n1OaHy3u9ZYs3iWbvWEqhP5ZGYWKy
         KhJ36Ha3UHngZKhecbUGM69croNzM3esqKguhXep0lleY6d4AZsvPLPq5XW1fso/ys
         KV5rdDgkNoZxdi5MQOOaGB4pUEZlQqYwfoY/W7YTjpFdy0BqtCM8HWbI2FpG3CBZfA
         QOK45yK2MNYTi0EeBUUKz0WtnZxSYl7fpsVAKtWXydnknbl3FjYWIGHal5UVWYk8gL
         YW4c3OHrJU1mw==
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
Subject: [PATCH v3 0/2] Delete MT8192 msdc gate (was "clk: mediatek: Delete MT8192 msdc gate")
Date:   Mon, 23 May 2022 12:23:37 +0200
Message-Id: <20220523102339.21927-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v3:
- Update commit message to explain better why we do ABI breakage here
- add Reviewed-by tag

Changes in v2:
- Delete compatible in binding descprition as well
- Add RvB tags
- add Reviewed-by tag

Matthias Brugger (2):
  dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
  clk: mediatek: Delete MT8192 msdc gate

 .../arm/mediatek/mediatek,mt8192-clock.yaml   |  8 -------
 drivers/clk/mediatek/clk-mt8192-msdc.c        | 21 -------------------
 2 files changed, 29 deletions(-)

-- 
2.36.0

