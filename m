Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5758D54A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiHIIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHIIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:23:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A82A1BB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:23:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay12so3130927wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BJWOeYOWaGtuSWpgn3DJStQNfUCfS0wNXe43q2ava3Q=;
        b=kJKNpygG1OIUcxR8O/QC0aXceRvoaiUrQDf/YJPW1+loD+a0IkdIlMs8b9Orla/OeG
         /5I09F70ijl3gKR6mzqD/HIF2Ud+kDHfm4xyYXWtAgE40eOX87k+oXaErctxr96V15d9
         kARohaRpAG9aPmFv2qlLrkZzReKnQJiZRdlgpcBaK+cajdIoa6dLnnUhosxkp03DuyIB
         4y6ZQlSTiEwyYeLYIu6zyKuZ1s4lltpgS2Wst0R2a8xiXt7U68jgwjDABgTXOhyuz4Dr
         2To729dHM+lGa5GVzUiaUS4Z/0cK2Ut+ROUcRFZEMF0AQAb1l6q5MQ0zuvSJIGnTkdgP
         azpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BJWOeYOWaGtuSWpgn3DJStQNfUCfS0wNXe43q2ava3Q=;
        b=Q4I5NpR6HRnW8ltAPCNvNyGkkK2b37N6VYvyIUyDm652PXPOpBxe/Q32YVCIFK27jN
         Uak9wU1lTdE5SNIk1lQ8G1T3iA3weStB25wcI/EIKb2iRcfuRZ0Osk8BCFYXikSahcTR
         XIGUeZxYpnprGptRNGX2wrcW6PK+/exRk5PuyvYmPmulQtJZ82JTix9JsVATZykX1SBx
         5Eu1zgsWxiJAaeWu08+waVs54LWmOgUwleAIRG6fo/KL4IcFe7l0a7NR0CQG8mfTfRY0
         QnnvygPAkdzE5n9I4FBnv16E9qnnVspMBOCzOIqNXBjn7SVZhhJDhgNCERWes5MHuOOU
         0MGw==
X-Gm-Message-State: ACgBeo3rSJ2Mzb8I0A2xSWCB281XyXjai6N+WCB8Y74d8SCjWNkhAKyK
        xkVbkT5ah0DLHbl2hNkzlR0BSA==
X-Google-Smtp-Source: AA6agR65Ka6kB6xgrHkvANuCCrRtr8CpPBbbo6EzKPhAu8eK4TDBf2PjFBheWdyREneQgnGGbFqlRA==
X-Received: by 2002:a1c:ed05:0:b0:3a2:ebae:c5e7 with SMTP id l5-20020a1ced05000000b003a2ebaec5e7mr14589715wmh.78.1660033433553;
        Tue, 09 Aug 2022 01:23:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q3-20020a056000136300b0021b956da1dcsm12886669wrz.113.2022.08.09.01.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:23:52 -0700 (PDT)
Message-ID: <27c03303-9ee5-d9df-b7f2-016491fce9e5@linaro.org>
Date:   Tue, 9 Aug 2022 10:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, daniel.lezcano@linexp.org
Cc:     abailon@baylibre.com, anarsoul@gmail.com, baolin.wang7@gmail.com,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220808094216.928018-1-michael@walle.cc>
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

On 08/08/2022 11:42, Michael Walle wrote:

[ ... ]

> On my second board
> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts). I get the
> following error:
> 
> [    6.292819] thermal_sys: Unable to find thermal zones description
> [    6.298872] thermal_sys: Failed to find thermal zone for hwmon id=0
> [    6.305375] lan966x-hwmon e2010180.hwmon: error -EINVAL: failed to register hwmon device
> [    6.313508] lan966x-hwmon: probe of e2010180.hwmon failed with error -22
> 
> Again, is there seems to be something missing in the device tree. For this
> board a device tree change should be easily doable, as it is still in
> development.

Logically with the fixes I've send these errors should have gone. Just a 
pr_info should appear "... not attached to any thermal zone".

If I'm correct, without or with the changes (new thermal OF code + 
fixes), the hwmon message is the same and the hwmon thermal zone is not 
created. So no regression hopefully.

Is it possible to check that?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
