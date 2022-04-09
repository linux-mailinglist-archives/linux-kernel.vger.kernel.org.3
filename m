Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152884FA7A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiDIM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiDIM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:26:56 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEFF1F619;
        Sat,  9 Apr 2022 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649507087; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xpz9qP27pZinyYZJySzqFZgO4JRDvkPdeCd3c2zUkL8=;
        b=lijqlWlqTZP5GTrescOMdRwvaKM9Y4prV/GiR2ActZqW0tTuWdbItRuhl4cHpa+c1GReIu
        pgrFGPcbXhrCdP94pApEN9IvYDxpe9e00uR6OCUWLcW3RE97+LV70TB/DI/yOyzjw9wR9j
        9+7uppfuv1ull072TfDf4ZgJ4UWHV9A=
Date:   Sat, 09 Apr 2022 13:24:37 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Message-Id: <1TN2AR.Q91IJNXMNNNA1@crapouillou.net>
In-Reply-To: <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
References: <cover.1649443080.git.hns@goldelico.com>
        <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
        <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le sam., avril 9 2022 at 13:11:48 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>  arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible:=20
>> 'oneOf' conditional failed, one must be fixed:
>>  	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is too=20
>> long
>>  	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu',=20
>> 'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
>>  	'simple-mfd' was expected
>>  	'ingenic,jz4760-tcu' was expected
>=20
> Trim it a bit...
>=20
>>  	From schema:=20
>> Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
>=20
> You need to explain this. You're changing the effective compatible of
> the device and doing so based only on schema warning does not look
> enough. Please write real reason instead of this fat warning, e.g.=20
> that
> both devices are actually compatible and this has no real effect=20
> except
> schema checks.

Well, if the schema says that it should use a particular fallback=20
string, then that's what the DTS should use, right?

If making the DTS schema-compliant causes breakages, then that means=20
the schema is wrong and should be fixed.

Cheers,
-Paul


