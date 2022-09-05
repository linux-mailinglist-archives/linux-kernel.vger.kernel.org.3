Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F85AD6CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiIEPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiIEPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:45:14 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AEC4505E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:45:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662392710; bh=q9fEBH3gcopu3CzK9ZpmTk1BGZLQ/rDml3lYdRY2lSE=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=WqxmVGsk9LDpi1helFou5dOiZiiuSbq7JfhJvMKulTsjUg7R3uATz8Y4qb86/fsuX
         VzH2cIsYo2GQtMResuDSGsH6+CrZKNgIQvlAsR/YrJh86+BKLFX0l56JyoUpk9pkeA
         GRsK3dT4uNF+R6juj5bH4vQKG+gaKxvuz5R08LSI=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 0/2] Untested TAS2562 power setting fixes
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <166239232739.736206.17258746656389143736.b4-ty@kernel.org>
Date:   Mon, 5 Sep 2022 17:45:09 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Stephen Kitt <steve@sk2.org>,
        raphael-xu@ti.com, alsa-devel@alsa-project.org, asyrus@ti.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>, navada@ti.com,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C600ACEB-C64F-4501-94E4-17B4FD0A8918@cutebit.org>
References: <20220825142226.80929-1-povik+lin@cutebit.org>
 <166239232739.736206.17258746656389143736.b4-ty@kernel.org>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 5. 9. 2022, at 17:38, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, 25 Aug 2022 16:22:24 +0200, Martin Povi=C5=A1er wrote:
>> The tas2562 driver does the same thing with the setting of PWR_CTRL
>> field as the tas2764/tas2770 drivers were doing.
>> Link: =
https://lore.kernel.org/alsa-devel/20220808141246.5749-1-povik+lin@cutebit=
.org/T/#t
>> Link: =
https://lore.kernel.org/alsa-devel/20220825140241.53963-1-povik+lin@cutebi=
t.org/T/#t
>>=20
>> These are blindly written patches without testing since I don't have
>> the hardware. (I even tried TI's formal sample request program but
>> was refused there. CCing @ti.com addresses I found on other series
>> recently submitted.)
>>=20
>> [...]
>=20
> Applied to
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git =
for-next
>=20
> Thanks!

Texas Instruments is shipping me samples of the affected
codecs, so I should be able to test the changes on hardware soon.

Should I find regressions, I will report back.

Martin

