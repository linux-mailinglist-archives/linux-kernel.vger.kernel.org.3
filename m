Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829E455C62F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiF1IVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiF1ITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322B02D1DD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:18:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BE65C5C0037;
        Tue, 28 Jun 2022 04:18:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 28 Jun 2022 04:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1656404306; x=1656490706; bh=712w3OsDSb
        bRAN97CqHhUG+Ti8AcxPbFv91wwZ84Q0Y=; b=HDXwLR9YnH7U9IJmVsdjuuiWNY
        tL7x8qAdIp6MxWg6Zx/2eEvl0u1dWxkAxvYImP86jihAfSgNATtpux68qBTFMeGP
        IrDtl0A7t3HwNfu74jA1rgnswIadrOvDe8MhTBe7pYRpQvTqLbb9vzwBp2jUJeB7
        gJqtNDPTudH1HOgRu7WC3HPVjLtb6PeGkJO86QWG6npognI5wqTV3Bjq46BEsZLd
        BTrFpCXn7PwRkSrwL7j5+Prj3R6wiqTD/aqUJOSahs2qcOPkjNbNBCahSUhXzxpv
        buiH4OEcUNhN2QB6RyXhPwSbo59ag51tgC7OXH9WLpe4Am3DeXV2sUxy7PCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656404306; x=1656490706; bh=712w3OsDSbbRAN97CqHhUG+Ti8Ac
        xPbFv91wwZ84Q0Y=; b=Vn1ZmIP5z/AS+dXPc5omwzxn7BeItSANbkpcm/fq2Opu
        bTlaYCTT4aKFyrehUbcwxnxuLYWkmlrlIH15UZ1IxSoKCMI+3tS9sLWOoHx3VKUq
        cE4wwpdvPlzpVfdjzXIaFC7kSJcuOy+84WmgJ4ikTVGQ+ZG/wuTno7t/WxQjhhH7
        DiOq2L/Dr6xtULU2b8A1H4vuLD/v+1CavJNiIFq5VjpEFB0ep7VepWvlzLxUOb9D
        MUqSQyv221gBSVICh8oHAD01RoeTVsOGr5v0tY0gtTmPzHz4WjmtNaJVkMzRRLFa
        0rvb22csHf03Xte7MGcnyW5H22Vu3YIssbscSgXH0g==
X-ME-Sender: <xms:Urm6YuMNyIGU62IqLEEqAzz-FNYAPJ-7NNhN7754peYL8GVTnUpkKA>
    <xme:Urm6Ys_34e35hmmhgPgWusog-AmPKqNGkUiqXh7XzbnhFpOZly5R93xrADnq2THjD
    X0DyFhS34qUSKmrPCk>
X-ME-Received: <xmr:Urm6YlTVDjock6Fg9bDsi-59AQ_c2tMVHs-ur2FISgX5IAbiPf3uwefZt7BGEZH6vV_B01zjndpENg7-MpMjy8sBKhR1-lX7af1qKrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:Urm6Yuu4TdJyFzCWMD4qYyQgb161giblbcuFG_5BcV5Y_p6-Fe_uKA>
    <xmx:Urm6YmeiIt51h6xst6lmWM21jdu-4U6Mb4lnCjWTEdZQ9QRv8DDR0w>
    <xmx:Urm6Yi1MgjxTYlfzYxtEXviYENA1HSmv3jdcBWPhDL_Sl0maM13xIw>
    <xmx:Urm6Yl6EjQxF3SKU4-MJz9VRRzPzfnWv1HbKtHqfpAcFXFrl_FsPXw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jun 2022 04:18:25 -0400 (EDT)
Date:   Tue, 28 Jun 2022 10:18:24 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     emma@anholt.net, eric@anholt.net, bbrezillon@kernel.org,
        liwei391@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: fix dereference before NULL check
Message-ID: <20220628081824.5u4p7q6xepp4uvsd@houat>
References: <20220628063657.3169049-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="auukrdoejisn426n"
Content-Disposition: inline
In-Reply-To: <20220628063657.3169049-1-liaoyu15@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--auukrdoejisn426n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 28, 2022 at 02:36:57PM +0800, Yu Liao wrote:
> The "perfmon" pointer is equal to the return value of idr_find
> which may be NULL, access by vc4_perfmon_get before checking if
> it was NULL. Fix this by dereferencing "perfmon" after "perfmon"
> has been null checked.
>=20
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

A similar patch has already been merged:
https://lore.kernel.org/dri-devel/20220622080243.22119-1-maxime@cerno.tech/

Thanks!
Maxime

--auukrdoejisn426n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYrq5UAAKCRDj7w1vZxhR
xd9KAP9+WatATh3hNMH6GeSkuP3T4bsk3GeDzOoHsrHhLCmvKAD9HJY6o/84y8so
/KpOXTRwS9prU1ikQ4hFYjbSdPJhhgg=
=HmDs
-----END PGP SIGNATURE-----

--auukrdoejisn426n--
