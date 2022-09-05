Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797A65ACA6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiIEGTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiIEGTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ACC13DF4;
        Sun,  4 Sep 2022 23:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6025B610D5;
        Mon,  5 Sep 2022 06:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10C8C433C1;
        Mon,  5 Sep 2022 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662358789;
        bh=qoVU5IEku9HQk6piaO1ti5LKrgIU0qiuy5TONVv+YGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WbhpBa4oNYu4pybWN/GNkcg1rjEJJ+uhDKXay5P/yQJeLJV4wLgeSqCTVtiIRmz8V
         Pa+ZY0Jlkd4Ff4r0jLNjQ2LHpW/C1hzwMiyG7Uv4vh3o1k+slIPLHPfsx2lS/FOOB6
         N2sCxUcJ1pFszykKb6oxm1dANWozR/VDC4N7cbRpQcMcaY0L3ZqjhSty1UNQFz/CTQ
         6zNXoqb/8yHHD3sgo4+A2cYXOwVSMq3mhf0Q/BmSK3mXmH1enarW+Co2KUVLd4Va6M
         q4n2erohl8dtqCR4qkCkBYogNfc4CxtfgJuAkeWY2PT+s61G+xJUXWjCqD3qx8irGh
         k0mZ6YBwujkRA==
Date:   Mon, 5 Sep 2022 08:19:42 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: phy: hisilicon,hi3670-usb3: simplify
 example
Message-ID: <20220905081942.4cd47318@coco.lan>
In-Reply-To: <20220817142246.828762-3-krzysztof.kozlowski@linaro.org>
References: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
        <20220817142246.828762-3-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 17 Aug 2022 17:22:44 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> escreveu:

> syscon and simple-mfd cannot be used without device specific compatible,
> so simplify the example to fix this.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/hisilicon,hi3670-usb3.yaml   | 26 ++++++-------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
> index ebd78acfe2de..1cb00dbcd4c5 100644
> --- a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
> @@ -52,22 +52,12 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    bus {
> -      #address-cells = <2>;
> -      #size-cells = <2>;
> -
> -      usb3_otg_bc: usb3_otg_bc@ff200000 {
> -        compatible = "syscon", "simple-mfd";
> -        reg = <0x0 0xff200000 0x0 0x1000>;
> -
> -        usb_phy {
> -          compatible = "hisilicon,hi3670-usb-phy";
> -          #phy-cells = <0>;
> -          hisilicon,pericrg-syscon = <&crg_ctrl>;
> -          hisilicon,pctrl-syscon = <&pctrl>;
> -          hisilicon,sctrl-syscon = <&sctrl>;
> -          hisilicon,eye-diagram-param = <0xfdfee4>;
> -          hisilicon,tx-vboost-lvl = <0x5>;
> -        };
> -      };
> +    usb-phy {
> +        compatible = "hisilicon,hi3670-usb-phy";
> +        #phy-cells = <0>;
> +        hisilicon,pericrg-syscon = <&crg_ctrl>;
> +        hisilicon,pctrl-syscon = <&pctrl>;
> +        hisilicon,sctrl-syscon = <&sctrl>;
> +        hisilicon,eye-diagram-param = <0xfdfee4>;
> +        hisilicon,tx-vboost-lvl = <0x5>;
>      };

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Thanks,
Mauro
