Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8450C693
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiDWCfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiDWCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:35:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F45E143;
        Fri, 22 Apr 2022 19:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71634CE2E45;
        Sat, 23 Apr 2022 02:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B47C385A0;
        Sat, 23 Apr 2022 02:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681141;
        bh=dKbDsWIxzId4sVO9IYKZLxmEb8V/7ZxzwKP19SLJrnI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pNpBlmxoKXPZEBLBxSit60KQFpktqZE2coflpGSYyzK+Jcyho/dpaQMi87l2WBYJZ
         lUIu5mubjFJLYW9108HX8SQ+tHPuclhcdqp7k/7fXpwUV5KSIwhE6Q1WXxphb4sCUc
         e8mzVYBwQgrMoe31tYsEJ4ysVA47Eh/1dY1EhcgClYRnodSlBCF0npBkMUIfDp+rl9
         ItLSGMHE246VSXlTqzuj/5etzGuAtkxueoLXean8CfDWKcEQ53SoTif0j3oKznyb+h
         aAxv/tCXmIYg6w6RuI7T93yLHVgF5eKP/lx/goEopRGHHpjWFXzwDNmrZpmIv80lBV
         vrSThePMtuk0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-2-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-2-steve@sk2.org>
Subject: Re: [PATCH v2 01/10] clk: cdce706: use simple i2c probe function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:32:18 -0700
User-Agent: alot/0.10
Message-Id: <20220423023221.75B47C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:22)
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
