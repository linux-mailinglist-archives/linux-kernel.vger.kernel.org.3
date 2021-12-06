Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4646AA89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351944AbhLFViP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbhLFViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:38:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E74C061746;
        Mon,  6 Dec 2021 13:34:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so48636827edx.2;
        Mon, 06 Dec 2021 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quIKySIUpr5MTJfpnarHC6Utt3+7Kapj52Q68fqD7/c=;
        b=RcG0NpN/CiGr6OfnnUTL7idQLJ4zDE6Vh6ZzmoVGdQ0VISX0i/Mnpa8FVE9p7jYqDF
         CEhjqGX5EdNwxzPT4HXdLGZAhAEDyVs7l6gMHigwRzQBU03QxVUAaYJ0vIn4d+ED5fLo
         9iX5JN2N7eCSK652vAV9ynOYdBGY85GqZGwQO8WTD8JCrgna4E9a1AYryFJjqt6RWvKP
         KxctAxHgfBXHzI/1Ycp4WnalCxt4sG7YzJl3FfNYZndIJrEc+ZQmtrlyx8gZw8Lzc1H8
         jXDlGLZhoZCLKW27JPI/bPkmIylXbSiht4PDhjW4ToHlHKTJ0inXBnIYPoV2HdWOX3ie
         femw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quIKySIUpr5MTJfpnarHC6Utt3+7Kapj52Q68fqD7/c=;
        b=Y/WWlxVhgimv7ymLfHp4nvkovweh+bOLCljjfPeH8GlhFVJJ7Y2MciBe8UnduMg6XA
         UvA5+W5wjQmTGLpuNeBM0bgawI5UnmqnbjtmXaR9PXC7O8EtA1rbvD6VpQYx2XxweiaY
         zVIO/Ikda6ESZX/1R1Lcqi0ff+Gx+EaHQ+wVIagksG+x2cUZqdbhHP3DPvJN3X1xvFl8
         l5CuqLjdkBg4hYXwqeEXxtWym2R/CrwlW81NHzbDVWCFmrxMeMLo2TJegPO/uR3yP5DQ
         2grx6Rz+EEMAIvV4N4trQl4VH1yNqAxWRznjqN5VkSMI6u3kygwBbkoixZ7OdCP8z03H
         ks2g==
X-Gm-Message-State: AOAM533490VZjlgPShG+zLsvRIapJm9/yzWwSXlXlKCB5jKfwQ7/Hk6D
        GX/IKAT30hYxmnHimcIjY8S/99K6vUpzCd8mWnq7ufzePhg=
X-Google-Smtp-Source: ABdhPJxKk5osnLLPa52HV3kvZMqV602+8tKH5puSMUMGuE3sqVSWJLfZFzzabDosBRZ+x/7gc1KN1GjOwLmcYYHtOy4=
X-Received: by 2002:a17:906:37d2:: with SMTP id o18mr48850450ejc.278.1638826483479;
 Mon, 06 Dec 2021 13:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20211130060523.19161-1-christianshewitt@gmail.com> <20211130060523.19161-2-christianshewitt@gmail.com>
In-Reply-To: <20211130060523.19161-2-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:34:32 +0100
Message-ID: <CAFBinCAkz2f7480+qnicM9Bm5r58_+=V4a_BvRduORRvyHS89A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] arm64: dts: meson: add common SM1 ac2xx dtsi
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benoit Masson <yahoo@perenite.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:06 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Add a common dtsi for Android STB devices based on the Amlogic S905X3
> (AC213/AC214) and S905D3 (AC201/AC202) reference designs. The dtsi is
> loosely based on the existing SEI610 device-tree.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
X96-Air with Gbit/s PHY
