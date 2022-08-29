Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD635A57DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiH2Xq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiH2XqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5203898588;
        Mon, 29 Aug 2022 16:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 137B9B815D5;
        Mon, 29 Aug 2022 23:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A3FC4347C;
        Mon, 29 Aug 2022 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816778;
        bh=xznvRydovJXEQ3K49NVz9aT+6MbyeBeoOCDHZ6kheuU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HFRuDKdgN6UPY8zmmz9yELwbcX8cJNxT+xL3Khf0rp3y0gGjeEiD2ulRa5Lo4sm8b
         m66Cvp971KyEqGqC2Ry6/aUV0mtlzt0TYO+lLaUPaRxcHze3x7HFIJit1T/uaZRNZC
         AD8PQjSkKZYRbmz2D1x94uo94TKSvmuQCN0pKxa/m/yBxT1Abvo+B2v6h65/J2HQVU
         f2YfZfWGxdapkaprhuPz96Mb1x2PyNYR0jXh86GTuFYsgWm4s8wYP7sSaNBUGV3N4L
         oYg7Qqv/nIgTZ7507DiIAJeyQu0FyYgNdVlSKBo0iz7ZOkVDmI7s4uPUJ+1Autxwy4
         elhr51oOcrahQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
Date:   Mon, 29 Aug 2022 18:45:40 -0500
Message-Id: <166181675964.322065.8912915551425768865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220718161826.4943-1-ansuelsmth@gmail.com>
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
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

On Mon, 18 Jul 2022 18:18:24 +0200, Christian Marangi wrote:
> Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
> some additional pcie, sata and usb configuration values, additional
> reserved memory and serial output.
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
      commit: a9f2cd80ee4669c851d6953fbbb592a3ba44df9f
[2/3] ARM: dts: qcom: ipq8064: add ipq8062 variant
      commit: 58907a1cae53dd5f91a7dfb17ac8de10c60c32fd
[3/3] ARM: dts: qcom: ipq8064: add ipq8065 variant
      commit: 12e621362be39350167ede99542256e768ecbfd6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
