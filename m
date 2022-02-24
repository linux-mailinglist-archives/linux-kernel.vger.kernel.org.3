Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468604C312C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiBXQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBXQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:25:55 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6424E22B08
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:25:10 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id c192so166936wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W/wmNqvkNRKH1gO1S389jk2HIm35cz9EGXNpcHB0DIw=;
        b=Hro208Z3aTFu4uq3IemoXRfv9uG8o6r64rEL3skqs/rcSF7CEzlLjJ73MPe3jm5Z50
         WPw3iBw2EDggDxPD1+HcOMFYvXrpTBTOXFh5AshPxXQYW+6qzmn9lshNUaGxbLuT3VYf
         Z4N+L2buLPNjKsnIig87LGN+SJdmrVkuB1/PcrudJpmemlt4rHgWXTRpKa6bEqLNnvi7
         DxuPgAbNT7dUTLmclbXQyjP2tergdmgMTtCauV2Mewm/SsdWCW0ddGKlB93sQUBeiAfb
         DY3hVaI69u5wRZWAkT0zP78dJ6bCmhyvFU8mdkvXqGs25Umps1y0iIX6Y3jBVYQ+Hkuq
         gkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W/wmNqvkNRKH1gO1S389jk2HIm35cz9EGXNpcHB0DIw=;
        b=eGgILYzbgj/riW5iN2FAIBbaZxGoc1cSSTw18b/0X/SewRFSP6BUUYeqwLtq8GbhNx
         J2Xf5/s1TFocYevvVawCgYuIW6MtEnU1aFbkzhK6K0bWCx9uJHtfbPuhJhHZn3cZATm3
         NoUpbAAVbehPm0pb6apLpJ0a7vUwLv/jnK/BaJTQur0XJNIxsC1nq6UUoPrxguTqdiPa
         QGCmR2Z26zRF/Eo6Vd3g8/Syg1RuyjJ/6zG0Sw6Aei453wEIxiMWef7ZCSEPfXUVzrL8
         qod1O09kAREhdsehm6QlfoUmBXT+tZ3Cj+F2zOBhbq7Dwne7NVz1d+HtFGuEWVo1FPDw
         hhIQ==
X-Gm-Message-State: AOAM530xnq8TRylbMl9qUVKRThkNCRJrfdKxg3yKj0gA9scmL8K0JEcX
        d0lIPF7IcaSw5UZMvUtmnTDs6W8X+KcH9A==
X-Google-Smtp-Source: ABdhPJycgDD4wf4+Jat3ytqdbVZMHMqtnqYtKyvBtzcPa4Jss3218ejv9wuDW+5LgxXrwkLvLHPi9w==
X-Received: by 2002:a05:600c:35d1:b0:37c:d45c:af57 with SMTP id r17-20020a05600c35d100b0037cd45caf57mr12201121wmq.149.1645719231791;
        Thu, 24 Feb 2022 08:13:51 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id az21sm3051490wrb.111.2022.02.24.08.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:13:51 -0800 (PST)
Message-ID: <86253ac7-ef06-974e-9b2d-6575ad5b7195@linaro.org>
Date:   Thu, 24 Feb 2022 16:13:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 14/16] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
 <20220224111718.6264-15-srinivas.kandagatla@linaro.org>
 <522ab282-ecc2-4186-2d77-f6241e255109@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <522ab282-ecc2-4186-2d77-f6241e255109@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2022 15:29, Pierre-Louis Bossart wrote:
> 
> 
> On 2/24/22 05:17, Srinivas Kandagatla wrote:
>> WSA881x codecs can not cope up with clk stop and requires a full reset after suspend.
>> WSA SoundWire Controller connected to this instances do a full soft reset on suspend.
> 
> is it the manager or peripheral that cannot cope with clock stop?
> 
>> @@ -1124,6 +1136,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>>   	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
>>   	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
>>   	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
>> +	pdev->prop.simple_clk_stop_capable = true;
> 
> here it's pretty clear the peripheral is capable of supporting clock
> stop, no?
> 
> Something's not clear between the commit message and the code.
True, This should be removed along with attempting to call clock stop 
functions from WSA SoundWire controller suspend that does not support 
clock stop.

--srini
