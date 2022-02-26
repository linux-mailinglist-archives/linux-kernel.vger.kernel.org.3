Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54A4C52D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiBZBCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbiBZBCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:02:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97D2023B9;
        Fri, 25 Feb 2022 17:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C91B833BE;
        Sat, 26 Feb 2022 01:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA0AC340E7;
        Sat, 26 Feb 2022 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837291;
        bh=ZFtrWiACO7Q2eVeQIQG2iRVtDxlI3xsY/s1kOhmuQS4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XpKAEdeDhjf6LI2p+64Fo5xQ0+GEvQ5kXtnSpzSAAh6ScLHhqKulyOVq+yvc9O5lv
         sBXlc/babAIzML5RX3UHR3+FS+sqz8ReLHsLLJscydDt+y+ngTbiXQ8DoETsMAzEln
         vm6p4ZUfQqpgp3RVLVwpjuc45HxTH4iJtRf20BMovKIPIvWmojU4Rf+dduSeJq+Wvz
         MzRfZRmZeJm35ns7EskntO8HRR3oWFgJHiRfMii1QRXMiVrTQ5ifYDsYAuFI4gvXXl
         j2E3zU4yhVafgbPyWWrULrkkiP5O6n6WZxk9ks13V/fI/QykpY6PawWfCDp8YB1p1a
         c+8HXSCKINReQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-4-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-4-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 3/7] clk: mux: Declare u32 *table parameter as const
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:01:29 -0800
User-Agent: alot/0.10
Message-Id: <20220226010131.2EA0AC340E7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:09)
> The elements of the table are never modified in clk-mux.c. To make this
> clear to clock drivers, declare the parameter as const u32 *table.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
