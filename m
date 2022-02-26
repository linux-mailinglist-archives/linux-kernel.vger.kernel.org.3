Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254C4C52D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiBZBBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiBZBBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65100202883;
        Fri, 25 Feb 2022 17:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 098AF61DD7;
        Sat, 26 Feb 2022 01:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60105C340E7;
        Sat, 26 Feb 2022 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837250;
        bh=SGWD/tIhAqUKVlJFsgJrMB7QpRlw7YvZ5rxL4jSiIOw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rrr8farzmJ/vj4hDYFwpxTO0yt7KyLD7u5tf+gr/xjWWnCK5tOidVcLtYeKPyqiQ1
         yZIQ8/YwWf9JBZBY6gwagjj022vZRIhNvltAdeUwswgxRDshCrQLDQOerWiwBsq6G/
         83u6BzmaBRTPLVQ/4OcM9GEjA5WsQwPmrskKvyTFnfDumHkNMnaguIMnExjHL7LjMG
         MlLeOSAiUvliAYK+tgbITnmMp0HFfbBx/HMnsRfqIP/VtJx1V/iKhJzS+xlJVjmp0D
         KPqOcpmpEtCY/KD/YlZpxLl5K5rtomUS1Qry52I6BwAgcDOrniqE1YpVqMc3G/l+nU
         fz7v8WIi4ACXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-2-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-2-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 1/7] clk: nxp: Remove unused variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Joachim Eastwood <manabian@gmail.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:00:48 -0800
User-Agent: alot/0.10
Message-Id: <20220226010050.60105C340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:07)
> GCC warns:
>=20
> > ../drivers/clk/nxp/clk-lpc18xx-cgu.c: In function =E2=80=98lpc18xx_pll1=
_recalc_rate=E2=80=99:
> > ../drivers/clk/nxp/clk-lpc18xx-cgu.c:460:13: warning: variable =E2=80=
=98stat=E2=80=99 set but not used [-Wunused-but-set-variable]
> >   460 |         u32 stat, ctrl;
> >       |             ^~~~
>=20
> Get rid of the (apparently) useless read from the PLL1_STAT register and
> the declaration of stat.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b04e0b8fd5443 ("clk: add lpc18xx cgu clk driver")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
