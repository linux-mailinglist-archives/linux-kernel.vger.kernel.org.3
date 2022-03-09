Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B04D2AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiCIIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiCIIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:36:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC9334
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:35:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66606611EE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBBC340EE;
        Wed,  9 Mar 2022 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646814904;
        bh=Z/3PNKlRE7i5sp7wa3raGFkwvxZD/V+28HQbL/JKM/g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T8fdH4GiZ9p8CaGOaJv4baWxkR+k6YT7hbCOTFMBOY/M3SUCOuitGgLvznOk9bkQ3
         cXGBZn6mzzlM0i/50FO6Nu4i5d3qB47bAUioUD3Hf/rBQXaHkTddDXU1ZKb8Apk1Uq
         yoqgs2DH3kKMFOVk9LNShB1hR28aCkMknLCarIm0w7gtKWFqKdOCjeLQDvo4tOmKjQ
         reQWR1zhv1oOLZ36hx+7foapmRY2M6TVmELfeRl64SuE6Zhen/mbBvkN5YP4IAQSZz
         1Jr5wKGrhF0Q4g25gkVF7Ou6vnqOGns5zPDdJ5W/WDn3MkAU2bTnEEPT9psJV+JxeZ
         FRegoQbN53Z3A==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Regzbot \(on behalf of Thorsten Leemhuis\)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report  for mainline [2022-03-06]
References: <164659571791.547857.13375280613389065406@leemhuis.info>
Date:   Wed, 09 Mar 2022 10:34:57 +0200
In-Reply-To: <164659571791.547857.13375280613389065406@leemhuis.info>
        (Regzbot's message of "Sun, 6 Mar 2022 19:58:50 +0000")
Message-ID: <871qzby15a.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
writes:
> net: wireless: rtl8723bs (SDIO) - Access point mode causes a kernel panic
> -------------------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/d58625ad-6f3e-=
a7d7-b5b4-d18eb16f4082@leemhuis.info/
> https://lore.kernel.org/regressions/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@=
leemhuis.info/
>
> By Jos=C3=A9 =C3=81ngel Pastrana, 35 days ago; 3 activities, latest 2 day=
s ago.
> Introduced in 54659ca026e5 (v5.16-rc1)
>
> Fix incoming:
> * staging: rtl8723bs: Fix access-point mode deadlock
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dmaster&id=3D8f4347081be32e67b0873827e0138ab0fdaaf450

Just a small wish for the future, no need to change this report, but for
staging drivers it would be good use "staging:" instead of "wireless:"
in the title. This makes it easier for people to see that this is a
staging driver, not a normal wireless driver.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
