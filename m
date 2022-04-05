Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506614F4E20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587843AbiDFAKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573695AbiDETla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:41:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C046208;
        Tue,  5 Apr 2022 12:39:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 1EB511F4370D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649187569;
        bh=/s6fZDVbpiIQW0S5UO2G1RWfpbsAjuqB16uALNiR7fA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=du7y76Mrgs9fzjL6kCL5pOm6CipJjs1QamPYv1VvPMSWG91LVSDu1RxdfWBh6lZPg
         +JGG/hCKtjAEKHkndXb3mOeTS33Xm53CSSlkRW355R9tGA7mUS7EQqKjc7cAaj5Kea
         HSxDfF4SMeP3vJ6Bt/9Ap2xsNhDHtmayvmHu7wnzVfu9vcLM6gPvdnVbY3JTkkcZzZ
         yS2ib2WEBNIRVpbXFfho7OvHdDDTTacxJLJ3byL5utZtnzqhYboqXajagIfyD/MWTu
         08J2P3HZ36pAqXCQvIeD/UYFPHTEOdagRPIY/mnP5S1pU+e4h13Fsnu0n2z5b1sCCH
         OdOslyJaw4/6g==
Message-ID: <9887dc0c-c2e0-868c-55e3-32083f820e09@collabora.com>
Date:   Tue, 5 Apr 2022 16:39:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
 <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
 <d9f14221-b0ad-9853-e9c8-a35d9111549b@collabora.com>
 <3e3b223f-7d05-f439-625a-a15afb44b95f@collabora.com>
 <CAOMZO5D8UHkkyJE9uJ4yBmf+ajjbzJOrLM57OHpyAiATvMNXcw@mail.gmail.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <CAOMZO5D8UHkkyJE9uJ4yBmf+ajjbzJOrLM57OHpyAiATvMNXcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Gentle ping :-)

On 3/31/22 10:48, Fabio Estevam wrote:
> Hi Ariel,
> 
> On Thu, Mar 31, 2022 at 10:35 AM Ariel D'Alessandro
> <ariel.dalessandro@collabora.com> wrote:
>>
>> Hi Fabio, Shawn,
>>
>> Can we merge this please?
> 
> Shawn will probably start picking the patches for the next cycle after
> 5.18-rc1 is released.
