Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8949359C051
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiHVNOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiHVNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A2512AF2;
        Mon, 22 Aug 2022 06:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3CC6117D;
        Mon, 22 Aug 2022 13:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C30DC433D7;
        Mon, 22 Aug 2022 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661174037;
        bh=tNeHnHaJjzswUACn776pwxPxD2MUG1JGluDyy3FZzd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuMBhBmnxZt4+44nb5kE3SzlJSnGt1iYtN7YtxFpBmcEZbxWQAkPVXQnLEBornGlj
         7Sn6nljoJwHdccbVJVSwpVyihQLEfBBWhrYYBgbaiNpTjfwJduuPLcOeQ+DOYRaVkd
         qAZKsgRqFUmE3HetbKbdtgLlSlzPLS06eP6mCIHLD0nnY87bfB6vELzJ2ZWQkmmL6W
         Jap6d9obs3UGwuurIwzXun5Jw6Zvd9q8YwdUGk/6zbuSzwaZ778cTJw3yJeilTRVjV
         /3FdBo+xxUoKyHupJI74IJso6rzdYBV6u7Je28ps3om5Wi2oR27MDh92MiNy07944A
         hFGvyyDz5IKZg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ7Fa-0002Ds-L6; Mon, 22 Aug 2022 15:13:54 +0200
Date:   Mon, 22 Aug 2022 15:13:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>, andersson@kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Message-ID: <YwOBEhViD1iY14yL@hovoldconsulting.com>
References: <20220802152642.2516-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802152642.2516-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:26:42PM +0200, Johan Hovold wrote:
> Move the USB-controller wakeup-source property to the dwc3 glue node to
> match the updated binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> This one can be applied once the following series has been merged:
> 
> 	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org

The above series has now been merged (for 6.0):

	https://lore.kernel.org/all/Yv56fFpuUsxCSxJ8@kroah.com/

so that this patch can be applied.

>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 13d7f267b289..dac3b69e314f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3374,6 +3374,8 @@ usb_1: usb@a6f8800 {
>  					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_USB3_0 0>;
>  			interconnect-names = "usb-ddr", "apps-usb";
>  
> +			wakeup-source;
> +
>  			usb_1_dwc3: usb@a600000 {
>  				compatible = "snps,dwc3";
>  				reg = <0 0x0a600000 0 0xe000>;
> @@ -3384,7 +3386,6 @@ usb_1_dwc3: usb@a600000 {
>  				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
>  				phy-names = "usb2-phy", "usb3-phy";
>  				maximum-speed = "super-speed";
> -				wakeup-source;
>  			};
>  		};

Johan
