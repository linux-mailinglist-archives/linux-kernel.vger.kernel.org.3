Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F7467533
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbhLCKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:42:08 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34713 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhLCKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:42:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7EE045801D1;
        Fri,  3 Dec 2021 05:38:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 03 Dec 2021 05:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rRzHlzSBjqtyvYL/4h3PntMy3Xe
        iCXlXwulLeCZvjIg=; b=gQYQYE8QFU+UUv9scGZxYeG4JesTX3bM6SNqyxpFTNK
        1pOrY8rgUECiIv7P6qyDRvRbaIl3vs+aleNXq8FwzXCYQ8zXw7hYzlkJsaml8pcU
        XptKF2KsXn0zrGk2FB/Ldj/AebVg2bjiscSm2MKF4ulG3lOMrbUp8AEezH1TzhDN
        6CzrhR5IlatxOey6Ah54D+9FAN1WWG4yo8H710+qWQH47fKHhLPvZLzlkH6UKZe7
        SUGClhBfWutx8ktQG4cuOeSrmqzsCx1p8m06EQA92YLYWbRldd1mwQTkaGszgeb9
        j6D/c0jEu/psySBk/beATs+QXfXeKTyyns9qZl+4GDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rRzHlz
        SBjqtyvYL/4h3PntMy3XeiCXlXwulLeCZvjIg=; b=bCyyyMx1zl9iVR/0IbA0U2
        wFGAyON+0nEtRr2kWfvA7qSMPf5tHJF6ij8oWVbpYGHLw4NGJuycn6bqVg4exBHX
        FpfCnwu3sz4iw948r9MRRG0oitQL/861MbixnDw9vTpSJiILRFH4ygh0KDJ516Bw
        OBEuPfjyGG7SJRuQZ787pPdsk2arwR55p8VDZtcvZVSVS16w4AOvOohm10GHWyO8
        FakMo4qvVXUNnLWssMZe8RndO9idK26BQyQ0lwfj0Ui5Y+HT8fq4cAbK2a+5Sh2h
        Ez9gb/f/jHLcQof6xKLs/YDyyXssFfLGVLh4+jf1fUAglJNXdI73T1CHc0ltJebw
        ==
X-ME-Sender: <xms:s_OpYUOzW24KbMmFPqRquZ5-wjMmdht_zQQgTs08vVAhTqa1R5--vQ>
    <xme:s_OpYa-h0wNjj7lafKFIo5WX7EDlLLtlkwRaEX_RTSRrImw_4I62fCPIMSH1aWmHi
    XYuXPtBpGdKXPqVD4g>
X-ME-Received: <xmr:s_OpYbRpE4upBA0lBXt7uXHtD0PSXXsGlsjIyHvwEr4wCW8DpKBNejk3ofN8eYI62j8w0dhJJBEBSPZGM1WT7He9LhnquLun9lib_AdOn4IXIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:s_OpYcslD3fKKJ45jXuwb1ujP6zsML88V3oSwXzCLQJBfeMy33Dlgw>
    <xmx:s_OpYcc9z2qiObBHhM9RYaUFkRLr013_9CAaKQ1wgYRToKlOiQKMUQ>
    <xmx:s_OpYQ20GLJJznWF20ZXPQFmE0Nj64X-o7meYDXwwMLPQ9RDLGZM2Q>
    <xmx:s_OpYQ3kJx4fvTmGwUQVoCharSkuOvBXNqebwDCWjRjIM44jpcOZEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Dec 2021 05:38:42 -0500 (EST)
Date:   Fri, 3 Dec 2021 11:38:41 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, pony1.wu@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 6/6] drm/sprd: add Unisoc's drm mipi dsi&dphy driver
Message-ID: <20211203103841.vkl3sjsbaohsviou@houat>
References: <20211025093418.20545-1-kevin3.tang@gmail.com>
 <20211025093418.20545-7-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ynqok2avqp6f7jvf"
Content-Disposition: inline
In-Reply-To: <20211025093418.20545-7-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ynqok2avqp6f7jvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 05:34:18PM +0800, Kevin Tang wrote:
> @@ -618,9 +619,25 @@ static void sprd_crtc_mode_set_nofb(struct drm_crtc =
*crtc)
>  {
>  	struct sprd_dpu *dpu =3D to_sprd_crtc(crtc);
>  	struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> +	struct drm_encoder *encoder;
> +	struct mipi_dsi_device *slave;
> +	struct sprd_dsi *dsi;
> =20
>  	drm_display_mode_to_videomode(mode, &dpu->ctx.vm);
> =20
> +	drm_for_each_encoder(encoder, crtc->dev) {
> +		if (encoder->crtc !=3D crtc)
> +			continue;

encoder->crtc is deprecated. You should be using
encoder->drm_for_each_encoder_mask, using the encoder_mask in
encoder->drm_crtc_state.

> +static int sprd_dsi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sprd_dsi *dsi;
> +
> +	dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> +	if (!dsi)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, dsi);
> +
> +	dsi->host.ops =3D &sprd_dsi_host_ops;
> +	dsi->host.dev =3D dev;
> +	mipi_dsi_host_register(&dsi->host);
> +
> +	return component_add(&pdev->dev, &dsi_component_ops);

component_add must be run in the mipi_dsi_host.attach hook.

Maxime

--ynqok2avqp6f7jvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYanzsQAKCRDj7w1vZxhR
xRe2AP99Mp7SYAZGjucY4sRI7q9PWgtA8VNJMZbPDvgid6+oNAEA4WA/RrSZs55v
1DqTNDjwtGIOSQy/IsSXdpZjjZq/ngY=
=++lK
-----END PGP SIGNATURE-----

--ynqok2avqp6f7jvf--
