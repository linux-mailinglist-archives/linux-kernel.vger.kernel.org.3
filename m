Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0A4AEBA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiBIIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiBIIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:00:32 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B88C05CB80;
        Wed,  9 Feb 2022 00:00:35 -0800 (PST)
Received: from g550jk.localnet (84-115-212-237.cable.dynamic.surfer.at [84.115.212.237])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 44725CDFCA;
        Wed,  9 Feb 2022 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1644393634; bh=4FXw/m0qzG12tweb/SpzqvxhvTalonOAWhiKiVfi+U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vDuyTleEJgBCbkmvWKcbLvpyCp7hBGTI4BZVTpm7IdRqrvDBL3nRGisMJOhn+8xx8
         jEDoW8C60Y6xIXcsExCaeXbtKPgfptE4EhsPU3EyZwqcbiBFFDcxUzg/VQNQQTWd58
         zC1MtpWI0VpmkObfSvsUWRKjxD5e1W1zxbq+R54Q=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Jack Matthews <jm5112356@gmail.com>
Cc:     jm5112356@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: pm8226: add node for RTC
Date:   Wed, 09 Feb 2022 09:00:33 +0100
Message-ID: <3306547.mvXUDI8C0e@g550jk>
In-Reply-To: <20220209052929.651881-1-jm5112356@gmail.com>
References: <20220209052929.651881-1-jm5112356@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Mittwoch, 9. Februar 2022 06:29:28 CET Jack Matthews wrote:
> Add a node for PM8226's real time clock.
> 
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi index 04d070d98f97..ecc38ab1dc4b
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -17,6 +17,13 @@ pwrkey@800 {
>  			bias-pull-up;
>  		};
> 
> +		rtc@6000 {

Please keep the nodes sorted by address, so don't put @6000 between @800 and 
@1000 please ;)

Regards
Luca

> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 
IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		smbb: charger@1000 {
>  			compatible = "qcom,pm8226-charger";
>  			reg = <0x1000>;




