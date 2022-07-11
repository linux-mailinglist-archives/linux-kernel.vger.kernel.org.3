Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EDF56F965
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGKI4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGKI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:56:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE54D12D06;
        Mon, 11 Jul 2022 01:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 886CDB80E76;
        Mon, 11 Jul 2022 08:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F0C34115;
        Mon, 11 Jul 2022 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657529772;
        bh=PpEE8mf3vOUTI7HZ52uDTZOLGpTTVD3SMaD4DBZ+kP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSNh0heq6z34LhARLgJLa9EHN+GWO1LwgtkBQj+4zD1t4Wd4LEUe1WlBQfiutwlY/
         URg/uKFZPgKE1Hb9WV9PoRFKmzRwD5e+JSQdOCjM2kpoBGJ1meOtT9ksmcW5Ilf1U2
         UoyPH+JcPNA9LJtcTk3cLhOgZ4V3PSs+6k9Tpy4z0HksOGJXlZGkrm1l22KuZgcHhZ
         nHyAats6pfk/6wZ1KUroIYsxQT1fTvAinfT/ngj3DPSKIEFGfNfl9AaAplFJXL8h3o
         NMmVMS7BclYWCoDjMvfwrSEUO60NZ0SeYNvU05/oI5R8jvTrL4B3tF0HAG7ZDi+SPh
         KQfqfmEdx5+OA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oApD9-00069W-TU; Mon, 11 Jul 2022 10:56:12 +0200
Date:   Mon, 11 Jul 2022 10:56:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <Ysvlqw/+eMk5XLRY@hovoldconsulting.com>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:08:58AM -0700, Bjorn Andersson wrote:
> The timer node needs ranges specified to map the 1-cell children to the
> 2-cell address range used in /soc. This addition never made it into the
> patch that was posted and merged, so add it now.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 2bdb42c88311..37a4cd6f85b6 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1667,6 +1667,7 @@ timer@17c20000 {
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +			ranges = <0 0 0 0x20000000>;

While addressing the current issue, this looks odd to me. Why not use a
non-zero parent bus address here instead?

And please use hex notation consistently for the addresses.

>  
>  			frame@17c21000 {
>  				frame-number = <0>;

Johan
