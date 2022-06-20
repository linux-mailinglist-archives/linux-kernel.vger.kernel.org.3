Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB87551608
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbiFTKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiFTKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:38:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE013F91
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:38:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so20182556ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+s1fQfW6DNhIDr3s4ER+coLI9K2pOkuofyZ5KAduIYE=;
        b=pespo32PKkFYzEq5EJWqDcxOhszBLeBhEb5WldaDOvrawNQ0XUVPX9Qx2JeaoUljDD
         N6oWawR1CV1MzBMPr/nOyuaL2Cehvs++OP2Am+VqYjlxQ9T8PSkDt3fW+dMc8v2rMs4W
         2RuBLcENxv2KZpo/dJpvfcM/zadlQN3VZzcI+o+0fkPYN8A+d9Grx3xleh+ohLiEX2WO
         m57jHavyliHkxhHSKGKUouJUJtcQwcbuwld3kt5tU5rs2rJb+lZ8E6TMXo6epM1XyGEd
         SJhPXK+9FmeAZ9meMT35SoXasnpS236pNShuY7+LXcakYxSeSIoLptC4Sua2HFIweXNa
         CKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+s1fQfW6DNhIDr3s4ER+coLI9K2pOkuofyZ5KAduIYE=;
        b=VoCvnWfwW8EjcRkPa+v+9Xz5Q9fD8vlhLCKkRIICDcXkYrNfLLsCjoWAjSMm76qzPY
         wvQ4NpFzOJWz8W5AcxpNioY5Wz6ka7E9x3mW2Z3q64Qga3RCb2skshk170CS9uQtqzyU
         zM1pvnt+Tp+A2Vkm1Qj7lPF4kQUlPW9kJNioyJKZBDwYsWArkiFTueolbuUmjWJJeJ4E
         nrF/TlHPL4irEEGw9LRXIfFjz9OKrToFLX2Ntr7XMZJFMS9Twx4JiH1dSRmIG/xFzSvI
         FHA5JbJoc+DrPSeQihxqhwbJatqByl6hBtnbdPHzeF+ght/+8nnWn9IFj7InzcFSFkR0
         ujBw==
X-Gm-Message-State: AJIora9Syoh1/tNxfyi7EZnm/GWHDuFt6b8I0xk1jEHAldLEdmTobRU2
        4fyfn5fWX+j/zucwmqSi+WI5Og==
X-Google-Smtp-Source: AGRyM1sP4TDttzlpu+tHrmPr9qEAwS7y6wDB+zQXWLVNnZGSmSp9/92ifj3N22k13BDkZ3sEzyxRfg==
X-Received: by 2002:a17:906:73d4:b0:715:701c:ae96 with SMTP id n20-20020a17090673d400b00715701cae96mr19568704ejl.50.1655721536603;
        Mon, 20 Jun 2022 03:38:56 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fq36-20020a1709069da400b006fecef65fc4sm5807864ejc.179.2022.06.20.03.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 03:38:55 -0700 (PDT)
Message-ID: <7c47bab1-cd64-cde1-a4cd-cca6514bc57f@linaro.org>
Date:   Mon, 20 Jun 2022 12:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS
 PHY binding
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
References: <20220618092201.3837791-1-victor.liu@nxp.com>
 <20220618092201.3837791-2-victor.liu@nxp.com>
 <b83e3100-edd6-4f91-75e0-8a87447d8a4c@linaro.org>
 <89a29795e918343583f45b0f8a65a002592f8b15.camel@nxp.com>
 <3f805983-47c0-9be1-f221-4cd23b847018@linaro.org>
 <d8af25c1d5e81d6b308c3162aae670f091b59bd4.camel@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d8af25c1d5e81d6b308c3162aae670f091b59bd4.camel@nxp.com>
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

On 20/06/2022 09:56, Liu Ying wrote:
> On Mon, 2022-06-20 at 09:35 +0200, Krzysztof Kozlowski wrote:
>> On 20/06/2022 05:06, Liu Ying wrote:
>>> On Sun, 2022-06-19 at 14:11 +0200, Krzysztof Kozlowski wrote:
>>>> On 18/06/2022 11:22, Liu Ying wrote:
>>>>> This patch adds bindings for Mixel LVDS PHY found on
>>>>> Freescale i.MX8qm SoC.
>>>>>
>>>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>>>> ---
>>>>>  .../bindings/phy/mixel,lvds-phy.yaml          | 64
>>>>> +++++++++++++++++++
>>>>>  1 file changed, 64 insertions(+)
>>>>>  create mode 100644
>>>>> Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
>>>>> diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-
>>>>> phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-
>>>>> phy.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..de964ffb9356
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
>>>>> @@ -0,0 +1,64 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: 
>>>>>
> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fphy%2Fmixel%2Clvds-phy.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7Cc7d6216ac12148ec95d008da528f78eb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637913073407696040%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=m588CiXOaJhWFbpEal3MjZaHtvOTUOVIujydIdPxSHg%3D&amp;reserved=0
>>>>> +$schema: 
>>>>>
> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7Cc7d6216ac12148ec95d008da528f78eb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637913073407696040%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=IGn5f05QrzyX05k%2FKgTitdq6OYN2FmdpsO6qHXun55Y%3D&amp;reserved=0
>>>>> +
>>>>> +title: Mixel LVDS PHY for Freescale i.MX8qm SoC
>>>>
>>>> If Mixel is a vendor, it needs it's vendor prefix documented and
>>>> used
>>>> in
>>>> compatible. Filename should match compatible. If it is not a
>>>> vendor,
>>>> then filename should be "fsl,imx8qm-lvds-phy.yaml"
>>>
>>> Mixel is a vendor. I'll document the vendor prefix and set
>>> 'fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum.
>>> I'll keep the filename as-is.
>>
>> mixel,lvds-phy is not a good compatible (and filename) because it is
>> not
>> specific about component version. Please use specific compatibles
>> only
>> thus also specific filename (filename should match first compatible).
> 
> All the information about component version I can find in the PHY IP's
> data sheet is '28FDSOI-LVDS-1250-8CH-TX-PLL'. '28FDSOI' looks like the
> technology name. Do you think the compatible name can be
> 'mixel,lvds-1250-8ch-tx-pll'? Or, any better option?
> 
> If the compatible name is ok, does the below compabitle property look
> ok?
> 
> ===================8<==============
>   compatible:
>     enum:
>       - mixel,lvds-1250-8ch-tx-pll
>       - fsl,imx8qm-lvds-phy
> ===================8<==============

https://mixel.com/wp-content/mixel/pdf/2018/MXL-LVDS-1250-8CH-TX-PLL_SS_28FDSOI.pdf

mentions entire name as a device name, so with 28FDSOI, but your choice
is also good.


Best regards,
Krzysztof
