Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194C947D093
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbhLVLNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:13:47 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44790 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhLVLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:13:45 -0500
Received: by mail-pg1-f174.google.com with SMTP id m15so1814705pgu.11;
        Wed, 22 Dec 2021 03:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MayrR7jtX6JmkeNEDTiX1Xp+TllGgyjNTqfAHwHPy4Q=;
        b=r9e3eQALK+sSddTlXDakqyBCedIxwdX3QaMIHBA0smmBmwcxJXnJG1NR8j9mHFa5Cv
         RFuoqn00wh/Ge0jBsuAPXkHyGegwVH1eZlJYT7dZF2HI+bT6K3uh+RIH/juYOkKsGcK1
         qbE6I3tYN+7A4z3XZiH/uBsYk+1NzE0jaBz562XYlH5QNCU4KVgEe56AzqVudSh9f6HZ
         jrzFtzm27K8RdKDFXgC/f+/VRHPjmXLAq6TOwX1/lKmoAzfHAFRP6WmZOVJiggoQQz5t
         OjdKA72etrwg90vW1uo06VrjpvP0TPqPntve4rjdKaWoiutkOgPLRs4Q+VUHXOt9p8uw
         Qw9g==
X-Gm-Message-State: AOAM5339QlTwMzserurkcNT+7D1EQTVpBjuFnEsJw9aW+eb1j6hGfVfL
        fDxFaUgt96JyybU5xIxj2c0B06lKyACgb/MIBGQoMX/b8cg=
X-Google-Smtp-Source: ABdhPJyXYwsdfxhLucQ4hWzGDnDGRr+SyXK94J6IwS5vxKYPM4jFCZGsyxVKLeUofAJK4skD+GwXYP/p+gRwJiyjfgI=
X-Received: by 2002:a63:f30e:: with SMTP id l14mr2307011pgh.519.1640171624596;
 Wed, 22 Dec 2021 03:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20211222073522.123656-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20211222073522.123656-1-yang.lee@linux.alibaba.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 22 Dec 2021 12:13:33 +0100
Message-ID: <CANBLGcz=B6RqjEi8GvSRETn9QhQYO4za_3XywbbScPs0r9hpyg@mail.gmail.com>
Subject: Re: [PATCH SoC-next] pinctrl: starfive: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 at 08:35, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/pinctrl/pinctrl-starfive.c:1026:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>

Thanks!
/Emil
