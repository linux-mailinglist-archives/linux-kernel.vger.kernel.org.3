Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD05A5802
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiH2Xrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiH2Xq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE5A572A;
        Mon, 29 Aug 2022 16:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B8E3B815E8;
        Mon, 29 Aug 2022 23:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF653C43147;
        Mon, 29 Aug 2022 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816795;
        bh=D3nuI8F6pKEFfIlvOaVvBsnkHFP4R8DPq0Mw2xs5YYY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e4aWTqgHakIl+jMDODtFBYaBwWll55Z/+qR2eN+MHC2MVn0ZGaVt0TTEu/m3B5qkc
         Y/e3vsZ6H8WK+MUmyQVCsVa14Kh5viFfQFxvEsoBSRV02sc9xCRIXpApifcEfOytDQ
         5NduS8qg22xrn7As9R9KiBJ3ExZA00/qPhJ3CWNBTwmxzjndglY070vSMn2RK98uVx
         8VNNi7+YJNVvCW/6kBO3IbJWv9pUhJJzHNRkZ3uBNHM+B1twau0ptXJsVd+v5vKRTx
         NZ1fQB+eq1lSETPAiGt7+uk6/eLKYhm75y7Z9qE0mHlCXpyk/z1GIssZdTpyBR/QTI
         TI+VmRg7XR2GQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH v6 0/3] dt-bindings: arm: qcom: qcom,board-id and qcom,msm-id
Date:   Mon, 29 Aug 2022 18:45:57 -0500
Message-Id: <166181675957.322065.10490440221994985932.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
References: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 5 Jul 2022 15:02:57 +0200, Krzysztof Kozlowski wrote:
> Changes since v5
> ================
> 1. Dual-license qcom,ids.h (Rob).
> 2. Minor corrections in comments.
> 
> Changes since v4
> ================
> 1. Change the qcom,board-id oneOf (oneOf at higher level) so newer dtschema is happy.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples
      commit: 2b96ef794caa539d52f8e8c85ef907b3bc601c27

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
