Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB94E9994
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbiC1Oc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243855AbiC1Oc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84A43384;
        Mon, 28 Mar 2022 07:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18D2B61222;
        Mon, 28 Mar 2022 14:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0409CC340EC;
        Mon, 28 Mar 2022 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477844;
        bh=5K7/qIjnjqYdbN5bggJoUjEf4uI3u4+9dChj8f8kMnY=;
        h=From:To:Cc:Subject:Date:From;
        b=Jl5E8ylouWyFlDG88PeHGTNQzZKLLr6leOvSGuu/GaIDQagWjeVPn771cTsZDvIHE
         +mFOqgbc5am68K/Yc6dvyNftHAk9caOeRq3qt1iYYaW1FTIpBhuW6DcEwPamGaV25g
         T5KhagmxcKImoZmkThwSK2Br6s2isxydV8MQaeHrRGB3mtENIidb3hsBduDs2x1FlZ
         MJfHZw5E3Adge4vzZzSnTgXiVxHtz2Fw7FaOx+mN0ru/uVaNDoe0sedYaALQPdvSh0
         SyLzJrFeQhdoiLoYaP6jcKAOdQuRMwcG7X6WQiqzSyWwsM36ugebXaervqE2MY5HZe
         SqwkJGPYIJ/Bw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: dts: qcom: Get rid of some warnings
Date:   Mon, 28 Mar 2022 20:00:29 +0530
Message-Id: <20220328143035.519909-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attempts to make W=1 free from warnings for all SM* dts files.

Bunch of these are releated to node not having valid unit address and being
present under soc node. So moving it out fixed that. Interconnect node was
simple rename to remove unit address which was not really valid for these
nodes.

Vinod Koul (6):
  arm64: dts: qcom: sm8450: rename interconnect nodes
  arm64: dts: qcom: sm8350: move qup-opp-tables out of soc node
  arm64: dts: qcom: sm8250: move qup-opp-table out of soc node
  arm64: dts: qcom: sm8250: move sound node out of soc node
  arm64: dts: qcom: sm8250: move wcd938x node out of soc node
  arm64: dts: qcom: sm8250: remove address cells from dsi nodes

 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 +++++++------
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 50 +++++++---------
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 76 ++++++++++++-------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi    |  4 +-
 4 files changed, 81 insertions(+), 89 deletions(-)

-- 
2.34.1

