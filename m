Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D7567F84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiGFHGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGFHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:06:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEB521E18
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:06:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a39so17268134ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bz6Q6Fa1YPetlBznSCPVIVUyt5DE98y2dZImsjK2Yv8=;
        b=tvIqGHClygD44BkugbMwanSv/36LJecwYVa+DSFyov6VN0U3qfLZb3nu87e6Esx1Gr
         HRaLCL0bxhrc63Fsrwteu3cgA2d5YNbLdQqXdieLgMp1oBHVNuErVcpXEl0ai83XBfnF
         K3NGU1lYCNjfweUXSoc04dJHls6JmxY4zO+4jBoMu5Scc7WL+8t9jL4Aa513JH/J5vpT
         EdoP7jq0kknSNbF86js20S1NhRPHZpn34l4Ja/MXmartLTQRlLDFjSGORA5MwWpmS3g1
         BHRsaj3TDoDhuTeW0APz491J1XYBKI6dguTvE8Drf3MxaEE0wXk1ag7aWi04d7/xWr1u
         iHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bz6Q6Fa1YPetlBznSCPVIVUyt5DE98y2dZImsjK2Yv8=;
        b=ffgtR4OEwgcrV8DWWZ9j58Tph82d55qp6IFFP05ZlKAhesgeAbi+jnIQQ90dhQShl6
         Vft0ToJMDdikWm2liBbdcQdlEP3LN33BpdHXBXL03F2UbKPEVyybOWNPe/WEGCKk5o3A
         WF2j1Z2Sp48vpF4iDWT4lEkNgITZfitdJ5upgvch3r5P+OAcZrk8mfMh0bkzXwvEXKTf
         BJbITpkCQKQj5yYBDhs68uy5FyGJQWwtuguJ9gLX6ux8xafXXqEUa1rNVfud0rczWe1V
         O8USAdFRolhQ77NAtOkU2UfYhve64E4kao3Kpgdz5y0PS3dtCxUP519zlOQ27gnMoCp3
         4mZw==
X-Gm-Message-State: AJIora/W0kvRouCaDIc6q9sX9ZEThlWOqC5i79N/rRC8/KruqHDgeGy2
        5FhvtHPgH4e/+o5xOn5x6oJemg==
X-Google-Smtp-Source: AGRyM1usm4O5Yb3o6i6Cn0wioXtQfAUgzfnG2UsRxbcZnwyO45UOmIaUEy5e/hW+wuLQ6mMtvCgPDg==
X-Received: by 2002:a2e:984e:0:b0:25a:9fd7:c6d3 with SMTP id e14-20020a2e984e000000b0025a9fd7c6d3mr21762666ljj.66.1657091175181;
        Wed, 06 Jul 2022 00:06:15 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s15-20020a2e150f000000b0025a89f36accsm5970693ljd.42.2022.07.06.00.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:06:14 -0700 (PDT)
Message-ID: <3d23244e-d926-ad9c-68b6-50ac8b4fd752@linaro.org>
Date:   Wed, 6 Jul 2022 09:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0
 controller
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
 <ddb0e946-c955-1404-c1cd-c2548f34ec35@linaro.org>
 <845d6817-d2e4-7925-f7f5-da1102514636@foss.st.com>
 <286633b2-43d2-655e-b3f1-54bf5c7a4a21@linaro.org>
 <6ef58f1f-ee8a-b060-6fda-d1388b3ede6d@foss.st.com>
 <f86dd47c-0fc5-6c93-a49e-534610d10c49@linaro.org>
 <dfad8fb5-6205-d620-81eb-5d44b9175e05@foss.st.com>
 <0821acfe-bcfe-b1d8-c1a9-81023f4ab6a0@linaro.org>
 <13266b3e-7571-23fa-13bd-1c8107a5f90d@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <13266b3e-7571-23fa-13bd-1c8107a5f90d@foss.st.com>
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

On 04/07/2022 11:08, Fabrice Gasnier wrote:
> On 7/4/22 09:55, Krzysztof Kozlowski wrote:
>> On 01/07/2022 12:04, Fabrice Gasnier wrote:
>>>
>>> Then I no longer get this warning upon build. But the dtbs_check complains:
>>> ---
>>> connector: ports: 'port@0' is a required property
>>> 	From schema: ..
>>> Documentation/devicetree/bindings/connector/usb-connector.yaml
>>>
>>> So It looks like to me there's something missing to handle the single
>>> port case in usb-connector.yaml, when using the "ports".
>>>
>>> Maybe usb-connector could be updated to handle "port" (w/o unit-addr) ?
>>
>> Not really, the dtc warning looks false-positive. Especially that you
>> need port@1 for USB 3.0 (super speed), unless you do not support it?
> 
> Hi Krzysztof,
> 
> Having USB2.0 High speed port only is perfectly valid. port@1 is
> optional to support USB3.0 as you mention.
> 
> I've no opinion regarding a possible false positive warning. I'd like to
> sort this out, perhaps Rob has some recommendation regarding this ?

I would propose to skip the DTC warning and stick to the schema with
only one port@0.


Best regards,
Krzysztof
