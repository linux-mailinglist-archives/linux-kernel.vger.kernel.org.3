Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B164C52DC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiBZBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBZBCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:02:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97992036E7;
        Fri, 25 Feb 2022 17:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7338B61DD1;
        Sat, 26 Feb 2022 01:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81BBC340E7;
        Sat, 26 Feb 2022 01:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837311;
        bh=WRePfeg+k09Vwf2OrmDJEXYSZQOAa+sTvVJzgksaxvo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fY2+3Si9WKHKnsuA+zANleSFJocCU6hokHycbg44GgSh8oUa5IjS51kHOsfen/Vso
         qDXBW3QiFnMpWZ5DQahfDWIjvoDm3YfCP7m0TO419/FtkJDeaf5wxl0Nzrm3nobi4o
         ywAdYC9Dg57ccFSJqnzIXgq2hXHC38nb5HEbMTAaIPx4fqhZz/slSTqlFTgq6hw7iD
         pD0PL8EvLfYjaWt+vzm4yzDWrA1HDAPa++zIfllLjTYIKHItRKfiPg42ABaf5Lqhl1
         Tdkx8xE5sHmSM8q0lFkqkALruCK3UFV/iRLgyO7U8qCZDykXrfrXMD/cn+TVka0Z5N
         E9CFLz8e0a5bQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-6-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-6-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 5/7] clk: mmp: Declare mux tables as const u32[]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:01:50 -0800
User-Agent: alot/0.10
Message-Id: <20220226010151.C81BBC340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:11)
> Now that clk_register_mux_table takes a const u32 *, we can declare the
> mux tables as const u32[].
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
