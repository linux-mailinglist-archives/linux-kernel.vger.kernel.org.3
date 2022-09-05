Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9FB5ADC03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiIEXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:52:11 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890E44E63A;
        Mon,  5 Sep 2022 16:52:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662421924; bh=W3JevZj+Q9D8r4igU1ZJmgIAeBet1bJnmsd/TGyYu1A=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=OJg/WetN0MEqqqGYSigrzdn9TEaFgN9D4ozqzm+x1AYqELC93mC/O+G3wKlMjI0KR
         Yk/acY923n3/RakzT73BXiSFGEW7cbaSfbleD3qB6hSpi4sCaPD5Nd8dCpJheiRl7/
         WXdwJQDItW2qap9E4NKWkWI1T0R7IFvh+PK652Kk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v3 2/4] arm64: dts: apple: t8103: Add MCA and its support
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220905223927.GE10102@jannau.net>
Date:   Tue, 6 Sep 2022 01:52:03 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27908832-4453-4199-A899-7B93ABD1216B@cutebit.org>
References: <20220824160715.95779-1-povik+lin@cutebit.org>
 <20220824160715.95779-3-povik+lin@cutebit.org>
 <20220905223927.GE10102@jannau.net>
To:     Janne Grunau <janne@jannau.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ciao Janne, thanks for the comments and fixes.

> On 6. 9. 2022, at 0:39, Janne Grunau <janne@jannau.net> wrote:
>=20
> On 2022-08-24 18:07:13 +0200, Martin Povi=C5=A1er wrote:
>> Add the MCA I2S transceiver node and its supporting NCO, ADMAC nodes.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 4 ++
>> arch/arm64/boot/dts/apple/t8103.dtsi | 73 +++++++++++++++++++++++
>> 2 files changed, 77 insertions(+)


>> +		/*
>> +		 * This is a fabulated representation of the input clock
>> +		 * to NCO since we don't know the true clock tree.
>> +		 */
>> +		nco_clkref: clock-ref {
>=20
> clocks are not valid inside "simple-bus", the node name "clock-ref"=20
> conflicts in "/", maybe use "clock-nco"?

I would smuggle =E2=80=98ref=E2=80=99 or something to that effect into =
the name,
otherwise sure, let=E2=80=99s do it.

Martin

