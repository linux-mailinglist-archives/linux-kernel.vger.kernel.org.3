Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E342A4FE0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354672AbiDLMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355479AbiDLMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:39:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8A2E2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:02:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c64so9902340edf.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QYvAQySo1sPsIjLPmB8FIvK2SiEiPIvz4SF0+8IYqQw=;
        b=GTUU/BAw/7g1icPdyU1gicA+0STlI2aa4ncYMDx5RcmR/waZhtMZOSNr5gntvcxXkt
         ZcRHjnk7S6mc7uTCeRabTQc9vxmnqPhg/QUV1E1kipzO+L0EyqtazSu7D+hHcyFzdRLY
         xlaIvsEwqmFdCFMNA4xJ9nRZ+ILKSUyNWulsjOL3z46V0yzJoqFbUAbnwraaVq0bvp0w
         uQlLLo3GU0MuerdCEEYIRrKWoo1PeJ1qi1IWeo5hFJP3kug2vwZN2B3S0Y7+T7Bi3itQ
         QkRrJweOerYJHTf6hdqjrPxD+bLYZnhDzB85b3xjzrAz6MkqmXpnRN5ocAoLtSeLuVE7
         z05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QYvAQySo1sPsIjLPmB8FIvK2SiEiPIvz4SF0+8IYqQw=;
        b=WSVgnF6Vr3Vl4RwkGZLwpxfSspxq7dleJMBPlQa3QVwc3AFj6W+k6Z/H7lHI/o1YY0
         xYzjulumsVlfwTzEaU7fk39Sddh2xgJoxX5R1tmU+W76q5BzZDIKAMyxbdv/aAF222NL
         mSjnjmIt1+r4XCdIgiFdXxVDD/UN4PN110IuryL6/eWT2TNFuBeqbzUwX7ieNRfOjO4Z
         D1M8D1EV6gGDO6pCT6Ec1+ZqH+cWq+rIUwPhRSyxV8V2T/SQkDC5eWkH8NBSttg7AHgw
         TE/ddP2IWLnJaPtbWhGxLxvqy3mxpXPZ8gMwFDQRFkfAzSAzv//w7HZHdu6AnqKN8VT7
         RT2g==
X-Gm-Message-State: AOAM532qNIjkfTFEZeyWo/kDr+zFkDC3ILhd1HPhtG1X6RMCzb2LEzDC
        ndo1QVuRFYl/DoiaMevEd2OKhA==
X-Google-Smtp-Source: ABdhPJzxtTWRt335RkLqbr9SGrvPqsb0D1/lwfuPdhnA0WbWgovri7fB6O1ERz8pptVoCEjSQJ+L3w==
X-Received: by 2002:a05:6402:438d:b0:419:4550:d52b with SMTP id o13-20020a056402438d00b004194550d52bmr38259034edc.83.1649764939866;
        Tue, 12 Apr 2022 05:02:19 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm4001892ejc.150.2022.04.12.05.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:02:19 -0700 (PDT)
Message-ID: <37b21c24-22e0-2de2-697f-d22ff92b90c2@linaro.org>
Date:   Tue, 12 Apr 2022 14:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 1/6] dt-bindings: usb: dwc3: Add wakeup-source
 property support
Content-Language: en-US
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-2-git-send-email-quic_c_sanm@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649704614-31518-2-git-send-email-quic_c_sanm@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 21:16, Sandeep Maheswaram wrote:
> Added support for wakeup-source property. This property can be
> used to check and power down the phy during system suspend if
> wake up is not supported.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index f4471f8..4d4de2f 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -341,6 +341,11 @@ properties:
>        This port is used with the 'usb-role-switch' property  to connect the
>        dwc3 to type C connector.
>  
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag

I would prefer to use shorter "type: boolean", but in any case:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> +    description:
> +      Enable USB remote wakeup.


Best regards,
Krzysztof
