Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA78599540
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbiHSGNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiHSGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:13:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895B491C0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:12:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q7so1190756lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JT4d+qIXOiD2c32PCe7VpC8Thaw9HKeDvaLegiyeoBs=;
        b=LlBUFZ0KtnEfoOPCl6+O8eSzoVMWvALL1/uzU8K4LZM4oP1qaxQmyOh4Q5o0/FdWij
         XD0AXh0ohnUTEGwV6ZrBbptWn+nXE5Lp7eG/vEcagIUmTK7NTCXsfQTXcY4SQpal6b+o
         kJeA6rdNrAUqfkW9R1iK3AmiFII5BYHSRObG6w7vxsUAxgXJq3Bwmv93yY7BzQRFlFQt
         57ll7i7YbB6G6ZeylC0kOoCeg4tCtBAstcxc1pymcsPIETiJumcQgMamBnkUAsrLupLM
         NLw4aaHGLsLbd6dB+68tHIcM3cjLgs+eD/KlyrA37JCl81+D3yLDnVX/YmjCHLscHwFf
         mv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JT4d+qIXOiD2c32PCe7VpC8Thaw9HKeDvaLegiyeoBs=;
        b=x3ts4HDpeRx+KFtd8ubEaMhF29OGo0gkblZSBW4u4At1w4rPVHJyJG+QHNjiPB6wpq
         YDH4V56haniQbN2qdv3ASy3yjD2MIG0DEbJVQV5AavYvOIeDl4Od3f7c+3dEksGKYWki
         38mdYb/WaZMr0dnTv4I+0o/yZfxhBcovJU6nQAVGwNqzlBpBWH0JjVhxQoNwR4oR9s4S
         Nj2BiboKUBYAY2EmIA/e0PFt5605cACx7xwCPFA/6+oTYPubHvjOprIKhwRCC+cXAXPT
         ijDMuOK8Bjms0OaNAFVYf15Laxqu0OE6yxO7xNXZ9jCxtcb1uPHUDPZV2MX2Nfdn6xtv
         K1dg==
X-Gm-Message-State: ACgBeo1EZOXFJpCMcPKt0G4X/qoMzcZJye6RKV+GHAxGW7mDHhwm6t7g
        b6UAy1FcjqCpjt7Asj/ifVp+2g==
X-Google-Smtp-Source: AA6agR6egBZWlTgL+lYH4tALCwa73LhErjRYFg+F5pOPcScNcEExN8yGp7Q5NJ4D804cjTkDXUtk1g==
X-Received: by 2002:a05:6512:32c2:b0:48b:373b:5503 with SMTP id f2-20020a05651232c200b0048b373b5503mr2055113lfg.192.1660889555612;
        Thu, 18 Aug 2022 23:12:35 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id 2-20020a2e0902000000b0025e6a3556ffsm467473ljj.22.2022.08.18.23.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 23:12:35 -0700 (PDT)
Message-ID: <ce1ea6c9-79bd-5dfa-41c9-38e49c9df735@linaro.org>
Date:   Fri, 19 Aug 2022 09:12:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] ASoC: apple: mca: Start new platform driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-3-povik+lin@cutebit.org>
 <53c8f062-a760-c65f-479e-53e7991b3f66@linaro.org>
 <82B580B4-85BF-4ABA-B098-98E3CA9EE247@cutebit.org>
 <414CEE0D-AED4-4900-88BE-A3BD993D79DD@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <414CEE0D-AED4-4900-88BE-A3BD993D79DD@cutebit.org>
Content-Type: text/plain; charset=UTF-8
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

On 18/08/2022 20:54, Martin Povišer wrote:
>>
>> Same as above, there’s supposed to be
>>
>>  resets:
>>    maxItems: 1
>>
>> in the schema.
> 
> Preparing an iteration of the series, I see there *was* the reset in
> the schema. Let me know if there is some issue with it.
> 

Indeed there is one, I missed it. It's OK.

Best regards,
Krzysztof
