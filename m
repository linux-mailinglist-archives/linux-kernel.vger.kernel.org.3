Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6264E1B39
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiCTLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiCTLCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:02:07 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223A46656;
        Sun, 20 Mar 2022 04:00:43 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id k10so1218281edj.2;
        Sun, 20 Mar 2022 04:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UcgHC2iDV9/2F3OSRK8axWbWLeeDPOH9bkq+3/RKRnI=;
        b=D+AvUvNaCfELEa52AVOGWsGBYsx0BNXDcppuK0YLpGQKrL/KB8zFYBJ3dB5xvV7Zw+
         vemXmB+cHuVFognnZIwlUJCPgu5mW2WP8fX3W58RdBTJsAeUYXNHpeBAeMkCRyXie3U0
         ICn49IOu5Z4rHfpFlU75Vxb6RllKMRPXecUr7SxVo2zgCYielvIcuEI8rdZpKHPAKR9V
         +UKzQTPAfSU5F1AcMVAuNntf1hLU5ZZBxGwVVx5pNHj65VnaWTjd06KujBVibUd8nNkg
         HC5JFNu8xdGVKHGpv1BnjRB9tvKU098i00hxw1XfGUIQQXtzRmJbV97A8d88tPXk94yy
         ZnoQ==
X-Gm-Message-State: AOAM532y8JmjARFUoytQTMe7AidFnOiB7htAkQj7BSAz7jKSmQ/7md0j
        yuGjQ/BWv41RHwoQSYq9DkR2OPQGlFU=
X-Google-Smtp-Source: ABdhPJxRTuLruUTDTZsAJVUshE+SpdS5Zkp55qyuD9JyUZ0J4JGG+LRYWQALmKuoSvu94aJGeiYzzA==
X-Received: by 2002:a05:6402:1742:b0:419:2707:747a with SMTP id v2-20020a056402174200b004192707747amr5398544edx.238.1647774041560;
        Sun, 20 Mar 2022 04:00:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm5395666ejl.122.2022.03.20.04.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 04:00:40 -0700 (PDT)
Message-ID: <f61abc2b-3ce8-7b1f-3d28-8a4a03ec58eb@kernel.org>
Date:   Sun, 20 Mar 2022 12:00:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm6350: Add UFS nodes
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
 <20220318183004.858707-6-luca.weiss@fairphone.com>
 <c88ed4b5-2e44-c3fd-ff2b-b4bee1354765@kernel.org>
 <CIO22P1JZY5F.1BYJF4HT2OOUW@otso>
In-Reply-To: <CIO22P1JZY5F.1BYJF4HT2OOUW@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2022 19:29, Luca Weiss wrote:
> Hi Krzysztof,
> 
> On Sat Mar 19, 2022 at 3:43 PM CET, Krzysztof Kozlowski wrote:
>> On 18/03/2022 19:30, Luca Weiss wrote:
>>> Add the necessary nodes for UFS and its PHY.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 79 ++++++++++++++++++++++++++++
>>>  1 file changed, 79 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>> index d7c9edff19f7..c5c93b6bcd2a 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>> @@ -541,6 +541,85 @@ uart2: serial@98c000 {
>>>  			};
>>>  		};
>>>  
>>> +		ufs_mem_hc: ufshc@1d84000 {
>>
>> Generic node name, so ufs.
> 
> With the node name changes UFS doesn't probe anymore.
> 
> [    1.893762] ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init failed err -19
> [    1.902674] ufshcd-qcom 1d84000.ufs: Initialization failed
> [    1.908391] ufshcd-qcom 1d84000.ufs: ufshcd_pltfrm_init() failed -19
> 
> I didn't debug this in detail but it's likely from the
> androidboot.bootdevice=1d84000.ufshc parameter in cmdline that
> ufs-qcom.c uses to fail probe with -ENODEV for all UFS other than the
> selected one. Not sure why this behavior exists in mainline (didn't look
> into this either).
> 
> This cmdline parameter (among many others) is added by the stock
> bootloader and as far as I know there's no way to turn that off.

I see now in the driver weird Android code like:
  static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
  ....
  if (strlen(android_boot_dev) && strcmp(android_boot_dev, dev_name(dev)))

This is wrong. How is Android boot arguments needed for UFS? UFS is
independent of Android... what if you run it with different bootloader
and different system?

I understand that it is inconvenient for you to change the name, but
looking at driver code, I insist even more. :)


Best regards,
Krzysztof
