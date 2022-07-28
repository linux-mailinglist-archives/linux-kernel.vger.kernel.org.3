Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E9583CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiG1LHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiG1LHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:07:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C96E1DA79;
        Thu, 28 Jul 2022 04:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E80CDB8240D;
        Thu, 28 Jul 2022 11:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F4EC433D6;
        Thu, 28 Jul 2022 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659006464;
        bh=7kmhiHLDWigtfnWVIEbBCX52nEfmZ+N0EJ/w9X+KN3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyHIRa/lkbHLxiXssB4CsJPYHd2bdzf66hoX5m4HXVQLatBWc5w76l3WVXEZM3lzY
         ZId8DWigVHSD04dvOILF7n/QNbIlqTIfFWBrkpqbTnCNT7cQeaaD1yj/IwZ7olDH5v
         Y/RZ7jjrWtSvHcJVXh1DfdimRZOK/N2MWioYMwz/nelsp2VQWAY6oEnPAYsoxKjReH
         wpR78qJ+35V3K3JZLynxqrVeqW3CX2fAjOj+2JpblFwXZRRBT0y7KjeXRdLppJSk47
         tFhoDOkVCJE6sU8kZzcBA+rN+/dtq4eOrJIVjqcu5sVoCTZ3SSli21WrZ8iuiAOSb7
         eIPbMeAOUO6Tw==
Date:   Thu, 28 Jul 2022 12:07:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
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
Message-ID: <YuJt9SF9Y2UsA4Jc@sirena.org.uk>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K08Z7tP9qKND+pgF"
Content-Disposition: inline
In-Reply-To: <20220728062749.18701-2-zhiyong.tao@mediatek.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K08Z7tP9qKND+pgF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2022 at 02:27:49PM +0800, Zhiyong Tao wrote:

> +        properties:
> +          regulator-name:
> +            pattern: "^v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$"

regulator-name should be free form text for the system integrator to
describe the use of the supply on their board, no constraints should be
placed on it by the regulator.

--K08Z7tP9qKND+pgF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLibfQACgkQJNaLcl1U
h9AnIQf/Q5AoIqoBgnEB5s1BZS67mELeo51xpoptOVEWQfXqiDJa8lTnJzrku0d6
1fZLhpWjRSfFM9Ht51vxNhdAcS618Ffw6GMn6vI9uzS4ON/GU8lL76Gu8cyYlMrB
bn3SoS/1HJso0DCsm1onC1SXSlbc8mkLfvqDshGQuS9eePkHL8VvyVbbbT9Tg6YD
rWuz9+TeXR2kaom4m9CzK2MxCSAZbMPHH0tDrIJJ/v5DkedEUXb2H2UI5gYpT2QR
wCUSIfmhlfA7uM/jsI7JkPWN4JmQRGXlWdOGUJQp9ooYyZGIk5a17N5ZBrPLpRr1
9I5pZAYTM+1NDLmkBs0w6mecARZ4Xw==
=VTMf
-----END PGP SIGNATURE-----

--K08Z7tP9qKND+pgF--
