Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491CA4E987E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbiC1NoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbiC1NoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:44:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA44CD75
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:42:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nYpdJ-0005kp-7J; Mon, 28 Mar 2022 15:42:09 +0200
Message-ID: <e2a3e6c0-d98c-7417-31bd-5f674c9c32b4@pengutronix.de>
Date:   Mon, 28 Mar 2022 15:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <37da40fe-6e85-af40-756b-d022fe2559aa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.22 15:14, Krzysztof Kozlowski wrote:
> On 28/03/2022 15:07, Ahmad Fatoum wrote:
>> On 28.03.22 14:56, Krzysztof Kozlowski wrote:
>>> You could also add two cases:
>>> 1. three compatibles, deprecated: True,
>>> 2. two compatibles, without imx7d.
>>>
>>> Existing DTS stays with three compatibles for two years and later gets
>>> converted to two compatibles. New DTS should use two compatibles.
>>>
>>> It's quite a lot of churn, but would make in the long term bindings
>>> correct and also not break other users/projects.
>>
>> I don't see why we need to deprecate the old binding. New SoCs
>> can be imx8mm-usdhc compatible from the beginning and need not
>> care about the old binding. Existing SoCs can just remain imx7d-usdhc
>> compatible as they are now.
>>
>> I don't see what the deprecation accomplishes.
> 
> It avoids to have too many entries of imx8mm (imx8mm alone,
> imx8mm+imx7d, imx8xx+imx8mm+imx7d).

I see. I assume use of deprecated binding will be reported on a dtbs_check?

If so, the expectation is that downstream projects run dtbs_check on their
imported Linux DT repository, see the deprecation warning and extend
their drivers to comply with it.

Some time later upstream will remove the deprecated binding and adjust
the device trees. This works for me.

Cheers,
Ahmad


> 
> Best regards,
> Krzysztof
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
