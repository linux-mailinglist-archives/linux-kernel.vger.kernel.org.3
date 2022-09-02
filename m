Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF95AA6CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiIBEOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiIBEOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:14:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D99FA9265;
        Thu,  1 Sep 2022 21:14:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z6so1551460lfu.9;
        Thu, 01 Sep 2022 21:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=AijBO9nrg7xX2FQ7t5pNNFjzi755cTFDKODqE4YFCPQ=;
        b=mm2IaPaiZD2YANcxOHf7RTxd/urUt118pLj6ni5f+pIKMaHXNOFjHxopf+AxdheVEP
         oE3Iwu+BchPlyJ0fTs2FN+KKWCI4ooCXNcsG6BcNokOMyK4Bp07Knk/Yq9+UKDH9cY4M
         U9A8FGjZVmubakszF9f8+qrQBSkjeo8ftj4rr0uiemHUYI0qD8z+h0rMpNSommvj3bwc
         LjnpzDRfS+osCXs2D261TmUzUd7Rc5v3omCgOJbDVQ6Yz1aBGKAOCSjub5NpoN/+F77T
         ft3WcXPmWO6OjTGR5xfeXkQ+D0JCgfMmZn4EopOP5gJaRYhXjRSTS66vPMHFm6WfHfJH
         Zkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AijBO9nrg7xX2FQ7t5pNNFjzi755cTFDKODqE4YFCPQ=;
        b=bW2qCnbN8NV5RtO3L5/E8b/eTmspkx5kfWnh3wLCA85H8HlbRY3uBM6Os0VM3CCUgr
         1C9e8uMhlhO8YQ0+59algRnY0SrxVzUfblKNO3aAlTsZ/YRMU4/7sKjKyQsVBFMXechd
         tphPERIDnlEY0acFjWcppE13cdeeTbgd/L6ndN29s3T+21aRH749KNO1yWCHkYF7KmbU
         REXd1eMBuCWJoyQG1D5rkbhLZ0PR9vRktwEQTi39/o4aZEZK33/6Pj4PxyDst76skhwC
         wHSZy+MNgcm7wyFQIDIXMds8u8VLeBvRVIZJMNqg/i9qsGzDN29HyPvIK8ViVg5r1XNe
         brMg==
X-Gm-Message-State: ACgBeo29enQSKZmYYzPrAOcysmsgPF5N1OXHaxi8zzLayU5tLzF2DkFN
        q6G1BJK/am4OLVzNAqTThN0=
X-Google-Smtp-Source: AA6agR5mOoimDDR08ufDCX8FZ5yVJE5be3+aRioWr9enab2ly9IAyC7eRKTTJTTrAStepJkxsgJAdw==
X-Received: by 2002:a05:6512:6c8:b0:494:796e:93b6 with SMTP id u8-20020a05651206c800b00494796e93b6mr5119794lff.213.1662092043519;
        Thu, 01 Sep 2022 21:14:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id z4-20020a056512370400b00494706193adsm106680lfr.208.2022.09.01.21.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 21:14:02 -0700 (PDT)
Message-ID: <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
Date:   Fri, 2 Sep 2022 07:14:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Marek Vasut <marex@denx.de>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
In-Reply-To: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On 9/2/22 01:23, Tim Harvey wrote:
> Greetings,
> 
> I've found that the bd71847 clk driver (CONFIG_COMMON_CLK_BD718XX
> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847 C32K_OUT
> pin) which is connected IMX8MM RTC_XTALI which ends up disabling the
> IMX RTC as well as the IMX WDOG functionality.

//snip

> This happens via clk_unprepare_unused() as nothing is flagging the
> clk-32k-out as being used. What should be added to the device-tree to
> signify that this clk is indeed necessary and should not be disabled?

I have seen following proposal from Marek Vasut:

https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564

I am not sure if the discussion is completed though. I guess it was 
agreed this was needed/usefull and maybe the remaining thing to decide 
was just the property naming.

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
