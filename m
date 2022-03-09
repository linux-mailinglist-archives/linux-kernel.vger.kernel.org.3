Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A94D389A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiCISS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiCISSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:18:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB845062;
        Wed,  9 Mar 2022 10:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F31FBB82260;
        Wed,  9 Mar 2022 18:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA0CC340E8;
        Wed,  9 Mar 2022 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646849873;
        bh=DLoe9VsBm1F5UzhArWcsKKlXI8dGWPQnv2PJBF5BIkQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=C0corbsnPk/WFeTGDO46Rpd2dABZegqC73qGcYDlbcI24PuScZmZwvBxBXGBY/liA
         sdYviwmkoqm8QROwEq9nlzRAVbjfJUrH13w/QEgweGJxWIFk7Dx7ORRKN5qRALnaO4
         hE1chMKOD2N6vWgPkdcFZ4Jao05uOU/Ca9CRdkHTIAGIG+MNr5HjtHuaqGQg5DoZmz
         oqCMxJltrDbVengM62OhagqlkSPBgfIBYpMVqZta69rVoDz2PODrx9MxVWjTkpd3ke
         67aYrqhqdQwROZRflaqifw1Y43UHhLv23sRVeO2vrx4A02zR2tUS8w+EKCRZG7azTc
         z8VJbndZxRxow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220308152657.30651-1-nicolas.ferre@microchip.com>
References: <20220308152657.30651-1-nicolas.ferre@microchip.com>
Subject: Re: [GIT PULL] clk: at91: clk for 5.18
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Date:   Wed, 09 Mar 2022 10:17:49 -0800
User-Agent: alot/0.10
Message-Id: <20220309181753.8CA0CC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nicolas.ferre@microchip.com (2022-03-08 07:26:57)
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> Stephen,
>=20
> Here are a couple more clk changes for 5.18. This Pull-Request is made on=
 top
> of what you already have for at91 targeting 5.18 on your clk-at91 existing
> branch. Hopefully, we are aligned on this.
> this.
>=20
> Please pull.
>=20
> Thanks, best regards,
>   Nicolas
>=20
> The following changes since commit a5ab04af49434aef532bf6cd4baa08a13665d6=
08:
>=20
>   clk: at91: sama7g5: Allow MCK1 to be exported and referenced in DT (202=
2-01-24 17:05:45 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-a=
t91-5.18
>=20
> for you to fetch changes up to 8e842f02af7e2f6225d52d78cd25b465a98d344b:
>=20
>   clk: at91: clk-master: remove dead code (2022-03-08 15:37:08 +0100)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
