Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C818551516
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbiFTKCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiFTKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140F13E91
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA4F60B3E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF518C3411C;
        Mon, 20 Jun 2022 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655719352;
        bh=RPWrMmTQ9win/WHzXLKou6ZiLn6V6pMKnD6XkzZiK3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p4M02fgSJZiMjguc9W23jPi9utH2R6nytVOtyvj0yih7hCHQX9yeP2wXUFzklMvZw
         PIPtcHOcVSmVtHtgl22+PZZZv2pu1uzsK44AqxCvjCekWb4lcJ+e/Isk/6bHotdYrd
         XuhGs1SVO0j8YjImD14SlQ9m93oZ8eiLs/eHFX4zZjVPD55GgsBKc85YLgOlyZOw9A
         hzbaen7ghnglOxDY5QmvdlOpMofpw6OepIXEyIV45fM+Lay/xY315yYLLEd47xEjcA
         hWRLaN6UlpGieqhS8Vz65K3q7jL6OIO8sX+pN256atmCpPrZK3l9nTv3HP8BAfHPpT
         Nol9KSGvfJvZQ==
Date:   Mon, 20 Jun 2022 12:02:22 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
Message-ID: <20220620120222.38250035@thinkpad>
In-Reply-To: <87o7yowaih.fsf@jogness.linutronix.de>
References: <20220619204949.50d9154d@thinkpad>
        <87r13kwawb.fsf@jogness.linutronix.de>
        <87o7yowaih.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 00:37:34 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> On 2022-06-20, John Ogness <john.ogness@linutronix.de> wrote:
> > On 2022-06-19, Marek Beh=C3=BAn <kabel@kernel.org> wrote: =20
> >> the series
> >> https://lore.kernel.org/linux-kernel/YouKQw72H7y9EJQK@alley/
> >> merged by commit 537e62c865dc ("Merge tag 'printk-for-5.19' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")
> >>
> >> and in particular the commit 09c5ba0aa2fc ("printk: add kthread console
> >> printers")
> >>
> >> causes a regression on arm64 (Marvell CN9130-CRB board) where the
> >> system boot freezes in most cases (and is unusable until restarted by
> >> watchdog), or, in some cases boots, but the console output gets mangled
> >> for a while (the serial console spits garbage characters). =20
>=20
> Also, have you tried 5.19-rc3? There were several fixes that came in
> after rc2.
>=20
> John Ogness

rc3 still has the issue.

Marek
