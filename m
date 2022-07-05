Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD15566741
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGEKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiGEKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:01:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7F13E86
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:01:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u14so13892192ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U9PFsZB/0/QmRDr09pEYPH9caFXecL3SOxTVBS97+JI=;
        b=wJ0jItWtosja/wQoJjQWUnJNtMedQ0Paoz9oR1YCGkWbN/mX7p9BbtGW0KibSdpqe3
         bQ04O/a8BT+HQ4AK3ufi8ansChrgSSzNZp6E1yKDrZOJDvGVRMyRvrmsCCfCF5nyAjiG
         A1c+Tckjym7I8zO1Kb5DOmaCjLvOuXQeCrEyTpOvlb91y2TUCS2SGAVx2viDOF2Dqz8x
         /nPY1OiCvFilgLZQLnm2jxqu0ZU1+S/nNcRCongYMEK1qYkIOyFLQwRw9CJ3YSbcRJDE
         h34jXHj+sOBFuFHeyGRMyz/2HLprGosDvQ1taUp+D+KYhH8CloW8Id+Dimkz/xz1KFtc
         MmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U9PFsZB/0/QmRDr09pEYPH9caFXecL3SOxTVBS97+JI=;
        b=yIQ3DzQA0KNuOlf4wyqEpCgSvl0NWJrk3WnsAP/3cM/WCBcJBv+zRZ4mTYneOAbhz/
         ACDKCc4KcE+e8D5aFmQL/Lx9tiNRwbSt284/9iYlefkOQ9hJO+FHGGYUeOUlpn+Me6Yd
         8A1m4yi/z94Sc6rZKfEsnymhwWMlXbzeuetVLGCxEbcdZRN6mSlcKFitkge0l8QIHvPK
         lRIOu357VgWzpUcsrO7aLpvwiAJl5NcCt9VWVM0bMfEjZYB4AnR/LFgWCxO9wzlHF1Pf
         WZEbqDwXnricGgSOFna6iLpF7hxeX0hLv5h99ZgVCKfmzv9wVpYp//fV/OkWihYNJz/U
         MJUw==
X-Gm-Message-State: AJIora8IxGRESzN0zKm5ELZ1i8eeH6VeIl+KES4VfE8eLVsLG+rL4Yjr
        irTWiX+ESJrHHLRuIEYQFd4VwQ==
X-Google-Smtp-Source: AGRyM1vZzAee/PdXNufa+In8yExr4AGKcMzQRZAvFKn5/GGjH7hPM3pVeIBp/gKb93qyLkk6yYkE3A==
X-Received: by 2002:a2e:b8c2:0:b0:25b:6b0c:34e with SMTP id s2-20020a2eb8c2000000b0025b6b0c034emr10195075ljp.397.1657015305041;
        Tue, 05 Jul 2022 03:01:45 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id r1-20020a2e8e21000000b0025d2ed848d6sm465617ljk.24.2022.07.05.03.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:01:44 -0700 (PDT)
Message-ID: <7ae2f396-7cee-7a34-2148-b2a1b7867751@linaro.org>
Date:   Tue, 5 Jul 2022 12:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/43] dt-bindings: phy: qcom,qmp: fix bogus clock-cells
 property
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-2-johan+linaro@kernel.org>
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

On 05/07/2022 11:41, Johan Hovold wrote:
> The QMP PHY wrapper node is not a clock provider so drop the bogus
> '#clock-cells' property that was added when converting to DT schema.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 5 -----
>  1 file changed, 5 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
