Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6364E7959
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377026AbiCYQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiCYQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3212E5400;
        Fri, 25 Mar 2022 09:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77C43618CA;
        Fri, 25 Mar 2022 16:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A6DC2BBE4;
        Fri, 25 Mar 2022 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648227160;
        bh=Ra8ieuBzaiUMPlsrjMnh2eiTTbFJ7RF3zaiOYqpcWRY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Yc5KjUsXj0C3ePGmhyRuZJgrCSRp4+HyI1a7yErLlR/GcQnY5tNLV1BmC+enHzLg7
         VkPDqNzov93jRYdDqfRphGZaqNe/6MrJKtu0chA542UYeMVcO+026KPHUvImpJHRy2
         SSD8o8rU0W/9ZVKZ5jWypI28tPMm5CFeJHLQj6GiDSEMXIwcm1fA5Ibf42imrE9nnZ
         uC1wRNKl95f+lsEt7efD2foDSsaT82ItZjSJdVJt0btni/gsKvvntazhgnpTDA3D9d
         ljIaXMIYw1l6gpYSSETL24GOW5zcqJ+uT5dWsIDJpz4+X5/ekL/ToquYczoXPsnd+s
         CQYhh6dO5mFPA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yj1x5hJEKVL71JZ1@Red>
References: <20220321200739.3572792-1-clabbe@baylibre.com> <20220321200739.3572792-18-clabbe@baylibre.com> <20220325004125.C80FDC340EC@smtp.kernel.org> <Yj1x5hJEKVL71JZ1@Red>
Subject: Re: [PATCH v3 17/26] clk: rk3399: use proper crypto0 name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
To:     LABBE Corentin <clabbe@baylibre.com>
Date:   Fri, 25 Mar 2022 09:52:38 -0700
User-Agent: alot/0.10
Message-Id: <20220325165240.C9A6DC2BBE4@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting LABBE Corentin (2022-03-25 00:40:22)
> Le Thu, Mar 24, 2022 at 05:41:23PM -0700, Stephen Boyd a =C3=A9crit :
> > Quoting Corentin Labbe (2022-03-21 13:07:30)
> >=20
> > $ git grep SRST_CRYPTO
> > Documentation/devicetree/bindings/crypto/rockchip-crypto.txt:          =
 resets =3D <&cru SRST_CRYPTO>;
> > arch/arm/boot/dts/rk3288.dtsi:          resets =3D <&cru SRST_CRYPTO>;
> >=20
> > Uh oh. Just don't change it and think about something else when it
> > starts to feel inconsistent.
>=20
> This is on rk3288, so not related to rk3399.
> Even on the RK3399 TRM, all crypto clocks are called either crypto0 or cr=
ypto1 (neither just crypto)
>=20

Ok. Please add a note in the commit text why it's OK to change the
define names.
