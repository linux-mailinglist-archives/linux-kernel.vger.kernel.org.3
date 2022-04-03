Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C34F0BA5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359699AbiDCRse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359696AbiDCRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:48:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F870245A1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:46:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so11167118wrg.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2g9qaHCuEJMeVa5OH4CWlrCXm2yddjigX6r4a3uF+bk=;
        b=rcwgiQ7fmqJ88I3Jf91Mfta3uYZ8QtARp8w3WvGxtOHFN5fZNFmW70GTLdCa+yulK6
         G1TQqMyFTSv38tQlFw7YE3v+xWA2YnoFTqymhC/NHvco4y+S2tmJLG2xyurtaC0KgXOB
         wiMYSwPMiKS8/ujZgjjoHtisF80DdrfbCkajBtwW0UA25BRv9V1+toF9PMrVsUgNP36V
         UQmUbDPZQbb30nyTo09vqGSLii/75jeVxcpcVgFsL94njAAGr9cIAlbGmBuo8XAXAJXh
         293NODuR0ay1dMB/pqalvnojX4AGMf2XKfHZ646Nu1f+COAWPXVQV9TZdqV8CpEBgLC8
         Zh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2g9qaHCuEJMeVa5OH4CWlrCXm2yddjigX6r4a3uF+bk=;
        b=kYLWOjAkepawTigmDkUxte8Tq4ipBJdZ0c2C4mf0uNZvp0if47cg1KcBDAoQ6KTW2E
         E4Y2AvCdAOK7UzYQYkx35xcyj4qPkVhBwQ/fnPAmm8L6Q7COdNvVAXHs9bfhDguxfKuj
         v4/R9FKJla4uTAPoLZi2GK3pc/fEGYK3/OBtaoK6lfjZKunh9xPfwqet+2WEbi3qy4mS
         +9TECW9jEg7/b43LU4HVmeetAv6LhW500QNtV1YBsphKa1wUqYbGV3OwgXHmjqj/uRKU
         K0uaI1gaGKKQmcmOwS1weJVZxDIfZtkP7EHRksSrIE6QfEtfxkpRLPxc/8XCmFmIn9SI
         fhRA==
X-Gm-Message-State: AOAM530pJRVoDVWOx9vmyMLcnx33EVqwJE+shYlU2KyGq4FZhAMePobB
        5gtE9tUlHnQ+ps8qfeLn3nQ8dQ==
X-Google-Smtp-Source: ABdhPJy2DSeufMTTGlQGYb78V/qM1iOXosW2NM+9ShpV4un5yPctthuLTvns43Z+dwPourVAYXovxQ==
X-Received: by 2002:a5d:4e8a:0:b0:206:d4f:86 with SMTP id e10-20020a5d4e8a000000b002060d4f0086mr2916038wru.301.1649007996129;
        Sun, 03 Apr 2022 10:46:36 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p18-20020a1c5452000000b0038e70261309sm1750080wmi.1.2022.04.03.10.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 10:46:35 -0700 (PDT)
Message-ID: <30aa1bdc-8b77-1077-a0a5-258ea0d27f71@linaro.org>
Date:   Sun, 3 Apr 2022 19:46:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 4/4] ufs: set power domain performance state when
 scaling gears
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20220401145820.1003826-1-krzysztof.kozlowski@linaro.org>
 <20220401145820.1003826-5-krzysztof.kozlowski@linaro.org>
 <YkdWvVVp4RloGjkC@ripper>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YkdWvVVp4RloGjkC@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 21:47, Bjorn Andersson wrote:
> On Fri 01 Apr 07:58 PDT 2022, Krzysztof Kozlowski wrote:
> 
>> Scaling gears requires not only scaling clocks, but also voltage levels,
>> e.g. via performance states.
>>
>> USe the provided OPP table, to set proper OPP frequency which through
>> required-opps will trigger performance state change.
>>
> 
> This looks quite nice! Just two questions about the path looking forward.
> 
> If we where to extend the opp core to allow specifying the clock rate
> for some N first clocks (similar to how e.g. regulators are handled) it
> seems possible to extend this to replace the freq-table property as
> well. Would you agree?

Yes, although that might be trickier. The frequency is a key. I'll take
a look whether it could be changed to multiple values like the voltage.

> 
> 
> The other missing required feature (in this area) from the upstream UFS
> driver is the ability of voting for interconnect bandwidth. Based on
> your path it would be trivial to specify different values for the votes
> for each speed, but looking at downstream [1] (each row represents the
> vote for the two paths in KB/s) indicates a more complex relationship
> between gear and voted bandwidth.
> 
> This was the reason I suggested that perhaps we need to key the
> opp-table based on the gear? But I don't think there would be any issue
> detecting this in runtime...
> 
> [1] https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio.dtsi#L1982

It should be doable with current bindings, assuming that gear is some
imaginary frequency. We have two interconnects for UFS (the DDR and CPU)
and OPP bindings allow to specify opp-peak-kBps and opp-avg-kBps for all
of interconnects. IOW, the opp-peak-kBps will have two values and
opp-avg-kBps as well.

What would be still missing is scaling clocks.

interconnects = <&ddr>, <&cpu>
interconnect-names = "ufs-ddr", "cpu-ufs";
opp-table {
  // gear 1 or some core clock frequency?
  opp-1 {
    opp-hz = /bits/ 64 <75000000>, <0>, <0>, <75000000> ....;
    opp-avg-kBps = <922 1000>;
    opp-peak-kBps = <0 0>;
    required-opps = <&rpmpd_opp_low_svs>;
  }
}

arch/arm64/boot/dts/qcom/sdm630.dtsi already uses it.

I think still the problem is scaling of multiple clocks, depending on
the gear.

Best regards,
Krzysztof
