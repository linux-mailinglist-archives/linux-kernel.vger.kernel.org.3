Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7426A4E6B91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357046AbiCYAnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348270AbiCYAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2662BA30B;
        Thu, 24 Mar 2022 17:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6AA617E3;
        Fri, 25 Mar 2022 00:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80FDC340EC;
        Fri, 25 Mar 2022 00:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648168885;
        bh=FbOzwJQ3VItTPiRwVL0i6iYEw4wn48XltfsXSq3Gp0I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=heQg+oDa7Y6hrV9cfifoxjjs109z+q36R8eT3+BFw4M0zUjooFDcroS4+WlBhFu8P
         GeyTbIPNwH8DN4D5L87WCjB6fsExxxYylolVtUVdqMnWNZLSXMI0bt77o83lwoDqsf
         U1V//fakJzWSm9GAFDn51NoPEQr2Xd/B88ALmkyf10pi8RjLf/6XnUHqOXwnRd6dx/
         Hbgm258ar/AEJ/RMB7grT+bdeR48/HT9+1RBcl9MaqOquU/xj0rDw4URq56v8wncNP
         Pk4HrDByhLh2ixpsORYTVluAGEBpP2gInzE4wN2G4QWvXSfZO8sZ6SsS+OisfXWtjV
         tR3pLBOcq+IAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321200739.3572792-18-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com> <20220321200739.3572792-18-clabbe@baylibre.com>
Subject: Re: [PATCH v3 17/26] clk: rk3399: use proper crypto0 name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 24 Mar 2022 17:41:23 -0700
User-Agent: alot/0.10
Message-Id: <20220325004125.C80FDC340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Corentin Labbe (2022-03-21 13:07:30)
> rk3399 has 2 crypto instance, reset for crypto1 is correctly named, but
> crypto0 not.
> Add a 0 to be consistent.

This is OK because nothing is using the define today?

>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  include/dt-bindings/clock/rk3399-cru.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings=
/clock/rk3399-cru.h
> index 44e0a319f077..39169d94a44e 100644
> --- a/include/dt-bindings/clock/rk3399-cru.h
> +++ b/include/dt-bindings/clock/rk3399-cru.h
> @@ -547,8 +547,8 @@
>  #define SRST_H_PERILP0                 171
>  #define SRST_H_PERILP0_NOC             172
>  #define SRST_ROM                       173
> -#define SRST_CRYPTO_S                  174
> -#define SRST_CRYPTO_M                  175
> +#define SRST_CRYPTO0_S                 174
> +#define SRST_CRYPTO0_M                 175
> =20
>  /* cru_softrst_con11 */
>  #define SRST_P_DCF                     176
> @@ -556,7 +556,7 @@
>  #define SRST_CM0S                      178
>  #define SRST_CM0S_DBG                  179
>  #define SRST_CM0S_PO                   180
> -#define SRST_CRYPTO                    181
> +#define SRST_CRYPTO0                   181

$ git grep SRST_CRYPTO
Documentation/devicetree/bindings/crypto/rockchip-crypto.txt:           res=
ets =3D <&cru SRST_CRYPTO>;
arch/arm/boot/dts/rk3288.dtsi:          resets =3D <&cru SRST_CRYPTO>;

Uh oh. Just don't change it and think about something else when it
starts to feel inconsistent.
