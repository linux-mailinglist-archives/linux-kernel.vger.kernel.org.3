Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAC559F68
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiFXRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiFXRTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:19:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436B6809F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:19:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o9so4358667edt.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1mS7MeLhqDF7A//E5jhahypB/uovVI38NPPCc6RFQiA=;
        b=wK1ybY4CMPD/YhNJv23Qg1YqoIQNUGv2qDLbhKLlEQ5sqGRcXIZl4ppBi5VxBgUEZP
         Q5E31vOb3OBa5sHriAEnzm8iG/QPcJZ6C4WNwsRfovG9jffNupHbCS320644Ira5RO5+
         e0nkL2q9J7UDXrq+Z9XEtGorNlDdpAtEgcKrvPRgG+Dfc1/ss0mkrDvgndsYowaOvZi7
         H0f71PiR3zR6BVxvifMWTAjd/ucp6t8aaZsi2Zn2jth4JGkKV/weLgkEIDmqdP3FIXQ0
         SH2e30+e009E3e8qOZq8XwLFbRhQBIr9UqCXxjjGaBJleMnleMlL51oDiM1gUUdlilcI
         rQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1mS7MeLhqDF7A//E5jhahypB/uovVI38NPPCc6RFQiA=;
        b=fP3iK5JmquM3Gk3ujBxZEoV0vt0YeZxW4QEEwc53E1DggRCevJxzFLNloaJ7IrtwLR
         8Da7YHxpg5dkmGxYxac1Gp+KgJF+CVyZybyR64eLrFqrBekzwHBOUuQiNdkohYwZYfDG
         J5ysXNVEiCGSXSR4eFHEyDHyZKBOvLIt+vQ6sQ60VOivVYJHX2T0/S4/eKuIV2OlbYTB
         t2ZBK015uR06ZzuukTis3SBXMAfyGn60Gbr3RX+JUhW4tggPXbxMGwzw8ogY2On6nTo0
         21w1cW+HK4JkKVD4dkiJrgnoAbUWL0uhaJh8HMqSKtDyVPc55tByVBOFiUkRQAdCaHE8
         KvLw==
X-Gm-Message-State: AJIora9ZiBhcr5unL83VbM8j12w0HFkbA2ItVfmlGxsAZyugRFrvxZ8d
        VvEen83ShLlThu02l+nhyOIFEg==
X-Google-Smtp-Source: AGRyM1tGTpZKHip8vrhphzvWpCMKPL/90cL8453ozIuX6HfyfUoBcF1h+aKQ1UNEk0xmQKnKS7KfJQ==
X-Received: by 2002:a05:6402:104a:b0:435:c7cd:11dc with SMTP id e10-20020a056402104a00b00435c7cd11dcmr105928edu.335.1656091140072;
        Fri, 24 Jun 2022 10:19:00 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906a20d00b006fec9cf9237sm1419402ejy.130.2022.06.24.10.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:18:59 -0700 (PDT)
Message-ID: <59d8a34a-a211-d00a-2243-6ad51cfa4204@linaro.org>
Date:   Fri, 24 Jun 2022 19:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v9 4/5] arm: dts: stih407-family: Harmonize DWC
 USB3 DT nodes name
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 16:16, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 1713f7878117..7ba528315dbe 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -725,7 +725,7 @@ st_dwc3: dwc3@8f94000 {
>  
>  			status = "disabled";
>  
> -			dwc3: dwc3@9900000 {
> +			dwc3: usb@9900000 {

This does not apply. What tree is it based on?


Best regards,
Krzysztof
