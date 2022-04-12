Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4A34FE06C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350978AbiDLMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352834AbiDLMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:36:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7E1A3B8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:56:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c6so6898005edn.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6vxAMFFRr0NPCcUM2OeYvzLThu9KnprPtO/7Wfh+zGw=;
        b=ptim7LvKUVHYzXsNFJJ5lOaaox1uNgxiKhyPHrCda1KZNkPqmpHSSM7S74nwKh0dvL
         q4cVJEO3EkbIGIxyLH0TfH+HhFu8S3eeUES7UGraptR5tLGLxg/ZBaIJjGjNy2yAQ411
         uWchf47F0ACHsaUCiCK25xpQ0DHeL5nvO42fGfhWpzKbtesbxetvVWBKFtMtK3QlbKBz
         oahU5jP207DqRKUf7G82xDiGfJykhP2Q4aHMc8q37r87gs0Rve8ahNDV/Q1036Usxs5a
         aSiovyNq2WTYnHCtFmwmQ/Gbql3e6KlXgej00MEIrsa75JJj9G4N7uo9tII/8ItCdq5y
         NlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6vxAMFFRr0NPCcUM2OeYvzLThu9KnprPtO/7Wfh+zGw=;
        b=b+jV8vQvD0pRgQRmaRDynV62Vq5hh1F5HSiyCSrq9e6P+HI91Jg0jiz+ule5Izp8Hi
         U+p1UaZt5Jo4YP7h2wTLnCQCU/JXF3SsqgfBT1GW+qmTczi2PbdT/6G0mwa9RexMTRlS
         Txzz+jmWVBrg8NQQib51+9S2OV6B3PK4VYMVzpHNT6lLRqiMaqTZhPd3gXv12RRW7nS+
         8aO/YnpePGOmcBLL3Gs6XD9zl+hwVxfkLxgIIQfFCXBc1J4L/OYbIbrXXJKXrlTDHI0o
         4+i4jYBPGGienhrDu4fpfZPDixeKXWuErz6NXCvc0eyMk74n9OdXtqkigWyFJC95Sgzu
         cPBA==
X-Gm-Message-State: AOAM533lwZHX718SdIFMUngkenqT5U31pyhTMb9i3b4TlM7HifJ6JJAL
        TEhyZuz0LKS4qnjUX3uOileO5g==
X-Google-Smtp-Source: ABdhPJy/oRgec0WQTvkI71j0XXmhBfTd5Z+XNoP8pK290bttfxckXJziNbgyTb89bNmiFkhIQYDrxA==
X-Received: by 2002:aa7:c790:0:b0:41d:7e0f:f15c with SMTP id n16-20020aa7c790000000b0041d7e0ff15cmr9193914eds.129.1649764603156;
        Tue, 12 Apr 2022 04:56:43 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm17152944edw.75.2022.04.12.04.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:56:42 -0700 (PDT)
Message-ID: <a8d09ab7-7e5d-2166-13b4-621259bc46d6@linaro.org>
Date:   Tue, 12 Apr 2022 13:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2 v2] ARM: dts: Add initial LS1021A IoT board dts
 support
Content-Language: en-US
To:     Changming Huang <jerry.huang@nxp.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        l.stach@pengutronix.de, alexander.stein@ew.tq-group.com,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        linux@rempel-privat.de, matthias.schiffer@ew.tq-group.com,
        cniedermaier@dh-electronics.com, sebastian.reichel@collabora.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org
Cc:     Alison Wang <alison.wang@nxp.com>
References: <20220411090828.1965450-1-jerry.huang@nxp.com>
 <20220411090828.1965450-2-jerry.huang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411090828.1965450-2-jerry.huang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 11:08, Changming Huang wrote:
> The LS1021A-IoT gateway reference design is a purpose-built,
> small footprint hardware platform equipped with a wide array
> of both high-speed connectivity and low speed serial interfaces.

Thank you for your patch. There is something to discuss/improve.

> +
> +&enet2 {
> +	fixed-link = <0 1 1000 0 0>;
> +	phy-connection-type = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&esdhc{
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	gpio: pca9555@23 {

Here and in all other places - generic node name, please. For example
pca9555 is "gpio"

> +		compatible = "nxp,pca9555";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		reg = <0x23>;

Please put "reg" after compatible, everywhere.

> +	};
> +
> +	codec: sgtl5000@2a {

Ditto...

> +		#sound-dai-cells=<0x0>;
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x2a>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_2p5v>;
> +		clocks = <&sys_mclk 1>;
> +	};
> +
> +	adc: max1239@35 {

and so on.


Best regards,
Krzysztof
