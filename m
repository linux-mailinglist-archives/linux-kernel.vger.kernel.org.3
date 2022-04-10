Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A044FAFA6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiDJTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbiDJTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:11:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA114A93D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:09:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so3844915ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5JkRrTryndcAcm6OcrnDa89Ue3+33Y4QUxSNspsSwJQ=;
        b=jQMOqQjK8ECeAuONJ/eXIeYZfEF/NsYeDNyFbfnhGWSeGGwv+7XBqOE74P+ScXh72y
         WU7Saa5aanIF89yTRL5sDrSGsvA7MfRTCjGhb1dt07MO6L8VMsQgmHyAbLtmhtd4tjL4
         7KmcfSU6oCSLkaa/sYfS/ESxMrPdH4DT+vaUtBvf1Sr62pAT8ApKbFyu1BDgfOdm1BLf
         qv5MOrEr2lb6G7DOCkgPgzeb5+UmagvIzOhRzguCiQ69oDUi4Y3OMtXXjFUNoMsVQPPb
         /IjAZdxUs2DZWo1KA+vlGNPz+KrOoFm6EXSP276vRN0Wa94ezixdIgTGJoc2ta9QFScC
         q2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5JkRrTryndcAcm6OcrnDa89Ue3+33Y4QUxSNspsSwJQ=;
        b=7DArYN1Q0H0kzVxOfqRqlYuKnUhVVu+KOA+/nUugNTDZlBZ9OQWqO16wl7LT3Evt1c
         S+3yjIm4v5vgiuCyS93boHCD97Jp3Uif0rS0KBMHJB6VyFdeWQ/qrH0/lwCzzrYlg4sv
         j45ppsvx0GuW4rIYYsWK5RL9n29TGkZ/MOC2gA/jsLJguWXxVTTEc1ESHhI0bzvHVNiM
         cmtZU6HpAXL/UtEs8AXQQa0dSc4Hz3rYW/wNt/VHYRN+8nvioIpsAlOpo8fdVtwa3s6x
         V0zmjMmn9G5ONfzbZ7CtHKFBVBz9qgPvfoNZLaHui9zRU/jWRQQJhQxl1G87RsdHzYGZ
         f92Q==
X-Gm-Message-State: AOAM5328IxSLJ0s21fm1l/gperamXDgoqH9jsStdgt72ZE0HZ9+Tg3YL
        phUkDchWJmGLy6peScB+OQmAIQ==
X-Google-Smtp-Source: ABdhPJxIt1BQGH9pTziRD1CYXt68InR995ah5nQT3BEMylKyA5XH/+cyADgzqYFfZBUHr2W8I27hcQ==
X-Received: by 2002:a17:907:7f0e:b0:6e8:7f57:2d96 with SMTP id qf14-20020a1709077f0e00b006e87f572d96mr4180838ejc.7.1649617752909;
        Sun, 10 Apr 2022 12:09:12 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709063e9200b006e0527baa77sm11099291ejj.92.2022.04.10.12.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 12:09:12 -0700 (PDT)
Message-ID: <f147760b-aeca-0cc6-8d6a-eb2321839d1d@linaro.org>
Date:   Sun, 10 Apr 2022 21:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/6] ARM: dts: qcom: mdm9615: User generic node name
 for DMA
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-3-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410175056.79330-3-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2022 19:50, Kuldeep Singh wrote:
> Qcom BAM DT spec expects generic DMA controller node name as
> "dma-controller" to enable validations.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-mdm9615.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
