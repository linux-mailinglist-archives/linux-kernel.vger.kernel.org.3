Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8889B5867FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiHALPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHALPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:15:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF622C645;
        Mon,  1 Aug 2022 04:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6E9B81020;
        Mon,  1 Aug 2022 11:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA93C433C1;
        Mon,  1 Aug 2022 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659352498;
        bh=KXxJvr1Gh3/rx3eZQfM+nY8zLaeraeH2urw35Feo3aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAmIhSAmT/Yj+g0jRrHQ0AYi3z0MwZKJFBZ16W8tayDl0DDBQ4i3Eli2jMg3muJ9W
         kOPYyaYnZKUEYmjTwB3da0HIgyPXtmgbguC/A15r2+Vi+Zkl9eIOfnv3C79ilkDUwT
         nZsLwr26jELYuJAPogoOykKQ2SHxomoYxc6QoVtKYMkm3y4w/Ls4rd09AHHkDMWIrj
         VKa5X7AuTMQBhe2vmhRarM6NOt6iJoYmGu7ZvM17b/EYyfosE4GHKDjvG8ZQAfyWiJ
         lrd01BE/IKWN0YmOs3ioUnIYPw5wR6vyINaoU0nyV11Pdouba61ZifETRzEUfRfSiX
         hDEtFyqSAMR1w==
Date:   Mon, 1 Aug 2022 12:14:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, eddie.huang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        fshao@chromium.org, sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        zhiyong tao <zhiyong.tao@mediatk.com>
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
Message-ID: <Yue1pzPM2rSsL+oy@sirena.org.uk>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com>
 <YuJt9SF9Y2UsA4Jc@sirena.org.uk>
 <9a99a1e95179f3b55dd1236c41a8cd3d9b2ccf18.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4izAq3eOnqAvkCD4"
Content-Disposition: inline
In-Reply-To: <9a99a1e95179f3b55dd1236c41a8cd3d9b2ccf18.camel@mediatek.com>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4izAq3eOnqAvkCD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 11:23:03AM +0800, zhiyong.tao wrote:
> On Thu, 2022-07-28 at 12:07 +0100, Mark Brown wrote:
> > On Thu, Jul 28, 2022 at 02:27:49PM +0800, Zhiyong Tao wrote:

> > > +        properties:
> > > +          regulator-name:
> > > +            pattern:
> > > "^v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$"

> > regulator-name should be free form text for the system integrator to
> > describe the use of the supply on their board, no constraints should
> > be
> > placed on it by the regulator.

> we put regulator-name here, we describe it by mt6366 datasheet.
> we think that it is the common attribute.
> So we place it here.

No, for the reasons above.

--4izAq3eOnqAvkCD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLntaYACgkQJNaLcl1U
h9BMFwf/V6k/8nOfes43hLPGdpN6ZINY6B1Cwbn9fJblGgECALOg9OuoApuLUqQO
BHsYJ76aJ419c3VAopk2SDcGphOodZ6KwarX5304tqyy1titOAJY/zhWfMHtkz0D
Gsveg+yW7ju+8uGCC80LNUDvO4eaON599LzQQ4LE0aJe7vgWbCDOh1yyeTuTLeRw
0xS0R3vft3l6/9z1v3rhGKjZ32Uu2gmMKQW7eZCdanC43xE48pAzUTU4ITt7Tq42
8Jt9TUj0hc7qGxcCHG20JuJrWzLoBsi6eVzRiuxXAP8gzfmXe5sKT6mwmEBSD2Iv
uskW1mCgcC49078z385GQX3iXWGiZg==
=4Xta
-----END PGP SIGNATURE-----

--4izAq3eOnqAvkCD4--
