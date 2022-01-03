Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6B4838EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiACWyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiACWyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:54:13 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D55C061761;
        Mon,  3 Jan 2022 14:54:13 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D586380;
        Mon,  3 Jan 2022 22:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1D586380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641250453; bh=57DOnsHkp6F6pWieveQyXYk5iIi/v1runbJrZXw/4VE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e4bDG513Mc5SgGECKgT06qN3LSneMzpP20W2iREzPLWjTRr0+AYXPxgZilaF0oLIW
         l4+rbZLHYqgGm6WMHm85TtNFFYp6vGcCoN735enOt4HZChJih9J+vUVsoZj5Hj6kq3
         i1hrTBi1MRseGqfqGvhLjEV5sAs0ppbtUH1CKoGLI7W+TCTgnnTwpHSp6sXbcllVoc
         SF9LCN2Mmqdx+AHRGbfxG7wo7dqPX4/DYT+KOz3YgUEGvyQC+gzBcDWaE5wGZJlioZ
         EZm/qcRdY6Yn2lzVL4HVx72S4VRjgxsHrUnBCLCrL0ONGBc7GyBbJzNSIHPf01/hEV
         eVNOiKG+1GNGw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] Documentation: kgdb: properly capitalize the
 MAGIC_SYSRQ config
In-Reply-To: <20211230172423.30430-1-lukas.bulwahn@gmail.com>
References: <20211230172423.30430-1-lukas.bulwahn@gmail.com>
Date:   Mon, 03 Jan 2022 15:54:15 -0700
Message-ID: <87a6gcxwfc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Most readers are probably going to figure out that the config is actually
> all upper-case letters, as all Kconfig symbols are this way.
>
> Properly capitalizing makes the script ./scripts/checkkconfigsymbols.py
> happy, which otherwise would report this as a reference to a non-existing
> Kconfig symbol.
>
> So, use the right capitalization for the MAGIC_SYSRQ config in the kgdb
> documentation.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/dev-tools/kgdb.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
