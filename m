Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8471F595DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiHPNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiHPNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:50:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC6AA0616
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:50:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s23so5260710wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9LJBpIo0+SZSSb+h19vRrs4FS+ALmCyNcdSZjAMWnnU=;
        b=uG81MiHOkTX3xbhyR0HXE1/6snjgxsPTqzo2PJsn3LIUJ70O5hgmkiAjnwl7ah/vBw
         cNNsouDNVBA1AOO1jgln0yTZ/1h7NVTgOSJ6c01qkZfJf/W+mjLKt1VVs4WhRsy4LGPp
         muGfkOClFeyQvLTSz/SEqjvcIiLMBR7pRa8uBLqVd3BNGyvVFWOixrSm6B67Rvdrfunr
         CfKQS9JNSveXyWzYqNU3EVpEEdULlGTIhkKPfo379bbtxnEXYT+GBUNWAZBe62JwAJTQ
         hBU4yxF8HGL0W/zHnl3GQbYju+3e4olQ2ixzr40ZGabYiuXtdJIKRX+W5EiXh2zXPVV2
         njdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9LJBpIo0+SZSSb+h19vRrs4FS+ALmCyNcdSZjAMWnnU=;
        b=S5f2bIakop0etxOD4OKR3oe9h6FCq98OzWgUWYVochuJ7r7Ul4F3MiVeepvEt9OI/H
         O3sjZVlVRUVI4u+6BIDShyAV1IFaVX3X5Xfgi0hDXAG6wfCx3Ynt0vX5bCw/33U5JG8L
         6SSJFhxBNa/vnr8fY8kftEDGz/WSRA9dawm9j4mcGUaMfHUfc4nJxM4n2cUlmpiLfyby
         qWKF9NTp66F0HjbOH/J9jHiv3jeOUSbIS/f181XI8vdNOPscuJ6EF44xMwOzETYAJjqC
         cHx6Dma8Powst+PxL3Iiq131RcKxGbDJyiM33yNsOPoshzCco+eDeKbd/wztbcNwRBW+
         8Txg==
X-Gm-Message-State: ACgBeo1McnkiqCnfLXIigNAv4mvuxgUieOaq+fzqzn4JIb0eAP4O177I
        46E1FBnz+dfW/isa4VugS8zh+g==
X-Google-Smtp-Source: AA6agR5tssHuRnKgToto8PwA2NfWmIXwAZFjcgWsLI8g0vnP6ItXMOwY2BKuji4CeuOq5DfrTobmDA==
X-Received: by 2002:a05:600c:430c:b0:3a6:26e:88e8 with SMTP id p12-20020a05600c430c00b003a6026e88e8mr3360740wme.48.1660657852032;
        Tue, 16 Aug 2022 06:50:52 -0700 (PDT)
