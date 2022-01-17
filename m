Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0F490309
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiAQHow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiAQHou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:44:50 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6735BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:44:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu18so31276670lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QF777/sKyHmB6kHdk8pAKes+SVv1gG+ocuwj9sgpRQ=;
        b=KOLLcV/F7XHmTeu4hItqu7+3uEtWlS6N+dsCP614S1MOSzmMSxoYjGpur5i1Y0f5of
         6R0ZuL1Gz5Mg1jiAkXKtDUZCFLosWZiLjo9xhfp6ovoAfvs4Cl/WPuvWvhJW5K/UOhW4
         ++Fvm3jtJK8eWY40Gfmu6WzYuye6hLY8yTocY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QF777/sKyHmB6kHdk8pAKes+SVv1gG+ocuwj9sgpRQ=;
        b=JQjpenZPX3Nmc8AFjmNtA/0PQXU80wEP102h/BCDEVdIVDapT+TfX5TzMKO+t8e9HK
         VpFL+/C77sAh40RcYMSt+bmI71UJqqKT1R8IlkuyzRcyc2lIu96l3ajoq3F7YZ3APKV1
         Aiewe2RzPLYIs445Gr+YEY75cVDGn2ZjaR9bIA8HsaMCddoi8oHqEw+cfNHVWmakhRDr
         K2sX9oi+K9vpRzaBAny4/a0H6KNlZI5LKQSnZWvYeHH355UnLcDYN5IVAJopmySklxes
         DP1z+tk9F8UW4811HPdv8oQtkmAzYzt3BuQ1NgKCRFOH5Sk4/r6wEjuSyTf0oZuGQYMO
         XhPw==
X-Gm-Message-State: AOAM533sLvdGcyjVlAyK9RVW59eTk+nd48n+1i4PAKOEjmtkIJKsBElJ
        3gOgUzBnawgjmS2bDZlmaKTmL+wI8LMTY2msUXfUEK/9N+w=
X-Google-Smtp-Source: ABdhPJy2y5w2Mgw1aXOAzh5xS6yKz737iKCVZw+kmTNKVPku08/RsSvDn73bBL7Kehh87ZNxsL8F9iFaH25KR8AyLpk=
X-Received: by 2002:a2e:b8d5:: with SMTP id s21mr3530683ljp.201.1642405488740;
 Sun, 16 Jan 2022 23:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20220114230209.4091727-1-briannorris@chromium.org> <20220114150129.v2.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid>
In-Reply-To: <20220114150129.v2.1.I46f64b00508d9dff34abe1c3e8d2defdab4ea1e5@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 17 Jan 2022 15:44:37 +0800
Message-ID: <CAGXv+5H0-dM28YQj_orS1_14NLcJve8VtO6oLcBiRpJFjaf5KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: Switch RK3399-Gru DP to
 SPDIF output
To:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Commit b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> switched the platform to SPDIF, but we didn't fix up the device tree.
>
> Drop the pinctrl settings, because the 'spdif_bus' pins are either:
>  * unused (on kevin, bob), so the settings is ~harmless
>  * used by a different function (on scarlet), which causes probe
>    failures (!!)

I suppose that means the default pinctrl should be dropped? Or maybe this
use case is the outlier. Up to Heiko?

> Fixes: b18c6c3c7768 ("ASoC: rockchip: cdn-dp sound output use spdif")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
