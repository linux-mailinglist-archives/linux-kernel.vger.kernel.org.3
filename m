Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF052C8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiESAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiESAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3DE24F37;
        Wed, 18 May 2022 17:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B70D617A9;
        Thu, 19 May 2022 00:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEFAC385A9;
        Thu, 19 May 2022 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920280;
        bh=3Cy63P/EAdXmjShIGXtNXxNCVW7B/ld963oEc5JgL9U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ThGa6TJ43IXsE06ntiNexs1XPEru39ZR9yRzZKyss8PDt9zx/p4fxHVMQY1ig0Csn
         xJ/oWm1xW9X8jg+9JFtKiPeoybs0vyCfAGaagw+Vtl11ofhRzRQe4oKXk4iIjUkzJc
         Me8t6Jzqvl79uzglQ+ODEPIwITj7+l+oan110Xkdn2d+bLxolZGARs04+TzUZ1/huT
         6lKDp8GAJdpiUNxLM0toRiW08UyADL55V722Dhm+LJd0LYGUUJo36QeN6ewCjTnLXG
         RQe75s9/mP5ljd2MzkoZI+iBqUnmqWK3YwWZB/X+qbU2JlrNAzTb+4lQK1s0mgx4tm
         Sjt1gdGojx5pA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220412122750.279058-3-aidanmacdonald.0x0@gmail.com>
References: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com> <20220412122750.279058-3-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v5 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dan.carpenter@oracle.com
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, krzk+dt@kernel.org,
        mturquette@baylibre.com, paul@crapouillou.net, robh+dt@kernel.org,
        tsbogend@alpha.franken.de
Date:   Wed, 18 May 2022 17:31:17 -0700
User-Agent: alot/0.10
Message-Id: <20220519003119.DFEFAC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-04-12 05:27:50)
> The TCU clock gate on X1000 wasn't requested by the driver and could
> be gated automatically later on in boot, which prevents timers from
> running and breaks PWM.
>=20
> Add a workaround to support old device trees that don't specify the
> "tcu" clock gate. In this case the kernel will print a warning and
> attempt to continue without the clock, which is wrong, but it could
> work if "clk_ignore_unused" is in the kernel arguments.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Applied to clk-next
