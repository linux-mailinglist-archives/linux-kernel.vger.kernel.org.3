Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7145ACA7A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiIEGVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiIEGVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A122B62D;
        Sun,  4 Sep 2022 23:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2838610E7;
        Mon,  5 Sep 2022 06:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C6C433D6;
        Mon,  5 Sep 2022 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662358874;
        bh=056KAePOeWgzIG5LJsb+xoS5aEhxNBcn6X0QjCynVOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XdNTeqviAxPaYfXQBCXsrQG2mq7ZAVcobfT6XXI3oDsn8ifBtUUUQoOTNH2cYqoYT
         EWG8N1mc3OZpX/xqdkK0LuZRruyFowz03dVrdlBKt9HdNN/mrZPr7KS9DfjoVC7D7b
         NYZVa2h/Dt2BEpcpyxaFlefQYMukqh5zORWfD6tKJhpnd/UeZz08/MwTYg3vtvJY19
         uNU879voF7VWVRV0eUWXW+2r5xYJO0kQ1sTyPXK0Moz08bghCLBzDqvHPInfITVLYS
         aWr1aKkB/TndgBDUIAFWxtw8KLd9rfBNtxV7MOx2AyyhPKUU9quSf+k42LL/WtWksO
         PRW5G/3Oai0/g==
Date:   Mon, 5 Sep 2022 08:21:07 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: phy: hisilicon,hi3660-usb3: simplify
 example
Message-ID: <20220905082107.7ff83539@coco.lan>
In-Reply-To: <20220817142246.828762-2-krzysztof.kozlowski@linaro.org>
References: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
        <20220817142246.828762-2-krzysztof.kozlowski@linaro.org>
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

Em Wed, 17 Aug 2022 17:22:43 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> escreveu:

> syscon and simple-mfd cannot be used without device specific compatible,
> so simplify the example to fix this.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/hisilicon,hi3660-usb3.yaml   | 22 +++++--------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
> index c2e073e26190..20b79e2e8b82 100644
> --- a/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
> @@ -41,20 +41,10 @@ additionalProperties: false
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
> -        usb-phy {
> -          compatible = "hisilicon,hi3660-usb-phy";
> -          #phy-cells = <0>;
> -          hisilicon,pericrg-syscon = <&crg_ctrl>;
> -          hisilicon,pctrl-syscon = <&pctrl>;
> -          hisilicon,eye-diagram-param = <0x22466e4>;
> -        };
> -      };
> +    usb-phy {
> +        compatible = "hisilicon,hi3660-usb-phy";
> +        #phy-cells = <0>;
> +        hisilicon,pericrg-syscon = <&crg_ctrl>;
> +        hisilicon,pctrl-syscon = <&pctrl>;
> +        hisilicon,eye-diagram-param = <0x22466e4>;
>      };

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Thanks,
Mauro
