Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FD51FD25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiEIMr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiEIMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:47:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC613CA0A;
        Mon,  9 May 2022 05:43:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l11so6369095pgt.13;
        Mon, 09 May 2022 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=SVrlMG9sH7kv5I9cl4/OZLrQBXySLyRLsCZbLGDjIqE=;
        b=Xi9cwvuPhW6vhymMjNEnGLjS2+mLkxi4nu2DYmB22i4hlbz2/AwKHyvl+T6RcixoHM
         zDy+Wqn7ejmxv55EiO4HmOQ4DfMV3zffSi1/xBMFtvg+ADgCZIXd8gXEVl16BGClyGCp
         dt/DN4VsFZHhCVA5nkdToHh9ZSMh2cowpfMdyG2O8MCc8AK3x8Xh5TWoxMxXa6efe+/h
         cPFMmN2r42EOVPBUmYu2cSWPEnHTWDYOo1lFWDPykG/Hg2WtScuDZLoSMrIfVqBBQkZA
         BY7e7B71BnKr2oA1byD7CJYUAnDGmjpDyg+1wHMTLJ0pqltSr8OJ6TMELYns0utsEumf
         NvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=SVrlMG9sH7kv5I9cl4/OZLrQBXySLyRLsCZbLGDjIqE=;
        b=JgprcD+RC9Rvjd8G8Xy9T7rj1fO0c5dVCK1ovZgfERYnL9wUr8D2A6llh+F6MQh5JQ
         +qRxduKf0lIMAyFgDKtPXzTZw2Xty801LA6ZH4yHL4ZgjVvEh67Z6GIoCoL0GYFDB4G/
         hhMA+yTAqK9xVnnbK9Iqxua5+CZK/WyPRtNT+Lpy2gvBvtwmN3Invx6cJmGy8KctiUhY
         dkdHOynRO2VfTJZ8ppIAU/4LV2FErueujSCTHy4vDdMWUn5cZlK1V33glPNswoqrrwVo
         a5Ibmm3qL9+3bfP1wrmsriAsPnTW7OalseylN6S3vWXnYPGvHqREqRpn/cZMht9G/nCg
         qTbw==
X-Gm-Message-State: AOAM533oRhcm0UEs6+tOzxhoe5Ddf9Hk/jXBMmcLek6YgkDBhlXpB3ZJ
        rqPH9nIQlDWGD06ijZo7WGEfvfu1+oegMw==
X-Google-Smtp-Source: ABdhPJz+/c4hjRHJy7STyl9bPPgXdQdXb8akW99y2Ri08rHOz09qfKgRmIitsqwn8L211TZgXqHz/w==
X-Received: by 2002:a05:6a02:287:b0:3c6:b341:e3ba with SMTP id bk7-20020a056a02028700b003c6b341e3bamr4911328pgb.271.1652100237895;
        Mon, 09 May 2022 05:43:57 -0700 (PDT)
Received: from [172.30.1.40] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id lb5-20020a17090b4a4500b001d77f392280sm8770023pjb.30.2022.05.09.05.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:43:57 -0700 (PDT)
Message-ID: <3b6a9b8f-d550-8093-5f76-49ea70d1ad62@gmail.com>
Date:   Mon, 9 May 2022 21:43:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
 <20220425125546.4129-2-johnson.wang@mediatek.com>
 <94efefab-918d-2367-4b74-076dd6f23936@gmail.com>
In-Reply-To: <94efefab-918d-2367-4b74-076dd6f23936@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 5. 9. 21:09, Chanwoo Choi wrote:
> Hi,
> 
> On 22. 4. 25. 21:55, Johnson Wang wrote:
>> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
>>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> ---
>>   .../bindings/interconnect/mediatek,cci.yaml   | 139 ++++++++++++++++++
>>   1 file changed, 139 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml 
>> b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>> new file mode 100644
>> index 000000000000..e5221e17d11b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>> @@ -0,0 +1,139 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek Cache Coherent Interconnect (CCI) frequency and 
>> voltage scaling
>> +
>> +maintainers:
>> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Why did you add your author information?

I'm sorry. I missed 'not' above sentence.
IMHO, please add your author information.

(snip)


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
