Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29C5A8A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiIABL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiIABL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0848DC09E;
        Wed, 31 Aug 2022 18:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5552961CD5;
        Thu,  1 Sep 2022 01:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A264FC433D6;
        Thu,  1 Sep 2022 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661994715;
        bh=K0IlwXuix3BvINpGFkVRnlr166FlxhMBm++Ywj0zDcg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G34RDrEQDBcZAlf3xZr+fmbay6EBPT7wXw8i/eixWy2rw2QH+3sXm/2Y9zIW/YXuJ
         kWTwirpkoRZLHAhorbAL5UPGOcHN3M60pr7AwJf30GbHp/hObb79sOKG9jMOI2thHK
         YXxRYbQVD46K95SfdZS/+6tvb6J1TTK48UyaQxVPfZUV1cH2F7eITXy4vSro7hi+Md
         qRAtnBWebBdonZWHJ3xHDSfpUQayPp4zT1q1C9gW0RK5D7jtYrX6iyepfDaan/Yv7z
         fS9rG9zpVtAqW+osYtsvmDdnZuipqWDQwuN7S2bbIgYTJ4NjJZ3jmpT6RS+UzgjNI0
         Wk5T8FjGKiQ3Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
References: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] clk: davinci: remove PLL and PSC clocks for DaVinci DM644x and DM646x
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Lechner <david@lechnology.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org
Date:   Wed, 31 Aug 2022 18:11:53 -0700
User-Agent: alot/0.10
Message-Id: <20220901011155.A264FC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2022-07-20 01:29:34)
> Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
> support for DaVinci DM644x and DM646x boards.
>=20
> Hence, remove the PLL and PSC clock descriptions for those boards as well.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to clk-next
