Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69E507637
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiDSROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244868AbiDSRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:13:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C33465F;
        Tue, 19 Apr 2022 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650388258; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jHHqMT3ZNJyXA6M3ybRSFsTHCa1a0GBz5I5GGvIb6E=;
        b=dx2HRl6oBoNgzvk39RvHvRVwUZSRIH5DOFtd4lqBrWOJ0j5jkENLlVzLcxN7Xx3y2Sk6Nf
        cTEn5cHY9n4ZoqGGx0nZYRRsUV39x04Iur3rItBvLzcWsst7tZ2YWQYbCFTwoQL0bI2TQC
        JbhHjo3PXhenPiPPYkhDlIBQLmF5skg=
Date:   Tue, 19 Apr 2022 18:10:47 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] SPI: Ingenic: Add support for use GPIO as chip select
 line.
To:     Mark Brown <broonie@kernel.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <ZPJLAR.DZVBSGKZUPVI3@crapouillou.net>
In-Reply-To: <Yl7quUXmEEPHfTfC@sirena.org.uk>
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1650032528-118220-2-git-send-email-zhouyanjie@wanyeetech.com>
        <61ZDAR.SD20HFTWMIBH3@crapouillou.net>
        <d7926a1d-c5e3-6519-6a52-1bd3ca3cf773@wanyeetech.com>
        <A5YFAR.5U5RNX82OXJY1@crapouillou.net> <Yl7quUXmEEPHfTfC@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mar., avril 19 2022 at 18:00:41 +0100, Mark Brown=20
<broonie@kernel.org> a =C3=A9crit :
> On Sat, Apr 16, 2022 at 05:36:46PM +0100, Paul Cercueil wrote:
>>  Le sam., avril 16 2022 at 19:55:13 +0800, Zhou Yanjie
>>  > On 2022/4/15 =E4=B8=8B=E5=8D=8811:00, Paul Cercueil wrote:
>=20
>>  > > > -    ctlr->num_chipselect =3D 2;
>>  > > > +    ctlr->use_gpio_descriptors =3D true;
>=20
>>  > > I wonder if this should be set conditionally instead. Maybe set=20
>> it
>>  > > to =7F"true" if the "num-cs" property exists?
>=20
>>  > I'm not too sure, but it seems some other drivers like=20
>> "spi-sun6i.c",
>>  > "spi-stm32.c", "spi-s3c64xx.c", "spi-pic32.c", etc. set it
>>  > unconditionally.
>=20
>>  Ok, maybe Mark can enlighten us here.
>=20
> use_gpio_descriptions is just selecting which version of the GPIO APIs
> we should use if we're handling GPIOs rather than if we should handle
> them.  We've got one last driver using the numerical GPIO APIs, once
> that one is converted we should just be able to drop the flag since
> everything will be using descriptors.

Thank you Mark.

Cheers,
-Paul


