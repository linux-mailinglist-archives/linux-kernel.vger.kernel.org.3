Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEAE4E1B57
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiCTLos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCTLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:44:45 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050C922291;
        Sun, 20 Mar 2022 04:43:22 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id o10so6173772ejd.1;
        Sun, 20 Mar 2022 04:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MdRORuO5rA49EY4CNBNxdiWNF+N36fghP5BMIssSxRw=;
        b=OScCUigDeR8Q97aybc1JM6Fa86j2z5WUtd4dNbrX6IEVD+ZsCV+KsJV6thmIxXSFlN
         lk8JdLBchuU8TE4pB2Fc4rXvQY+gHS6CkuUCp5ncvJ1eeREq8asTc+vuP0noyjGwr+rn
         znz0u0UbryHm3dxZC5IvGmF5DP1cEaVaJLKTQZ1bDjk3F3kdauhokZCFpqcjxaXhaZY7
         Etzjop2tFWo8KuNP+ebm9MXBrVB2yuNqKjdZbkg07se5mQUMTdoHSJiSSrCm7H+kREub
         XsjhGONSy7QDrkWNFk3Hx0oy9N6Ry+aA3YRvf6790VzgmqbymrqmiIaIMeaELo5KgKhU
         Xjcg==
X-Gm-Message-State: AOAM530xBWRuDbWfpeEyethTQPA0WFt+OiHKNGsHNz+Kty1iSOspNOrx
        SbdE0W8IgnbJmNnpMZ+xiXM=
X-Google-Smtp-Source: ABdhPJxZ/unqku39jnaG6CRZB+TRKVxT61WyxhQ3KXHNkbK58qYss9hxrYmX/p3w9LUCv0eiRlPcRg==
X-Received: by 2002:a17:907:60d3:b0:6db:8b59:1564 with SMTP id hv19-20020a17090760d300b006db8b591564mr16494132ejc.228.1647776600471;
        Sun, 20 Mar 2022 04:43:20 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i2-20020a1709067a4200b006db720b1231sm5914265ejo.2.2022.03.20.04.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 04:43:19 -0700 (PDT)
Message-ID: <a79087bb-516d-be29-1139-20c0c4126fb1@kernel.org>
Date:   Sun, 20 Mar 2022 12:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
 <1647410837-22537-6-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1647410837-22537-6-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 07:07, Rohit Agarwal wrote:
> Add support for the PMX65 GPIO support to the Qualcomm PMIC GPIO
> binding.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
