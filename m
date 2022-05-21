Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2749B52F8B5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiEUEce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiEUEca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88898185433;
        Fri, 20 May 2022 21:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2370D60B45;
        Sat, 21 May 2022 04:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFCBC385A5;
        Sat, 21 May 2022 04:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653107548;
        bh=MtA3HwgnwMddgCHNhZRtjdWToZWuCgimnJZfeEUrTv0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YDUfUoL6QncNRpPeKgWoKvgykXAYvpkoUHalIlWo3bBVKYG7fMG6cD0JRPngXgDa7
         uk4UYOU/4laB3Ta09ZW3hEPzLpfNSVMU8FiFndXWqdQtZCauhNcuJVyyrXNWeD4aSB
         lmig8M9z/kdr2c6XXLf38MveBBLHmZKPyua3B/lOQbFew9KElwZV23tMc4BJHy0+2c
         mlWoRkPtLWDpMVEctwevi9BRDajJh7QONVOI27c7yJ1EfjM+W1vzMIYWpl79hf0EWT
         llheKAkpKtRre+W0SGu98aNS/P5DtlRmEfBq61nVDZH/asYsclULkP7vCzP24Qg/yJ
         710Ee0TaVlMIw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49d726d11964ca0e3757bdb5659e3b3eaa1572b5.1653081643.git.christophe.jaillet@wanadoo.fr>
References: <49d726d11964ca0e3757bdb5659e3b3eaa1572b5.1653081643.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: bcm: rpi: Use correct order for the parameters of devm_kcalloc()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Date:   Fri, 20 May 2022 21:32:26 -0700
User-Agent: alot/0.10
Message-Id: <20220521043228.7AFCBC385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2022-05-20 14:20:58)
> We should have 'n', then 'size', not the opposite.
> This is harmless because the 2 values are just multiplied, but having
> the correct order silence a (unpublished yet) smatch warning.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
