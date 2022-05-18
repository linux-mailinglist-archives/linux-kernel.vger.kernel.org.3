Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1476252C493
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbiERUeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbiERUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD5EBAB1;
        Wed, 18 May 2022 13:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0BDB619F6;
        Wed, 18 May 2022 20:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33791C385A9;
        Wed, 18 May 2022 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652906058;
        bh=sjaCDr9zvFHDaefm+MkdBE5eRInSqjlcvYK08lou6tU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ve/WyoSi5GLme3oUyX3aG/07ESBBrOzBNTFCO6ydxn/Za0DwmdLhwQ+T1I5sV6snR
         ywKhGYGE+yxkqw0hOOVCPzPpMOfOgoSKgjLC7ydf90Y4zox7MAAbpT1nu7soOMOWlC
         zw8Lxie3uFZzPCXusbnNi9PlD2moYln0gwOaCvS/iXc0vGlRW/waKtbUx8o6shZMvq
         FQ/Ly62iFWzzD5QKTE4WdP3qey4oLfVHngkpyGnPc7KN47h8NRyO5EqwDCdoX2oXpr
         JpEUpomqfHuDxlThk8w/DKm/+FyhD/1eXz9yYlFLd42fEPZSajBQBBMHAGWwbe3rSO
         MpwQmutapXuOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220518062537.17933-1-hbh25y@gmail.com>
References: <20220518062537.17933-1-hbh25y@gmail.com>
Subject: Re: [PATCH] clk: ux500: fix a possible off-by-one in u8500_prcc_reset_base()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
To:     Hangyu Hua <hbh25y@gmail.com>, linus.walleij@linaro.org,
        mturquette@baylibre.com, ulf.hansson@linaro.org
Date:   Wed, 18 May 2022 13:34:16 -0700
User-Agent: alot/0.10
Message-Id: <20220518203418.33791C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hangyu Hua (2022-05-17 23:25:37)
> Off-by-one will happen when index =3D=3D ARRAY_SIZE(ur->base).
>=20
> Fixes: b14cbdfd467d ("clk: ux500: Add driver for the reset portions of PR=
CC")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---

Applied to clk-next
