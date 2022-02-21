Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CB4BE022
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiBUJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:04:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347297AbiBUJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:01:13 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE627CD6;
        Mon, 21 Feb 2022 00:56:15 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 870DC580229;
        Mon, 21 Feb 2022 03:55:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Feb 2022 03:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=zcdXYKD7AIGXfsVFdjjk2+yAJ6zsZ8B0f4omWG
        U4udk=; b=LVxkjzRmQ4i/fCDy8Ek6wbLyQWNE22E401IzR2k13N3Ew037DuZLmi
        90/AdOlQQhkoKP0QzB4gbeJGr18LbcLmBzV8ka9qsNurIaBsjLYunuxvmyZG8Xi2
        hLcPwTKTqhs5iEj1cbAVJhKsmISL69uUAPmvZnzjLsfXCwUTHeJOaNyswUWg6WJ+
        miYx1ovsB7VqI0r55amRpSaRiZL0Ak7+bHM/EtrmlX+kUJi9Jkyj/DC+hxwrjDuV
        7myTB+f8OwKY8/BErNQMSfa2Kuc2iJ4o5mLqbiQHcliVzv64PfEWmE5hrnhfaH0m
        zs0da30wSrcgNKNjdJvOW/JA8pFGRJJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zcdXYKD7AIGXfsVFd
        jjk2+yAJ6zsZ8B0f4omWGU4udk=; b=Q26jmJCQeassQD8bDmdKizI0QTqNcla26
        Z/sXnrDLuGaL9HqS/i8YzFk2xmSMg5qT/kGsVZyoLqSTwsIyBqXyq8RkY1BwuSFt
        QliDhtgjgX+f//x2hHtBd0x9iJ/e9wbClQ53Vq8ySt2L5I5z1MsYD9spxcgoRscu
        QaDu5sly+LhYn7wj37qZFFT4P56NisZ7DFvxHeADJ2Yo3eCcecgr07VYmoM8WjSm
        ivXsSrxXOySf62FF2HZLDdgb+1ARoSIGDx5b2+B8HLOZurpInf8VZT3E4HoqDgSz
        I5T2YtcS/CmqQ8PBVPs8UiGfEjktjTOzHthV6fN+nwMwzPlzufzyw==
X-ME-Sender: <xms:iFMTYkhhyhwq3q1gNDcLdP3q8C2Gcn0xGoGTIFTl5cf-mLt7sYkBUw>
    <xme:iFMTYtA36Hu-MfKjDgBkfzvgPIo3849S-J6pti4CJExQLCHTJVSCWNEU_UEJ7qt-V
    q_DIkav7joDmQTtBy4>
X-ME-Received: <xmr:iFMTYsH7JC_CWS-AKr917Bjxwqh6SbbwsRdMCucyfFiuWAetY7p88YlWByv5qdFb009yJNgva4gF729RxR0r-7ZfzvNueqUeOdzPO1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:iFMTYlQDvgXohLsYkaWvn1BTfIex5vySL60NfMqFYxzkcJyz8UNl_Q>
    <xmx:iFMTYhynmE5168aSv0qT-xR_Dqtkvj78qdTou6E4xuMW1lj21zzrFg>
    <xmx:iFMTYj7r2HOg3-c1NHjZOOf6MpAPn-q2NINtiX1xYM_81dmCIx7vEA>
    <xmx:iFMTYmo4J-9O2AlAD-UW1T9vmr3i44wDDqBByzDzzOKwQaNNj9QSMg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:55:35 -0500 (EST)
Date:   Mon, 21 Feb 2022 09:55:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: switch to devm_drm_of_get_bridge
Message-ID: <20220221085534.qw2x6mge42uo4fl6@houat>
References: <20220221073339.10742-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcae224eyodkfp6e"
Content-Disposition: inline
In-Reply-To: <20220221073339.10742-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kcae224eyodkfp6e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 08:33:39AM +0100, Jos=E9 Exp=F3sito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
>=20
> Switch to the new function and reduce boilerplate.
>=20
> Signed-off-by: Jos=E9 Exp=F3sito <jose.exposito89@gmail.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--kcae224eyodkfp6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhNThgAKCRDj7w1vZxhR
xQ/3AQDoqp/3uuiqU47wvaKsMT4OkQ8oU6uBZBmILyZXiEmPlAD8C7QMIh6RfG/2
cMb7pXNT5FUCHu/NDIb0I9E7Cig+gw4=
=WH80
-----END PGP SIGNATURE-----

--kcae224eyodkfp6e--
