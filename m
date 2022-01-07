Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E44487B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbiAGR3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:29:36 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:36760 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348577AbiAGR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:29:34 -0500
Date:   Fri, 07 Jan 2022 17:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1641576570;
        bh=UiTlyBo9UuvfhzocANog0JAKgTNkVZpUBxSayY9p2tE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=GAauKnGMTyEXiFfCB/6NXgNZXkVYvCukP7KR+50OnPx0xmNzSXyo70fbab5XGx6ZX
         gxwDRNAQZl9tweSDOfxQYGN6bI04/u4vrJnFk82UsvYYqXRO/k8m/iDjdGLdg7NZik
         TIJIbiDbKhZNgLv+B9Q+TLr3wEhHERsQfW3M3o7MGD4PV+yxYYcFeVLObLQDXSwLUD
         Hi9TLYSZHMPMDEsiaQaJvLvn9TghvS2bW6mGvCT3eO8lYzkZm/0C9iCCZlG/V1TpXL
         kIRWEKbpaC/u4T1xHlFwYdVi2WAZ7xmbKAT2NXUCwZTVeHnr6vqpD4XPBwKrDrMQRW
         /rdLFvZ8Hiz2w==
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     ville.syrjala@linux.intel.com, dmitry.baryshkov@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, marex@denx.de, stefan@agner.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 2/6] drm/plane: Fix typo in format_mod_supported documentation
Message-ID: <zTX9uSmiLpHhH2VG6QBEkyfzqLTLylulwnf54f-fsx7Qp-ePGWW9gJJm-whTbo35o0TKd_hzV_f5Ir977j0A_sMeXCXZ8nofLNV6Q9Rzwwc=@emersion.fr>
In-Reply-To: <20220107172601.GA122757@elementary>
References: <20211226112503.31771-1-jose.exposito89@gmail.com> <20211226112503.31771-3-jose.exposito89@gmail.com> <3DdB6YPUQr4O063yNreefZcIm6p5Z6HORoVVbk5RTMmjz8qvnxMse42hLvfDmA323KG-TWLc_JUFZEEEIkoINXQuAzjLVe2jRRM01tQgYOU=@emersion.fr> <20220107172601.GA122757@elementary>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 7th, 2022 at 18:26, Jos=C3=A9 Exp=C3=B3sito <jose.exposi=
to89@gmail.com> wrote:

> Is there something that needs to improve in the other 4 patches?
> Or just waiting on maintainers input?

Yeah, these patches look good to me. Feel free to add my R-b.

Maintainers for these drivers still need to review/ack/apply them.
