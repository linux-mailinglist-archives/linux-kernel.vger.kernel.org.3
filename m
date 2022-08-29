Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9E5A57EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiH2XrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiH2Xql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9ACA4058;
        Mon, 29 Aug 2022 16:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9746EB815CE;
        Mon, 29 Aug 2022 23:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E94C433D6;
        Mon, 29 Aug 2022 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816791;
        bh=5UxpWJxqZwILUXZUt1KNjnP6PxOHT95HX5+3o9Vcyko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFZzTO4Yta50VhXlW3JPq3Bl09BBtSCKdHw9N9JQRRZOAkb9RjJWuNpnBh4YVbf3x
         tJnb4WWmskbKqfZDp881Cp6ecABp6vlVN595oxjkxcrA+Af9meKBVTjqQE5GVKd+px
         Y4LIP6e3j00VkriLxDQvpbKCiRJ8NWOeVg+EP6eBj2WtWajbjNcSTLFWdIoNBN6swy
         H2ai1hnSfoiZJittBqGsv8G4jW9qS1WQd8QHN7ukiCIqFji7cWXBsgxTZy2+sbgglP
         XZ/wmRh/onvRi0TueuuxrhH9y/z6nkaK9+sUtTaJBXXTkDaIUZR6SmHHZYRV73vxLZ
         nPtBC3Xa+LYMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        martin.botka@somainline.org
Subject: Re: (subset) [PATCH v2 1/5] dt-bindings: arm: qcom: Document Sony Xperia 1 IV (PDX223)
Date:   Mon, 29 Aug 2022 18:45:53 -0500
Message-Id: <166181675960.322065.16076194643868486800.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Thu, 14 Jul 2022 14:34:02 +0200, Konrad Dybcio wrote:
> Document the compatible for the PDX223 device.
> 
> 

Applied, thanks!

[1/5] dt-bindings: arm: qcom: Document Sony Xperia 1 IV (PDX223)
      commit: 4277c839a1395072f4c8fd07f9ca52b4f770068e
[3/5] arm64: dts: qcom: sm8450: Adjust memory map
      commit: 2fb19263442dda351e8bc2f6bd71f5a355971f1a
[4/5] arm64: dts: qcom: sm8450: Add SDHCI2
      commit: 20e8f1ee8d2729589cd2c0b4a13df753667d6930
[5/5] arm64: dts: qcom: Add device tree for Sony Xperia 1 IV
      commit: 0a631a36f7244d56fffcd0dd5bc473cf14571970

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
