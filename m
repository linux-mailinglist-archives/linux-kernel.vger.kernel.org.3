Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6458E8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiHJI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiHJI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:26:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9680E61DA3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:26:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l22so16894583wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=C4O+deHMw21i9ROh6aMeCmFYtLZ7zT5HJpdxL44+uwI=;
        b=skHNKGe/EdlNIN/2JhTRvDNdaIJYAJYZium+/LxZVQO0MKzpOUYuSxH2xdjSGwF4DV
         HUDoXC+raOXmQ/g1GVIjK2DfK8UF2H943OZhcV9iFmez0onZLNqDA0Sde4Wp0hNaVopL
         phO5973aD84d2BDmNjRhrnxVP1fu1ggxab57oJpdb2s5jstkKpSJVIvyz4NT8OVfez5g
         487I6AzTst2+OPjLwmslFsT87SiCwRj6yDbktUDlor/YGTnzAG9nvDjX4mbDesYOLbqQ
         TY+6NylwgPvvbBFY8wYhm8xOcPeGCx0AAjjvG5pvcxMVuLBH80cS7VIt4ybHZ24ChwjN
         NCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=C4O+deHMw21i9ROh6aMeCmFYtLZ7zT5HJpdxL44+uwI=;
        b=pQR2Wfp4O44CM5vzNzJZzHP8sL2/9Vm/wnPwsoZOWdbrhQTP/LEuy0gsj+v5mIzeHH
         yO8cGY7y30yT86iWtGgKILosSU/fLWW07Gu+GKh8KK1ruFUN7j1E7HEPu9iqIGddwYme
         vRmyIPH0OB/FdvVQxXUA1k6y3SDyAG82xYC3TNQIJAHNRBXcs23cxxi1gy8brdty+bdQ
         CZglaD18ElS2tDwgUEDK9+mlTuC/lLZoFbAg5/z3DDYkfONFA1im6FUcJXtQ0macpuu+
         GTUSlI0xrdBAQmvGNozsodKGOvClWv8iHiHUibf6ACaw2jatJBdUHsn0sSY9fPin4yTg
         dUyw==
X-Gm-Message-State: ACgBeo1pJ4ipXF3vta+sbHNSyKN7Qle5Y/kKizkt7bBPIIXseTGKu5bo
        BwiirrBkPkWyzx+eyIfstZ04AA==
X-Google-Smtp-Source: AA6agR4fgxq/68/WWQn+yFOTbhC53pUpIBXclTppON1LvC+cb77XJAaWf6/2h68rIy+rMscuIaf75g==
X-Received: by 2002:a05:6000:1ac8:b0:220:8168:126b with SMTP id i8-20020a0560001ac800b002208168126bmr16394237wry.288.1660119992494;
        Wed, 10 Aug 2022 01:26:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e26-20020a05600c4b9a00b003a500b612fcsm1533910wmp.12.2022.08.10.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 01:26:31 -0700 (PDT)
Message-ID: <1514c4c3-32c6-4127-0fd0-9a244445ff9c@linaro.org>
Date:   Wed, 10 Aug 2022 10:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <27c03303-9ee5-d9df-b7f2-016491fce9e5@linaro.org>
 <5adfe0882926d8f16c158d453069b37b@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5adfe0882926d8f16c158d453069b37b@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 10/08/2022 10:01, Michael Walle wrote:
> Hi Daniel, >
> Am 2022-08-09 10:23, schrieb Daniel Lezcano:
>>> On my second board
>>> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts). I get 
>>> the
>>> following error:
>>>
>>> [    6.292819] thermal_sys: Unable to find thermal zones description
>>> [    6.298872] thermal_sys: Failed to find thermal zone for hwmon id=0
>>> [    6.305375] lan966x-hwmon e2010180.hwmon: error -EINVAL: failed to 
>>> register hwmon device
>>> [    6.313508] lan966x-hwmon: probe of e2010180.hwmon failed with 
>>> error -22
>>>
>>> Again, is there seems to be something missing in the device tree. For 
>>> this
>>> board a device tree change should be easily doable, as it is still in
>>> development.
>>
>> Logically with the fixes I've send these errors should have gone. Just
>> a pr_info should appear "... not attached to any thermal zone".
>>
>> If I'm correct, without or with the changes (new thermal OF code +
>> fixes), the hwmon message is the same and the hwmon thermal zone is
>> not created. So no regression hopefully.
>>
>> Is it possible to check that?
> 
> Yes, I'm no more seeing any error messages and the device
> is probed successfully. Both on the kswitch board as well as on
> the sl28 board.

Great! thanks for testing

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
