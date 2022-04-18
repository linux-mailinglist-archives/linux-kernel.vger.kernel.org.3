Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CD505E49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiDRTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiDRTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:17:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF932EEB;
        Mon, 18 Apr 2022 12:14:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so18568997edv.1;
        Mon, 18 Apr 2022 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=8vjH6cZOjMPKmMYM8U9yyT827f2QaB+PvuhuwLr3Xlk=;
        b=lQut0xtvDeVyqYFPNTUqB22vY5AIURHZF+Fe0MzIHbLB827ZUpJlIGKgfE7xtIjJjx
         Jgm8uySI+v0v3rL/dRX4/9A8Rv99A53Iey5zDd6KsgRsbKx6P6N9CC+Oaz+rY9zlRjUz
         e8edov02aG07IciohsEZ3TGk7AmOKKC8ylg2s+iuD8IMccbF0jTZFREN4klRVT6Zgt7W
         eVWCrafZJEP7Zm64CBJu9mRf++JU3PEbEVJTsZswm+5+ho7oRuqLlFRJhSO+6/n2HdBH
         iC0cR7ZHrpFqa8qwexHoLPDIG40j6aqXk5sDAOaEMu5i3AeyKnllppZpjOGmuMuKz+0e
         XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=8vjH6cZOjMPKmMYM8U9yyT827f2QaB+PvuhuwLr3Xlk=;
        b=iQGUBPjzdUqBbKp4cVpthytRMfNhxfrZ6kcUBCCnikPSHnZ+HNgDG5EQbLy/ikFBpk
         azrToOexID6iIVOcP8DtCXUdOE8qh7phoWJbT4M/2fO3M1ozyAfU93l03ZGGbjirb/G/
         CvWLt4rd9jCeU5OLz+1ji2cZcpj4mZla/P9xcBHxqChrq6KPMkh984apBORcJy3G4gyn
         ZulqhIp8wRuoyAz1QjiiAcyR9HXzclznAilPLSDrdgaTkFz0gDSGP4TfzERKNf1TxE7Z
         Io1Od58Z+nZiu5t9baYZNc7eDCSs2l+TTuOAyQHIjSbrphCNjSRLHNd7+SteJUhitEZd
         pxMw==
X-Gm-Message-State: AOAM531RnGeQD+y3NYc5/R6ZRRPIT1s8tDMnQQTZL6XS84q+28a81ZOL
        JgCzDxxsEug4p4OBJ/kY+yg=
X-Google-Smtp-Source: ABdhPJwev6wR4b0ex38BXGBB7t3VDqhLP5+ZMFkH/K4ICKFNkbcCGUKBkCym9mkKwf/H1vSzl6s9qA==
X-Received: by 2002:a05:6402:515b:b0:41d:82c2:2749 with SMTP id n27-20020a056402515b00b0041d82c22749mr13806249edd.38.1650309271494;
        Mon, 18 Apr 2022 12:14:31 -0700 (PDT)
Received: from [192.168.11.247] (190-2-132-198.hosted-by-worldstream.net. [190.2.132.198])
        by smtp.gmail.com with ESMTPSA id mx14-20020a1709065a0e00b006e8bc3ce121sm4841045ejc.6.2022.04.18.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:14:31 -0700 (PDT)
Date:   Mon, 18 Apr 2022 23:12:31 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH RESEND v2 1/9] dt-bindings: clk: qcom: msm8996-apcc: Add
 CBF
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Rob Herring <robh@kernel.org>
Message-Id: <VOUJAR.IJKRF5T1P4ZE@gmail.com>
In-Reply-To: <813f4a3d-255b-0ec1-cc3e-a1280e4d74ae@linaro.org>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
        <20220416025637.83484-2-y.oudjana@protonmail.com>
        <813f4a3d-255b-0ec1-cc3e-a1280e4d74ae@linaro.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 18 2022 at 18:04:08 +0200, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 16/04/2022 04:56, Yassine Oudjana wrote:
>>  Add CBF clock and reg.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  Acked-by: Rob Herring <robh@kernel.org>
>>  ---
>>   .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 
>> ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml 
>> b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>  index a20cb10636dd..325f8aef53b2 100644
>>  --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>  +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
>>  @@ -10,8 +10,8 @@ maintainers:
>>     - Loic Poulain <loic.poulain@linaro.org>
>> 
>>   description: |
>>  -  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for 
>> Power cluster
>>  -  and clock 1 is for Perf cluster.
>>  +  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for 
>> Power cluster,
>>  +  clock 1 is for Perf cluster, and clock 2 is for Coherent bus 
>> fabric (CBF).
>> 
>>   properties:
>>     compatible:
>>  @@ -19,7 +19,9 @@ properties:
>>         - qcom,msm8996-apcc
>> 
>>     reg:
>>  -    maxItems: 1
>>  +    items:
>>  +      - description: Cluster clock registers
>>  +      - description: CBF clock registers
> 
> This breaks the ABI (which might be okay or might be not, but was not
> mentioned in the commit) and breaks existing DTSes. Please fix them
> before this patch.

This is only documenting changes made in an earlier patch[1] this
series depends on, and the DTSes are fixed in another patch[2] that
is also listed as a dependency in the cover letter (both patches
aren't applied yet). Shouldn't the ABI changes should be mentioned in
those patches instead?

[1] 
https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.dybcio@somainline.org/
[2] 
https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-2-konrad.dybcio@somainline.org/


