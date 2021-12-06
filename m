Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1946A97F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350584AbhLFVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350652AbhLFVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:17:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D18C0613F8;
        Mon,  6 Dec 2021 13:14:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so48387950edc.6;
        Mon, 06 Dec 2021 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Co9V75bhJjlnXQzibNJsjv/WAUqDKbvzqNnHzf1Eeho=;
        b=KHY8xjlSX0x30xhsYg/MqcjRFjhPPJmTS8WAR2Q+W7zdCC7Xj1d2LLz74MYGiY4tiE
         qK7jOzS/B4Irfg55ixv6DFNZKWnrM0lVOLoUSd8wOCoRuFbUsoIH4nz6tdjgWWBuTeV5
         UpoGxAQ+j5+H8x0HIiGjA/zr1HiWQlD9Ji3W6pcZMzY5gNe2my0mBt+C2wYOrYCvYVhM
         /MY8+SCbRkh/7hHNbiTxVa3NoAk0yrR5ZKY7jnJfacaCpaCg97hyqOxyyBQJGOeUG+sG
         CzXTfdjRqqz84qtkFmmtsBTKRa9rt1y3lawvuwCmQy9HqVMnwOByJqQ54lqJS/c8X7Fm
         HIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Co9V75bhJjlnXQzibNJsjv/WAUqDKbvzqNnHzf1Eeho=;
        b=5LxRvbW+Scj+keEPfwyWdpdRc2Er78dYARkl98paW+l7LhNkdhe2ntPeaRSywRKY5b
         ip2cg/8vXexiel2KD0wVDBK1SomgysXstNwP/aElu1sJXRmwrBnlGEvCgLnZKSwNyc/c
         a87yuQ/u4ofr/pr9rQ6XP3WmSaqapwF4ya3R2hLmVLHE2lvBOrzoO1T60InRojbpDTPw
         Zlj1hP1ei3UIzFXyTC85f3iTXHV80I2RlShUso+lFeDhwxZRW7uxmVJOJrypT9/srj3A
         M64kR1gfWW3GJW2AnBHf/xKH14zM9O26Z3wi5rdOcmbDTvQwdy/26uwcohLjroPqERhn
         Lxtg==
X-Gm-Message-State: AOAM5313Q2qDBo1V0gCPD22AqQvwsvlbpXR4NxoL1HJGsWl42vEeOexT
        FPUd3aOaIjMq//qhFaWTRv7isBr+suuBWyV+m44=
X-Google-Smtp-Source: ABdhPJze26tcSbr/g8nCxQAhS+VDeJWJ5k4fF+PXDNELrqFtXe89/FZeJqgXCDLPHtSW8Q6sRxuv4ZKr24poy2z6AgA=
X-Received: by 2002:a17:907:6e8e:: with SMTP id sh14mr47367635ejc.536.1638825254184;
 Mon, 06 Dec 2021 13:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20211205215846.153703-1-aouledameur@baylibre.com> <20211205215846.153703-3-aouledameur@baylibre.com>
In-Reply-To: <20211205215846.153703-3-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:14:03 +0100
Message-ID: <CAFBinCA8EFHhUnuPQnMKgE5JLF3fYD34Q7DOg_SP7qSkNrdOyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] phy: amlogic: meson8b-usb2: Use dev_err_probe()
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 10:58 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use the existing dev_err_probe() helper instead of open-coding the same
> operation.
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks for taking care of this!
