Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3174B4E51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351092AbiBNL10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:27:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbiBNL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:27:12 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404865832;
        Mon, 14 Feb 2022 03:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644836574;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UuYelEPUUVN2By4s65pB/byvPZxpZ0/KX4emzn6gY80=;
    b=XmHSJjW5lMjNkKyFEnYyKU3qq7w9yhrWIfJ9SJ0YWsZnK97HV6wUiNUIpmMGCCUG1Z
    Ws01peA+jNPuHpmMwSMYY1r86bUlZJmmm4DaTIobuG4uenw1mCNAhG+U0RcSv7/AAB6S
    ch5gyAt8xV9pVUtznXfJNXLL/iY6x4rXsHeZtH6Gygswt2J1lfBpmJQZjNp1kb7sozk0
    0DsgVLQBn+zIe0sk+Lwq3bpG0DaJZ9Txz84GcFNIMIw4SmARxMN2pLKZ1QOJqAwmanlT
    Q19plqv9cR5PLQray5sejrms9OcVvx3MXKJd+Tt/0tEPPa6mQET0Rd2TqGpr9HHbh9k2
    sU1A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3jcR+"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1EB2ryAP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 14 Feb 2022 12:02:53 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v15 2/7] drm/ingenic: Add dw-hdmi driver specialization
 for jz4780
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <58IA7R.PZ9FQXN7FVAK@crapouillou.net>
Date:   Mon, 14 Feb 2022 12:02:53 +0100
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Harry Wentland <harry.wentland@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD978522-8321-476D-955C-3CDD747EFCAC@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
 <e6e1f3f44e6979a998ec9c372e329b6facaded15.1644681054.git.hns@goldelico.com>
 <58IA7R.PZ9FQXN7FVAK@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 14.02.2022 um 11:24 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Le sam., f=C3=A9vr. 12 2022 at 16:50:50 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :

>> +static void ingenic_dw_hdmi_cleanup(void *data)
>> +{
>> +	struct dw_hdmi *hdmi =3D (struct dw_hdmi *)data;
>> +
>> +	dw_hdmi_remove(hdmi);
>> +}
>> +
>> +static int ingenic_dw_hdmi_probe(struct platform_device *pdev)
>> +{
>> +	struct dw_hdmi *hdmi;
>> +
>> +	hdmi =3D dw_hdmi_probe(pdev, &ingenic_dw_hdmi_plat_data);
>> +	if (IS_ERR(hdmi))
>> +		return PTR_ERR(hdmi);
>> +
>> +	return devm_add_action_or_reset(&pdev->dev, =
ingenic_dw_hdmi_cleanup, hdmi);
>=20
> I think I said it already, but in this driver you could use a .remove =
callback, there's not much point in using devm cleanups in such a simple =
setup.

Well it was your suggestion after v8:

https://lore.kernel.org/all/DIA33R.QE29K7RKLI2C1@crapouillou.net/

So we now almost go back to RFC v1 almost 2 years ago:

=
https://patchwork.kernel.org/project/linux-mips/patch/2c131e1fb19e19f958a6=
12f7186bc83f4afb0b0a.1582744379.git.hns@goldelico.com/

Of course there was a good reason to better handle the regulator
AND the dw_hdmi_remove() by a single mechanism.

Now the regulator has gone and been replaced by the hdmi connector
and we can go back.

>=20
> In your probe you could just:
> return PTR_ERR_OR_ZERO(hdmi);

No, this does not work since we need to platform_set_drvdata().
to be able to access the private struct in the remove callback.
And checking errors after platform_set_drvdata() can be done but
looks strange to me.

It is up to you what you prefer.

>=20
>> +}
>> +
>> +static struct platform_driver ingenic_dw_hdmi_driver =3D {
>> +	.probe  =3D ingenic_dw_hdmi_probe,
>> +	.driver =3D {
>> +		.name =3D "dw-hdmi-ingenic",
>> +		.of_match_table =3D ingenic_dw_hdmi_dt_ids,
>> +	},
>> +};
>> +module_platform_driver(ingenic_dw_hdmi_driver);
>> +
>> +MODULE_DESCRIPTION("JZ4780 Specific DW-HDMI Driver Extension");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:dwhdmi-ingenic");
>=20
> Should probably be "platform:dw-hdmi-ingenic"?

Yes, indeed. Thanks for spotting!

Was also good in v1. Probably someone deleted the hyphen unnoticed =
during editing of "jz4780" to "ingenic"...

BR and thanks,
Nikolaus

