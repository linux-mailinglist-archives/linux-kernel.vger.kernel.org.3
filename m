Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14BE58452B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiG1Rfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiG1Rf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:35:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2DB1CA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:35:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b6so1382931wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VbbJgehw8s69ZFldc80l1If2xNlW1MCzh0YgoGTkFWQ=;
        b=snLIwA63J2zsHlnWu52Gpx/KsjI8oAuG/PxSiB/UbQqZE6/kWzXyAaUjkXba8Tq9+N
         EPqGz0KVQ4S6aLzn99R+YW2bxjKsnqKwqwmXdVcOAs7NAmQVw4b6toQevZWcY+YhItqX
         /xIrig3AcA8JHkMggt5ugsES93GWBvZYIwTTAqZN1JkN8WV/m0L8RT/M/Y6bGJ3bkFLq
         ELc+vg0axo4F5EDxzsqpMpWy1Ole9zWriLqSouGfdwQJNd7nUlM8irLCIuxXjTV8sj2B
         ujxcOJmqvceWGLr6zrtUUy4jygbQ5G2Qu7kzOSVOwymrdyA6PdH1uuH8psGF9idOiLvN
         mt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VbbJgehw8s69ZFldc80l1If2xNlW1MCzh0YgoGTkFWQ=;
        b=6AvUpPuSrCmum7guRc4i59jlJ5YC88J+j7L96HEK0uCtrREzO02g33+OH6gQGEq3zw
         BOdyWuSduTo0k/WTA6bxZYSMRuPQo2ftchqP58donJirPZyMbeuL+QP0dL9G5MSH3KPF
         SxEgUZ1mjrrLexpnKvaLfG5gXc4TtXk5d1Yr4uWhHwQPAcXic/dWOX3XNZAi/NqErlLq
         5t1E8r6Uj7VzsJJWWBd6W9Tp+EII/L2c1GQtCkj9aPKqGZUZn978uLuyMfgpOKotAznn
         czPVEOxAeHVyvH4D4L0KyMzNJCMTyx57899EtWhPVpLkTy3VG/YeR0MIQM+z6EKSKLRZ
         nTEQ==
X-Gm-Message-State: AJIora8dglE4D15WKWkuD4YAmDV50Q74S2EV4X59kVoVNdKwxJcjBZkb
        AiogFcME72eYmVKZ3cqdy0P2rw==
X-Google-Smtp-Source: AGRyM1sOD6Y08ZL1MA0szDzx3Whx7DStDWCvrxUZpox8X8ojsNF8FBVXQm9uCjHxKuWylc6DovVKCA==
X-Received: by 2002:a05:600c:4f81:b0:3a3:1f5a:2b6a with SMTP id n1-20020a05600c4f8100b003a31f5a2b6amr17901wmq.53.1659029722901;
        Thu, 28 Jul 2022 10:35:22 -0700 (PDT)
Received: from [192.168.43.135] (33.169.185.81.rev.sfr.net. [81.185.169.33])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm6074212wmi.22.2022.07.28.10.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 10:35:22 -0700 (PDT)
Message-ID: <6795356b-29d4-0098-f282-1eaf4fb21108@baylibre.com>
Date:   Thu, 28 Jul 2022 19:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 1/2] dt-binding: iio: time: add capture-tiecap.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220728125212.76728-1-jpanis@baylibre.com>
 <20220728125212.76728-2-jpanis@baylibre.com>
 <6268ec8c-73f8-6517-c7a7-a6d3ede420ab@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <6268ec8c-73f8-6517-c7a7-a6d3ede420ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2022 15:38, Krzysztof Kozlowski wrote:
> On 28/07/2022 14:52, Julien Panis wrote:
>> This commit adds a YAML binding for TI ECAP used in capture operating mode.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---
>>   .../bindings/iio/time/capture-tiecap.yaml     | 68 +++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
>> new file mode 100644
>> index 000000000000..5d66df90ba5d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/time/capture-tiecap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> Still wrong file name.
>
> Do not ignore comments you received. Either you implement them or you
> keep the discussion going.


Sorry, that was not intentional. I have prepared a new version which 
takes into account your last comments.

Julien