Received: from [192.168.0.12] (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id c5-20020adffb05000000b0021e4f595590sm10391715wrr.28.2022.08.16.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:50:51 -0700 (PDT)
Message-ID: <b34b2fa6-7dbf-e4d3-9833-57efd42f9137@linaro.org>
Date:   Tue, 16 Aug 2022 14:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <T2Uz7zs4Ht58lYc5zWg1VBY0ju6bVaSKa9y3RhBQWDDHmPXBHbAxI2J34jSeY0BFQy2y4JtFn3nQS0Lz4xI5jw==@protonmail.internalid>
 <20220812101240.1869605-3-abel.vesa@linaro.org>
 <e6821eef-4fcb-97b1-24be-e2bb62b99039@linaro.org>
 <Yvtx2aK1Uu51hTPM@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Yvtx2aK1Uu51hTPM@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2022 11:30, Abel Vesa wrote:
> On 22-08-15 21:34:07, Caleb Connolly wrote:
>>
>>
>> On 12/08/2022 11:12, Abel Vesa wrote:
>>> SDM845 is a special case compared to the other platforms that use RPMh
>>> stats, since it only has 2 stats (aosd and cxsd), while the others have
>>> a 3rd one (ddr).
>>>
>>> So lets add the node but with a SDM845 dedicated compatible to make
>>> the driver aware of the different stats config.
>> Hi,
>>
>> I gave this a go on the OnePlus 6, I noticed the driver is also meant to
>> read the stats for remote procs via smem, however this seems to fail for me
>> - it can't find any of the SMEM items even if I probe the driver manually
>> after ensuring remoteprocs have booted. Is this an unsupported feature on
>> SDM845?
> 
> Thanks for giving it a test.
> 
> Actually, you need to probe the qcom_stats after the remoteprocs have
> booted.

Hi, thanks for getting back to me. I did try this as mentioned above but I think I must have been 
doing something wrong as I get different behaviour now:


enchilada:/ # cat /sys/class/remoteproc/remoteproc*/state

running

running

running

running

enchilada:/ # ls /d/qcom_stats/
aosd  cxsd
enchilada:/ # rmmod qcom_stats
enchilada:/ # insmod /data/qcom_stats.ko
enchilada:/ # ls /d/qcom_stats/
adsp  aosd  cdsp  cxsd  modem  slpi



Weirdly, despite it succeeding it prints the following in dmesg with logging added to 
qcom_create_subsystem_stat_files() [1]:

[  156.540307] Couldn't get smem object 'wpss' (item: 605, pid: 13): -2
[  156.546899] Couldn't get smem object 'gpu' (item: 609, pid: 0): -2
[  156.553260] Couldn't get smem object 'display' (item: 610, pid: 0): -2
[  156.559957] Couldn't get smem object 'adsp_island' (item: 613, pid: 2): -2
[  156.567007] Couldn't get smem object 'slpi_island' (item: 613, pid: 3): -2
> 
> Doing so, you'll end up having the following:
> adsp  aosd  cdsp  cxsd

I seem to get a few more, I have some out of tree patches enabling the SLPI, and iirc the db845c 
doesn't have a full modem firmware. If these look good to you I'd appreciate it if you add my Tested-by.

enchilada:/ # for x in /d/qcom_stats/*; do echo $x; cat $x; done
/d/qcom_stats/adsp
Count: 48
Last Entered At: 1199663157
Last Exited At: 1524359015
Accumulated Duration: 793060082
/d/qcom_stats/aosd
Count: 0
Last Entered At: 0
Last Exited At: 0
Accumulated Duration: 0
/d/qcom_stats/cdsp
Count: 35
Last Entered At: 1194818037
Last Exited At: 1194769648
Accumulated Duration: 3223580811
/d/qcom_stats/cxsd
Count: 0
Last Entered At: 0
Last Exited At: 0
Accumulated Duration: 0
/d/qcom_stats/modem
Count: 49
Last Entered At: 3687081003
Last Exited At: 3686727026
Accumulated Duration: 2915592136
/d/qcom_stats/slpi
Count: 53
Last Entered At: 3120905905
Last Exited At: 3120894535
Accumulated Duration: 3218969498

Am I right in thinking the aosd and cxsd being all 0 is probably a similar issue to the one reported 
by Stephen in [2]?


[1]:

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 121ea409fafc..56cfb20d3683 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -178,8 +178,12 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,

         for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
                 stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
-               if (IS_ERR(stat))
+               if (IS_ERR(stat)) {
+                       pr_info("Couldn't get smem object '%s' (item: %d, pid: %d): %ld\n",
+                               subsystems[i].name, subsystems[i].smem_item, subsystems[i].pid,
+                               PTR_ERR(stat));
                         continue;
+               }

                 debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],
                                     &qcom_subsystem_sleep_stats_fops);



[2]: https://lore.kernel.org/linux-arm-msm/20220628201340.3981860-1-swboyd@chromium.org/
> 
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Tested-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>
>>> Changed qcom,rpmh-stats-sdm845 to qcom,sdm845-rpmh-stats, as suggested
>>> by Krzysztof.
>>>
>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index 5bea96a9ce06..67fe08b837be 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -4851,6 +4851,11 @@ ebi_cdev: ebi {
>>>    			};
>>>    		};
>>>
>>> +		sram@c3f0000 {
>>> +			compatible = "qcom,sdm845-rpmh-stats";
>>> +			reg = <0 0x0c3f0000 0 0x400>;
>>> +		};
>>> +
>>>    		spmi_bus: spmi@c440000 {
>>>    			compatible = "qcom,spmi-pmic-arb";
>>>    			reg = <0 0x0c440000 0 0x1100>,
>>> --
>>> 2.34.1
>>>
>>
>> -- 
>> Kind Regards,
>> Caleb (they/he)

-- 
Kind Regards,
Caleb (they/he)
