Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C315AD569
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiIEOpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiIEOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE2DFD8;
        Mon,  5 Sep 2022 07:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6661061040;
        Mon,  5 Sep 2022 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213BDC433D7;
        Mon,  5 Sep 2022 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662389069;
        bh=H9hA8zdC+SGFL9yiRvISUV/6e2tbwEh+Q6op7CMDZ28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTwQyZ5eUoZYUrkXczCO4BnLTgzT2tHKdVDsb23l9Ep+IezoNzBNniPF2eEgUuLOE
         7hHMmLGCyM4iO3nYUSZRNb1uP/wUXodoK+57p5zYOu6A5Si4AxHSTUK2VOIfi/zKuh
         D8NNcUMSIV2BZX+KD74Eg+dMNes1CMVUBoIV8UhI8kVuGdTc4A2PTvOErB8dLI8RIj
         aq4IjwoPEbpbtykRkHipzn6fvxi/cg0/4fVTHEawLAeQbw88e0eOzNIjdJZeZ905pr
         JEUGjzq4S99frH7lLW4Qn0CSv0juW+HiIVJw6o4GT1dPgwcp/mAopJX8K4IbxUSNay
         SQY3QHiXJrHaA==
Date:   Mon, 5 Sep 2022 15:44:13 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: extend example
Message-ID: <YxYLPdIcs98nbBtA@google.com>
References: <20220828130113.5845-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220828130113.5845-1-krzysztof.kozlowski@linaro.org>
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

> Add a more complete example with PM6150 to provide better validation of
> the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
