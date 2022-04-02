Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CA4F0488
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357353AbiDBPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357351AbiDBPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:46:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D73467D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:44:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d10so1423451edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KZ8/fEAK8gL6LZf1WUUUrVlQCOQtgCe3PxNJlYV+zLQ=;
        b=MfoUHg62C9zk6zb6ueTF1mLsAKxV8QDuTMoAWqMD6o1v0e3w5nAK6/9uvgHm66VbxM
         avejGNV4Lc/W3xweAqk8X2jbcvY5Gh3YSmNbKUZLo9GU+u1lLdaIcs7mu+CUX+6/JYRI
         MRzwWN3qndxpLEbVD00PLvfIy1wnW8D/aJ9RlBaIYBoJ326rOx2dCrJ2fyFfFMifOKi1
         HrK0qg02dDM89aZGh9x5bEZlgS0e9cipFT09BT8IpoqyOy8aRX3Eyk5xU5zqtmfpM7Fv
         0ZICKl+PkKvPmseQQO0BTHOePdNVV05erEeCpdtt4oAOQTyYkWn7zjB+xtluVr7nOUJl
         yC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KZ8/fEAK8gL6LZf1WUUUrVlQCOQtgCe3PxNJlYV+zLQ=;
        b=T4fjNmhsjE9ACH8o9B77sJODcOLobCFeT+0mPE4br95plL7atFL40H1E5tmIWWew6R
         O9Lq0BHGe6WDxYJJlM/el7telYPUQd1rDXs6T5DHG5BuqyqalZ80q1+zLTqvqZWeLzPk
         loWh6JuH4E1IY/5FECLyinIEO85Hxnq4bHSI35fKONCAZ7FObm1k+s03JkwM6AYqScHH
         sAH+Dowq4HC0Uhp79VwFHs0+YYCyNxMjD2x48vmd1vj6aFGZiwJpB3n+aKNx7B1HWo2f
         Kq1BTRi6iGDp4dAWMqfRggPEadHMYaZdNzfFE9aIIX2/fmu2JjkGr2Ppt80u0gZsnRin
         w76g==
X-Gm-Message-State: AOAM531Z2z81Wv43mPQmyen9HuUzA+nptN+VgfLpxv7QluxJIE5reMon
        AzEk7AeMP6XYBRhIMnsnv8uPTV8WOcILhw==
X-Google-Smtp-Source: ABdhPJwNHUoqs/nTqT9b4RQ3iE3pAQn7Q5456kJUCETm6XcoXqoTI19RlOdwMsCodSspxOC/dhnzIw==
X-Received: by 2002:a05:6402:1749:b0:419:325b:f8c with SMTP id v9-20020a056402174900b00419325b0f8cmr26045752edx.386.1648914250882;
        Sat, 02 Apr 2022 08:44:10 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id sd7-20020a1709076e0700b006e015549bdfsm2162441ejc.53.2022.04.02.08.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 08:44:10 -0700 (PDT)
Message-ID: <4111496f-c26b-ee89-15ed-6902e58fde5f@linaro.org>
Date:   Sat, 2 Apr 2022 16:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
 <20220401230356.w7obr3nxl6673mig@mercury.elektranox.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220401230356.w7obr3nxl6673mig@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 02/04/2022 00:03, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 01, 2022 at 09:26:43PM +0100, Caleb Connolly wrote:
>> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
>> drivers.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   .../bindings/power/supply/qcom,smb2.yaml      | 68 +++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
>> new file mode 100644
>> index 000000000000..1bea1fef78b8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/qcom,smb2.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
>> +
>> +maintainers:
>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,pmi8998-smb2
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: usb plugin
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: usb-plugin
>> +
>> +  io-channels:
>> +    items:
>> +      - description: USB in current in uA
>> +      - description: USB in voltage in uV
>> +
>> +  io-channel-names:
>> +    items:
>> +      - const: usbin_i
>> +      - const: usbin_v
> 
> Is there a good reason to use usbin_ instead of usb_in_?
These are the channel names exposed by the RRADC driver, so they would have to 
be changed there.
> 
> -- Sebastian
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - io-channels
>> +  - io-channel-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      #interrupt-cells = <4>;
>> +
>> +      smb2@1000 {
>> +        compatible = "qcom,pmi8998-smb2";
>> +        reg = <0x1000>;
>> +
>> +        interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
>> +        interrupt-names = "usb-plugin";
>> +
>> +        io-channels = <&pmi8998_rradc 3>,
>> +                      <&pmi8998_rradc 4>;
>> +        io-channel-names = "usbin_i",
>> +                           "usbin_v";
>> +      };
>> +    };
>> -- 
>> 2.35.1
>>

-- 
Kind Regards,
Caleb (they/them)
