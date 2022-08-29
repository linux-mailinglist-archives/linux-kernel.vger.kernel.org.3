Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2A5A57F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiH2XrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiH2Xqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663759FA81;
        Mon, 29 Aug 2022 16:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCEA1B815BE;
        Mon, 29 Aug 2022 23:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA19C4314E;
        Mon, 29 Aug 2022 23:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816794;
        bh=03KnsmBF+BfrLK1T6rQ4rdE1hYYkMJYIiXB2LfVO9xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwSR+ZOfRGeaBMLWExfPLNcrDthGvVLb2HKQK730WsugB/XyfEAgIm1PkujwdJDWx
         iYyfWG1c55edJDnfpLLiR+gzvJW2oPKh7T1Zv0ciDUFWKl9a0QK0AbPrs/G1JR5s1e
         0zV5HTvZf0XJVEGDU0F7BkzBCTWf8vA9x8PqQFbvMGrb3wdwSWp9PWZeoNNeV8SVfj
         LNcpoR2OVQbM7FWdKhqP3rQApJw30SxTfzw8Fnv0yLBB2Y3YR8Zh/5/rsmZyMOPFXO
         eT/WebozWuVgqse1mWaBDoWsxUN/gL2T9WKoDO7m5AAKne9kaSPX5jxaoKDNAJ26UI
         hRZkSPpG0dPIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        bhupesh.sharma@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, adrian.hunter@intel.com
Cc:     dianders@chromium.org
Subject: Re: (subset) [PATCH v3 0/3] dt-bindings: mmc: / ARM: qcom: add MSM8998 and cleanup driver of_device_id
Date:   Mon, 29 Aug 2022 18:45:56 -0500
Message-Id: <166181675959.322065.11391852631848577834.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
References: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 14 Jul 2022 11:10:39 +0200, Krzysztof Kozlowski wrote:
> Rationale/background:
> https://lore.kernel.org/linux-devicetree/CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com/
> 
> Changes since v2
> ================
> 1. Add Rb tags.
> 2. Add a comment to SDHCI driver to hopefully prevent re-adding of compatibles
> (suggested by Doug).
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
      commit: 18f581bfe29de7c3ad33b3f2b2bd515623417494

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
