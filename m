Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D939F4B81CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiBPHlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:41:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiBPHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:41:40 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE6A88B6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:41:18 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95BA03F1B6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644997233;
        bh=HjjHm0MmfHZpWjZVsNkyG9pg4Z1MpYcDRR0vQD2wdMo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=a2KaBIHPQvJdihYd5dURbHihwGN3kZlQtN/74ueslO41ooR8Y6wo/hVlzo4VBXqZE
         PGEvyibhAFhbaUW+9A6UdDsZd6JRjZrMN9+TMYv8mXmJrTAhkvDtyGnfcfpdhdC4Rn
         tfUVr6C2XCrilixKvtMIIGvfmeRAHD+Nf6SLRBZRDhIwNC8NrFl+aW2PyOGiidtone
         ApaFaHn+RmKwCBDbLBXtk+rxlR2rImfJnfCzkYHsGIF7VqgcxcIlghXhuxSft3zHb+
         L5Vd8P7z6lwFTwapmw3oNcYvFEtr5BJbPtkNUdO3qu+oLV0srqWIas8Uba+ieiOsx6
         PuaXtuI5OaAOg==
Received: by mail-wr1-f69.google.com with SMTP id s22-20020adf9796000000b001e7e75ab581so671484wrb.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HjjHm0MmfHZpWjZVsNkyG9pg4Z1MpYcDRR0vQD2wdMo=;
        b=sdTMsGmFY4UydIuAHjHsswvStbHEJjAasmOxV52ph78fetHZ0VMuGFzpVGAsK0hSYU
         cNEha9Wjp/1kEWgSGZDrxSg9oFXkgtPQ0Eo7pB327kAHg1g9rRS3wUGtwrtseyUoVOlm
         4Y6IVoslTwwrNofCa1T0CLe/uiR8jkOZGnXg+rlqEYVT9BYP8NjIhcK6UdU8rd47eRMN
         8HoU6XVEn+ABRMSbSUzPB/kboqAYQAzX7LX1/h572Dya3zbN2LAURY7qD60hLF8PF+8M
         BRQVONtUi0x/Ys1ytSzKRQXVfAJfbdyWBy6VS3QCdV+rJ11RrjvgCOGb4nO115J9BDJo
         42/w==
X-Gm-Message-State: AOAM530eU0xBQXs5feG8yu0bHnQyi7lhlBe6XSR6ZWq94rXQS9AVIK9y
        ysqefTkQQ+g1hE3D2yL0J87ZcXaaaiiByYlDeRdQA/HVy6q8c5y6ltvrsI7ooETug+g5QncN3EE
        Ubg4kVCQyuypo8HPX3eQy4kyv/snM6qjhJG3edYdO9A==
X-Received: by 2002:adf:bc14:0:b0:1e2:b035:9c46 with SMTP id s20-20020adfbc14000000b001e2b0359c46mr1267010wrg.386.1644997233319;
        Tue, 15 Feb 2022 23:40:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySOUBYFK4c+mqEex56yPck36dUfWi8o4H5ITy5kEeoNmTIL04m2GTFApT1FwNPmHkCgKfSyg==
X-Received: by 2002:adf:bc14:0:b0:1e2:b035:9c46 with SMTP id s20-20020adfbc14000000b001e2b0359c46mr1266999wrg.386.1644997233173;
        Tue, 15 Feb 2022 23:40:33 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p12sm17346674wmg.36.2022.02.15.23.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 23:40:32 -0800 (PST)
Message-ID: <9acf139a-16b3-598e-06b7-b17611adb359@canonical.com>
Date:   Wed, 16 Feb 2022 08:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
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
Cc:     evicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
References: <1644952755-15527-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 20:19, Sandeep Maheswaram wrote:
> Add support for overriding SNPS phy tuning parameters in device tree
> bindings.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 0dfe691..44cf3bf 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -50,6 +50,22 @@ properties:
>    vdda33-supply:
>      description: phandle to the regulator 3.3V supply node.
>  
> +  qcom,override_x0:

Do not use underscore in properties, but hyphen. Just like everywhere in
bindings.

This does not look like description of hardware but hard-coding some
register values. Bindings should rather describe the actual hardware
parameters instead of values written into registers.

Plus what other reviewers pointed about usefulness.

Best regards,
Krzysztof
