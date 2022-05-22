Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2547C5301B9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiEVHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiEVHvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:51:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038C659A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:51:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v8so18843173lfd.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=88owq8uKXDsheKyfsbWWUMK1Cxn07lBnqHB3aJaGB1U=;
        b=HVhU/XPrfs70po+5RBr7uTXEFc/VT5WW15xfZyh/B66A+4JMDjApfrPm9LRtsDlVDx
         rn4F21ZXGLeqWNK6TPvES0lJnTpmWCfIDKIIQKrhwl5a5jq+U03iw57s2C+vvGGiEaTa
         K92fGdP1dmnlb2nq/bKbPysPtwIOUuZc0KgZ3pzvbRgmExF722IxMHjeKrj1xbqGKvy0
         OHdyWGfX/JJXBD6AvvCredZcZamJSn5dzrg6726hKyC+yDDqAZxIF1ZnRyWlxgAnF9tA
         x/zX17rGo5nQAgaLZYBoVVJG9yl9byHEjzzdusuHaqplRK85L/MKn+jf/6y7/vBOO7G9
         Q1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=88owq8uKXDsheKyfsbWWUMK1Cxn07lBnqHB3aJaGB1U=;
        b=rfNiIw6KjfNF6ztXNpdRyEedblmQnkAxgkU0+Wme19DyhwyV+4KT29vN3fKs1ef+Zc
         eBo6dW7P4APE4gycwM0rZ5Nbz4U8juZngqn1DhhzrSHKkEvkI9vBDPZkG+RX4pWmmvax
         hsVMIxRZtwmDeYulXegFh5d9GBWxc6cdF1LKiu8LGA9XbbCPpipEGtOCyDl/GuhAyISD
         lY6rI2gykLKGxUPvPdQPFF7u9H0bXrJ65Kd29ZzSG/fi4CM0jRtrH008wY1vICYYSCkn
         KVS3pUSF/OuYT0/jTD9+pbe4KrJ3bZwELbQb5RjD+RVFaQZJQwiZL1U3XusAAj1GjzDA
         mzew==
X-Gm-Message-State: AOAM533Rz4pgNh8BvVoTAcg1eiQ4xH0BkU3haxPEPhpDPJTmMr/paZMw
        m6jhbWtf00Ie2BZ6cSe2yZ+Blg==
X-Google-Smtp-Source: ABdhPJxn3SFCU7olnoR4mSUevcHXgr6rUAve15/U4XQVAOEFghCkWDWlZk6zSIXXpDyWWLZER5dIUg==
X-Received: by 2002:a05:6512:150a:b0:474:bb9:5174 with SMTP id bq10-20020a056512150a00b004740bb95174mr11826565lfb.207.1653205869755;
        Sun, 22 May 2022 00:51:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25286000000b0047255d211c1sm1354476lfm.240.2022.05.22.00.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 00:51:09 -0700 (PDT)
Message-ID: <e15d74d0-2cae-230f-a410-0e1106f490a3@linaro.org>
Date:   Sun, 22 May 2022 09:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: mips: Convert plain text file to ReST
Content-Language: en-US
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20220521015613.6197-1-soumya.negi97@gmail.com>
 <7fd80a4b-5e60-0117-b790-359f6d94aeef@linaro.org>
 <20220521202412.GE14144@Negi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220521202412.GE14144@Negi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2022 22:24, Soumya Negi wrote:
> On Sat, May 21, 2022 at 04:25:07PM +0200, Krzysztof Kozlowski wrote:
>> On 21/05/2022 03:56, Soumya Negi wrote:
>>> Converts .txt documentation file to ReST format(.rst).
>>>
>>> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
>>> ---
>>>  .../devicetree/bindings/mips/cpu_irq.rst      | 56 +++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.rst
>>>
>>> diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.rst b/Documentation/devicetree/bindings/mips/cpu_irq.rst
>>> new file mode 100644
>>> index 000000000000..601cc12caa2a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mips/cpu_irq.rst
>>> @@ -0,0 +1,56 @@
>>> +=============================
>>> +MIPS CPU interrupt controller
>>> +=============================
>>> +
>>> +On MIPS the ``mips_cpu_irq_of_init()`` helper can be used to initialize the 8 CPU
>>> +IRQs from a devicetree file and create a ``irq_domain`` for IRQ controller.
>>
>> Bindings is not a place for code. No.
>>
>>> +
>>> +With the ``irq_domain`` in place we can describe how the 8 IRQs are wired to the
>>> +platforms internal interrupt controller cascade.
>>> +
>>> +Below is an example of a platform describing the cascade inside the devicetree
>>> +and the code used to load it inside ``arch_init_irq()``.
>>> +
>>> +Required properties
>>> +-------------------
>>> +* compatible: Should be **"mti,cpu-interrupt-controller"**
>>
>> If you wanted to add bindings, please use DT schema format (see
>> writing-schema, writing-bindings and example-schema files).
> 
> Hi, 
> I don't want to add bindings. I want to the convert the doc file
> Documentation/devicetree/bindings/mips/cpu_irq.txt to ReST file format.
> 
> I referred to this page(https://wiki.linuxfoundation.org/lkmp/lkmp_task_list) while
> creating the patch. It also mentions exceptions that should be kept as plain text 
> files. Does this file count as an exception?


The original file you mention is a dt-bindings file, not a doc file. As
you see it is in the bindings subdirectory. All (or almost all) files in
Documentation/devicetree/bindings are bindings.

It should be stripped out of C code and converted to DT schema (and
moved to interrupt-controllers), not to ReST.

Best regards,
Krzysztof
