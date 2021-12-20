Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83D47B512
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhLTVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhLTVU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:20:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:20:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y22so43797785edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG8LZjz52Sv3bsHubNvrikDmWB0tVzADFuwGdiqWvyo=;
        b=22WHJSlCMTrpOAICG5PI5lyOLWmzi0uGmUfYBn7sj6sp5gibXCbtCafklaYzH9+GqJ
         BH6TCQQSA7Fg4Clbdh+OmySsPyvtNAJvIMvklJwL3jLVqzX5iBjt5M/N0q64UDbDf+5F
         /TS6OA1Oh/JhRFKXmFhFgJ7cXvXcrzA4ix5iR6pA+yW6GRC7+rt2hGmM3JYE+og0l3Qh
         8jLmgbF5vekjC+rfKccTwd6CiO3rRiYjJEowrHH+GZNwzq29rCawHfsRl+F1OWppZQ4w
         5jagWh0qPOWP0kBf8t9/UxXa8cp1pOxLYelCwpvOpprQU9nDUVJNVbJ6LkX4rnkhbg1H
         rPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG8LZjz52Sv3bsHubNvrikDmWB0tVzADFuwGdiqWvyo=;
        b=H/lQCIRT4daZnMvo/AvzV2+KUJ1gQVwPgEWiTgvi6WmXn0rFWErnoLZCdsI/EU+Qpr
         BcgBADJ/dAbaqQG65IVsAieyZdaqCuxIAgaguNIhUx3mL44ChhYdP0sHYn57ywEnb96J
         ZlGZWLdiXKrYRQ9lQp3MGBCg+exnJ439dMQs2xx/KLej9oNqFXl18imvAuUYjWUdud4k
         A8avYPFdlLFREgHnhIRyrHp4nlWolpCDC+pvvtGZBl500HxpJKHaDj91Zsq3hwKgW/Dc
         sja/EjDhR7CG9kDhWMdM7i75SpdsK0SwtIYWi7o6J06zf3G1MC8MCLCboJN1eDgy8O5O
         uOCA==
X-Gm-Message-State: AOAM533HjTeFoB/P48bTefiGhfhghL+VLGU9OA43j9AeX4App/RHEKHl
        4FWznqGlAKw0MAOP0yaNX+j/kT/OPuBlhRI4VK6Q
X-Google-Smtp-Source: ABdhPJxzBK00qdQqBlLshB1f8MtmoklomCDL2RS0BNvCZuGS/NNrdOTim0zxPybOFYWJlZNuUidGfMSIyMJptGcecn8=
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr42794ejc.29.1640035227186;
 Mon, 20 Dec 2021 13:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20211217010152.61796-1-xiujianfeng@huawei.com> <20211217010152.61796-2-xiujianfeng@huawei.com>
In-Reply-To: <20211217010152.61796-2-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Dec 2021 16:20:16 -0500
Message-ID: <CAHC9VhRP_6XcAkuAv92uPaPuxO4TgSnXe_+o=q3uvni9kEndmA@mail.gmail.com>
Subject: Re: [PATCH -next, v3 2/2] audit: replace zero-length array with
 flexible-array member
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     eparis@redhat.com, gustavoars@kernel.org, keescook@chromium.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 8:01 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Zero-length arrays are deprecated and should be replaced with
> flexible-array members.
>
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  include/uapi/linux/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It doesn't look like this shouldn't impact the UAPI so I've also
merged into audit/next, thanks!

-- 
paul moore
www.paul-moore.com
