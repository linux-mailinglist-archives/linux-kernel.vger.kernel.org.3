Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4C487EFC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiAGWf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiAGWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:35:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F836C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:35:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c71so15866577edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJrTOgh1BpphQDyMp+sJajflfyJjq+t21DzU6lHdSU4=;
        b=JkyBZUD07AqOXQSj7I8GTf0fX6mcjJjXqOyObGc+r3m34mdWfoNu30bMbljR9Pf7dV
         Rv+++kSM1kEVlTak5gMIG1j3/46RspfbXH/cRfXYojy9DkYhhY7ziVjkfsrnJJVtPz9Q
         wiWrQTg0l62jPRjn80WzmAKjOWXCeEcAM7NuVj3ZTf9J3pNCUE2di6ZL76uILIOQnoEi
         SuIHrUr/veOipm4qCcmDCwsRLKI2Axtz4OrRsFqCLy8OQ4KzHSutJLcviK/r65RKhUFP
         ljjO3ZN9MTKdupmsThe7THG2LJKq1SEJ5nK5a69Cb0o4g2dYwYQcACZ6XEvaBYEORkmt
         +HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJrTOgh1BpphQDyMp+sJajflfyJjq+t21DzU6lHdSU4=;
        b=Toc0/Mn3enXCf0umwffQpyJGqUM0Lc3Z3DkgbQKXgXZbBIqi4Lep2xPWpkeuC41gfE
         xTPLtrSXYbKz1DnGUbAgzI2zPiGy7Cq7Q9TsgCkHhlnbwDd/iouHBimSEylJ6r+NVObu
         WSIp1HaTi0hn3g4fFA6nVXa6fcLIh4kZJ3eQIVzOlKW3TT2qRX+uamZ3OmBiihITHSwm
         o6JiNxc6TIBM9t17SVFf2CycGFJPzqSGTR+9J4wRCzjBTsRAdKiXmSTOmzLCpvS8xpVE
         xuoAOxNL7BZ1loXyLDN2beh+dUrMHMy8kq4WmpTNjcNn+5J8f4ILK46FnFItYNPM94Qq
         xkpw==
X-Gm-Message-State: AOAM530zCphMXRPvTAo6uWBCXaGuNgAFviCofXndfNTeF9Lxlh31AHSC
        0u8ntg5UnvUw04ZSyK8hDPP+WNc2kkeNFcddRpA=
X-Google-Smtp-Source: ABdhPJwWWj41v92H/MlW5O+b/Fbpqer/i92MXxrWRNrU7ja6rVWwWcPO1NMu7xJe2swKrRQnVOjVtheSWsg41w0MMsk=
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr5504426ejk.649.1641594926899;
 Fri, 07 Jan 2022 14:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20220107145515.613009-1-narmstrong@baylibre.com> <20220107145515.613009-6-narmstrong@baylibre.com>
In-Reply-To: <20220107145515.613009-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 23:35:16 +0100
Message-ID: <CAFBinCCR4zftkvJWgX4T068BRsjVp9YhRbzgdBOR+tuMcGSZ3w@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/meson: add DSI encoder
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Jan 7, 2022 at 3:57 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

[...]
> +       writel_bits_relaxed(BIT(3), BIT(3), priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
see my comment on patch #3 from this series for BIT(3)


Best regards,
Martin
