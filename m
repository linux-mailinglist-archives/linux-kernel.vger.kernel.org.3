Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52853D229
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiFCTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348938AbiFCTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:05:22 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5030F78;
        Fri,  3 Jun 2022 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1654282936;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GN32FHxgQcHqH2ucXhtQRiGh0eXPPIP92mFkqoNojOw=;
    b=NcenauWPTPMC//K3fNo54K+j79IWwc/2lRt9IAjn+ZA7EAehD9f3toPwur/SByZyy1
    dN6bYMCufLOg74gkUBgzuT8y9dR6jGT3N+NkWVGq9bxLphd3F+rzEslD7OqhmdidPGYf
    hmtgzlmxcU++3t9NYqydQx96VEKWKeIIde3J8k33yb2RByQySh69paiY4rMSHchvDPkT
    jxGADZIjyJegCYGD8zslD3KDuTMkoosndUoq/2WTK6lYW+wBhYP3AP9XHv+xAMN7eXZ5
    HR7n0BdbIKsTxa0OzB1uAnm5EcBUOc2VMRooHHyDdNA6QG9Fx4+5Hjse3qfRnzisRqAM
    Z5TQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy53J2Fwnt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 3 Jun 2022 21:02:15 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:02:14 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sdm845-oneplus: split
 qcom,board-id into tuples
Message-ID: <Yppatj7KuQLPdDW1@gerhold.net>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
 <20220529202629.47588-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529202629.47588-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Caleb Connolly <caleb@connolly.tech>

On Sun, May 29, 2022 at 10:26:29PM +0200, Krzysztof Kozlowski wrote:
> The qcom,board-id is an uint32 matrix, so a list of tuples.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> index bf2cf92e8976..8897a2f4cfe3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> @@ -12,7 +12,7 @@ / {
>  	compatible = "oneplus,enchilada", "qcom,sdm845";
>  	chassis-type = "handset";
>  	qcom,msm-id = <0x141 0x20001>;
> -	qcom,board-id = <8 0 17819 22>;
> +	qcom,board-id = <8 0>, <17819 22>;

FWIW: While it's just a cosmetic change this is a bit misleading in my
opinion. Having two tuples suggests this should be interpreted as:

"This device tree is suitable for two different boards:
 board-id = <8 0> (aka sdm845-mtp, a standard qcom reference board)
 OR, alternatively: board-id = <17819 22>"

Since this device tree is clearly not meant for sdm845-mtp one could now
argue that the <8 0> could be removed, and only the second tuple covers
the actual device. It might be worth a try (maybe Caleb can try?), but
I suspect the bootloader will not accept that...

I think the bootloader from OPPO/OnePlus is actually looking for
quadruples instead of tuples on this board. I have seen similar hacks on
several other OPPO devices as well. They usually add their project ID
(here: 17819) somewhere and look for that in the bootloader.

In this case maybe adding a short comment would be sufficient, just to
make it more obvious that this doesn't actually follow the binding
documentation.

But this kind of brings up the question if it's worth making any
constraints in the DT schema at all, if some of the device trees
can not follow it.

For example, older OPPO bootloaders actually look for triples instead,
e.g.: (This is from a real device!)
	qcom,board-id = <8 0 15009>;

So maybe it's just a matter of time until someone tries to add a DT
with a format that cannot be changed cosmetically to fit the DT schema...

Stephan
