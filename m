Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383634721CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhLMHeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLMHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:34:43 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EAC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:34:43 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 15so14219068ilq.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pN73UJTcYa5JOMyuK9jaetarpbkD/7IbNdXwxXj6+68=;
        b=cgjLob2ExtmzQgI8lE2pZ6tGgPX19y/hv8KNnoFSmCp0r9RjcHeTd2QSsKuKNt5Nq6
         VJX2PjHvIOzpTKzrxkWN05NX0bV5P1jhFbZjGTlzKixL8K1QBfd32V7i5CDhjL90Qjyh
         tpHI0VDFtYLu9vr+Mn7+o8teHVQl1zfyrqhz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN73UJTcYa5JOMyuK9jaetarpbkD/7IbNdXwxXj6+68=;
        b=MGmDQWjzAVHHema1Mt/OBXpzshz1wQ5KeqB0woxVUKsVwdT3EvTjwU4l/BSVHFc6dZ
         FepJQnfqk2iHuvSNei0bgeyTx4XEbvFWiYNaynoboTqJtZilD720UzqGeIWcNUIhXX2W
         XUklTdKK4l0Psw93yY8dsxNXAQnuF4cuq5+4Ldubm+CSdO0LoZDELr+evKYs+o2v9ck9
         cRtWBPl0P6fjVOYch8fdYvRQwEAajVtHNFq+iqfebP/y9uyBIPu8N7M2sITqGWFFyC33
         gmw8mgL2fquMtetqISH1/bNgI6CgeXE64e4FYD7r7yLG8MoNUygkxugsWkfnsdqcU5T3
         s2XA==
X-Gm-Message-State: AOAM533bKUwqGjh5i5UuOWKIqMuam0Q3JCYoHHnnRRUwv3R4c66RUSmb
        6FdwX02111B6QXmwUKb9wS4F2JAgB6V6ZC8oaRpB+Q==
X-Google-Smtp-Source: ABdhPJxw/ioRoR157XgseUrw3c7HP3415u2sCKveQYQIo5zuO0Szx6eTkqgdfeHqipoMc7JlvROjw072kWhrEWww0PA=
X-Received: by 2002:a92:c64f:: with SMTP id 15mr31217790ill.231.1639380882685;
 Sun, 12 Dec 2021 23:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20211108100608.22401-1-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20211108100608.22401-1-xiazhengqiao@huaqin.corp-partner.google.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 13 Dec 2021 15:34:16 +0800
Message-ID: <CAJMQK-jTRt7OSkfCEmUBvC=2_dDo8vRC0awjJ4Jc+rzHFRUqzg@mail.gmail.com>
Subject: Re: [RESEND] drm/panel: Add inx Himax8279d MIPI-DSI LCD panel driver
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 10:06 AM xiazhengqiao
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>
> Add STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
>
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested with a mt8183 katsu board [1] which uses this panel.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20211213072355.4079568-1-hsinyi@chromium.org/

> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-innolux-himax8279d.c  | 515 ++++++++++++++++++
>  3 files changed, 525 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-innolux-himax8279d.c
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 2cb8eba76af8..dcf04c32f6ae 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -167,6 +167,15 @@ config DRM_PANEL_INNOLUX_EJ030NA
>            320x480 3.0" panel as found in the RS97 V2.1, RG300(non-ips)
>            and LDK handheld gaming consoles.
>
<snip>
