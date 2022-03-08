Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1C4D183D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiCHMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCHMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:50:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7B27CDC;
        Tue,  8 Mar 2022 04:49:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B7BAB818B3;
        Tue,  8 Mar 2022 12:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0917C340EB;
        Tue,  8 Mar 2022 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646743747;
        bh=2uWXtW9QT2635460+Dinu7D098A/hUaWfqozGWkV7w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeO8tTIKHAtU2R13GSd/FvDMehJL18154CQO3JCqCvkQPQ8n+B0lvR3IxQZfSA0Lu
         1vjB9ymejx/bqO/0VJFtuKj01n/Cwapbs7aDf3gGJCVeHyrzgLP8HFt7/2YHbyeG0E
         4Ex8BOUGPcKuvUZsrre0k10LjzN2vZde+/5C98q3rUH8ckjNoXwKp7Xy0KTpRexAYB
         1RiMF7TKeFnJjyGZfCBiIfSuVpJmTalnoVOvCTKaQ6gAcue/mZHzLapOTDqswPlYjf
         lbu6mMYFvC2PQH+fKalcdrV61NatbFaQvawOwjFk1ZWoKwE8YzQ+7TearH3RjpLYlv
         F8792+X1779cg==
Date:   Tue, 8 Mar 2022 12:49:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [GIT PULL - FAO MARK BROWN]: Immutable branch for MediaTek
 MT6366 due for the v5.18 merge window
Message-ID: <YidQvkIYsacSPsXv@sirena.org.uk>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <YicTu6FwOR7zIC6I@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QE9JO7JgZCx+voQy"
Content-Disposition: inline
In-Reply-To: <YicTu6FwOR7zIC6I@google.com>
X-Cookie: Dental health is next to mental health.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QE9JO7JgZCx+voQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2022 at 08:28:43AM +0000, Lee Jones wrote:
> Mark,
>=20
> This one is just for you, so you can merge the other patches.

I don't know what the other patches you're referring to here are,
someone's going to need to resend them.

I'm also not sure things like like "FAO MARK BROWN" in the subject line
of the e-mail, I can already see if a message has been sent to me from
the To and it means less of the actual subject is wrapped out of sight
in my inbox.

--QE9JO7JgZCx+voQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmInUL0ACgkQJNaLcl1U
h9C/Qgf/WnaMYcqzKVQ8vePGa5v2ViuhDUssLXOHgpAuydZbERN+Gwrs4SHm1O9w
xgvNZuX7aZ1BAOn0IsMmhyNdj+18fvA3kvuX33MQcwi4gpg/WyQU5n0Ff4YmgaFu
MZe4Lqt0ZVAxsWccgFXjkBvrObZQwK+GB28brmPBgnteeJj/ZnAY6w7C53pTBJwm
SpxCdc20Nz5QP/Mfvfqos766weCM3ptP8dxGJzn5Cinb2Wi+ZXchoB6PU32L+lzX
FYOxFT8z3NaKPsqhFfIS9nvo+zwzhI0GJ3Cb5Oy2Cu4S5t3kcfb/3qplEJPk6hvT
YOHPeANMYG38LxYZf84nAJqKHEXoDQ==
=IkM/
-----END PGP SIGNATURE-----

--QE9JO7JgZCx+voQy--
