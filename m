Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC224E73FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbiCYNNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354117AbiCYNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:13:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8FCD306
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:11:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h4so1422176edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=39vGWICtE1D8WySZuhFVZlySZosFxjBXRPANWqdHqJI=;
        b=NTx2AJfNxhtsruI+24G5OYmC4RHPpFcxU392t4ad1qdWs3PL+wH61IGlUhqrZF/kj/
         Y6u7so5LGZyjeNOaBNTyKVcVtcDy/DVeIH+UyQpE6gVpe/2Xh5kY+q3AEJxudzf4uv/d
         SZdJHdcKlZojzwZs3vMPUoHiUOKKsoWVcj8y0UT9IhyIxtMF0KqTh+xag8oz+vRPGfdU
         IC/EBlaXJHbP8ia07dtrBi/LGajTT6INsCG6oOEWPyR9Ro5yRTXCBrD8Dhdpg50WerI4
         M8rrBkhR3hcsn3s1Jbi6LN5KZ38YGPOdjtiX7FDUzl32H1EjVIoJpuTLnuaw1vKNbuZ1
         lZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=39vGWICtE1D8WySZuhFVZlySZosFxjBXRPANWqdHqJI=;
        b=pZMTTxuGF1MpwChS1qDF3zURWO/sFJ9kRHN+3216r4QUIOeqjsnifQ8s/2fXnbDPiR
         DFglDIpmjj5Q/IHL01t0OjjLrHlkCJGkZFG+9MPI77SXGYZIU7t/ATMFNwWtCmNRJFAX
         teJrD+BAARCapknHaGzZSdUUbpnDqKGDKeqRISTSzbr8fBMF9KghKKztf+iCrTPu5VLi
         OzIBkqAy2oD/vODYF3JJTmPVNujlmWcKA3XfnsNihj1Py41gA8tuQF4d+sthH68XW120
         AgiVn25O4Xzv97G6Uc8WSw4lyTKv3oWNTQoC2uBYbhCLQu/DeRPnInlQSxrM95q0ujGx
         rSOw==
X-Gm-Message-State: AOAM533HeRIWIKZPsc6DWybptDUqXnfkWyxxX/jfrc/URt6BJfjRZzU9
        qqwDoee97rn3EkvAeCg2fHeoElgBcfoRvMqp9yVc+w==
X-Google-Smtp-Source: ABdhPJyY9ujjG8SdRD4j0AKKCRXtfcW1P0TEC08sIy7OcwjNsgCf8+3eqAIPJgf4CNG0xp7IsqUiUeoJWYb80ZrGmbc=
X-Received: by 2002:a05:6402:1e92:b0:419:76:21a6 with SMTP id
 f18-20020a0564021e9200b00419007621a6mr12936544edf.128.1648213889593; Fri, 25
 Mar 2022 06:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
 <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
 <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com> <5be83f0b343c04d877a2c2d805fb5f71ca9973b1.camel@ndufresne.ca>
 <fe24d151-6097-aa8e-7691-5e4d81fa42c6@collabora.com> <f80128c50d3dacff0af70bd88521abae42476f85.camel@ndufresne.ca>
In-Reply-To: <f80128c50d3dacff0af70bd88521abae42476f85.camel@ndufresne.ca>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 25 Mar 2022 13:11:13 +0000
Message-ID: <CAPY8ntBQBrWytYRbv50F-4TZJdCaSQs86r3vY6kJdp+oc6SxEQ@mail.gmail.com>
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas & Dmitry

On Fri, 25 Mar 2022 at 12:32, Nicolas Dufresne <nicolas@ndufresne.ca> wrote=
:
>
> Le jeudi 24 mars 2022 =C3=A0 21:20 +0300, Dmitry Osipenko a =C3=A9crit :
> > The root of the problem is that DRM UAPI is more flexible and allows to
> > customize offsets for both S/MPLANEs, while V4L doesn't allow to do it
> > at all. I'm exploring all the potential options, so far neither of the
> > proposed variants is ideal.
>
> In GStreamer kmssink, the way DRM is used, is that if you have 2 planes i=
n your
> pixel format, but only received 1 DMABuf, we will pass this DMABuf twice =
(well
> GEM handles, but twice), with appropriate offset.
>
> With this in mind, the idea for V4L2 could be to always resort to MPLANE =
for
> this purpose. The tricky part for userland is that it needs to know the d=
ual
> pixel format and map that accordingly. That is a bit difficult and this i=
s
> something Helen was trying to address with the v4l2_buffer_ext (that and
> allowing space to store DRM Modifiers in the future).
>
> The second challenge is the overhead. In DRM, as we "prime" the DMABuf in=
to
> handles, this gives a kernel object to store any relevant information abo=
ut the
> buffer. So having it duplicate can be done at no cost. In V4L2, the drive=
r would
> need to handle that more often. Specially that despite the recommendation
> (except for primary buffer decoder, were this is mandatory), we don't for=
ce a
> strict DMABuf / Buffer IDX  mapping.

To throw another use case of data offsets into the mix, I'm keeping a
watching eye on implementing stereoscopic capture into libcamera where
we want to present the same buffer to the ISP twice (once for each
eye) with either a vertical or horizontal offset between the two
passes.
Adding a data_offset of either a half line or half the frame is the
easiest way around that one, although it could potentially be
accommodated through the selection API setting a compose region
instead.

  Dave
