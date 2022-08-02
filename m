Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E41587824
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiHBHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiHBHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:46:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41D1E3EB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:46:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x39so11197085lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RKbt80axAQfOB4DhyqkpntLd+mhVQK1GRd49ynJihfU=;
        b=PkIXQyslez+E7OClgkr1a3L2n8MrBiO1qQrWB0iEBpqF85yBM16nTVVnK69vt1BX9a
         dl53gBBPqrQBHlSp7bSLOXVfZmcQAABz7xVHVmjVCwJf6fMY5GAAYqawSSRnuZVHimal
         h/Cn79WypwdlQLIudVKifLGZJ96vXlw09GTQrkb2fmj4vDZ3qPsLfvSLKQwcM2S3UXKz
         7SWpM4tbclwB/+B40/YO7wEwi0Lxpmp2s1K30KxtsEz9aLyqSQ8vfta7cyaIxBcBcbqE
         ryo5CKKpDfmxpk5arXytTKgGJbCUBSSu3wIiUGuyYAwfxkR08pNg2xdt3FGEWL7u/tsa
         zWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RKbt80axAQfOB4DhyqkpntLd+mhVQK1GRd49ynJihfU=;
        b=Ox9vEHRAdz2ov/umcJUGVfYriA8UBAmPNt+0vukH6PnM8Fecoa6tqE3gMW8rtIVRYf
         kZD45KWnhLNTgb0Lpbo7GIk8XHw1yToQw/PmingMwwpK5YE5K0Vy1gG9icNgVk0eK4+/
         FZetfz+XFFULxc638ERdWiHHlLyOwlerMA/ViHv0sYauAfP/XhzEqJwax92svJJbbzog
         JqaeMkK9fh1O0Cy/0ZlVGePjYQPVc+C031zrAlXXqZJH/eWNxf6wPGGAd6Wcm4oDttzB
         ni1tnYuhy9t0yWXznSE2a0WCbyoQ7mxXsSp7HpwPX7RM6m5k7zLO/GEbsoWsYv0aP0+q
         1eVw==
X-Gm-Message-State: ACgBeo3O476qvNM6uuntRlAhN4C+gAZU1pGOdaMF2RMOXdI1+/CcrzPu
        9GJ7qeHyNF8DyVlPiLD8q+Z1rA==
X-Google-Smtp-Source: AA6agR5NptaxdnaipUCkSDf+B4BKrGT4sXCp0b/ozr3XF1G2x4DcIcXHqMbKokL3W4oiWztQ7iLycw==
X-Received: by 2002:a05:6512:70a:b0:48a:ee11:1002 with SMTP id b10-20020a056512070a00b0048aee111002mr4532370lfs.501.1659426395967;
        Tue, 02 Aug 2022 00:46:35 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512358100b0048af6019c01sm863795lfr.246.2022.08.02.00.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:46:35 -0700 (PDT)
Message-ID: <822b24fb-add3-b49f-d64e-15b577929edf@linaro.org>
Date:   Tue, 2 Aug 2022 09:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-common:
 move common nodes to a common dtsi
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Joel Selvaraj <joel.selvaraj@outlook.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <BY5PR02MB70091276EDE0CE4FCB6CFBD5EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <20220801185304.ozoydbmbgqe6fqdy@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801185304.ozoydbmbgqe6fqdy@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 20:53, Marijn Suijten wrote:
> On 2022-08-01 16:55:11, Joel Selvaraj wrote:
>> Since there are two variants of Xiaomi Poco F1, move the common nodes from
>> Tianma variant into a new common dtsi. The EBBG variant will also inherit
>> the new common dtsi.
>>
>> Signed-off-by: Joel Selvaraj <joel.selvaraj@outlook.com>
>> ---
> 
> Any summary what changed since v1?

+1 (although I already reviewed it)

> 
>>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  | 595 ++++++++++++++++++
>>  .../qcom/sdm845-xiaomi-beryllium-tianma.dts   | 590 +----------------
>>  2 files changed, 598 insertions(+), 587 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>> new file mode 100644
>> index 000000000000..83edcb1171f5
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> 
> I haven't re-read what was discussed in v1, but doing it this way causes
> git to _not_ record this as a rename but instead state that everything
> has been removed from sdm845-xiaomi-beryllium-tianma.dts, and a new file
> sdm845-xiaomi-beryllium-common.dtsi was introduced with inconveniently
> almost identical contents (see the unnecessary size of the patch that
> follows).

The patch should be formatted a bit different. I agree that if combined
with first patch and proper settings (-M10% -C10%, optionally also
experiment with -B although here it looks not needed).

I reviewed the diff side-by-sie and there were differences (labels)
tricky to spot. If you generate the patch correctly, not much of review
is needed...

> 
> Instead, I'd keep the original patch with a rename from
> sdm845-xiaomi-beryllium.dts to sdm845-xiaomi-beryllium-common.dtsi, and
> _also_ update the existing:
> 
> 	dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
> 
> in Makefile to match this rename so that it keeps compiling, even if
> that means we treat a .dtsi as a .dts which may (likely) not be treated
> correctly by existing build rules.
> 
> If it doesn't - and this approach is probably frowned upon anyway - it
> is perhaps easiest to generalize sdm845-xiaomi-beryllium.dtb (as
> suggested above) _and_ introduce sdm845-xiaomi-beryllium-tianma.dtb
> _and_ update Makefile in a _single_ patch, such that everyting keeps
> compiling and stays consistent wrt how git treats renames.  Later
> patches update the compatible and add the ebbg variant.
> 
> - Marijn


Best regards,
Krzysztof
