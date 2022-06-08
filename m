Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8A543EAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiFHVfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiFHVfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:35:14 -0400
X-Greylist: delayed 95219 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 14:35:12 PDT
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982131536
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:35:11 -0700 (PDT)
Received: from player774.ha.ovh.net (unknown [10.109.156.41])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 6BEB722E15
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:35:09 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id D931D2B4416F2;
        Wed,  8 Jun 2022 21:35:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R0017e798ef0-2c53-4b9f-83c6-efc9b453c964,
                    6E401FA8E05BA175062CDB0CD5257D625965C0B7) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Wed, 8 Jun 2022 23:34:55 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: shmobile: Use backlight helper
Message-ID: <20220608233455.4d56238e@heffalump.sk2.org>
In-Reply-To: <YqBK+GXrIx3XX+Km@pendragon.ideasonboard.com>
References: <20220607183132.1123648-1-steve@sk2.org>
        <20220607230537.70020736@heffalump.sk2.org>
        <YqBK+GXrIx3XX+Km@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZTYoB4+bVoN.2Tdkltb547L";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 1588926244128982662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeiheevvdeugeejffefteffvefhieegjeevhfekjeejvdelgfefkeehhfdufffhjeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejie
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZTYoB4+bVoN.2Tdkltb547L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Wed, 8 Jun 2022 10:08:40 +0300, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Jun 07, 2022 at 11:05:37PM +0200, Stephen Kitt wrote:
> > On Tue,  7 Jun 2022 20:31:32 +0200, Stephen Kitt <steve@sk2.org> wrote:=
 =20
> > > backlight_properties.fb_blank is deprecated. The states it represents
> > > are handled by other properties; but instead of accessing those
> > > properties directly, drivers should use the helpers provided by
> > > backlight.h. =20
> >=20
> > Apologies for the misleading boilerplate, this patch came about as a
> > result of cleaning up fb_blank usage but doesn't involve fb_blank itsel=
f.
> > =20
>=20
> No worries. Would you like to submit a v2 with a better commit message ?
> The patch otherwise looks good to me.

Yes, I=E2=80=99ll do that.

Thanks,

Stephen

--Sig_/ZTYoB4+bVoN.2Tdkltb547L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmKhFf8ACgkQgNMC9Yht
g5yKtA/8C77pFUKpTqjkzhnutberm1ngr0EtTd2Dh6hPQLP05xe3TvBvIKVohTL7
/j+eIxzg0LaRt4ZDzozjt422t6RMbS86mxzfsOamj0rYtdXQCxz845w/T6JR65e/
o78pSyfBctnHfruQ/LYSTSbTzV91on4mTdqOLgt0cjPoZg9mz+JbAJ9If94TGg7A
3M++bsOVuyTs1/PNqBYTLecMZRE51bWY9NMQyXQ0K8LWUHGyqJ34Xfzo0qs1aX+c
1vBP44e4TsVud4Yn0mkjAyVrpgpcVrM+fvBNp9/PIlfqZB5sy2ofiz5bBOb2lhOB
KWKKqbC7IkowCEXcr4p7qRSpbY3RvDW8KHlE/+dOf6YzpFz5GAbWYXeWX8HsCij/
op4p0eK2EgT95NrkRVfvpcrgPOtJLvPF+/dzkca+aLCSKrk/jcB8uVsnqodfET2Z
WyJkzS232Pqy5rSbu2muNLoQYZAirCf8uRQCOrjVO4q5BAW+ykGrbdYCLJKeAlAZ
DQywOTGII5dPGaD6+JvwFR1cq+1tz76/7KtexI+7x4FvuRHZ7egKRpk6Avui2w10
+uLvkBVdnYMu6p8yvgGqpKCJu6Q+qdPkT8QmNZNVnBoBS7K6BCEmy9KQN5l+zFTg
fqWoOkPTZdbg6ktvatyFCEAbTz8tZTxCo4c3puVmAoAWjdiFxok=
=+z4T
-----END PGP SIGNATURE-----

--Sig_/ZTYoB4+bVoN.2Tdkltb547L--
