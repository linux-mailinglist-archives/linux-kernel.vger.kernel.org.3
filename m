Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2AD54ECD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378698AbiFPVq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFPVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:46:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1C5F8D2;
        Thu, 16 Jun 2022 14:46:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m20so5154505ejj.10;
        Thu, 16 Jun 2022 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSQFRDEgINvllunQauaH/Y1t743uBR9C06AXn0bzorc=;
        b=nmc/dM5JUlhcEft9FPy/eplFzUsCkuLjPVZaNRiDmWURygEBDqb0aXTLxiv9NR+RSo
         ZT1QPR0WVGWlMe5AThCzwv/NynIvNYlQzsIjYKs9ml+iB3JQSu6xEoHifjwyT3hJ07js
         OxM4WkhcfSJHbezMWWroMUjz92O5vIRIAxKPUYex+I/E0xEKtJpmpFlVJVj4Z1OsEHMS
         2IYOUam0bpzAG0EPYHGp5HtuhIH4CyR+zYiKTEsA6wr4zM+7YWkDA9BvpOAfapuZB485
         /CBHJnIkd9qvW5E0zjlxy4icjxzSoVjJwcZOneM61V9z2taSFVhfCa5NHSG40UN0bRT/
         77mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSQFRDEgINvllunQauaH/Y1t743uBR9C06AXn0bzorc=;
        b=z8c5AhNW4jEB3altajq+P2yY4zR2v55fsi1x+HcJC0X6OaBx/XpFAP+NnnsAQ9A8tj
         2x2VSPm8BUC7a6tNpEcjSY6i0Y5ZQPRR7qxCtIJIiGZr0xljBE2lKD9z9A5ZCwsIMMvF
         VNfoF8xM3r8Kdhc4oa+Y0bB1h/6h5aMuiLoQrrVTdf1TYIhiOmYBRU6WglwlIUd8GRyz
         6mbLFTotNLcfIZj3tzpro8EG0gko+iUqJ++kAydCv0hhXMW/WXO4UxEeZpcMlrcXA/U6
         hb8lHbqLJJAARhZKeTcAlk8EyX3cjkNQoKe8S/68dfznYvaCq7C0wEYiyayLMzWbr+hs
         DW+g==
X-Gm-Message-State: AJIora9EuSTiHubhTcIt1/vErt6FrJYGCfiapM/Rx27BDlCSz3yrFagq
        XRJyhDhZgdlqn1DW57tI+SQ=
X-Google-Smtp-Source: AGRyM1s//zJocBYAERflvIMVweP8k36M2aFY3OToGe+LovnfFlApOLb64M0/TXuacgm6plsL0Roi4g==
X-Received: by 2002:a17:906:4a13:b0:715:85cc:9224 with SMTP id w19-20020a1709064a1300b0071585cc9224mr6372285eju.267.1655416015665;
        Thu, 16 Jun 2022 14:46:55 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906538800b006ff05d4726esm1262372ejo.50.2022.06.16.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:46:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, wens@csie.org, samuel@sholland.org,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] media: cedrus: fix HEVC decoding
Date:   Thu, 16 Jun 2022 23:46:52 +0200
Message-ID: <3178102.44csPzL39Z@jernej-laptop>
In-Reply-To: <39a83a7e-caaf-1dac-1072-72cd2f5d8bf5@xs4all.nl>
References: <20220615204436.137377-1-jernej.skrabec@gmail.com> <39a83a7e-caaf-1dac-1072-72cd2f5d8bf5@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 16. junij 2022 ob 09:14:05 CEST je Hans Verkuil napisal(a=
):
> On 6/15/22 22:44, Jernej Skrabec wrote:
> > After detailed comparison of register names to vendor library I noticed
> > that one register has completely different name. After some testing I
> > discovered that it was misnamed and used incorrectly. This patch series
> > fixes it. With that, 3 more reference bitstreams are now correctly
> > decoded. It is also possible that this fixes instability issue I had
> > after decoding such bitstreams. Running Fluster test suite very often
> > locked up my board, but after applying this fix, I never experienced it
> > again. It might still be completely coincidental, but I doubt this is
> > the case.
> >=20
> > Note: Patch 2 clashes with HEVC uAPI destaging. In current form, it can
> > be easily backported. However, there are few users of Cedrus HEVC and
> > skipping this fix wouldn't be that bad.
> >=20
> > Please let me know which way to go:
> > 1) wait for destaging, send rebased v2 and not care about backporting
>=20
> Let's go with 1. There is not much point in backporting since destaging
> the HEVC API will also change it, so userspace will need to adapt. It's
> a staging driver anyway (although hopefully not for long).
>=20
> If you post a v2 on top of the latest series from Benjamin, then that
> should almost certainly work fine when Benjamin posts what will hopefully
> be the final version of his series. When it is all OK, then I put both in
> the same PR.

I actually have several patches for Cedrus HEVC which I plan to send soon.=
=20
They would apply on top of series from Benjamin and would implement all=20
missing decoding features, except maybe 10-bit support. I'll include these =
two=20
patches in that series.

Best regards,
Jernej

>=20
> Regards,
>=20
> 	Hans
>=20
> > 2) merge before destaging, but v9 of HEVC uAPI destaging would need to
> >=20
> >    be rebased.
> >=20
> > 3) something else?
> >=20
> > Best regards,
> > Jernej
> >=20
> > Jernej Skrabec (2):
> >   media: cedrus: h265: Fix flag name
> >   media: cedrus: h265: Fix logic for not low delay flag
> > =20
> >  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 29 ++++++++++++++++++-
> >  .../staging/media/sunxi/cedrus/cedrus_regs.h  |  3 +-
> >  2 files changed, 29 insertions(+), 3 deletions(-)




