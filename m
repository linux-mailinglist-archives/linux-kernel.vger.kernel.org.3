Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060BC55F980
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiF2HpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiF2HpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:45:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186DC381A1;
        Wed, 29 Jun 2022 00:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B891FB821E9;
        Wed, 29 Jun 2022 07:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AA3C34114;
        Wed, 29 Jun 2022 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656488717;
        bh=KPsgs8cYmzbFpz1SwOImxvV/uU9kcBZIAD+8codpXLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImpbNVd+JxaeZ8Tnquye4c9vziA7b9nPF959oSBvvWhMB7SILDNMvwuSCoZtzLNLQ
         JzFAT1CGfatpQsg6lIsQdb1BZii5Eb+HWI1CLi4JJ1+TKDoCAql3e3twWRzn0gVCg3
         j8D44U/P4FHxzeYZlUN9VPqYISWI6XI6YKYtzkAbvMb59wKxterFwWJNTI4zLBvIen
         JqT9belF7T5+nTAb948LtUSroPwjI6oaBsPyUs/wsEbbF3CrKF49YLyPfVrL9ItGvh
         /Bt7HkhP9LXXnM5oEcRDBF3NUR0wOkXb/FjwzFt1mBxADIXV83hPoTwDmwwn8A5ZZo
         jb2xHFqIYIdZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o6SNq-00014n-PL; Wed, 29 Jun 2022 09:45:10 +0200
Date:   Wed, 29 Jun 2022 09:45:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: add SA8540P and ADP
Message-ID: <YrwDBpvW4PIWRQ4X@hovoldconsulting.com>
References: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
 <20220629041438.1352536-6-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629041438.1352536-6-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:14:38PM -0700, Bjorn Andersson wrote:
> Introduce the Qualcomm SA8540P automotive platform and the SA8295P ADP
> development board.
> 
> The SA8540P and SC8280XP are fairly similar, so the SA8540P is built
> ontop of the SC8280XP dtsi to reduce duplication. As more advanced
> features are integrated this might be re-evaluated.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs (NSPs crashes shortly after
> booting) and USB.
> 
> The SA8295P ADP contains four PM8450 PMICs, which according to their
> revid are compatible with PM8150. They are defined within the ADP for
> now, to avoid creating additional .dtsi files for PM8150 with just
> addresses changed - and to allow using the labels from the schematics.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes since v2:
> - Sorted "status" property last throughout the patch
> - Dropped empty reserved-memory node
> - Dropped multiport vbus-enable pinctrl states for now

> +/* PINCTRL */
> +&pm8450c_gpios {
> +	usb2_en_state: usb2-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pm8450e_gpios {
> +	usb3_en_state: usb3-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};

You forgot to remove these two when you removed the other multiport
vbus-enable states.

Looks good otherwise.

Johan
