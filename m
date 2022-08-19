Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD8599D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349576AbiHSOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349557AbiHSOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:35:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43075EC4CD
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:35:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so6348873lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SeHZ27XNszROnXvDUYzNdYyTiRb4BIM2jQzW5MqSyEc=;
        b=fbb2z35hagDVu/Vg+G7F5H05F7hWxuAt0ZwmlDzFzuM4i1aO4sFlU2Y00/zuyo7/5T
         8FlxQNdqmf3CE1KeZC3pwOhWFEibAmKmjH+OF9IkzzlGmMVM2bLySkK0Jyjz+90FiV4R
         db6WpvpkhZxEFJb2lhcNXg10wOC1Yg6bv+kseazCF2v3BFGbeoJDa5GEL17uqf5zHoVV
         WJFEt1ZOzRgc/MAQDMj72DDJc5KYg9GUStNnZwVF2dAdnNX6Vg/8VDTK16kSO+l5kBl3
         zSPhOzBx7G3NlCNRMTUmOOPxL++gXO14fdgr/yxsuQBLSTaOUrq/8Sr38zi8/kFOCdO3
         jCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SeHZ27XNszROnXvDUYzNdYyTiRb4BIM2jQzW5MqSyEc=;
        b=4MqTyNHVWv1t/AiBFhkbFq/Pcce9BXVazfpbvlPWyw50eQhRQ6kYWh/slkJrTr9YYi
         QkWhQyYfshGMIJuETWawz9bcXX9wmXy8nI0tbUespBQVRNIuQgUhoXWj3ANDTbA6qiRo
         X97lqW2lFLRrL0WLMLUUL3bDFeAxQETRZaCzeJ5uzPu7Pse90B7JGg02RpmmjLu0nfZE
         aQbghvCC8ccSyrXDD+OCecDa9J5z4DYYNinQhGi6sDk8Veq3BmxQLMJErLdu69po/smE
         LEm6vQcOY/2hDMAeQrmgaQU9uOvH5d8aObVpv/wBi6A5CIe+EPEjVkdHNjxSYug/XrPW
         BYIQ==
X-Gm-Message-State: ACgBeo2pb+Iye+S/RH08scrz4ImQcdHlN5VqqHzpMnc/qIOHGuWQKJIX
        4W0OM71PD5Udg4vfOU+wHv21HA==
X-Google-Smtp-Source: AA6agR7Zi6Ib+jSmmdNrH2FE8pP3qnIypeXUxNqJmIpV/7jD9ZnC1uDf4dVnk9URUxLDS2lqc7BDHA==
X-Received: by 2002:a05:6512:1193:b0:492:7e33:870 with SMTP id g19-20020a056512119300b004927e330870mr2642782lfr.37.1660919714599;
        Fri, 19 Aug 2022 07:35:14 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id s25-20020a05651c049900b00261c241d4a1sm35245ljc.59.2022.08.19.07.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:35:14 -0700 (PDT)
Message-ID: <200e3faf-e377-9fab-7cb2-bbea07be00cf@linaro.org>
Date:   Fri, 19 Aug 2022 17:35:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Content-Language: en-US
To:     Conor.Dooley@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        Daire.McNamara@microchip.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-7-conor.dooley@microchip.com>
 <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
 <3ffba600-bda9-8ffa-a435-9a6f94e072b8@microchip.com>
 <f3d8be5c-737b-8c71-9926-a4036c797769@linaro.org>
 <19ca2ca1-c678-c669-4214-e92416e37191@microchip.com>
 <138af26e-8e36-63a0-d3a0-5af866318839@linaro.org>
 <f8496006-7487-7b7e-1a53-ec38492dfe70@microchip.com>
 <4e12e8c3-2170-eaab-d910-f674bcc93f79@linaro.org>
 <560e80df-4819-1062-50ee-eb1d1d19bae1@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <560e80df-4819-1062-50ee-eb1d1d19bae1@microchip.com>
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

On 19/08/2022 17:32, Conor.Dooley@microchip.com wrote:
>> The clock names should not really matter, so if you have conflict of
>> names among multiple controllers, I think driver should embed unit
>> address in the name (as fallback of clock-output-name) and the binding
>> should not enforce specific pattern.
> 
> Not sure if you just passed over it, but I agree:
>>> Truncated base address I suppose would be a meaningful thing
>>> to fall back to afterwards.

Yeah, indeed, you mentioned it.

> 
> But if the names aren't an ABI, then either there's not much point in
> having the regex at all for clock-output-names or failing the check for
> it does not matter. I'll have a think over the weekend about what
> exactly to do, but I think the driver side of this is clear to me now &
> what not to do in the binding is too.

Yes.

> 
>> I can easily imagine a real hardware board design with
>> "sexy_duck_ccc_pll1_out3" clock names. :)
> 
> If Alestorm made a board with our FPGA, I could see that..
> I'd buy the t-shirt too!
> 


Best regards,
Krzysztof
