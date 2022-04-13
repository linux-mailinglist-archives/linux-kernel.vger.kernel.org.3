Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D03500052
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiDMU5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiDMU5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F4220E0;
        Wed, 13 Apr 2022 13:54:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so7363978pjn.3;
        Wed, 13 Apr 2022 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z8n2FKlH4PPLZudd5wmQXBKFzCBNjhBZWi9v/kIPikk=;
        b=SapZ8FRGWZ38OHiXjH2V0nZ1xZ+fof7DG0rpw+atdv7R6rTyBDgBymXUCrK00dZoqS
         UHt7b3BsHtsPUvAV6WzBP18RF7n2S8Yd5L85WtoATnLc9tk4XuBC9GNzARrQdgxLzTYQ
         5br+Ik1swXuR2oVyTa8oXHNgHpjlQCBsC5N5KRMMLLTQ/3tBpI+SK6+UtoaPE/2BmC1z
         JwLOIjv6BWN9FzDqcV6QJuA1NpPyKuwKlEuDNH1eq3IKKGR0e1gHPKSt3mVQk5NGOdsQ
         AqvIETui/UCK2K5epA8zLO20vOQbAmyctvQYlxv4Vbl9/iqS1cB8U9kNHRwQ4ocfr05v
         1GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z8n2FKlH4PPLZudd5wmQXBKFzCBNjhBZWi9v/kIPikk=;
        b=5XhGibGud4At2iW/M7HR7vziRTatsVDPiaeXpxYIFJ+CMG4PdhOJzJOeAXKLj5CQ/7
         +g6xtrRxpzrQkbN44AoQi4gS4dvypO4wB2cRiBcnu5R0Nf786EmQewnxV5f0mjkxmPhx
         JtQrsmG4IrCu9o3jEYQtJOPLgXIvjrF+Nrf+ZKc1Qp+fr72Kq7xMsNFcb1qZNnjKzspR
         hdCK1YDy3S/Cg7icL6kXV4Sw831e0ulpkjbM7MWQz4fDYOW3g4qM4t31rnT1R1ANkSx+
         S5w4EanAARCHxEBUvbyRwwGOnL2e35CU9yoU5nkQzaJm6+3BXTMc4k23R6JqYJSTqap3
         yX4A==
X-Gm-Message-State: AOAM530iJv4kuEBKAsEtZkS/od7QqxoCQjaZ2+KPugdsqP51AJORleQe
        DEv3S7sK/q6Ae1nsewVnqWM=
X-Google-Smtp-Source: ABdhPJz9zFqadNRA+ndtin3mKhcwMF1jk+93aKdbtcYAcws109E/nP5a7ElcKU6Bf/j8DS2xCdRhlw==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr43303158plt.101.1649883277874;
        Wed, 13 Apr 2022 13:54:37 -0700 (PDT)
Received: from [172.30.1.44] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm43549529pfc.3.2022.04.13.13.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:54:37 -0700 (PDT)
Message-ID: <924e2208-d939-0243-9780-ae1b8cbd2c49@gmail.com>
Date:   Thu, 14 Apr 2022 05:54:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: mediatek: Add mtk cci
 devfreq dt-bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johnson Wang <johnson.wang@mediatek.com>,
        cw00.choi@samsung.com, krzk+dt@kernel.org, robh+dt@kernel.org,
        kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
 <20220408052150.22536-2-johnson.wang@mediatek.com>
 <855d7daa-45d1-d6d8-32bd-51778cf58392@linaro.org>
 <fe7d2b878c18a42ff36ebd9911ecb562fe29c953.camel@mediatek.com>
 <39152c86-ca11-2792-6b25-ae55ffb47b09@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <39152c86-ca11-2792-6b25-ae55ffb47b09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 4. 12. 18:17, Krzysztof Kozlowski wrote:
> On 11/04/2022 14:10, Johnson Wang wrote:
>>> Also please put it in the "interconnect" directory.
>>>
>>
>> I don't really know about "interconnect".
>> However, it looks like a Linux framework about data transfer and "NoC".
>>
>> While this cci driver is more like a power managment which is
>> responsible for adjusting voltages and frequencies.
>> In my opinion, "devfreq" should be more suitable.
>>
>> Please correct me if my understanding is wrong.
> 
> devfreq is a Linux mechanism, not a real device/hardware. We try to put
> the bindings in directories/subsystems matching the hardware, therefore
> devfreq is not appropriate.
> 
> Whether interconnect - or other subsystem - is appropriate, I am not
> sure. To me this looks exactly like bus bandwidth management and you
> even use "interconnect" in several places. So interconnect matches.

I think that 'Documentation/devicetree/bindings/arm/mediatek' is proper.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
