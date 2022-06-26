Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35D55B14C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiFZKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiFZKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:42:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9C12AE8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:42:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z7so9236822edm.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+7oDvDolVgyiWCBP1kGvDhx2VojLawcjdaZLLC+Q36w=;
        b=s6B+CpTs4RD/gcT1faaJi6ASL1l5+sjwqAltmmk46YurGaSsYbCZr16lzlZNTYBFtb
         CiBnpSMUKdq0DlYTvdb5vsrU1gMOwRt5vsSFFr3TKOMJFbaYyA6TBoktOa+Bn4A5BGiI
         KahyH4DScCPH6S/oe8Tz6vPR7r9Ewip0HtLcEUKs/mv2CkwDDgL6r5Fa0gpbJ9jJdAQ6
         YY9DOOdDGKWldDluxU0eVDBwbqLZ1hQ209Pl8DX7SnKoqJy34VLuSqnBYS43673oKJ5Q
         2ni2cU2cYyt/aoo32PmMZy1ewJOURm6AfBUtUScTZrdsZtx9+kAceYdpH5VwQR+im1ih
         bATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+7oDvDolVgyiWCBP1kGvDhx2VojLawcjdaZLLC+Q36w=;
        b=VMNRJncuJLuMcxF9FfL3MSZ5PMtL1EGNrm+FOHRBTGw1UhEbPT9tH3JYnYV+ZaeAzL
         l1//p/pF/3NjAPAlZAKTRRx3vEKE1X6wm/Z1ygkMJw2J1pAJo+icH0u/KOvfFWwd/1EE
         dB8/BAIPH4bNQh+rVPcUXIdGAvvcouJ4JKL+p2mu4qSMStTDFIp3jPBTRznd8KlhdlD0
         WntGwWzWGvvzLM704YYC0tGop8LZt7+kXDEBH8uiew9vhTpcNk/Oq95TGNTNGOVNIyK1
         rE9iuq8FzsJ+ygBpXidlpMFutb+gs1GdFlYqKCwd2o3U9f4dYUuh18NswDedUZCQxnpt
         24OA==
X-Gm-Message-State: AJIora+FblCHuXbRFAOk9OTa29o0hSLwD3UHDU3aOpzh/TH7STu++/fJ
        B2Ar0Dlby1wfboF7Fg6ZKI1j2A==
X-Google-Smtp-Source: AGRyM1u1d/DmBwJzEStyDHpQojeLaBFX8PgoTatK6v58i5U80IJg6lCXoo9PZ/Lil9R60f4Yaccg6A==
X-Received: by 2002:a05:6402:2929:b0:435:6dfc:c4f2 with SMTP id ee41-20020a056402292900b004356dfcc4f2mr10120571edb.284.1656240170903;
        Sun, 26 Jun 2022 03:42:50 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p22-20020a170906839600b00711d5bc20d5sm3561921ejx.221.2022.06.26.03.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:42:50 -0700 (PDT)
Message-ID: <8b384f4e-7114-7afb-98d6-af71709525d6@linaro.org>
Date:   Sun, 26 Jun 2022 12:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v9 4/5] arm: dts: stih407-family: Harmonize DWC
 USB3 DT nodes name
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
 <59d8a34a-a211-d00a-2243-6ad51cfa4204@linaro.org>
 <20220624204524.nveittak6ruksuvq@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624204524.nveittak6ruksuvq@mobilestation>
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

On 24/06/2022 22:45, Serge Semin wrote:
> On Fri, Jun 24, 2022 at 07:18:57PM +0200, Krzysztof Kozlowski wrote:
>> On 24/06/2022 16:16, Serge Semin wrote:
>>> In accordance with the DWC USB3 bindings the corresponding node
>>> name is suppose to comply with the Generic USB HCD DT schema, which
>>> requires the USB nodes to have the name acceptable by the regexp:
>>> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
>>> named.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
>>> ---
>>>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
>>> index 1713f7878117..7ba528315dbe 100644
>>> --- a/arch/arm/boot/dts/stih407-family.dtsi
>>> +++ b/arch/arm/boot/dts/stih407-family.dtsi
>>> @@ -725,7 +725,7 @@ st_dwc3: dwc3@8f94000 {
>>>  
>>>  			status = "disabled";
>>>  
>>> -			dwc3: dwc3@9900000 {
>>> +			dwc3: usb@9900000 {
>>
> 
>> This does not apply. What tree is it based on?
> 
> That's weird. The series has been rebased onto the mainline kernel v5.19-rc3.
> Do you have the stih407 dtsi fixed on your local repo?

It conflicts with my change:
https://lore.kernel.org/all/20220526203632.831039-1-krzysztof.kozlowski@linaro.org/

I'll apply with local fixups.


Best regards,
Krzysztof
