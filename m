Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0663C595ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiHPPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiHPPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:12:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3E76754
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:12:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l5so8331390qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=avEs6sEaW7Q+OL4Qh4yPbVdUs0EXIhNSjWRflw76Ppw=;
        b=K5leMx4ru2eHpqIqN6yh9fYk63nN/8kHAw5hGVYzSyZbH4vv58bKnm1zfGWGfJj0dY
         YNI9j+a/AqUhvJPgTWJA1rHrw1DNDB0ogNX55VvSz4V1MaIpPM2x3G+KuKIE979P9a7q
         RRctIYYRxxIn0ExPyJ62NrkY/Su9MJt14FbJwpd6jnjwjELpuKedacBPzJUy91k4Nfg/
         rT9nU04unU5TMtljc9j0MB9/mEbbTHi1GAOAhaJLT+a6ClAA6WdiLO8QTAQ2U6Hol/xn
         /q7vzA7j0QVy8+prWugH3SK6e7LKapie5BjQGDONgWESHawdl18kgT6XTMXvxAY+m+0r
         whDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=avEs6sEaW7Q+OL4Qh4yPbVdUs0EXIhNSjWRflw76Ppw=;
        b=rJ2x0VsmsrQ/LHa53ve7BCYVkeLwJh3Mx8j1FHMy0pASICZb44UhOD1S+jCClTLpyI
         4CzvDLdTPIon4KabPI0GDXnwTf12UmOg02Qxia+Ch7KwN+vNjVmDbGg1RoAPt8+xdXa2
         o/7kalgHbpCEhiyJxz2rDbp53vpQV1rcEP3PJ7nc2VkOD0uW7QTIXeH56gnkr0V8H1c6
         x307jlu1DU5ope5Amq0jywBQVmkph6jtu8v7A3nEdDiUH6KV2Ouo3WM0YVdJ56gLSyS9
         fRF7QfL8dnbeCCsBzvAySaUODV5abBXNFTs+TVsGjlr/rnr2qK3b7B4yF3maACDOBXPB
         PB3g==
X-Gm-Message-State: ACgBeo0u1tQb0luJnsIRYJOAjsuKp98oImL7obc1oVR7ZOksAvUzLiDl
        XvK1kb6hGvx/LsJsasw6bwu9oQ==
X-Google-Smtp-Source: AA6agR5DYl6+KOIp1qdbG50xFGn9SzMOsy2QOvcbTXTSY8lNhZZ3LwPLbkRbboLOWtun0IQZhZWZ2A==
X-Received: by 2002:a05:622a:1889:b0:343:19a6:d972 with SMTP id v9-20020a05622a188900b0034319a6d972mr18929013qtc.290.1660662775782;
        Tue, 16 Aug 2022 08:12:55 -0700 (PDT)
Received: from fedora ([23.82.142.208])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a249500b006b5e1aeb777sm749802qkn.43.2022.08.16.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:12:55 -0700 (PDT)
Date:   Tue, 16 Aug 2022 11:12:52 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Message-ID: <Yvuz9NUWXPhXqzeU@fedora>
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com>
 <Yvkq9Hy+hxAPQd8J@fedora>
 <fe0fe04e-5ac2-e8c2-d568-0976ba085d6a@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rkAt867fDpCKeN9q"
