Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0085B4A8160
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiBCJVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:21:17 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiBCJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:21:13 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXop2-1mjjBb19tE-00Y9iS for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022
 10:21:11 +0100
Received: by mail-wm1-f52.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso1379170wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 01:21:11 -0800 (PST)
X-Gm-Message-State: AOAM532ArfxOsEPqs9LOYDo/6oTeKvYFfyaZIUL+E1NkRhaXcrG4J6Ui
        0Cb+gqVVMenQJ9AlvjxAPFsRDMBddUTFZeeK7YI=
X-Google-Smtp-Source: ABdhPJzzGHS040+Ga0s5Uewyaa/jDPD/fj5JRTVbX2eFjm6kLmPkl8rRFjQT8dqAI3jEVH6cV/zk5k8WD1CiDjX4ogQ=
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr9597514wmo.82.1643880070927;
 Thu, 03 Feb 2022 01:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20220203091340.20285-1-tzimmermann@suse.de>
In-Reply-To: <20220203091340.20285-1-tzimmermann@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 3 Feb 2022 10:20:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dYmCfyQV+iPj6KJAKpv8zYCVorDjqpeyVeAz7v7JyaQ@mail.gmail.com>
Message-ID: <CAK8P3a3dYmCfyQV+iPj6KJAKpv8zYCVorDjqpeyVeAz7v7JyaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XHM8TnvLWDi7Z0voRc5CGdjb0zKP3XkptcFDPs90piIOw1gYKyL
 Y4jqG+IX4oSoXkVZx/NCh3norR++J6W4HuP5KXM7Kl3y1TA2fIXJ0cPE5O8nPN1g9T4cYCU
 fcryPQst19kstXyEttuFixS/PoyfeRk8WU8srGefIVZ9koyptRg/4q+innlN9IX/C+e9jdf
 JrbVBFVtzN/MiMgK7FQfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GxYDRdwi2wk=:Hg5bpc4UFiGRnhdaqH/Iao
 GUH+aKo7qSOfEgCmyGAqiZ/lKCFiWR55QauLF9hhJ/n/IipS+pQS1gWoZgvOu2eyRloam9wVY
 Brz5AmWYi+ixo/3RILEarYONv1oArHMx5gKDu4pih1NOh2VVs0CO5IiA9s6Xsh0vaS0eQSzJr
 +I2klSg896z0c+B+OPP3ffgXZIoju2E0LYIG5n4Ft6746cjo4aGNqqO8+AV9EiUzxTUCPJB2D
 8dtj06nY4oNszqeKkBRKP5CQ4mrtRtru2JDYS4sJ1UrHytOF77Yh7lpByKu4VnAPJmbIDKT82
 xOJJxpA4Fx4QIqbkzltqXDiDvEFjwXW/J4ukn2pkPRGhjpBNj9Yvi+QsEZaHFUfhPF2XbIqma
 RskkMmlWTzhMVBrHlL3i+pTB/yp0nJHjNjuQ0wd34bVahiYIiN3bfP+LjQIg1BsbEi0NLh1SN
 GmJR1OcM8Znj+L1nbbcLWIw9fJGBE23PU91/kaHBGVxPcazEvRpa/6/jxALmbeihvCPzoigj4
 zm+QGi3mAzBN1jwcRxon07HrH993ijJanMGTnVWLeZO8airimsZjIbTnFQmtEk6TndHQ2lavW
 qzlC7TdGL4xdWWX/FjQRA0K0kMKyjKZysH9uMyCOXse6WRzkXHFjkwa40v4sMw/0V9ZjESEug
 eCFPgflSW/UTZHjGF8NujNr41IzMvdTCdRFGiS3u4F1aQDtT/aXTijsPqgN/+d8PgmmUOXRiM
 Ng4VMm7BbYZKeY7WL7mmVEG9L1gSpRf/g7XxZMPz2D5yp0eq8WYhoEIJDEkGNAOpr7KBb4LSD
 gKLytYowiUekCTnws3Zweag5Q0bWWdWdk1Jpr/nz1RxYLWzseA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 10:13 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> As reported in [1], DRM_PANEL_EDP depends on DRM_DP_HELPER. Select
> the option to fix the build failure. The issue has been reported
> before, when DisplayPort helpers where hidden behind the option
> CONFIG_DRM_KMS_HELPER. [2]

The two links [1] and [2] appear to be missing here, and I would also recommend
copying the build output into the changelog text for easier reference.

When linking to a bug report, best use 'Link:' tags in below.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: adb9d5a2cc77 ("drm/dp: Move DisplayPort helpers into separate helper module")
> Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 434c2861bb40..0aec5a10b064 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -106,6 +106,7 @@ config DRM_PANEL_EDP
>         depends on PM
>         select VIDEOMODE_HELPERS
>         select DRM_DP_AUX_BUS
> +       select DRM_DP_HELPER
>         help
>           DRM panel driver for dumb eDP panels that need at most a regulator and
>           a GPIO to be powered up. Optionally a backlight can be attached so
