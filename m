Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB415805AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiGYUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiGYUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:32:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076B9FF9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:32:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r186so11394432pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cidzZoSWZYoDXDF9IC7uoFIPruoJyTZNnPCtO/DHQEU=;
        b=HGBsFyxe5D+LXHZiE3jtAlGE64QTjqrCRhyW06Fn3gqVHuZJ4m16bgXylHuVu7QXi9
         ZR9X5qzUUjIWu/K1XlaXTBAqLoaIQ2As/uGs70DbYlaX989nYloYWxECX+eW51395dzu
         J4LF3gj7fcyyHk7H7/pdCfG1piCJjsfC1fHADZO+1bmGo3+aVntahp7UCl0zIJ5yNKA8
         zKG2MbADvPPDtLulzAc7x3neOf0MRDTXWuEAExaFQWseqdOgONA9t778l1g3pB85aBdu
         pGyD4O/9fv4jwFsTso49Rvy4TDxjt67Nwre6VHi9MloGy5WjqxAq2a+lSWrHNuaY25co
         VOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cidzZoSWZYoDXDF9IC7uoFIPruoJyTZNnPCtO/DHQEU=;
        b=kltut3XCaDaOG9rHjNGlADAunC7Mzh+bn/RgvgLVu29AhkxUNPM6cbIozq9aGH7FeN
         d84SX8k/I4PSFQJqOPRnjCdbnulvVZdeLLhbTsMg2p9QJm2N8DhgXp/Vf8vyLqkMV3mS
         DWYRk9UpAUF9hw7l1LS+wU3zPGTkbf2mdcw8uwFK6VQ28w/fOxC9wE1UcD3evAUdhwie
         a8ztEczZibXs9t0ln9tBSRDpdixgBRkQBkuV+rzo4oRbqkU3EeL2wyKZbgVZpXt/QVYZ
         n6AxuVL5KVQE+1KpVvWhFKJlq5j3GiKpLTXrafStQWhSL9iCkAb+Y+nXiIZwMARSVIv+
         hZjQ==
X-Gm-Message-State: AJIora+RLYxoWYYtPTbvHBiNaCV01sxvzygD47hgTgNW1814MWwqxm3S
        oIUVHxAuQYPQp8cKVXeNEFbbCw==
X-Google-Smtp-Source: AGRyM1vrZIWgkVOEzElyLDDlXKV9IqGjL4yfkx+JwhmB2iyqwGkIeWwv0hSiwg/0CnS4xbWT2/FSRg==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:666a with SMTP id t2-20020a056a0021c200b0052bff44666amr4529213pfj.83.1658781132627;
        Mon, 25 Jul 2022 13:32:12 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0? ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b00168dadc7354sm9697518pll.78.2022.07.25.13.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:32:12 -0700 (PDT)
Message-ID: <7fa26bdc-e07e-4978-03a3-2241373f4dbc@linaro.org>
Date:   Tue, 26 Jul 2022 02:02:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Fix issues in yaml
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "Gross, Andy" <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20220514220116.1008254-1-bhupesh.sharma@linaro.org>
 <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/2/22 3:36 AM, Rob Herring wrote:
> On Sat, May 14, 2022 at 4:01 PM Bhupesh Sharma
> <bhupesh.sharma@linaro.org> wrote:
>>
>> Rob pointed some remaining issues in the sdhci-msm yaml
>> bindings (via [1]).
>>
>> Fix the same by first using the 'mmc-controller.yaml' as
>> 'ref' and thereafter also fix the issues reported by
>> 'make dtbs_check' check.
>>
>> [1]. https://lore.kernel.org/linux-arm-msm/YnLmNCwNfoqZln12@robh.at.kernel.org/
>>
>> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>> -> This patch uses the dts changes sent (here: https://lore.kernel.org/linux-arm-msm/20220514215424.1007718-1-bhupesh.sharma@linaro.org/), for fixing the dtbs_check errors.
>> -> This patch is rebased on 'linux-next/master'
>>
>>   .../devicetree/bindings/mmc/sdhci-msm.yaml    | 52 ++++++++++++++++---
>>   1 file changed, 44 insertions(+), 8 deletions(-)
> 
> There's another issue with this applied:
> 
> Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb:
> mmc@8804000: Unevaluated properties are not allowed
> ('operating-points-v2' was unexpected)
> 
> Should just need a 'operating-points-v2: true' line.
> 
> This won't show up until a fix for 'unevaluatedProperties' handling is
> applied. But first I need all the issues fixed.

Sorry, I totally missed this comment. I have sent a fix for the same via 
[1]. Please help review the same.

Thanks

[1]. 
https://lore.kernel.org/linux-arm-msm/20220725202709.2861789-1-bhupesh.sharma@linaro.org/

