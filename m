Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE1568C08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiGFO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiGFO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:59:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63825E87
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:59:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i18so26356654lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cmKQ1A+SNcVV+xdQAtk9f96FGO9npHWf2vTO1h3im4s=;
        b=bJ2wmt19f7E1iCV0cGWdHwG61juT9VIkFewxrXGstKTVLXv0jkpZkQy6KxA/5C4qCk
         Jp3/f2gVaIhNHYyeq8rvmfsLz9PtwYUqeV2kuy4xPxHBteIXHDQaLGKsHvXyB78CBRhO
         Mko6wPrrUlSKk6yGd6ObodHqj7Kucs5yHvjwp5If/uKb9PILyEzFwUY3Ql3yIl0UjmZI
         4ichYDbs91f7sSkVOXgKmZM7DWZmVf8I5Ow/GLh+VNIoBbKnJ2pKssLSyol/GOyj/y7h
         +lIkCKVw7m1OxBhsAZXLvfeINFzlzcpA0J9BaRHgB9QVfHD+DgIaRwbU7pfIlLZIJER9
         X+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cmKQ1A+SNcVV+xdQAtk9f96FGO9npHWf2vTO1h3im4s=;
        b=G25ppbNg89rHsVi+h7Jg24FI7x7SRWav8i1ASWK3jfGaxXjVK6kLebPNfy/IQIbHBJ
         p+vt9h3FEbwkxf2GQ7Nh6JcOcao5keYVvJkBDHA7o9s/zN4Sk6dW/gXY7rGk8SImEAM+
         jU0RQWR5WJT0LwtNKx9q6w785jOTt8mLd0HxkSOvvvuenvwSLtzECEG5S5ZPBdRf+TL3
         qe6x8Si/UVGOlyhlH956qvOO9pPQFr+ACwxrMd8rBQUciCBBkCDXq7+XWJrHBu2aeDWd
         3KpAv8ptWnh4+dxZ3S8DCs0WeHebt5tN+qNoP/TL3Svt0P7xQiifyR8AingnVaNNejo/
         c3fQ==
X-Gm-Message-State: AJIora9IHxy3ljPiz+3vN6AdcKnitwrQQhaEPtUAgWMdgfVvMwGUpma5
        hZo25WxrCB3h9TzleYvxovyfeUTiXsQrECGp
X-Google-Smtp-Source: AGRyM1vgEuf632zLZr+I1Gp3QidCXy8XtIkAtWyjsW3vgP/zQ1uvi/Tv6A+oTDrNIBJQQDoRMtGnjg==
X-Received: by 2002:a05:6512:1698:b0:47f:b5a6:6870 with SMTP id bu24-20020a056512169800b0047fb5a66870mr25958708lfb.578.1657119542015;
        Wed, 06 Jul 2022 07:59:02 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id o14-20020ac25e2e000000b0047f93edb9f5sm6304967lfg.181.2022.07.06.07.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:59:01 -0700 (PDT)
Message-ID: <75f8b257-7e0a-d871-ab30-37a72f7da56e@linaro.org>
Date:   Wed, 6 Jul 2022 16:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: pci: QCOM Adding sc7280 aggre0,
 aggre1 clocks
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-3-git-send-email-quic_krichai@quicinc.com>
 <1fb5f0c6-ff72-b9ba-175a-b5197ed658a7@linaro.org>
 <9de4c3a0-eb95-f4e9-b828-2343241fff41@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9de4c3a0-eb95-f4e9-b828-2343241fff41@quicinc.com>
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

On 06/07/2022 13:55, Krishna Chaitanya Chundru wrote:
> 
> On 7/4/2022 1:54 PM, Krzysztof Kozlowski wrote:
>> On 01/07/2022 18:11, Krishna chaitanya chundru wrote:
>>> Adding aggre0 and aggre1 clock entries to PCIe node.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index 0b69b12..8f29bdd 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -423,8 +423,8 @@ allOf:
>>>       then:
>>>         properties:
>>>           clocks:
>>> -          minItems: 11
>>> -          maxItems: 11
>>> +          minItems: 13
>>> +          maxItems: 13
>>>           clock-names:
>>>             items:
>>>               - const: pipe # PIPE clock
>>> @@ -437,6 +437,8 @@ allOf:
>>>               - const: bus_slave # Slave AXI clock
>>>               - const: slave_q2a # Slave Q2A clock
>>>               - const: tbu # PCIe TBU clock
>>> +            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
>>> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
>> You ignored my comments from v1 - please don't. This is not accepted.
>>
>> Also, please do not send new versions of patchset as reply to some other
>> threads. It's extremely confusing to find it under something else.
>>
>> Best regards,
>> Krzysztof
> Hi
> 
> Krzysztof,
> 
> Sorry for confusion created which replying this patch.
> 
> The only comment I got from v1 from you is to run make dtbs_check.
> 
> I ran that command I found the errors and fixed them and I ran the make dtbs_check again
> before on v2 and made sure there are no errors.
> 
> Can you please tell me is there any steps I missed.

The comment was:
"This won't work. You need to update other entry."

and then a conditional: "If you test it with
`make dtbs_check` you will see the errors."

So let's run it together:

/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
pci@1c08000: clocks: [[42, 55], [42, 56], [41, 0], [39, 0], [42, 50],
[42, 52], [42, 53], [42, 57], [42, 58], [42, 177], [42, 178], [42, 8],
[42, 21]] is too long

	From schema:
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/pci/qcom,pcie.yaml

/home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
pci@1c08000: clock-names: ['pipe', 'pipe_mux', 'phy_pipe', 'ref', 'aux',
'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'tbu', 'aggre0',
'aggre1', 'ddrss_sf_tbu'] is too long


clocks and clock-names can be maximum 12 items, as defined by schema in
"properties:" section. You cannot extend it in one place to 13 but leave
12 in other, because both constraints are applicable.

If you test it, you will see the errors.

Best regards,
Krzysztof
