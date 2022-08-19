Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2C599D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbiHSOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiHSOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:14:23 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C094D141;
        Fri, 19 Aug 2022 07:14:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660918452; bh=mikOm114pTMlqwHfoxCgC3bYF4HKVthSAvijVuexpIw=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=aYs3E+bQRjogZa+jboGDQlcmn6kqUrIV/mKg5R0JX7eNcVchSgv/qfDGj8GvvDPMI
         7uU52ZKQaSyiorIR+rB02MTf1xx3nYI1YwZ8ye8V13vdZ4pT5v0zHp0Rymu2ZZBVL7
         tseeOoWVBu6kBqO6CjUOvUO51OaolN7khxRn0pog=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
Date:   Fri, 19 Aug 2022 16:14:08 +0200
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
Message-Id: <737767DD-CB70-4941-8CF5-497333D3A801@cutebit.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-2-povik+lin@cutebit.org>
 <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
 <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 19. 8. 2022, at 15:08, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 19/08/2022 15:58, Martin Povi=C5=A1er wrote:
>>=20
>>> On 19. 8. 2022, at 14:54, Martin Povi=C5=A1er =
<povik+lin@cutebit.org> wrote:


>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - apple,t8103-mca
>>> +          - apple,t6000-mca
>>=20
>> Since it was brought up last time but I didn=E2=80=99t respond: the
>> nonalphabetical order is as the chips were introduced (and
>> matches other schemas).
>=20
> Sure, just keep that order for future compatibles as well - so always
> put them according to verifiable time of market introduction...
>=20
> This is very poor reason, instead of alphabetical order. Even worse
> reason is repeating wrong pattern just because someone else did it.
>=20
> Best regards,
> Krzysztof
>=20

I don=E2=80=99t see it nearly as clear-cut. Adding to the end seems =
pretty
foolproof too, but OK, next submission will have it alphabet. ordered.

Best,
Martin

