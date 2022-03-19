Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B834DE8AA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbiCSOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbiCSOlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:41:44 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E431350AA;
        Sat, 19 Mar 2022 07:40:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a8so22017488ejc.8;
        Sat, 19 Mar 2022 07:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=51MF7CMveV1FPVM1stqHHfoXDZB2HvnqZFW3qb4HPvg=;
        b=cjBBtzZ/bCyS/+mJFqLgANsj/Hg6naP00ah/JRvFX6qcHLekF8sLAz9Cx/2LsZTU8N
         6rdSrDBwThcOLWNCtg78owr+dYIzkY2O90/i6ERLGbjW/wLO2blHc3OiZDSVLTES7fv5
         6mC/UBxIS90ycAHkigaov20vnSV38kTdGLLxRCYkrTLA3EdPNEJVUVCohInSdeWsaTaR
         NC1tovojcbmde5kd0h2j2fikTtKjCMVzAA+g6d8kv61UZP2B47cX+k7DV9W69NcdjLd4
         NYYgnTYCHrALYwz/tRMi+4v/NXw1rla1T0qB+5qtS0SMLjBKcQAZn3Ak3aqaRuIWF1F2
         agHg==
X-Gm-Message-State: AOAM532vFkWGiQZudTIzE8njDyON/SS36IOEHjIS/I8UyLRaCn8JbRmX
        a0X8Aj4y7m4rv4manBn64aU=
X-Google-Smtp-Source: ABdhPJzTCHBns8Of5aWkggpbK2hL/YYJMUO6iz0EeO/XI+KIAn3YnmSkyRfVvIMxKQxf1sKzq+oq6A==
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id rl15-20020a170907216f00b006ced85f35cfmr13488896ejb.517.1647700820629;
        Sat, 19 Mar 2022 07:40:20 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm5752540edj.49.2022.03.19.07.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:40:20 -0700 (PDT)
Message-ID: <ae73a362-cbfe-4e33-37a3-61614fcde9c0@kernel.org>
Date:   Sat, 19 Mar 2022 15:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/6] dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY
 bindings
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
 <20220318183004.858707-3-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318183004.858707-3-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 19:30, Luca Weiss wrote:
> Document the compatible string for the UFS PHY found in SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index e20d9b087bb8..934aa9101ddd 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -39,6 +39,7 @@ properties:
>        - qcom,sdm845-qmp-usb3-phy
>        - qcom,sdm845-qmp-usb3-uni-phy
>        - qcom,sm6115-qmp-ufs-phy
> +      - qcom,sm6350-qmp-ufs-phy

Please also add constraints to clocks, resets and any other necessary
properties in allOf:if:then section.


Best regards,
Krzysztof
