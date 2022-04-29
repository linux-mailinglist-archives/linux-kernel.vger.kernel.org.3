Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1351488D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358644AbiD2Ly3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiD2LyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:54:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C46BCAA;
        Fri, 29 Apr 2022 04:51:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so14958408ejd.5;
        Fri, 29 Apr 2022 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qpiHoeXtT6bCajJr3pmoRuTkgohV62q00/CK6KJlrC8=;
        b=Z5KwGaqDlv2xwy4oNuaKmZ8dflQwv1KDwu60+7H/W8OH3PcqC84qUJReN+bktFypLp
         JK1EdhERzMp/z3LpygA2MVMvZlSEtP7/Dto1jzOD/TriTdOPNpzssejGk4/qIOhhwhjE
         X4faIhuqF5Pm7Jea4pKddmKDnslWyNtu5aVofMF7KfhjFUvkoaVlhn4VBAoacXYf5sba
         03BAXSXGLB9CRAHyDfKsJICYavfii82f4R8DDtelPKlpPjPOt+YW07kwlExAMRlwBcJe
         1ajwPVr/ywq9QQT76ZydYyTRluOZtPTwHhGB5w1y3C92pkRifr0mrLxqTDSqMW1cF4ab
         CgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qpiHoeXtT6bCajJr3pmoRuTkgohV62q00/CK6KJlrC8=;
        b=NA+0+tpkarw3KF2L5fp1t4mJrAgcKYbcxrGIWZm6Jq3v2Hb90asO8ZNtIR8B3T7OHW
         snWwNADliFis+RYmRwwX5ztmZvqwz4mpDFuwqOd7uoBuGz58CAcRwenVNF58TNLYfAZZ
         cSeEATaqveHSn3L1zt1QFvQyd3km45DRkGZX8PgVosRDYXmKOHbt2ZOdhAk2XjPNrdsu
         ADViPS5Bon2w5mc0MT1o+k5rCwfr3BeZpU4uSpil4EzEf288531DB+yxr01tGGgFUeW8
         rQmSMKMdPUpM2v5ycs7YJydc0duZDZsLWu34kdJeXkPhCktG7sLjb7XL4XqaEOpwaL5U
         4y3g==
X-Gm-Message-State: AOAM532uXWdJatPejntI+YHGqHk6Rnb30ezT1IjeqrnrRya+zfY3MGKz
        MvIUinRiYVhi4yCywT2L4Io=
X-Google-Smtp-Source: ABdhPJycRE7Z/4NozWquIfWH/J3WCO6gsbfEPi4M5HUv0S8J8xlKazDwLC7ZIv8c8LYRc7nrWb9edA==
X-Received: by 2002:a17:907:338b:b0:6f4:6e1:ed66 with SMTP id zj11-20020a170907338b00b006f406e1ed66mr770793ejb.341.1651233065473;
        Fri, 29 Apr 2022 04:51:05 -0700 (PDT)
Received: from [192.168.35.91] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id k6-20020aa7d8c6000000b0042617ba63d0sm2887694eds.90.2022.04.29.04.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 04:51:05 -0700 (PDT)
Message-ID: <2a18073b-974f-00d4-5811-8df577e943a8@gmail.com>
Date:   Fri, 29 Apr 2022 14:51:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
References: <20220429113927.5145-1-markuss.broks@gmail.com>
 <YmvQhpO8dg6VLHNP@sirena.org.uk>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <YmvQhpO8dg6VLHNP@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/29/22 14:48, Mark Brown wrote:
> On Fri, Apr 29, 2022 at 02:39:25PM +0300, Markuss Broks wrote:
>> This patch adds device-tree bindings for regulators on Silicon Mitus
>> SM5703 MFD.
>>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> ---
>>   .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> As Rob said please send an incremental patch with any fixes needed.
I'm sorry, I didn't understand it correctly. Does "incremental patch" 
mean I should send a separate follow-up patch with those fixes?
- Markuss
