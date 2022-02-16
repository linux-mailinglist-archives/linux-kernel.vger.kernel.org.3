Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783254B7EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344274AbiBPDWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:22:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbiBPDWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:22:39 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7869289
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:22:23 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id e19-20020a4ab993000000b0031a98fe3a9dso431176oop.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1UE5mxJJnwzOyLPJKQRyZVhIVlOta3ZlkgAHdJG/ons=;
        b=c8nILGB/vkXbwXmQNrD1XfFv4PsbmcvPox9DWoBvaa5KFr//oCPe/HBc7V1xMDki6V
         rxJKcDFS9QKbWinbfQzZL0hcFDZml2XCVki2ksrTj0nyk14LovCKxxP1Wm3gOWFqq3ca
         nwZ+HUZDdSOkO1VXXT+H8aszhZ68/VVgegb24evWrooUJDirVAp3y/ocAS7Zrq96NEnK
         dm3+8AtWXl+NK63qRLcNgtMhXgMxvQzwATepWM7rz+D8HoXgWXBcaA9zN3v7EPLLQ4Nz
         ELwyRnGVzqdus62zJ1+pscdJwYqSXODohDsUjLssFJHc15UCLYRIrfVlSpz6i+G80n65
         0lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1UE5mxJJnwzOyLPJKQRyZVhIVlOta3ZlkgAHdJG/ons=;
        b=WZZejVl1XBOd9EwajkVJjtrN74mCyKEEb/IK3ngbfT/UFxU2wqj344GRbxp2ZZRAx1
         9wtj9GdyD38gmQkzxc1jgKbqPzkk7Yy3ZscytLnDR0xunznZ1LFYRVSLAT+fJnDa6l7l
         bBVk8kE/uNrpYNRwE3xLOhwJmso0APkK1eaTYuAM/M594LDEskTzvMeWhPKs0LFaK0nE
         Bl04+BtqFyzkrrzKyjPOtq4QbshkOB4eAWHqpGbfBVdePxn5uy+Wzfv4/oU4scVzl7zv
         nVCLoBn00xD4PALxVzryUSroYUUP7qFdf1RuBU0xbmNBTfd4H3g+fKrKr2ReRPiIIyCz
         kQ0Q==
X-Gm-Message-State: AOAM532v0Ua9gxTUN/5jxVAE0d1ht0Fuj86kuqp27i05d07llIgDEGjM
        puwwe4uBymhcfY45RBbQJDsjHQ==
X-Google-Smtp-Source: ABdhPJxNTbE35rjOZUVQXv0RMxWaa9rztzoP+D5KoISvvHkCMF49ddlGEIsYPQW0xXvoXKAmBm7jhg==
X-Received: by 2002:a05:6870:7884:b0:d3:1509:b400 with SMTP id hc4-20020a056870788400b000d31509b400mr323676oab.292.1644981742656;
        Tue, 15 Feb 2022 19:22:22 -0800 (PST)
Received: from [192.168.11.51] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id l14sm14267638ooq.12.2022.02.15.19.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 19:22:22 -0800 (PST)
Message-ID: <47ae3e73-5880-bfb7-fc14-7dd95a75ce14@kali.org>
Date:   Tue, 15 Feb 2022 21:22:20 -0600
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
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <0e006cc0-2760-195a-35b9-0a2f6e8452c5@quicinc.com>
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

On 2/15/22 3:40 AM, Sandeep Maheswaram wrote:
> Hi Steev,
>
>>>>
>>> Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if 
>>> you are getting the issue.
>>>
>>> Regards
>>>
>>> Sandeep
>>>
>> I just tested here, changing both of the IRQ_TYPE_LEVEL_HIGH in the 
>> yoga's dts to EDGE_BOTH and I still do not get a booting system.
>>
>> -- Steev
>>
> Please let us know what devices are connected to your setup and share 
> the device tree file you are using.
>
> Please share the failure logs also,
>
> Regards
>
> Sandeep
>
The setup is a Lenovo Yoga C630 (Windows on ARM laptop).  I do not have 
any sort of serial console access to the device, unfortunately.  Even 
when taking it apart, it seems to have some sort of 26pin debug adapter 
port that I've never seen before which you can see on the far right in 
this picture of the motherboard at 
https://i.ebayimg.com/images/g/a2EAAOSwwzZiCxPM/s-l1600.jpg

I do not have anything plugged in to the USB ports (sometimes the power 
adapter, but I have tried both on mains as well as off.)

I am using this diff


diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index eab3f00c603235..c54042b9e21df2 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -370,7 +370,7 @@
  		reg = <0x15>;
  		hid-descr-addr = <0x1>;
  
-		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_BOTH>;
  	};
  
  	tsc2: hid@2c {
@@ -378,7 +378,7 @@
  		reg = <0x2c>;
  		hid-descr-addr = <0x20>;
  
-		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&tlmm 37 IRQ_TYPE_EDGE_BOTH>;
  	};
  };

Which I added as a commit to my kernel tree, and pushed so you can see 
the full dts here: 
https://github.com/steev/linux/blob/c8234e664491e35e3edcd211f3b78c04436402b0/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts

I am booting with the command line arguments of

clk_ignore_unused verbose module_blacklist=msm video=efifb 
earlyconsole=efifb

I can't provide a boot log, because I'm not actually getting anything.  
Booting a different kernel, and it doesn't appear that anything is 
logged at all.


-- steev

