Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEFC4A7FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbiBCHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:43:40 -0500
Received: from mail-40141.protonmail.ch ([185.70.40.141]:46259 "EHLO
        mail-40141.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiBCHni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:43:38 -0500
Date:   Thu, 03 Feb 2022 07:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643874216;
        bh=oL57e77hZZR49PdM02PnDu37Z4T12IsJ558i6C2+Ch8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=lOCf9VyCv4K0YQUo7zilZojt/cu3WeyO38ZynY2JT9sVwkW07+xABrKB42Uu8S/Xj
         znazV+y4lrl9q75tY/3BfEe+SWTtbffVO6Ng3qzBbbQG/T46/w7Lq/BLo1eI2XKM7U
         GtHO6sQNvxMoAhOnndcS/ICDNOP0TsS2mvyx5cQ6T4VhJk+f0/pRpHK4vl8WrnDmzN
         RjsvlO1Czzh+9RKKaPSOFRFHRrBE6IfNL3HDmzThL7jGWN9tB9mJjtkIt3CgszpEx0
         +QWbCPcJSuM6D5RdNVlRnlmCu3IXUk4ug7nkj2aB/4Vq0NAghy4lIm2fphVBIchWj/
         7NEw0T68NELdw==
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for LG.Philips SW43101 DSI video mode panel
Message-ID: <20220203074245.53322-1-y.oudjana@protonmail.com>
In-Reply-To: <20211121034748.158296-3-y.oudjana@protonmail.com>
References: <20211121034748.158296-1-y.oudjana@protonmail.com> <20211121034748.158296-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 03:50:03 +0000, Yassine Oudjana wrote:
> Add a driver for the LG.Philips SW43101 FHD (1080x1920) OLED DSI video mo=
de panel.
> This driver has been generated using linux-mdss-dsi-panel-driver-generato=
r.
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v2:
>  - Make the DT schema patch first in the series.
>  - Use backlight_get_brightness where needed.
>  - Remove 0xff mask from return value in sw43101_bl_get_brightness.
>  - Constify struct backlight_properties props in sw43101_create_backlight=
.
> Changes since v1:
>  - Add regulator support.
>  - Add MAINTAINERS entry.
>  - Dual-license DT binding.
>=20
>  MAINTAINERS                                   |   1 +
>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-lgphilips-sw43101.c   | 358 ++++++++++++++++++
>  4 files changed, 370 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-lgphilips-sw43101.c

Hi,

Any comments on this?

Thanks,
Yassine


