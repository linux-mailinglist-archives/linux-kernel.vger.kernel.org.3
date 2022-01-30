Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7C4A32EE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353612AbiA3AqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353603AbiA3AqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:46:22 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7EEC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:46:21 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id r65so29495764ybc.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CkGE9Ok32toHn0F3ILw6NYE0JtPX1pPXi5Uwmz6i/E=;
        b=CyU4byVCy2zP7rLS3aAb+Gpyn1UzN3hst7qvRNGEhOqDefWNCL04SQZesw4CRgRD6X
         61N2DWtykRl1OJJvVZz+5PAPGJ2iwEm1lN8xX/p6t6nkjymmfTMeX6rXjap2fzt9lUrq
         yUlnYyXckP7xumLSMnsyRUb1Xvd5xAa+8EW/KbxvzHYd5wLKqRDUo1Cm+TQfFSncxJRN
         Vu4kWqsXIpl10WECsTCRDAXQ+FEfWS+svoRk3x/RhBwMj/9nllXUIFFVj1FwC3n0w2JU
         uVb9ZQiLCUblH3S41y+XovOjQoS10o67rJpLngNbP7ht7F8sAMNPUYgX6S2W71vbOxRl
         T2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CkGE9Ok32toHn0F3ILw6NYE0JtPX1pPXi5Uwmz6i/E=;
        b=oTWDXaIqDM8Rnf8byAjRCiUGeliDTvgUIbJD18DjRQq8shxmSVr8R3cck9VUkE/E1w
         SB+RwdrO96D0yGLEyKD0BCHWLFxYlAmxB0T+lENB5N8TQ790QHB84q2Ab3rpPbTC8BpH
         8dNTKkAP3V3xupn9PNsJwFIucLi2fWbGoQJrLJc625T+E9ndJTbJPi7VuYCl/IZsJ8oL
         Xz36UxxoM1YDKnK3N3PNQ4QB+lFcSeFEmtlKGdb91aOWTVUDJjpCK6n3v40MZ7jLwDCp
         TEw1BvBXHwlZq4Ho0EEH82rOpeMvmgHkrDC79BXQFKMKZIs8N3b24ahmFCziec/6Wx8s
         cGdA==
X-Gm-Message-State: AOAM531uoG4KVhTct1v9uYk1lYs9iI2C9+HYTAnkne3GrpfMShYaGOi4
        Sg3wVHwvvXlNNEy/fi9zz148E2t6D0GgAud89uELsQ==
X-Google-Smtp-Source: ABdhPJxBBbvxiS1E9vs8QRFfJybGryxP5F1pejpBuS7PwfZtqKt4WfyDm6NBmgEeNSTPVT4THEVvoRYsy2lA+HhDHi0=
X-Received: by 2002:a25:2451:: with SMTP id k78mr20790628ybk.511.1643503580791;
 Sat, 29 Jan 2022 16:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com> <20220120150024.646714-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20220120150024.646714-3-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 01:46:09 +0100
Message-ID: <CACRpkdbnEKeDNmFCuUCLaySs6AtD9MPtxV+9JDxKuXvTs9iMVQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] dt-bindings: gpio: logicvc: Add a compatible with
 major version only
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 4:00 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> There are lots of different versions of the logicvc block and it
> makes little sense to list them all in compatibles since all versions
> with the same major are found to be register-compatible.

The reason we try to be precise is because sometime, long after the driver
has been merged and maintained for a few years, a bug is discovered
in a specific version of the silicon.

What happens is that a fix is applied on all silicon whether it is needed
or not.

If you have the precise silicon compatible, you can avoid this and target
only a specific version.

Yours,
Linus Walleij
