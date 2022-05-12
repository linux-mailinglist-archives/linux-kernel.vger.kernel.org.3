Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB115247FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351635AbiELIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351542AbiELIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:37:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4848B080
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:37:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z2so8750846ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nv8lNSH0gbtDRGd36VCloQ6uZGegVPpsw/onrG8x3ew=;
        b=yzFJE4m26cI254ywYC9KLHQeXSX1cl8syDdlPf27qy+G0mcnTD0mjfjwiZWKfNMCVG
         bimWGCB8dEaE8pCVPoXHBIvO7B5ruTyh8RbzEW+KTU6Q5Ur68C/0PrfR3gwonkuZILKn
         XBEDBiRH3pEBoR0p9xzsQt3QSUfqEAs/l0utOohuB3A0+eVfGEEDm4GR//oeVo9nocC3
         LnRt5HKYPC2gNtKH09R6CWG2p1K7zb/RLei1GCX0WchH+T1PnfXGnQjsTAoGFMoDKMOW
         H5nABG6HPcz+QYi/kx0YLqNgwtJ8GZFbXjbKK4i/3dOZRUBZIBAgKzxeIiS4MEw/xpHm
         KeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nv8lNSH0gbtDRGd36VCloQ6uZGegVPpsw/onrG8x3ew=;
        b=NimQzRnuGScF3ufbN+nmvefnR0IG28CQtRO4EQnMM2qx6WnFsmusdA5aJdEXKfiApm
         O5tHegMIYB8lKmsF3aWiIGA4rhNqJsURtd7lZ+bISa0qY2ByJbMxiklmYz//rw9NAAV8
         crK65OP/D9q9vnBS69hvWKdzD9qgUNpHr8pWvfD2p9S3HVnCeERDUMK5cFzdvTtFTp35
         Yqi6La2w90oOkGj9PF0SbDIcpUrV3GgUjJo/jZAurBTK69q3v+iCyOnkJ6F9qfOvsjAE
         EUuZY/sUmXSScHfDeK4a7qZ49p05soHFPm0BFMrqxOXj3JN0RIR3gEcZIroB6WOHuPXQ
         8cvw==
X-Gm-Message-State: AOAM531GA88b/NPzF4CGqiN8Ms7PE8Ru+laLgDUkO4K3mjDCNMjN9m1A
        xBdad9xV1NqJXeMuzzNgDU9mxw==
X-Google-Smtp-Source: ABdhPJwZLwXF5gGhpt3H78T3NZu8Rwtld52oms13g3NCCt4/CVIBRMHb30iIrWeu9SanSWzwVRzyKQ==
X-Received: by 2002:a17:907:86a0:b0:6f4:fc1f:30d9 with SMTP id qa32-20020a17090786a000b006f4fc1f30d9mr28654321ejc.708.1652344618652;
        Thu, 12 May 2022 01:36:58 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ko21-20020a170907987500b006f3ef214e28sm1881071ejc.142.2022.05.12.01.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:36:58 -0700 (PDT)
Message-ID: <30c18480-bf0d-82b9-5b11-daa3b70c40df@linaro.org>
Date:   Thu, 12 May 2022 10:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to YAML
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-5-sireeshkodali1@gmail.com>
 <00234f36-9bae-31d5-5b83-ea238e7e3c11@linaro.org>
 <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CJXL0SG2GHN1.1IO2JOR5ARNV8@skynet-linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 08:50, Sireesh Kodali wrote:
>>> +    description: The names of the state bits used for SMP2P output
>>> +    items:
>>> +      - const: stop
>>> +
>>> +  memory-region:
>>> +    maxItems: 1
>>> +    description: Reference to the reserved-memory for the WCNSS core
>>> +
>>> +  smd-edge:
>>> +    type: object
>>> +    description:
>>> +      Qualcomm Shared Memory subnode which represents communication edge,
>>> +      channels and devices related to the ADSP.
>>
>> You should reference /schemas/soc/qcom/qcom,smd.yaml

It seems it is not a SMD driver so above reference is not correct. This
should be probably described in its own schema, I just need to
understand what's this...


Best regards,
Krzysztof
