Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F05ACF16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiIEJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIEJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:44:50 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D771409B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:44:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662371079; bh=UuiZBQrk3PkxgO4/DkhLIrDD9ZaCQxTMdt1KEb2j7EM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Bk/TT7cPidOmX6ahdFI2MrqSMRZS+vn/0NY6KUScFZzqAHQfvZvMnMp0l8sNXaJAu
         Qg/VOM876LH+AftUOPKpvCCFzGDOO2JIPsYLrp/dfuUz4DLtFp0cryr1bPvrDfgdM0
         yBSN4qQ/USJ7dzvMDKP0Bw1NwkxvFQvnjfTtzwLs=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] MAINTAINERS: rectify entry in ARM/APPLE MACHINE SOUND
 DRIVERS
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220905093546.19735-1-lukas.bulwahn@gmail.com>
Date:   Mon, 5 Sep 2022 11:44:38 +0200
Cc:     Mark Brown <broonie@kernel.org>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DB82E66-0BB9-4B43-917B-55E115994876@cutebit.org>
References: <20220905093546.19735-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 5. 9. 2022, at 11:35, Lukas Bulwahn <lukas.bulwahn@gmail.com> =
wrote:
>=20
> Commit 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver") =
adds
> a new sound driver at the location "sound/soc/apple/", but it adds a =
file
> entry referring to the non-existing location "drivers/sound/apple/*".
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains =
about a
> broken reference.
>=20
> Repair this file reference in ARM/APPLE MACHINE SOUND DRIVERS.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Martin, please ack.
> Mark, please pick this patch on top of the commit above.

Hi Lukas, fixed here already:
=
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?=
id=3D55e2bd9c41e800638676dce3f19dcfd16b309a08

Best, Martin

