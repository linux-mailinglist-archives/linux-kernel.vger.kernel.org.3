Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56EA59EF79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiHWWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiHWWv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383518C02A;
        Tue, 23 Aug 2022 15:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AEAA61716;
        Tue, 23 Aug 2022 22:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACFAC433C1;
        Tue, 23 Aug 2022 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661295114;
        bh=ZOSW9NIvvlhXKcI3RjGLmofSDC5frDvrDUVXeKYtQlA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dEB2C5FI54ahu1gQFvFPrKI7ZiImZqjdT+FvnRcIAr1G44YynwTcBM5KQlVONqur/
         vHxBX9jrqITO87RBmRARCwjhjrWxkd5NQlKsf6ZHEVn4GTfJBhTf7Jti2Hgmczt/gd
         /WNiFUn6oM6IagIDnVpMF9ha1IS6Y5X4O/ufCnrgTKaJRWRo8+oZN0Jmq+vzmT2swE
         WZpYiK+FaOYr3vtnZFdKwK/NInlRyCHj6hFtH3KODeqjNQv+dtvhJniZC2+QSGCt7d
         y1p9YDVXiMWUWyU89GmESnNmW5K0ijTQ8Byrq6pus/R/t29gTbFEW2gLsuVySzqySz
         PDBchDhwaDF2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220713154953.3336-3-stefan.wahren@i2se.com>
References: <20220713154953.3336-1-stefan.wahren@i2se.com> <20220713154953.3336-3-stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/3] clk: bcm: rpi: Add missing newline
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Tue, 23 Aug 2022 15:51:52 -0700
User-Agent: alot/0.10
Message-Id: <20220823225153.EACFAC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2022-07-13 08:49:52)
> Some log messages lacks the final newline. So add them.
>=20
> Fixes: 93d2725affd6 ("clk: bcm: rpi: Discover the firmware clocks")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to clk-fixes