Content-Disposition: inline
In-Reply-To: <fe0fe04e-5ac2-e8c2-d568-0976ba085d6a@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rkAt867fDpCKeN9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 09:58:10AM +0200, Julien Panis wrote:
> On 14/08/2022 19:03, William Breathitt Gray wrote:
> > On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
> > > +static int ecap_cnt_function_read(struct counter_device *counter,
> > > +				  struct counter_count *count,
> > > +				  enum counter_function *function)
> > > +{
> > > +	*function =3D COUNTER_FUNCTION_INCREASE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ecap_cnt_action_read(struct counter_device *counter,
> > > +				struct counter_count *count,
> > > +				struct counter_synapse *synapse,
> > > +				enum counter_synapse_action *action)
> > > +{
> > > +	*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > > +
> > > +	return 0;
> > > +}
> > Right now you have a Signal defined for the ECAPSIG line, but there is
> > at least one more relevant Signal to define: the clock updating ECAPCNT.
> > The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
> > clock Signal, but for the ECAPSIG Signal you will need to report a
> > Synapse action based on the polarity of the next capture (i.e. whether
> > high or low).
>=20
> Just to be sure : by using the word ECAPCNT, I guess that you speak about
> the
> Mod4 counter (0->1->2->3->0...), don't you ? (2 bits)
> Or do you speak about ECAP_TSCNT_REG register content ? (32 bits)

Sorry for the confusion, I'm talking about ECAP_TSCNT_REG (32-bit) here.
You should rename this Count in your ecap_cnt_counts array from
"ECAPCNT" to "Time-Stamp Counter" to make it clearer to users as well;
it would be prudent to rename "ECAPSIG" too.

I didn't know that there was a register exposing the Mod4 counter value.
If that's true, then define a Count for the Mod4 counter in your
ecap_cnt_counts array.

> > > +static struct counter_comp ecap_cnt_count_ext[] =3D {
> > > +	COUNTER_COMP_COUNT_U64("capture1", ecap_cnt_cap1_read, NULL),
> > > +	COUNTER_COMP_COUNT_U64("capture2", ecap_cnt_cap2_read, NULL),
> > > +	COUNTER_COMP_COUNT_U64("capture3", ecap_cnt_cap3_read, NULL),
> > > +	COUNTER_COMP_COUNT_U64("capture4", ecap_cnt_cap4_read, NULL),
> > > +	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
> > I just want to verify: this enable extension should disable the ECAPCNT
> > count itself (i.e. no more increasing count value). Is that what's
> > happening here, or is this meant to disable just the captures?
>=20
> Yes, it is what's happening here : no more increasing count value.

Okay that's good. By the way, COUNTER_COMP_ENABLE ensures the enable
value passed to ecap_cnt_enable_write() is either 0 or 1, so you don't
need the enable > 1 check in your callback.

> > > +static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
> > > +{
> > > +	struct counter_device *counter_dev =3D dev_id;
> > > +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> > > +	unsigned int clr =3D 0;
> > > +	unsigned int flg;
> > > +	int i;
> > > +	unsigned long flags;
> > > +
> > > +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
> > > +
> > > +	for (i =3D ECAP_NB_CAP - 1 ; i < ECAP_NB_CEVT ; i++) {
> > Would you walk me through the logic for this loop. Is this for-loop
> > intended to loop through all four capture indices? ECAP_NB_CAP and
> > ECAP_NB_CEVT are defines, so your for-loop has i=3D3 and i<5; is this w=
hat
> > you want?
>=20
> In previous versions (IIO subsys), this for-loop was intended to loop
> through all 4 capture indices
> and overflow flag.
> In this version, it has been modified to loop only for the last capture
> indice (the 4th)
> and overflow flag : yes, this is intentional. Only 1 event has to be push=
ed
> so that the user
> gets all 4 captured timestamps in a single-reading (using 4 watches).
> But if I understand well your previous suggestion, you would like tracking
> Mod4 counter value,
> don't you ? So, I will change back this for-loop, so that it loops for all
> capture indices (and
> overflow flag) -> For all 4 capture indices, Mod4 count will be updated. =
And
> event will still be
> pushed only for the 4th capture indice.

Instead of limiting the event push to just the 4th capture, I'd push
COUNTER_EVENT_CAPTURE on every capture but delegate them to their own
channels::

    counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, i);

The captures operate as a circular buffer, so the user can determine the
current capture index based on the watch channel reported and perform a
modulo to read the buffers in right sequence. Alternatively, they can
watch just channel 3 if they want to process only four captures at a
time.

William Breathitt Gray

--rkAt867fDpCKeN9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvuz9AAKCRC1SFbKvhIj
K8mQAQCOs3D703lZxMBKK+yMQez6WY70xUMLnDKmlzE/2QGv6AD8C94wDbMxjYD2
po8KeImSPXRMjLkgBlqZHKY+bmemGwI=
=w7+f
-----END PGP SIGNATURE-----

--rkAt867fDpCKeN9q--
