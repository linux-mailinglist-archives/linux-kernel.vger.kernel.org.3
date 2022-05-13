Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3B525EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355885AbiEMJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378578AbiEMJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:33:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE820D4FF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:33:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h16so9939859wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=iI3J6M1c5C8y5M42ZpMfl0r//lsinVxxLKzK6eOUa+g=;
        b=IGYqWfrSe/zPdzA+FAV8IXXHkrsYYwh17HRvpEGw9XCStqqe3r97vxTIFNNCz75GST
         zeTJHwhcBSeB4Spp+OCiaH6Ee8HzIj1zSxthAHwwch3k96WO+pz5fYUFAcrdRb5I0G+H
         r+sZaqga//r0OrCu+VvFbyB0AYE3NcdP3f2rsFj5IHbzkJA++ETAkaj4yqglyw0GmgUb
         M2HXBYz/Mq76XSUfbplsMpdvwv5/wdfhDBe5nC1MaJ/ZmLg7C02JfrCbQjY2tKyHERrS
         EhVNEdrbL4DxKGN+8/oIA5+eLnNMaSidXFAE2n2Y7Swo4y1LBdt413SomXermFA7BHnR
         oP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iI3J6M1c5C8y5M42ZpMfl0r//lsinVxxLKzK6eOUa+g=;
        b=l6vSIhevK/rF4c1N5ftqWvYYNcMKmURY2ZaUKeg/EDw7hlLRxfH+2iUtbSIy68OjgM
         gxIvV9zGXkh8iocOGJ+KwYFIDFtAy8kkHRqOsWTWRDXjkrpZkmEE/KrYV42MiUgJwn+F
         WkKSDdVBljseZWLltUh6Uq7NPCj7ufEgsH/FlnM/fmsdvLx3MQ3Y8TljNUjYkmtAcg8Q
         zAOGEU0aIo+0STyg+kQ0oxFXG2QcOoQf3NGA4QDbCyOCIDpGW5TX7JRlVGK5lKp0ZJCB
         TPQir61A3hho0E9zq5FI4d0psSXORpS9HsZ+5zJUwKGYIly46weJ+DrCnBMSZL/z2pDf
         9nyw==
X-Gm-Message-State: AOAM533plZjMHv4qxDQgzX0Lam+AEfUzMS1BlbOznn7eBytbeLo0qa5E
        pAOLaTPDRv6IKEcHFtTO1+5FPQ==
X-Google-Smtp-Source: ABdhPJzvZbiscTccrd3tJU+uxCEixUkPIVIKLgalKrvbjaWWl4ngAWd5lJ6uj4iWaC8Tjm50jASYAg==
X-Received: by 2002:a5d:640f:0:b0:20c:9be6:30c1 with SMTP id z15-20020a5d640f000000b0020c9be630c1mr3066931wru.273.1652434402658;
        Fri, 13 May 2022 02:33:22 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c13-20020adfa70d000000b0020c5253d8f7sm1729851wrd.67.2022.05.13.02.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 02:33:22 -0700 (PDT)
Message-ID: <51a9cc50-72ab-2417-1a22-0d85a944d00b@linaro.org>
Date:   Fri, 13 May 2022 11:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/7] arm64: dts: qcom: Add PM6125 PMIC
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
 <20220511220613.1015472-6-marijn.suijten@somainline.org>
 <7c7f7036-e3ad-c9db-2c31-749e2d01e83d@linaro.org>
 <20220513092551.hvz5jvej57cgvavj@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513092551.hvz5jvej57cgvavj@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 11:25, Marijn Suijten wrote:
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>
>> No children, so this should not be needed, I think.
> 
> The size-cells or the entire node?  There's a PWM/LPG block here
> according to downstream DT, but my device doesn't use it so I can't test
> that it is valid.  I can add it anyway, presuming reviewers here have
> the ability to validate it for me with a reference manual.


I mean only the address/size cells. They are needed for the children,
unless some binding expects it?


Best regards,
Krzysztof
