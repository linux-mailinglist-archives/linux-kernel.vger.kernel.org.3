Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B055B153
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiFZKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiFZKtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:49:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CAB13D48
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:49:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o10so9323218edi.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mmEZuF3sSMd4FiYZEbnqFV/YPFODuaItHC3npgDdbmY=;
        b=sAMMH6H1Igx/l0oc1TMDg0yhWD2+7xxpQaRJDVU6VU99ReByrwf8ByJmoIccKcHJSm
         142dAFEQavZd/Lmt6SXt8gOGFKGqQgRV2VE7d0t2EIm0REzEjNN3T1s6/KoJu3XjI82Q
         WMx9uHdTA3us9tlf1cJtjA2qmFZh29yPpUTMg1rKPB2a59W+6SmYCIvI6cNupMNVhk+j
         FwrhlWmqH+MvVAEdOyw5O86MjNyqIr149R6dLVMzWMq8Eee9z1WWZtNEzFQ1x22A0J9e
         NiT8yRtxZbHC2i6+utob8AGe5tnCIFEMB3gF4Fw+VADCwTtmXWXPhvNa4omYr/YSeldv
         S11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mmEZuF3sSMd4FiYZEbnqFV/YPFODuaItHC3npgDdbmY=;
        b=5I1MjoIyrOmjQa8NbomsobaCyyYqZfXKxkbapQYI4oA26M4cipPDrpmtJshkMqBjUl
         yX6DMESQdXcx0hD9tm/0l7IZrFL1RYFPYW0hIrR6AMZg4r8maK08U8Pd6mbb3X68V8Xg
         Zots43S4YYKbcy6YuxO35EZdyS1Grg12iKQQdO3YtdRXUbuR9HshP3+vrsWPkxjSrWGX
         2HVaHZFOlNj4ewgtuszaSKZn3DkU9dnwgQ4B2TwcZ6BHuKUFSLuRg6LXNU/jACJP9sPe
         MQR+vrhfc2aFC1dWuZbszONtVh9b0pvJrtkQVAKt+G2vh1tE+68VDA4AXJRjL8iz9ebb
         Gpug==
X-Gm-Message-State: AJIora9RWB54zEVV6iFdHiExELBdQ2oEH955hH9Y1aZ7O6dZROyadKy7
        dhkvxQ//XRdlavTDRwmYvvwy7g==
X-Google-Smtp-Source: AGRyM1umek5iPRNqIejfVVCxmNssO5BgP+bQ+pexW3w1fg6cBla9xeht8NvKw++YLsTe34mcv9gYLw==
X-Received: by 2002:a05:6402:3886:b0:435:643a:b7ae with SMTP id fd6-20020a056402388600b00435643ab7aemr10010189edb.4.1656240548399;
        Sun, 26 Jun 2022 03:49:08 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906941600b0072660d8d83fsm1643197ejx.188.2022.06.26.03.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:49:08 -0700 (PDT)
Message-ID: <8b9c2b8e-fb65-2b65-1294-47d3b5623f66@linaro.org>
Date:   Sun, 26 Jun 2022 12:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v9 5/5] arm64: dts: apm: Harmonize DWC USB3 DT
 nodes name
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
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
 <eb00b6c3-ae5e-9858-ab5f-fd78229ff436@linaro.org>
 <20220624205902.y2un4lr7d3zkc6jx@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624205902.y2un4lr7d3zkc6jx@mobilestation>
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

On 24/06/2022 22:59, Serge Semin wrote:
> On Fri, Jun 24, 2022 at 07:17:53PM +0200, Krzysztof Kozlowski wrote:
>> On 24/06/2022 16:16, Serge Semin wrote:
>>> In accordance with the DWC USB3 bindings the corresponding node
>>> name is suppose to comply with the Generic USB HCD DT schema, which
>>> requires the USB nodes to have the name acceptable by the regexp:
>>> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
>>> named despite of the warning comment about possible backward
>>> compatibility issues.
>>
> 
>> Sometimes node name is exposed to user-space which depends on it. How
>> did you check there is no issue here?
> 
> I well remember the Qcom problem caused by one of my patch:
> https://lore.kernel.org/lkml/CALAqxLX_FNvFndEDWtGbFPjSzuAbfqxQE07diBJFZtftwEJX5A@mail.gmail.com/
> 
> The next patch caused the same problem, but hasn't been reverted.
> https://lore.kernel.org/lkml/CALAqxLWGujgR7p8Vb5S_RimRVYxwm5XF-c4NkKgMH-43wEBaWg@mail.gmail.com/
> 
> As before I am more inclined to thinking that the problem was mainly caused
> by the improper node-name utilization. Anyway John later noted that the
> problem was fixed in the user-space. 

Yes, I remember. The node names are not considered ABI, therefore any
reliance on them is not correct.

I wonder however what was the reasoning for this comment in APM DTS.

> That why afterwards you were able
> to provide the commit b77a1c4d6b05 ("arm64: dts: qcom: correct DWC3
> node names and unit addresses").
> 
> Anyway I am not able to track the way the node-name is used on the
> affected platform and can't make sure that the dts would be still
> working well on that devices. But seeing nobody responded/commented on
> this patch for more than a year we can at least try to merge this in
> and see whether it causes any problem should the denoted platform is
> still in use. If it does we can revert the update back and forget
> about it.

The APM is kind of abandoned, so indeed we might never get a reply.

I'll take it.

Best regards,
Krzysztof
