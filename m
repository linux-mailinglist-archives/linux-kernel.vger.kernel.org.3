Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775EE530D17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiEWJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiEWJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:32:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5234831A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:32:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u30so24517969lfm.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q/enRC4Ndz4RqDlyz4L9YUMSofmx3n7/SL/Bs97Wk3Q=;
        b=QhiWAAuT0jPilgzGT7fIdpELX0vQ6jhKPNS8nhXl2gWonYoAu+EHnvrwQSkDYiJR90
         CtNWLYifRPmxpQdXETswWp7vhbAqQ9m7VPvn3dQ/HWYOvrwU8pRU4xehYTZJZu1lRPSn
         ixsqbu2EuZB5UIi4iAx1QSXw+O8rUbEx8/rzBsadFl8KDXPDKhYbE5pcw4z6qOZkXcRx
         czq8MLhJk2f1lxzqYil5dpALdM5nbwoVFNyaLX1y4INoAubChMtGGKng0NquWZwMobbZ
         Z1nwB3hItnAMlZZZFHHyAnowwtGkScMP+zFcSOTkthWdyn9JZ6TTmgO0qznf8g/zCqHM
         WQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q/enRC4Ndz4RqDlyz4L9YUMSofmx3n7/SL/Bs97Wk3Q=;
        b=BP9M8jUNQvwBxFOpNQdgLTaYvNr15HZ6x2s4iYu7I5TYPQZU9nfQHu1whb1NoRqaRL
         AHhxMVYHcL1h+muy/knYLcb7Mw5eqQx83WqYkqlW2fzy6gcKcx608c3X519XDFzdkXN+
         4COkNMcs9IpVJvS4YKg0bYuT9zUp/85o0PYsVA2b0LuY4UNbuLbfxpKkH6NKA5KjY+lN
         /9U8lOvybiD/W6WTTkc67UXJB2TBcgPeKuITEJyCczikWxS4JWUxDmoEpJWNuUxnqenT
         Q308pRa7EKPHvN3K8xgdzJ826TfNs74JIet970TfbGscq53aDvuE4HvcAs1qI1Nm9tsf
         21og==
X-Gm-Message-State: AOAM533yUf1i5qVymwyuEjp0+K4A3f3xImengXlZs8z3BppdJ/3Q2UPT
        WlG97p7jP1sv3+DglA6nTI2dvg==
X-Google-Smtp-Source: ABdhPJznnYLmewc+wlf0ynuOnOuUsSH1C1ZEqLM25ELA8J0sHBc67y/sesioWbSz11SWEPuu9vXrVw==
X-Received: by 2002:a05:6512:2594:b0:478:62a1:3b17 with SMTP id bf20-20020a056512259400b0047862a13b17mr6838443lfb.274.1653298369500;
        Mon, 23 May 2022 02:32:49 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13-20020ac2596d000000b004779f2f2bd0sm1883802lfp.44.2022.05.23.02.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:32:49 -0700 (PDT)
Message-ID: <d4ab965c-d193-3b4b-9b88-95b8b2b40f80@linaro.org>
Date:   Mon, 23 May 2022 11:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220520172422.4309-1-Alexander.Steffen@infineon.com>
 <20220520172422.4309-2-Alexander.Steffen@infineon.com>
 <02596f22-3d19-8872-75fd-2a8f563c8270@linaro.org>
 <8f0d2098-8c7f-2347-3004-bf3e422de3a3@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8f0d2098-8c7f-2347-3004-bf3e422de3a3@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 10:55, Alexander Steffen wrote:
> On 22.05.22 10:30, Krzysztof Kozlowski wrote:
>> On 20/05/2022 19:24, Alexander Steffen wrote:
>>>
>>> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>>> +
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id of_tis_i2c_match[] = {
>>> +     { .compatible = "infineon,slb9673", },
>>> +     { .compatible = "tcg,tpm_tis-i2c", },
>>
>> Please run checkpatch on your patches. You add undocumented compatibles.
> 
> Sorry, the old infrastructure I had to do that automatically is not in 
> place at the moment, so it slipped through.
> 
>> Without bindings, new compatibles and properties cannot be accepted, so NAK.
> 
> Could you be more specific as to what the correct solution is here? 
> Usually, I'd just look at what the existing code does, but that is a 
> little messy:
> 
> 
> 
> * socionext,synquacer-tpm-mmio is documented only in 
> Documentation/devicetree/bindings/trivial-devices.yaml
> 
> * nuvoton,npct601 is documented in trivial-devices.yaml and is also 
> mentioned in Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
> 
> * nuvoton,npct650 is only mentioned in tpm-i2c.txt, but appears nowhere 
> in the code
> 
> * infineon,tpm_i2c_infineon appears only in tpm_i2c_infineon.c, but is 
> documented nowhere
> 
> * tpm_tis_spi_main.c has all its compatibles documented in 
> tpm_tis_spi.txt, except google,cr50, which is documented in 
> google,cr50.txt, even though it has the same properties
> 
> * tpm_tis_i2c_cr50.c uses the exact same google,cr50, even though that 
> is explicitly documented as a device "on SPI Bus" and lists 
> spi-max-frequency as one of its required properties, which does not make 
> any sense for an I2C device
> 
> * According to the feedback in 
> https://patchwork.kernel.org/project/linux-integrity/patch/20220404081835.495-4-johannes.holland@infineon.com/#24801807, 
> the text format, that is currently used everywhere in 
> Documentation/devicetree/bindings/security/tpm/, is deprecated anyway 
> and should be replaced by YAML
> 
> 
> 
> So would you be okay with just adding the compatibles from tpm_tis_i2c.c 
> to trivial-devices.yaml, so that checkpatch does not complain anymore, 
> and leave the cleanup of the mess above for later?

To trivial-devices you should add only bindings really trivial devices,
which do not have any other properties, even when the bindings are
finished. This means you entirely fully the hardware and still have only
reg+compatible.

If this device fits such case - no other hardware properties than reg -
then, feel free to document it in trivial-devices. However I am not sure
that TPM devices are that trivial... For example tpm-i2c.txt defines
also interrupts and label.

If the device is not trivial, it should be documented in bindings,
either dedicated or some existing ones.


Best regards,
Krzysztof
