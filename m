Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAB4E9DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbiC1RhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC1RhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298713EBA;
        Mon, 28 Mar 2022 10:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A2C60F43;
        Mon, 28 Mar 2022 17:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F3C340F0;
        Mon, 28 Mar 2022 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648488918;
        bh=8DK84zvqPVQ5dqS+l/hxkkjiMncObsS+szQGh2/hPXg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c2bDiePA9kHGkpvEstcte3dmY6J/ZwxEwE+Akse5+A/eLvrlrOHTah0fbvzTpRuh4
         Pokc1eA4hRapiiyGDVv7277DFDB+HQ8hZe6l+gOshZAHIksKcpxXEB1ikexTibdkJP
         f60RlTKUb7L0Djzxhr943hpHmv1HuG3Jr+P43jTJ30TkGk+Q+TQ6+iK6umVxiVqewQ
         JQWzn1Ibvr7nDQw3iR4n33tSn5lWpGTtBkX6wHt+6NyvhH4ms3egZ3yvz9dVYJs5se
         vZ26BRS4YGRcpdNJ1eiJa1uwFOWgXH/OU8iHr15SF/oruYYJiqRreOQD7ZMvr+Cy5i
         2TOB7CldP3qPw==
Message-ID: <6e1686d0-50f4-8681-1f15-2e4df957ebc8@kernel.org>
Date:   Mon, 28 Mar 2022 19:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20220327123835.28329-1-aford173@gmail.com>
 <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
 <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
 <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de>
 <5c24c12b-3a12-1e18-9f03-2c54cad30bf9@kernel.org>
 <CAHCN7xJ28t3igV8uHWfLxJx6wWkwzojg-d0QTTZM9jdfGCbTzw@mail.gmail.com>
 <5282b39b-85d5-81d6-10d5-a45c66d4d4e9@kernel.org>
 <010b3600-81dd-f5e3-2d57-8cab8efd58f0@pengutronix.de>
 <37da40fe-6e85-af40-756b-d022fe2559aa@kernel.org>
 <e2a3e6c0-d98c-7417-31bd-5f674c9c32b4@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e2a3e6c0-d98c-7417-31bd-5f674c9c32b4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 15:42, Ahmad Fatoum wrote:
> On 28.03.22 15:14, Krzysztof Kozlowski wrote:
>> On 28/03/2022 15:07, Ahmad Fatoum wrote:
>>> On 28.03.22 14:56, Krzysztof Kozlowski wrote:
>>>> You could also add two cases:
>>>> 1. three compatibles, deprecated: True,
>>>> 2. two compatibles, without imx7d.
>>>>
>>>> Existing DTS stays with three compatibles for two years and later gets
>>>> converted to two compatibles. New DTS should use two compatibles.
>>>>
>>>> It's quite a lot of churn, but would make in the long term bindings
>>>> correct and also not break other users/projects.
>>>
>>> I don't see why we need to deprecate the old binding. New SoCs
>>> can be imx8mm-usdhc compatible from the beginning and need not
>>> care about the old binding. Existing SoCs can just remain imx7d-usdhc
>>> compatible as they are now.
>>>
>>> I don't see what the deprecation accomplishes.
>>
>> It avoids to have too many entries of imx8mm (imx8mm alone,
>> imx8mm+imx7d, imx8xx+imx8mm+imx7d).
> 
> I see. I assume use of deprecated binding will be reported on a dtbs_check?

Unfortunately no, at least not yet. :-(

> If so, the expectation is that downstream projects run dtbs_check on their
> imported Linux DT repository, see the deprecation warning and extend
> their drivers to comply with it.
> 
> Some time later upstream will remove the deprecated binding and adjust
> the device trees. This works for me.
>

Yes. Plus this gives the notice to downstream projects, to comply with
the change of DTS.

Best regards,
Krzysztof
