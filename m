Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50224757E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhLOLiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhLOLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:38:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF08C061574;
        Wed, 15 Dec 2021 03:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7A7E0CE1CAB;
        Wed, 15 Dec 2021 11:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCC4C34605;
        Wed, 15 Dec 2021 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639568292;
        bh=f5ntzzaFhGAIVxebpq7bXFC+HmDxjS0rudW0kLZ6xZM=;
        h=From:To:Cc:Subject:Date:From;
        b=SqX70SpNteWYrxo6NuM+BH4mL+fCigNoyIr6mRBKaGz5WZYTKCBKJL26fav9jVheq
         4/N7htoh8A+F1upbTCKd38gQBJftVfYGz/mbLn//ND0lG8DsTYDP37iacCG4lGIfqV
         1LD4GeN0cLDcK+KWjabo2SPgh1UhnB9QUiNMjUPubnnrhCVmfE9o9LbsnSXyP2VxX4
         Gfbl9gAYHguu5WU6j6rz+OCClbDYnHeWQ+o07GnpvotvFZwddptkfnAbTFC7vsqzLp
         MbP+C5XwumiI0dMQm/bLojYJ2AbY7Wa48k01U28rnNnnsY7DPC0z5wuKB2Zsg8B9Fn
         ENOT8ziOgyhmQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] clk: qcom: explicitly include clk-provider.h
Date:   Wed, 15 Dec 2021 17:07:55 +0530
Message-Id: <20211215113803.620032-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As disucssed in [1] it is a good idea to explicitly include clk-provider.h
for clk providers, so include this in rest of missing qcom clk providers.

[1]: lore.kernel.org/r/20211209082607.06929C004DD@smtp.kernel.org


Vinod Koul (8):
  clk: qcom: gcc-sm8350: explicitly include clk-provider.h
  clk: qcom: gcc-msm8994: explicitly include clk-provider.h
  clk: qcom: gcc-sm6350: explicitly include clk-provider.h
  clk: qcom: lpasscc-sc7280: explicitly include clk-provider.h
  clk: qcom: lpasscc-sdm845: explicitly include clk-provider.h
  clk: qcom: mmcc-apq8084: explicitly include clk-provider.h
  clk: qcom: q6sstop-qcs404: explicitly include clk-provider.h
  clk: qcom: turingcc-qcs404: explicitly include clk-provider.h

 drivers/clk/qcom/gcc-msm8994.c     | 1 +
 drivers/clk/qcom/gcc-sm6350.c      | 1 +
 drivers/clk/qcom/gcc-sm8350.c      | 1 +
 drivers/clk/qcom/lpasscc-sc7280.c  | 1 +
 drivers/clk/qcom/lpasscc-sdm845.c  | 1 +
 drivers/clk/qcom/mmcc-apq8084.c    | 1 +
 drivers/clk/qcom/q6sstop-qcs404.c  | 1 +
 drivers/clk/qcom/turingcc-qcs404.c | 1 +
 8 files changed, 8 insertions(+)

-- 
2.31.1

