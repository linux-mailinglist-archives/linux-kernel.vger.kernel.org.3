Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA4564F26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiGDHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGDHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:55:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCDAA45C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:55:36 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a11so10064716ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B2nX36DhNE+YPsgSpf2ql/EZ3h6K1ZO8bpe3+8TnPfM=;
        b=nXTYyZDPmlqhJVymYJBfa1NRZ+TXOznu+2u2I7s5wzLVRNeyF/LItXWtpSPcknsWaD
         x80uDexpFmuNjZLMW3uB3s9YTUx2c1AZ+aVvWhnJoWGZtHy9WkvVzHOdU8Dp/3BmkdeU
         ppmhxHLuQwXYwb3TpOARomA+VxzF4qRhB3V6K7XoXjRhcc2/C51NrsRUxPp89PXxdFw6
         gjVKS2EEymm6a98HIRb/hpGaxs1VB0G5ReVZZZgblbywC53Z6gQrXXNGfXJ/xujsR/Er
         GyE1u8ELyk4SMvohECidTKdnolWQzMwhKfDYpQfDTdxV45rWZHGdDcYGsHX1B1+yVrpy
         rO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B2nX36DhNE+YPsgSpf2ql/EZ3h6K1ZO8bpe3+8TnPfM=;
        b=JugwWhnR7APSRgIkXiskbiQvjFJt7fuEsLM/t0OArakthDDiVX6MQPn2jo5E5QJZ33
         Q8FYzPgE0Cpxdcu0T+fDFx6a5aAWjiU292UNzpjcpiOTn7W0ka6d05VOhMswi2lvuiC1
         Fc0Eb8e1BoiteLGWjTXCJneaN6aZ03oJvg7wLGPj/ncOqTIyLnYsOmM/JzGlSAhIysQV
         vi+iq+qKeeqQMF/nvaxT92CFQa67aerYqKVUl3eywt/bp98ZiPV4qajMJ9ilGIaQJcec
         6m4zbyV3B3Oz+XKWHFlq3BvMACZJ0BqLzY9qsFoJZXyzCN2MmtuarYx7+lHeweoFMZ95
         97Pw==
X-Gm-Message-State: AJIora8B3QbTwXZNzNPbYTn2n70cBYzZa2z/7+/H3wjHXdVo0qHCxH9B
        IPmKrkIwb8TNg3MDothh2ERxfw==
X-Google-Smtp-Source: AGRyM1sU96AoUiSmtK7GcqHBoEun+kgEcDD3k31uifc31fPwq4I7gS9lnhrtoen40aoC/4x5NeFCmg==
X-Received: by 2002:a2e:908d:0:b0:25b:cabc:31a1 with SMTP id l13-20020a2e908d000000b0025bcabc31a1mr15627633ljg.32.1656921335008;
        Mon, 04 Jul 2022 00:55:35 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id a9-20020a19ca09000000b00477a6c86f17sm5017773lfg.8.2022.07.04.00.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 00:55:34 -0700 (PDT)
Message-ID: <0821acfe-bcfe-b1d8-c1a9-81023f4ab6a0@linaro.org>
Date:   Mon, 4 Jul 2022 09:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
 <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
 <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
 <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
 <f86dd47c-0fc5-6c93-a49e-534610d10c49@linaro.org>
 <dfad8fb5-6205-d620-81eb-5d44b9175e05@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dfad8fb5-6205-d620-81eb-5d44b9175e05@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 12:04, Fabrice Gasnier wrote:
> 
> Then I no longer get this warning upon build. But the dtbs_check complains:
> ---
> connector: ports: 'port@0' is a required property
> 	From schema: ..
> Documentation/devicetree/bindings/connector/usb-connector.yaml
> 
> So It looks like to me there's something missing to handle the single
> port case in usb-connector.yaml, when using the "ports".
> 
> Maybe usb-connector could be updated to handle "port" (w/o unit-addr) ?

Not really, the dtc warning looks false-positive. Especially that you
need port@1 for USB 3.0 (super speed), unless you do not support it?

> I'm talking about:
>     required:
>       - port@0
> 
> So, I came up with:
> 
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -176,6 +176,9 @@ properties:
>        port number as described below.
> 
>      properties:
> +      port:
> +        $ref: /schemas/graph.yaml#/properties/port
> +
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: High Speed (HS), present in all connectors.
> @@ -189,8 +192,11 @@ properties:
>          description: Sideband Use (SBU), present in USB-C. This
> describes the
>            alternate mode connection of which SBU is a part.
> 
> -    required:
> -      - port@0
> +    oneOf:
> +      - required:
> +          - port
> +      - required:
> +          - port@0
> 
> 
> Do you agree on this approach ? (I can add a pre-cursor patch to this
> series, to handle the single port case)



Best regards,
Krzysztof
