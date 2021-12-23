Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A2847E11D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347617AbhLWKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:10:26 -0500
Received: from mail-4018.proton.ch ([185.70.40.18]:12588 "EHLO
        mail-4018.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbhLWKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:10:24 -0500
Date:   Thu, 23 Dec 2021 10:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640254223;
        bh=JZk2QkwvQMw2dr3xN0Nul1fIObR/x6Mzssnku9CKGxI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=jogA9ITM2pLDQetcpufIntC4yTHzrr4+DWIpmT87TPMpju4Ot4RMQ+WoPBM247Tpu
         O8vwV/m9VY6TxbagfU0VqDfUoySRpsVQo8xeuk9rtka7kmhULzDeBU2qj80qLAr/Pl
         tyDxdNlMTeN0/VI1nIPmPi2rBZGD7vDOaQvRjOwGNN+LymeR2yX0gOrADjxqBRv/DK
         ozo9R/9VLfI7qonEXrrdE+T/byG6eNDz/7xkaNdebwMR90q+uJRbnzVrYS6X2DgczQ
         EA5Qt9X6ExeKkKVzmhOOM5KaR6wD89AGhOi8m7lMoK37T0naYw47i++tgbFwpoVybB
         Jjs8alSOHkPVQ==
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dmitry.baryshkov@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        marex@denx.de, stefan@agner.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Ville Syrjala <ville.syrjala@linux.intel.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: =?utf-8?Q?Re:_[PATCH_v2_1/6]_drm/plane:_Make_format=5Fmod=5Fsupported_truly=C2=A0optional?=
Message-ID: <8OwW5vWFemsZ6SHYICEo6Ic972ApufOImdVLLprAxvjF3AxrjQghwFAZsQ1WJNqrv2fCTyB16g4JALC8omFmZ8-vcmTV289KfBEIkKMS5xc=@emersion.fr>
In-Reply-To: <20211222090552.25972-2-jose.exposito89@gmail.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com> <20211222090552.25972-2-jose.exposito89@gmail.com>
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

On Wednesday, December 22nd, 2021 at 10:05, Jos=C3=A9 Exp=C3=B3sito <jose.e=
xposito89@gmail.com> wrote:

> Make "create_in_format_blob" behave as documented.

LGTM, nice!

Reviewed-by: Simon Ser <contact@emersion.fr>

CC Ville just in case
