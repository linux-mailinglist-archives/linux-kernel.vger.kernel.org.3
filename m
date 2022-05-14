Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26D5272F0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiENQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiENQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:33:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E108DBC90;
        Sat, 14 May 2022 09:33:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q23so15078128wra.1;
        Sat, 14 May 2022 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HBKA+WQkXWZ1I3M6pl42jHxqJFwGouJWtzUfEFdf0+g=;
        b=WD6ukIW4K4lBCtxb//51iee1HzWMXQBB1vRuiI4YRFTpfFCktN8Miki8o2INlirdoB
         lbwk/bx53kCnRUXMde0JdWR9gbTFm5GBioAFCeLw4Duutj3m3rTuM5daMy2Z+A6E4vCF
         2c6W+qyBjoXNcqeR48AZcVUaEyjrUSOwWxPClaiPDxiO0sUeXPJIR7S+4l9qUqw+3AYi
         qesTlPX0SXP/dxzjj+k2kT6L9B+d4+Oh+a3lt5F02/5mbetxgnmpU8uAQhoSC/tkS0uY
         OhgzUOg8BEbREbKVxgktgTwgj6MMmExvJTS8X/7+p+hjGEswkVGB3pLJbqMyhyujkyV8
         stRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HBKA+WQkXWZ1I3M6pl42jHxqJFwGouJWtzUfEFdf0+g=;
        b=0GcorM04xEc1+ZnMftLZ31p1gVHez2CVn+AL1Jqxgf8asf0lZ/B0jpQI7OZn6wsEus
         jQGMAf7IFw6O65fOeapCA6THu+jgwyKPLPFBX6jac/HsK5Zbn4HFyeH8P9ktsJkQnePW
         G5a9eW2J8R8DZdvRHwwg5YkVPagmkRG9yOrLAaLCxlXHa/hItZoABEHcDI4KHwg4TMvN
         4u9LTVYexlhXGnyCYqyyaMGC+K9AXkdD3LBROC/FPkRlrOP6BAWwVAWXGA3FqkmKgg8x
         oLqWvVAcJcdQiHkCS5yCAt/bbTNQAFTrm/RT7aCG5VHxMb2/1gzLyr4iR88ApdfM158W
         LugA==
X-Gm-Message-State: AOAM531RwgoZx4/61vo6NuyBjhLfkRo6O9X3OaO3dhYVyR1c748kKM1g
        1pdUyHnluAVUXyZg32pk6zgm9AWItzaG9Q==
X-Google-Smtp-Source: ABdhPJxhNlOF1OhdQWFqzov1nKY/StqGiLhQBCuYeSCsvuIxu4oMC7BoGZW/ze1a/4OUk4/ziT0F2w==
X-Received: by 2002:a05:6000:1889:b0:20c:617a:b087 with SMTP id a9-20020a056000188900b0020c617ab087mr8142515wri.102.1652545995603;
        Sat, 14 May 2022 09:33:15 -0700 (PDT)
Received: from [192.168.35.91] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b00394586f696dsm8581841wmc.11.2022.05.14.09.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 09:33:15 -0700 (PDT)
Message-ID: <fad8e87d-20f9-d01d-e92b-2c7b9a751287@gmail.com>
Date:   Sat, 14 May 2022 19:33:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/5] dt-bindings: proximity: vl53l0x: Document optional
 supply and GPIO properties
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220512191334.61804-1-markuss.broks@gmail.com>
 <20220512191334.61804-2-markuss.broks@gmail.com>
 <f5ec4fd9-b9d7-10fa-1c27-2f268466274f@linaro.org>
 <20220514152940.1a212c7f@jic23-huawei>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20220514152940.1a212c7f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 5/14/22 17:29, Jonathan Cameron wrote:
> On Fri, 13 May 2022 10:56:50 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
>> On 12/05/2022 21:13, Markuss Broks wrote:
>>> This patch adds the optional properties for the VL53L0X ToF sensor to the
>>> device-tree binding.
>>>
>>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> Wait, two days and three versions? Please give some time before
>> resending entire patchset.
> Yeah, several instances of this on the IIO list this week. Please
> let things sit for at least a few days between versions even if
> the requested changes are fairly minor.
>
>> Same comments apply as for v2 and v3...
>>
> I 'could' fix this up, but given you've not responded to Krzysztof
> I think I'd prefer you send a v5 in the second half of next week or
> later (to give time for other review) with the patch description
> change Krzysztof suggested made.
OK, good. I will give this version some time to settle and send a 
version with those fixes some time next week.
>
> Code wise the series looks fine to me.
>
> Jonathan
>
>
>
>> Best regards,
>> Krzysztof
- Markuss
