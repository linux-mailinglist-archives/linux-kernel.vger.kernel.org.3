Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5B495716
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378214AbiATXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiATXrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:47:18 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351AEC061574;
        Thu, 20 Jan 2022 15:47:18 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s11so8871238ioe.12;
        Thu, 20 Jan 2022 15:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJ90QS3WDxbWZGV9qp2wlVMqrzH0lrdfE2wGoP5u0Ec=;
        b=mncFIlkJKwHf32Cf3QB4H8ZOzxzUldOzvB5Xw+5wR9lV2heldocaKVtPnw76OTSjL8
         O9tCOjEl0hIRdafi/u73dim+HkveLxxOZzZLiLrKf0YAyarqNt14bHHHoJhhG/HMDZqj
         9g0tfoe5p58l0jlXtAhkfwzchpY9qEOZD1z/KPfnA9MS+5soay5JnPq5uLiy1e1rI/GW
         HhHKsyJnNHPJEwE/0005tMZf+h1/hMI1mAMl8Jjpezr9COwprcDVmtcFXS0a19mDQkxo
         kObhif4hoAB7OqRGG+ltOkV17qWVz/4wKjFuL7K9cGUwehV93aafjeiCtsL6oaWK/Mvl
         z37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJ90QS3WDxbWZGV9qp2wlVMqrzH0lrdfE2wGoP5u0Ec=;
        b=lzIWnkdbUs/I8Wq9UP/6CvCVM5F5pHULekhbyXlpRYku7yM9bNUUj4EK1VFahSxxf4
         co5m+DwWakHQW30yx/RJ692ArM+SpAM4y/32xF5W/SkzSmx3M3NYCN24t8f1D7YNHmYM
         Dk6B+sQ99sjDfffEPe3BL6aix2w/HoQmS0wwn9+O8Q0ZrFbHGdbM2oBNte80/4jKHGTZ
         v0Sd42ccBijxwAnlM6Bq7azqA4vdhwy3AdB8LwQbWtuf9WHdrMhxqi5lLWcLXs/743Xs
         pthEGgwxY8ZUuDW/tOvACD0r1LbbNIZXe4KS3Pa+JjSyCwKdWQCNiyAhNfdZx7H66MM6
         ItMg==
X-Gm-Message-State: AOAM531sGQ3wv8U7yb1OHcAuGKSmPEPNSM8iqDKocHiC87ddTfNBnJda
        s417ucQ53Y4GxZJNYovNlNKK+w6AaJmUdIjKFgk4DMD9
X-Google-Smtp-Source: ABdhPJxyTylBPCP8VoEfAJE/3FcIiy5PFGQpykCerFhxt2xa+9tcCFNIKtizJYhzHKKzg/ZoKwuO+mqwkGSkP7CifZA=
X-Received: by 2002:a02:7a1b:: with SMTP id a27mr606745jac.186.1642722437494;
 Thu, 20 Jan 2022 15:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20220119023947.30628-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220119023947.30628-1-jiapeng.chong@linux.alibaba.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 21 Jan 2022 00:47:06 +0100
Message-ID: <CANiq72nVrJVPSfHTSWjXaoyHbnc0VtqM=z7mrJyA9fxVaW47Yg@mail.gmail.com>
Subject: Re: [PATCH] rust: Remove unused including <linux/version.h>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

On Wed, Jan 19, 2022 at 3:40 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Eliminate the follow versioncheck warning:
>
> ./rust/kernel/bindings_helper.h: 13 linux/version.h not needed.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thanks!

Cheers,
Miguel
