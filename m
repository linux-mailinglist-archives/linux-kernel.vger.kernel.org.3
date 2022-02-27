Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D74C5A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiB0Jdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiB0Jdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:33:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04516220D1;
        Sun, 27 Feb 2022 01:32:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r13so19184131ejd.5;
        Sun, 27 Feb 2022 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bPYynrjqhgBLtN2cr7LwW1Kf2fLVZCu7r0EjUJ+YJiA=;
        b=LYhWFAXnRxSuSvGZnnvVcr2T5OpbkiroI1QxIQj+W54Oyelh03Q30ieQdg1LyfVqS7
         HFUm9bMy7N1/iUaQfE1/U451qlV5t7BNldbEZGqm9l+nk+5cjq1Ahf1+2E/JGCX5f6pX
         0OnLzJ7SjZyFrdW/I0M/XS2+F0g/BA+jfvsFPhG+5chcOeHgpvVVoo6VbCRMSCpJgVi/
         d90jE/o2skITJ+v2PFc5RmLQJHFqHKEbXtN6O6DCmxzX+diJ1oj+781w3tQsywuYRypH
         2y2JK9LeuoBjc5cTlkeecsXxl+HOMF0bpCkKwUBSkROZQ771hQo6U1YpXBh/ukG/yPF2
         xzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bPYynrjqhgBLtN2cr7LwW1Kf2fLVZCu7r0EjUJ+YJiA=;
        b=22tenkIzOpmkV6IYFpPWXa8YDiSdBtQZ5m96i61YVcmyPRuXl5cr5kvk54ln95nqY9
         kLsTpx7z8NdU5DDI5DRSKoOXgAfIDld6DmJGat9jZxnJdhyIiWNA+rtyW6j9oK0tEQT2
         4Ah+gs0+N84TwSQmYADNHEqQ/BoGjeENJkx7Kh8YcntS4doGUIN+ucdUYKuZU1ZNEU4O
         yoYlyA2cm0xvAgxBBzPBIQhp8CWbznnws3xG01xwwdfem6KahCa4zwaGPFZTV0uMu0UX
         Z11SoYbqHcy0pjZS7UfVoIWMFhBmM7ATPLxTigEAVj2o5I5p+Kx54qA9J77dTNJL6NZY
         uxpg==
X-Gm-Message-State: AOAM531kAvB8kpUvpdnG/sxO1JMwwiLvx/RZwgkDRbNVLLLHHdY2BIrN
        70rlvqsq0tHdgmxZDNBOG2s=
X-Google-Smtp-Source: ABdhPJx5ot/uXGhr5obXyws4B25ucf9VX/1Th/XDjyDOsT+iqK5YagLm09kuiQJ/Y+hXhld1lFapUA==
X-Received: by 2002:a17:906:35d5:b0:6b7:faf7:9611 with SMTP id p21-20020a17090635d500b006b7faf79611mr11571638ejb.537.1645954373052;
        Sun, 27 Feb 2022 01:32:53 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id lx9-20020a170906af0900b006d0d3179e11sm3166949ejb.105.2022.02.27.01.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 01:32:52 -0800 (PST)
Message-ID: <89f358ac-eafa-3887-2fcb-db952a6161b3@gmail.com>
Date:   Sun, 27 Feb 2022 10:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add sata nodes to rk356x
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220227082131.131883-1-linux@fw-web.de>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220227082131.131883-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_FMBLA_NEWDOM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Combine your patch in a serie with the ahci-platform.yaml conversion and
include all current CC people and Rockchip list.

Your conversion and DT patch contains lots of errors.
Check your serie before you submit and fix.

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml

Add power-domains as a new property after the conversion patch.

Johan

===

make a serie:

conversion ahci-platform.yaml
power-domains patch
rockchip rk356x sata nodes patch


On 2/27/22 09:21, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> RK356x supports up to 3 sata controllers which were compatible with the
> existing snps,dwc-ahci binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes in v2:
>   - added sata0 + 1, but have only tested sata2
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..2e2e73be7417 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,51 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  

> +	sata0: sata@fc000000 {

rk3566 has no combphy0
Move to rk3568.dtsi

> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc000000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
> +			 <&cru CLK_SATA0_RXOOB>;

> +		clock-names = "sata", "pmalive", "rxoob";

remove
> +		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;

> +		interrupt-names = "hostc";

remove

> +		phys = <&combphy0 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
> +	sata1: sata@fc400000 {
> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc400000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
> +			 <&cru CLK_SATA1_RXOOB>;

> +		clock-names = "sata", "pmalive", "rxoob";

remove

> +		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;

> +		interrupt-names = "hostc";

remove

> +		phys = <&combphy1 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
> +	sata2: sata@fc800000 {
> +		compatible = "snps,dwc-ahci";
> +		reg = <0 0xfc800000 0 0x1000>;
> +		clocks = <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
> +			 <&cru CLK_SATA2_RXOOB>;

> +		clock-names = "sata", "pmalive", "rxoob";

remove

> +		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;

> +		interrupt-names = "hostc";

remove

> +		phys = <&combphy2 PHY_TYPE_SATA>;
> +		phy-names = "sata-phy";
> +		ports-implemented = <0x1>;
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fd400000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
