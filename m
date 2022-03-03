Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F136E4CC212
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiCCQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiCCQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:00:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D469418E41D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:59:26 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 977E83F61F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646323165;
        bh=MdwjWjZqm0RnOglfFnSZ5WY/pIE+2hElYzOWtQJQrYc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MDfg+jPjpKksoV3C4ckPNTlr6lsnvPv+QZArpMsQY8WYhLtUFIqz+LK/lFlpJZYZ8
         ivJcT3Rk65/Jz0jNlaaI0f99CvhDkERzadWiACAYpWmUdD0hP0Ghfd5lfxvFEzycf/
         qZy4zYqp9a4YTfzIk+OwhLHztwFHdqC/d2Tf+7fV8WdPV4+afop1QfOBn4mG8e6iDa
         e9q/EubfqG1UDuRYDxIteNZ+96iR3UPjEOZwkxyUeOoHSjqRF5B7PpgM/F1NvyQO6T
         yA3LLUHX3zGyYsuPQ6BUuCoLq6VL6BK4xqdpkxI34yPshpCPoaeupLnyK4wCE0Jp5V
         iQ6aI7XEOlGMw==
Received: by mail-wm1-f72.google.com with SMTP id a26-20020a7bc1da000000b003857205ec7cso1313591wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MdwjWjZqm0RnOglfFnSZ5WY/pIE+2hElYzOWtQJQrYc=;
        b=70ziji/J2z7PQOwf6RsfVnK09Ehexb0MlyLYcHkiyL+taMxj8Zw/MRJ3KG5YudvEO+
         O4CJ0fA1aa1ze4keygdUaK5JG//qnxB0v2XWZXNJd5qvQjKu98/jt6Vt15A8V82ln9g6
         hSvmyWAiEWGD0R5JTxNAMp60DO8B/sdQq089OFWbpNyjGlUo+QF9eW0R46zUZiLF29RU
         G0gbhYb0evh4S1bFs/r7yKJDWmQum4+2dH29qiWK5CpmPq6GxsafdRWFP5s6L2AFJ6a/
         X9/JYQ0H8YmZ4NA051GucDq6s5KBWVvScDERb19r9HOnOCKcZzEfbaEeLlRfQTklZhqJ
         99lw==
X-Gm-Message-State: AOAM533Qn6iD3Ur92aplT2a8YSv5N6MrwG5Cx46vwHSayWG9WP2A9w3H
        wAeJpNMCQL42mOZxML7lU1X7V9aoQ4RarSA291a+y//JVUm5JEInj2HGM5RTdNvmtS0EkfAXIh8
        6+0Mo2x9RCIPK9tRTjwhc1shFD12ZywkfUfelNEh9Zw==
X-Received: by 2002:a5d:50d2:0:b0:1f0:2348:4331 with SMTP id f18-20020a5d50d2000000b001f023484331mr8154300wrt.19.1646323164084;
        Thu, 03 Mar 2022 07:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHlIPEDuVmE/S59LvjLHrwrYJRSachY/7BYD0C1MLQqqJNXoqHm4h7MEj9W5zhmieIqEBtnw==
X-Received: by 2002:a5d:50d2:0:b0:1f0:2348:4331 with SMTP id f18-20020a5d50d2000000b001f023484331mr8154279wrt.19.1646323163879;
        Thu, 03 Mar 2022 07:59:23 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm2610469wri.111.2022.03.03.07.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:59:23 -0800 (PST)
Message-ID: <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
Date:   Thu, 3 Mar 2022 16:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 07:13, Sandeep Maheswaram wrote:
> Add device tree bindings for SNPS phy tuning parameters.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 0dfe691..227c097 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -50,6 +50,131 @@ properties:
>    vdda33-supply:
>      description: phandle to the regulator 3.3V supply node.
>  
> +  qcom,hs-disconnect:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This adjusts the voltage level for the threshold used to
> +      detect a disconnect event at the host. Possible values are.

':', instead of full stop.

> +      7 -> +21.56%
> +      6 -> +17.43%
> +      5 -> +13.32%
> +      4 -> +9.73%
> +      3 -> +6.3
> +      2 -> +3.17%
> +      1 -> 0, Design default%

Use "default:" instead. Here and in other places.

> +      0 -> -2.72%

In current form this should be an enum... but actually current form is
wrong. You should not store register values in DT. What if next version
of hardware has a different meaning of these values?

Instead, you should store here meaningful values, not register values.

This applies to all cases below.

> +
> +  qcom,squelch-detector:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This adjusts the voltage level for the threshold used to
> +      detect valid high-speed data. Possible values are
> +      7-> -20.90%
> +      6-> -15.60%
> +      5-> -10.30%
> +      4-> -5.30%
> +      3-> 0, Design default%
> +      2-> +5.30%
> +      1-> +10.60%
> +      0-> +15.90%
> +
> +  qcom,hs-amplitude:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This adjusts the high-speed DC level voltage.
> +      Possible values are
> +      15-> +26.70%
> +      14-> +24.30%
> +      13-> +22.20%
> +      12-> +20.00%
> +      11-> +17.80%
> +      10-> +15.60%
> +      9-> +13.30%
> +      8-> +11.10%
> +      7-> +8.90%
> +      6-> +6.50%
> +      5-> +4.40%
> +      4-> +2.30%
> +      3-> 0, Design default%
> +      2-> -2.20%
> +      1-> -4.40%
> +      0-> -6.60%
> +
> +  qcom,pre-emphasis-duration:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This signal controls the duration for which the
> +      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
> +      The HS Transmitter pre-emphasis duration is defined in terms of
> +      unit amounts. One unit of pre-emphasis duration is approximately
> +      650 ps and is defined as 1X pre-emphasis duration.
> +      Possible values are
> +      1-> 1x, short pre-emphasis current duration
> +      0-> 2x, long pre-emphasis current duration

I could understand encoding of percentages in way of register value, but
a boolean flag is too much.


Best regards,
Krzysztof
