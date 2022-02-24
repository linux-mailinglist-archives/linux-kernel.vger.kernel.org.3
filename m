Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1178D4C2700
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiBXIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBXIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:54:47 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E4163062;
        Thu, 24 Feb 2022 00:54:18 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C1FB122239;
        Thu, 24 Feb 2022 09:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645692856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvkcoUKllQj2T4+MNV6kXQ3nLOUi8Q7r2MLGcdGUqmY=;
        b=RBInsJPHuWavYhtDil26uHxuu1hhkXEIy8BK9iZ7Gqbb0NEctvhoVGEPGErHLnVGbznh6m
        CCB2eo37CSiFwVfhtG/l4bHYj8aczvSJLIAgxX1PlM+kXD4C/xywD/5II4iBMgUbotl7Sq
        eKne8tpz6DqzFLwtJ43OtBoLdquy9E4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Feb 2022 09:54:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC
 outputs
In-Reply-To: <CAEyMn7aVWK7NBH5+FpcK-gr9LPqb8MwsiOOTVJqo+PZJ+_naSw@mail.gmail.com>
References: <20220223210559.1999209-1-michael@walle.cc>
 <CAEyMn7aVWK7NBH5+FpcK-gr9LPqb8MwsiOOTVJqo+PZJ+_naSw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <b3f0b5ee57b144c2e0487fb104ae92da@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-24 08:29, schrieb Heiko Thiery:
> Hi,
> 
> Am Mi., 23. Feb. 2022 um 22:06 Uhr schrieb Michael Walle 
> <michael@walle.cc>:
>> 
>> Use the power signal names as given in the schematics of the reference
>> board.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 20 
>> ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts 
>> b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
>> index b4225cfcb6d9..eaa06f49aef5 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
>> @@ -41,7 +41,7 @@ pmic: pmic@25 {
>> 
>>                 regulators {
>>                         buck1: BUCK1{
>> -                               regulator-name = "BUCK1";
>> +                               regulator-name = "VDD_ARM_0V9";
> 
> I think BUCK1 and BUCK2 are twisted here. This should be "VDD_SOC".
> 
>>                                 regulator-min-microvolt = <600000>;
>>                                 regulator-max-microvolt = <2187500>;
>>                                 regulator-boot-on;
>> @@ -50,7 +50,7 @@ buck1: BUCK1{
>>                         };
>> 
>>                         buck2: BUCK2 {
>> -                               regulator-name = "BUCK2";
>> +                               regulator-name = "VDD_SOC";
> 
> And this should be "VDD_ARM_0V9".

You are absolutely right. I noticed it on the 8MNANOD3L-EVK but
forgot to update these.

-michael
