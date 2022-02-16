Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38B4B84E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiBPJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:52:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBPJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:52:26 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB814085
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:51:59 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s5so447054oic.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=idK/WPsNn9ovkHFdsU7Sif7/eTWJW74G0kzJx4BCAZk=;
        b=oWhRr51VmZU2S2gYaR5kbbLcR2oXecbmfKsZjko7tJ8FT7VDZbsbDpzlXUSHGGZE2R
         OCD3N5//IxagJbjaThbI3lobLqGexsB2KenC9HSrf4i9MBD65cK/kpSzy2HWdrqNZ5Is
         Nu62dR40mf/Edvdo7eW3xe2jHPksS/QIpKevTsyiNmGKhTguFs17sCXWQ5J3/+mhtLa+
         9PKQQLnuQn/H790sO1tDsu5Yr1lBmLXa7HP54dfazNtxFOCfMRMXx1MxO4pWhehIRlIr
         Yb4DmxqjB9nD+wHD/KEZlpoiCFlEK6aUVt6Tt1nivmpzvrC17wOYBnpIf4dIoR0ni0Cy
         fhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=idK/WPsNn9ovkHFdsU7Sif7/eTWJW74G0kzJx4BCAZk=;
        b=Z7Jbhv/UhRHKhBmpEDdVOx/STKmwebR4CEwtV2sQ4qoxAP1E/69+mxYasKTIsCEvYo
         PgEyXvh9xvAY+Zk2b3jKWz5kzF8D+Sts8ZrTYhmW2iPZ8jSw9H6gPbR6QPi7IM2meaKd
         FLoU/M/GSTqtTMKh6Zx1yBaj7BoyFtsOhpSOIG2mpUapMGwJH4/5PWm/wMXrNu5ppWsj
         6TXGhSV2ttRKLjSGOZDbikEVesAuTS+SzBJL1Wsu2xZBpiZWbj+3Wxv+DuKkQMx4jwS5
         OfLUmjT3ZAqWLrLjhhyS4emCkpL6A/B7IKX+xQGCSSdw5sOkShTmVg9iNp5CyxDe5VgR
         RbTA==
X-Gm-Message-State: AOAM530H9kppPCfYSom/2kyzjA27Zr3HZTLxA7S+pMDWMfljV8zCqX21
        xWVO9JnlZi+g6xyzVgs7PEY7TA==
X-Google-Smtp-Source: ABdhPJwIrThB4NcxBobY13FmQry+UoAcN8imJp73VfgJGon0wEf9Bswt2u/KdjQIAJpntb8vjP7PSw==
X-Received: by 2002:aca:b585:0:b0:2ca:e90c:3b59 with SMTP id e127-20020acab585000000b002cae90c3b59mr286602oif.80.1645005101046;
        Wed, 16 Feb 2022 01:51:41 -0800 (PST)
Received: from [192.168.11.51] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id t192sm1520931oie.14.2022.02.16.01.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 01:51:40 -0800 (PST)
Message-ID: <55aa0436-64f5-1ecb-d95d-721e45f6fb95@kali.org>
Date:   Wed, 16 Feb 2022 03:51:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Content-Language: en-US
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <20220118095255.GB11385@hu-pkondeti-hyd.qualcomm.com>
 <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
 <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
 <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
 <0e006cc0-2760-195a-35b9-0a2f6e8452c5@quicinc.com>
 <47ae3e73-5880-bfb7-fc14-7dd95a75ce14@kali.org>
 <bb36a205-fbfe-536e-5bf6-4a717ffd4e6e@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <bb36a205-fbfe-536e-5bf6-4a717ffd4e6e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On 2/16/22 12:27 AM, Sandeep Maheswaram wrote:
> Hi Steev
>
> On 2/16/2022 8:52 AM, Steev Klimaszewski wrote:
>> Hi Sandeep,
>>
>> On 2/15/22 3:40 AM, Sandeep Maheswaram wrote:
>>> Hi Steev,
>>>
>>>>>>
>>>>> Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if 
>>>>> you are getting the issue.
>>>>>
>>>>> Regards
>>>>>
>>>>> Sandeep
>>>>>
>>>> I just tested here, changing both of the IRQ_TYPE_LEVEL_HIGH in the 
>>>> yoga's dts to EDGE_BOTH and I still do not get a booting system.
>>>>
>>>> -- Steev
>>>>
>>> Please let us know what devices are connected to your setup and 
>>> share the device tree file you are using.
>>>
>>> Please share the failure logs also,
>>>
>>> Regards
>>>
>>> Sandeep
>>>
>> The setup is a Lenovo Yoga C630 (Windows on ARM laptop).  I do not 
>> have any sort of serial console access to the device, unfortunately.  
>> Even when taking it apart, it seems to have some sort of 26pin debug 
>> adapter port that I've never seen before which you can see on the far 
>> right in this picture of the motherboard at 
>> https://i.ebayimg.com/images/g/a2EAAOSwwzZiCxPM/s-l1600.jpg
>>
>> I do not have anything plugged in to the USB ports (sometimes the 
>> power adapter, but I have tried both on mains as well as off.)
>>
>> Which I added as a commit to my kernel tree, and pushed so you can 
>> see the full dts here: 
>> https://github.com/steev/linux/blob/c8234e664491e35e3edcd211f3b78c04436402b0/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
>>
>> I am booting with the command line arguments of
>>
>> clk_ignore_unused verbose module_blacklist=msm video=efifb 
>> earlyconsole=efifb
>>
>> I can't provide a boot log, because I'm not actually getting 
>> anything.  Booting a different kernel, and it doesn't appear that 
>> anything is logged at all.
>>
>>
>> -- steev
>>
> Can you try with below change
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0d6286d..0a9c0f7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3796,8 +3796,8 @@
>
>                         interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +                                    <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
> +                                    <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
>                         interrupt-names = "hs_phy_irq", "ss_phy_irq",
>                                           "dm_hs_phy_irq", 
> "dp_hs_phy_irq";
>
> @@ -3844,8 +3844,8 @@
>
>                         interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
> +                                    <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
> +                                    <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
>                         interrupt-names = "hs_phy_irq", "ss_phy_irq",
>                                           "dm_hs_phy_irq", 
> "dp_hs_phy_irq";
>
> Regards
>
> Sandeep

That does allow it to boot, however.... it breaks USB.

[    2.013325] genirq: Setting trigger mode 3 for irq 35 failed 
(gic_set_type+0x0/0x1b0)
[    2.014063] dwc3-qcom a6f8800.usb: dp_hs_phy_irq failed: -22
[    2.014134] dwc3-qcom a6f8800.usb: failed to setup IRQs, err=-22
[    2.014351] dwc3-qcom: probe of a6f8800.usb failed with error -22
[    2.018496] genirq: Setting trigger mode 3 for irq 39 failed 
(gic_set_type+0x0/0x1b0)
[    2.019124] dwc3-qcom a8f8800.usb: dp_hs_phy_irq failed: -22
[    2.019193] dwc3-qcom a8f8800.usb: failed to setup IRQs, err=-22
[    2.019372] dwc3-qcom: probe of a8f8800.usb failed with error -22

steev@limitless:~$ lsusb
steev@limitless:~$


-- steev

