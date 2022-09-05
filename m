Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04095AD57F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiIEOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiIEOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:50:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70520F62;
        Mon,  5 Sep 2022 07:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1785AB811E1;
        Mon,  5 Sep 2022 14:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C860C433C1;
        Mon,  5 Sep 2022 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662389397;
        bh=xQCHjwCs0IaMIcV1Z927MhI49paVR5r2QAmuiHDrRtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZ5oKkpv0ex5TaDUbHU4wAxZor430R5u4F1YPkLSdDhfY1ejaVoa7fYeBz6uTveIY
         tc1gQUbElJ45BFs1PKrDOOCJ6/Vu/InHQe646WGJFiDaNFvoGkf6LhQZzw+EKxJk/d
         vW0PjbXzzhabPnbNCYCKgUXICq+3uDE6HvFsTxqvbII6ykVrHSMluNOMsygLqG3VG0
         IaL4LWlSC2lDf5jC/kE7x4JPsR4ZW7MG7WcygqraXBCMQls68lQAiIMz0AaQ4qnv2h
         eH+6qgeTZgJEuQev9UZtZSNKhPpcC2tZdp9tyPl7fJoCA2Vr97WX/nyByj6CCmZxZY
         RCINMh1Zp8smg==
Date:   Mon, 5 Sep 2022 15:49:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 13/14] dt-bindings: mfd: qcom,spmi-pmic: fix regulator
 node schema
Message-ID: <YxYMVp3e0PVXKSoE@google.com>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
 <20220828084341.112146-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220828084341.112146-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022, Krzysztof Kozlowski wrote:

> The regulators node of Qualcomm SPMI PMIC represents sub-device, so it
> has its own compatible, multiple regulators and uses dedicated bindings.
> 
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
