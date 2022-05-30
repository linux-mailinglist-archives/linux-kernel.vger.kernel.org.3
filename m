Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA695375B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiE3HnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiE3Hmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:42:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C1712D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:42:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z17so5834203wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tDRiL7T1D2xh8IqjQ4J9GQ/82u6rcAgsmar4+giEo/c=;
        b=DyT3t+1nyG9y4HN64kgP299uQMuwvYQw3UXLpbawcwaWR/Jqerrg29FeN0CWFMCYbo
         wYFK+RTScfJC11jD7p12SBCHM6cnrVn02ZhrexSayH9QhoKjl2Fki9rOWgd4xZEPrdKW
         FAsewudhQ2ax1Og0wls9gcytEW/VAX4IZe534jNFQORswYITHyoUjmlqAURly9zdzHRC
         swS5xuL9QRfIpzLsOkyIdTkIgzHaIrsc2BdcHDRVSj7MXk3v4dQKr/VuBNGhpnRtifDJ
         dicKc83acHjeI51wuiYAKK2AwU7sn0qjvC8PnR1L+d9/YmVy0Nj7Pvpd+13OkuHk7uw2
         pA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tDRiL7T1D2xh8IqjQ4J9GQ/82u6rcAgsmar4+giEo/c=;
        b=ta4m4P8tFuRDUdZxyetm8EU2xkPAPW3At6maCfK2BCtnlAHhoMHshe3vEOl7tpLvRT
         9YAoLKwBPSZCToNF/R0pnodjnKU4dlfAIRb/iLGnV1aVWcFLonjQ0sc32aNk8HeLnCzu
         gLFU3JJtDx91bI5/GFn9hFuYCw/J+FDcqh55oXo+e2Dke9toh69pS+UyPVftPqwWH8ft
         Azc3IBs6YVrAluw9AGPlG7XWAm1Li5rww9xHOtAHWR2lZiY5YK0G98RYM+YimH3G1Ruu
         NHcXeYlVU4YZEE6nfDGBNL0G4ODSbPyFmHf1PzSfqvsqkNtXzw7Ig18GrpOtZLsYu1Pt
         6SZg==
X-Gm-Message-State: AOAM5304+iiFH/wXtuF2Dib3G9k52Se7cyBjb76WU6HdzRCm40RGsxdJ
        CqlpK/6LLX3o0vztYGwJ5JPZMA==
X-Google-Smtp-Source: ABdhPJwoeX8AFnrofXaPRVEbqd1WcQ2GzDw7JV+PLebAOLW2qA5bkbyquUytImzShJhd5/S7esV1wA==
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id 5-20020a05600c230500b0039744a4d3cbmr17393978wmo.115.1653896549076;
        Mon, 30 May 2022 00:42:29 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b0039456fb80b3sm9966481wmq.43.2022.05.30.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:42:28 -0700 (PDT)
Message-ID: <fb007f9f-b2bc-9221-64d1-48de8fdb25f0@linaro.org>
Date:   Mon, 30 May 2022 09:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sdm845: control RPMHPD
 performance states with UFS
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-5-krzysztof.kozlowski@linaro.org>
 <20220525071630.irrz24rs73l3ke4o@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525071630.irrz24rs73l3ke4o@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 09:16, Viresh Kumar wrote:
> On 13-05-22, 08:13, Krzysztof Kozlowski wrote:
>> +			ufs_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-50000000 {
>> +					opp-hz = /bits/ 64 <50000000
>> +						 0
>> +						 0
>> +						 37500000
>> +						 0
>> +						 0
>> +						 0
>> +						 0
>> +						 // FIXME: value 0 copied from freq-table-hz
>> +						 0>;
> 
> One general comment, I think this should follow how we specify
> multiple voltages or other fields and so each frequency should be part
> of a different < > braces. Like: opp-hz = /bits/ 64 <5000000>, <0>, ....
> 
> Whatever is there between < > seems to be connected, like
> min/max/target for voltage.
> 
> The code will process both in a similar way though eventually.

OK, I can change to such format.

Best regards,
Krzysztof
