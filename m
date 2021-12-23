Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC647E117
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347611AbhLWKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:07:27 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:55606 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbhLWKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:07:26 -0500
Date:   Thu, 23 Dec 2021 10:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640254044;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=gbYSD1oJfitEUpR//HJf9DzbjJxOgkD3iapphcrU/uZGqgKkUcCc1vIpK0dTcDkfx
         mpfR6x7lHdm88Xz4Wey/NerEFw2ZdhTaDSUqgg0kl9OEUeuhK5+60lH31lkXoHTW9n
         KiOuxYNdz3JEsXmRMBVcXtis824NHyURJ9U9vvBWd5Fr+qaLBhjLOE8h+6eAY4iXmC
         u2ssCeZrgyAv28ZuTVfoHOKWfKgWhfmLfcoVCQZigJGmeXViQPjFHaJbx6spoa6Tmq
         VQWWd3nbsAXijeEZUFhyrAlufaWuX8s2mWaIoOarcpLda7X20a3t5mQuP5BToi1Mtp
         NZi94UIxVtVnQ==
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
        linux-stm32@st-md-mailman.stormreply.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 2/6] drm/plane: Fix typo in format_mod_supported documentation
Message-ID: <Mvx6OvWCWFlETEiAbcFfstJZLT3KuMwwbWOdID03IpRLb8IFXUyPXd89dKGZvd3UTYSrteRLv9gAFNJYc56X7-OFvC31c981WeUFDZDTAi4=@emersion.fr>
In-Reply-To: <20211222090552.25972-3-jose.exposito89@gmail.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com> <20211222090552.25972-3-jose.exposito89@gmail.com>
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

Reviewed-by: Simon Ser <contact@emersion.fr>
