Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97905487EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiAGWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiAGWJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:09:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3EDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:09:25 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m21so27428547edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+0ZpFdgBKihQctxGsR5tz5extrL8aulkQZU1Kn3azo=;
        b=K3ZcUyDM3Xy3mHkSHSdku4XVutFc0wBOgQ298XZZbl41dH+SV1Sl+YTDH+ZmccgVZW
         cB26EaTH8yMaFESd5M5Th5+qVyZ03IB4fQSqVTXj4FLapg+1CxRABeGIYtAffiZzQyMK
         TN6NxI2Wl/1dWBLuzo+NnsvN41LR1844VIEE1Vnp+MkzVERHGS7ipLxo5Ce7BF7I9oDH
         Oagxs56lCIYgtdwoccq9K1e76+ieIEVenbc7fWE234q4sDZg2ESsLw0w0IDga11NXeKy
         xKVTTYh85E1msdtQ7lZpf2gRI+jxrN0bsKxeXEJc5Q5ixbwnT68SELi4Js8kf2nNfcmG
         RI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+0ZpFdgBKihQctxGsR5tz5extrL8aulkQZU1Kn3azo=;
        b=Xpg9fYMx3QQEa2uzbgtE4CT/mUAJNQh545SJu0uWF9njfqcSnT7/CKsMPPRWZVZBwk
         a53grNRQe2ragPOenFQRLqKpltxRRGtBtFWW4+6FJmGFQYOyXamnfW/Y8602BgTl7TND
         l568Fe8G3mlMVlLYX2h3l2TVrmn0FW9yLIljNmpZtJqvwgTCDRw34F3lWM21nT9hce6Q
         968pmXCvHz/dEL44i9dMDM3xnGsWOMByitEIiuYo0ycBMW7JmDIU4frQQOXmeULcSRKn
         NoXXekwxqYnfuahXbG8sQfXjolQT++/ke6fuIbNA9fTmaU8Ao83kSirDfOj+hhpRcoqh
         pINA==
X-Gm-Message-State: AOAM531p/13MYdSfukoiEeWKciPnv5Ab2RhDwFjZPDzBJUOKqNa2MB8H
        N8GLhKT6LeBj4naR6KYYpt6Cbk37iY2JdvVNZBE=
X-Google-Smtp-Source: ABdhPJzeY83EKOGSCN9Dn8swluMDNbgvxPIXcBwiH7LpXk5Wf7DawvbKULi0rEQR33XhaAtyGEHq3NwqqLMBBhKLhMs=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr61116623edd.29.1641593363736;
 Fri, 07 Jan 2022 14:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20220107150512.614423-1-narmstrong@baylibre.com> <20220107150512.614423-3-narmstrong@baylibre.com>
In-Reply-To: <20220107150512.614423-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 23:09:13 +0100
Message-ID: <CAFBinCC9J_w9JM-TmrXp7SXT27V7Ze37wrxHZZQ1==N4y2-0dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Jan 7, 2022 at 4:06 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +#define HHI_MIPI_CNTL2 0x08
> +#define                HHI_MIPI_CNTL2_DIF_TX_CTL1      GENMASK(31, 16)
> +#define                HHI_MIPI_CNTL2_CH_EN            GENMASK(15, 11)
> +#define                HHI_MIPI_CNTL2_DIF_TX_CTL0      GENMASK(10, 0)
> +
> +#define DSI_LANE_0                             BIT(4)
> +#define DSI_LANE_1                             BIT(3)
> +#define DSI_LANE_CLK                           BIT(2)
> +#define DSI_LANE_2                             BIT(1)
> +#define DSI_LANE_3                             BIT(0)
At first I thought that these should be named
HHI_MIPI_CNTL2_DSI_LANE_0 (and similar).
But then I understood that they aren't bits directly in HHI_MIPI_CNTL2
but they belong to HHI_MIPI_CNTL2_CH_EN.
Have you considered naming them for example
HHI_MIPI_CNTL2_CH_EN_DSI_LANE_0 to make this more clear?

[...]
> +       if (IS_ERR(map)) {
> +               dev_err(dev,
> +                       "failed to get HHI regmap\n");
> +               return PTR_ERR(map);
I suggest using:
  return dev_err_probe(dev, PTR_ERR(map), "failed to get HHI regmap\n");
to simplify the code

[...]
> +       if (IS_ERR(priv->phy)) {
> +               ret = PTR_ERR(priv->phy);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to create PHY\n");
> +               return ret;
and similar here:
  return dev_err_probe(dev, PTR_ERR(priv->phy), "failed to create PHY\n");

[...]
> +static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
> +       {
> +               .compatible = "amlogic,g12a-mipi-dphy-analog",
> +       },
> +       { },
In the past I was suggested to use:
  { /* sentinel */ }
meaning: no trailing comma here so nobody can add entries after the
sentinel by accident.
I suggest doing the same here if you re-spin this series.


Thank you!
Martin
