Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E550C64C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiDWCEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiDWCEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:04:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4359BB9;
        Fri, 22 Apr 2022 19:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B0CAB8216B;
        Sat, 23 Apr 2022 02:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E902C385A0;
        Sat, 23 Apr 2022 02:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650679285;
        bh=mrOPhWLuAIUxSoj+v6MDLwHfuvPmqtwovzfv/A80gNE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JShmaSoog00ktcZWVyCeeeRXc4TOBoCUdltifsplVJo0hlLCA9mIiOeLvgLg832DC
         +bUn00nVuYccRZtaHS7g0lbrbFaM3ca8W3ic/i+r9IkOWUd6Q0YQvyriLMH4s0ACZQ
         JUHh16tpm/IxsVt+35u4o4NYWRRQq5ZfYnzAipBuVo/DzdBOcEIkD3BiqdvFNiKqsP
         79vQ5hISAzH6sF3k5cWm0wUDJaQeK8Q5BgtoYO1PyLQo+KnSF26e+MVxsZNUoU0kqe
         P4dGGqxD92++BGd6yoQI5vI0LAtEx/Mvh8CZqRmxSM9Jhcka8m5Wh0SfcVohJPwOAT
         Hg/JFcgj9eDWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220418141537.83994-1-colin.i.king@gmail.com>
References: <20220418141537.83994-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: actions: remove redundant assignment after a mask operation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Fri, 22 Apr 2022 19:01:23 -0700
User-Agent: alot/0.10
Message-Id: <20220423020125.3E902C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2022-04-18 07:15:37)
> The assignment operation after a & mask operation is redundant,
> the &=3D operator can be replaced with just the & operator.
>=20
> Cleans up a clang-scan warning:
> drivers/clk/actions/owl-pll.c:28:9: warning: Although the value
> stored to 'mul' is used in the enclosing expression, the value is
> never actually read from 'mul' [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
