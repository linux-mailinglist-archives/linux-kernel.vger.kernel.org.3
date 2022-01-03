Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060924830EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiACMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiACMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:16:59 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D962C061761;
        Mon,  3 Jan 2022 04:16:59 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id w184so78686072ybg.5;
        Mon, 03 Jan 2022 04:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lOyYQI0CIiGDaIpaEWbuQqbHJxkreGLXN8QH7/z8oI4=;
        b=avHPEGVXj896OQFF1OF8lCa7weuU688Bgnpm0I6pbYz1jMhNj2SDgNGAGsxgYOWx+c
         cpbaI+2zQm4NH4mEZp8vasOY2vT9Edc/3q82TLFpkKZxWA6McTVyivhnhlomW0gSZETH
         c/VZWKq2H5c5gEIo3cKElPBM179+Pq/ivqeFhTjEWKBR0QYsdk7PtUcXqxxNdFLl5fbe
         HC4xM3B/D6RSOJfP0r5Ky1dVi9E3oOY90BuvcNe59iqbvkxBcD7yKYZ0LNk6Km+UUyd+
         JmUg+t8XZi1bG73eHLaBasdU9dgEVq0npwkZbvcXTc2AdFM5khqDAru/yuHfS9FXsEWD
         GKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lOyYQI0CIiGDaIpaEWbuQqbHJxkreGLXN8QH7/z8oI4=;
        b=7wVPrrvd5szd1JakcGc4VoMRah4kWZUtIcJ9jfOaSn5twf9qRI7Jol9QVQHLS5Bdmy
         XoidvXEw9+iK1ULrwFx0aVTVpZJh+eZUphaSbuDfR1Uqkc9yU43tQvAYcCJxwfvGv+Lr
         TeZB7YWxjzCt2fbSeQNlugO+yXvzqLr9yu019yuoSiUlbIOeTo9lIvNwIvDUblv3XHCF
         MwSHlCj9AKc+9DiMS28c6OE4hC6WLysCndh+YeeUH6MHT5lcgaQD95ESnYAHwphAHpB3
         SuIKa0DnfJRzvQvX5D3u2Uh14Mt4QKfSrMGEWbGsr/DDZFShBTNH/+KFMhpUEorHhLla
         uVSQ==
X-Gm-Message-State: AOAM531lXjC1UZlfiMz1Q6Tz0EAVriWKCI10+1ZJthHAnWigFB8ZimpM
        jIkY1h9K+L8g+dkXuJeA3KXnn/VzP/Y9328mVxdzd1XJppg=
X-Google-Smtp-Source: ABdhPJzFJ/ln50kOs0GKYcEn5ilkqzXWpFA5l2H5i2IT85AlUaFrXYtyGnGh00nCHkufXifTTHJwPUUlwvvkP5I6cis=
X-Received: by 2002:a25:3454:: with SMTP id b81mr41515482yba.723.1641212218511;
 Mon, 03 Jan 2022 04:16:58 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 3 Jan 2022 13:16:48 +0100
Message-ID: <CAKXUXMwcPLAAviuotom39+9m3upZvir-az=_-ZxU0eOu8OPxWA@mail.gmail.com>
Subject: Reference to non-existing config COMET_EARLY_UART_DEBUG
To:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Brian,

In arch/hexagon/kernel/vm_init_segtable.S, an ifdef refers to
CONFIG_COMET_EARLY_UART_DEBUG, but this config is never defined in the
Kconfig files.

Can we delete this dead code in
arch/hexagon/kernel/vm_init_segtable.S? If so, I will send a patch for
that.

Best regards,

Lukas
