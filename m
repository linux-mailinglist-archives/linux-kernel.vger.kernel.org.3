Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55A475041
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhLOBE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbhLOBEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:04:08 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C40C07E5C4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:02:55 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id be32so29482636oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw6bN6d4TEpZ4w8TTcuB+Vquo3dAMeEaia/fJgaxXHs=;
        b=SACGvHfj5YdxBygMuhuGG+TiirG1OgYendw09HPlxdJBYSZtfYEj+mqWeJb0iunRuA
         QfIrvHdKjVwAYWnM9T9wOc409ulqh6XeAgE6qfUdYFVBSW+t0KISMR17JY8NzngiK6B0
         f427tIdUCy0F04lppByT6bj7C8BX39k3rlzSYFj337Sbusq70XyqPRdzcV5ndUdhcxLU
         QlbTETEsMrXSOEPVK8+BnNKnjjpcGAPfGZqx5oyThCJOLL07DQR617qX8po3pP7YEZqG
         yan2StqmxmjQkTwtEU93K4rs28Bznd8yZ8e2IoGyN/z/F9DBtJ3FuIUHGaQO/lmuAUte
         nPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw6bN6d4TEpZ4w8TTcuB+Vquo3dAMeEaia/fJgaxXHs=;
        b=irZLrGsBsqEpCA8ew8cjidjlYD6q2ndEmmY5513/0b1TyfUew8sPrLvwsubeHemRjI
         LUpLqzZS6NC3xa5fHfYvSKf0Mk0M2yegR+w6y6HkeT3jAgubNB6V4ZIMHiG2xfwuIeO/
         USpYzM8zttxXYPjfndDoVfXk+a71EnC1FO3HbcWk9L7x52oOK3hzpF/g0ZTRgiPWRlM+
         bzciC0Jlm3wZ/CdHktw6WPVUW4zfPVI2hoq/82UZ2rFpavOV7Bc9JZxSF5ORc8pBsa8E
         9h9LA0n1xKA6qRQ73HXxMokep6TNr+0I3ydOdR0AX8svk6Jh/Ll4vgJfcohqCk3TGOGy
         HJnA==
X-Gm-Message-State: AOAM531S6DizWBEvUSnFnEmylk5EUwJ1ijPiDOKgQ98Dd0BIZAhUcLtZ
        COs/pDb88rDI5ExN/hZnEQAYGuhEC0yP4+HD3lY1FeZhp5U=
X-Google-Smtp-Source: ABdhPJzOAvpi3w1v48JflBnBVLjgIFqMwloypvvyPKwd3U/6VNHLw2B2yHodWXAdIWQxrvvexiygjlv+LBDb09azMPI=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr6839185oih.162.1639530174761;
 Tue, 14 Dec 2021 17:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20211215010008.2545520-1-javierm@redhat.com> <20211215010008.2545520-22-javierm@redhat.com>
In-Reply-To: <20211215010008.2545520-22-javierm@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Dec 2021 02:02:43 +0100
Message-ID: <CACRpkdaFvQOSZmo4t7uTGo8m2yKDS4_h0-CpKW5KSFv=WDcWtQ@mail.gmail.com>
Subject: Re: [PATCH 21/60] drm/mcde: Add support for the nomodeset kernel parameter
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 2:01 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:

> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
>
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the systewm system framebuffer will be available if it was set-up.
>
> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
