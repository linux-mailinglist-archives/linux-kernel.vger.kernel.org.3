Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC4485CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiAEXzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:55:32 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:56658 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245600AbiAEXys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:54:48 -0500
Date:   Wed, 05 Jan 2022 23:54:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1641426886;
        bh=08qnopJ/DUHN91WheoJBHHaZdklDDu1TthMMx1Fhljg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=V2pKlZ/4UcNGlRHolp7at7kYgRaAnJ5tazpFkXjni0jqbgNPuewWZXlYyTLLt/c8B
         zhj9ywkoZl/LhvrRNYEQUBD20+NXTPQR+kwp69uTrvhgbSslG0Rm8LLEl6ARxo1kxd
         LpRwpY3PT2YcDQB+7wOEFlfkwyRdvGhvzac8IxmgKz+Q9vXxHwafCcf6NeuMNeruit
         Mbzu5Ubn+U1fXJO97kP95TExgYJN01odNRLjp48zHSAGBIc+8LdFNKTIF9gU9PDaCt
         e00IqFAlN8qMoXcJ1JhBD3gRw8J4lv+45BSB0AwSSRqSRNvBSVohD78Fmxbf0+S1bl
         Rawl2cx86GEJg==
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
Message-ID: <3DdB6YPUQr4O063yNreefZcIm6p5Z6HORoVVbk5RTMmjz8qvnxMse42hLvfDmA323KG-TWLc_JUFZEEEIkoINXQuAzjLVe2jRRM01tQgYOU=@emersion.fr>
In-Reply-To: <20211226112503.31771-3-jose.exposito89@gmail.com>
References: <20211226112503.31771-1-jose.exposito89@gmail.com> <20211226112503.31771-3-jose.exposito89@gmail.com>
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

Pushed patches 1 & 2 to drm-misc-next. Thanks for your contribution!
