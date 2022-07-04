Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9715C565C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiGDQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiGDQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:50:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F54B91;
        Mon,  4 Jul 2022 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1656953449;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wQVtKPYuwCaa3kdZ17v1bdxFoy6uTm+y21q5yvZvN+U=;
    b=ZQl/wzmRSNEcf/AzLuHJSGsl5vQn1L35jKYXO1A9sPiQtiUGXq1DCu0l4eILZq1cUA
    3DWmOx0/c6j1yRLkrLlnEbycnxXzEhszVLSPsOBQ3H5qJ9zddCNGdHGGdw2ySQzSuNOB
    1Cyc03UHxuLDV4f0fogSZVWQNLe2ugLlEvvbllAY/PbYVH6mx7Jff4Reg/A0n8YefbQK
    upancp8aEM6AWuSYwJcKqrhy1CALdQA4UB2CE1M86QkgJQ2JWK0MTBsfyc6vsgoup/iO
    ppzumFv/6LgrPy7RS3wcPTLFq53RuKkRf2usR0ZwP/I8qBicUtWbazK2Zb8ip8Y177LR
    2AxA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw5+aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.1 SBL|AUTH)
    with ESMTPSA id yfdd30y64GomFAU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 4 Jul 2022 18:50:48 +0200 (CEST)
Date:   Mon, 4 Jul 2022 18:50:35 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,sdm845: convert to dtschema
Message-ID: <YsMaW6cO2fEfTGPz@gerhold.net>
References: <20220704153824.23226-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704153824.23226-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:38:24PM +0200, Krzysztof Kozlowski wrote:
> Convert the Samsung SDM845 sound card bindings to DT schema.
> 

Nitpick: s/Samsung/Qualcomm

> Changes during conversion: do not require 'codec' under dai-links - not
> present in all nodes of examples and DTS; not required by the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt |  91 ----------
>  .../bindings/sound/qcom,sdm845.yaml           | 166 ++++++++++++++++++
>  2 files changed, 166 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.yaml
> 

Can you check if you can just add the compatibles to the existing
qcom,sm8250.yaml? It should be more or less identical given that the DT
parsing code in the driver is shared between all these SoCs.
I already added the MSM8916 compatibles there a while ago.

It also documents some additional properties ("pin-switches", "widgets")
that are supported for SDM845 through the common code but are missing
in its binding documentation.

Thanks,
Stephan
