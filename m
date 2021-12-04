Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF84684E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384960AbhLDMxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhLDMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:53:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692CC061751;
        Sat,  4 Dec 2021 04:49:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so22876743edx.2;
        Sat, 04 Dec 2021 04:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ri2HwsI51qtq6+Fe4jioYyU67KqbswxWX+W8Sq5ZfPg=;
        b=nmN8C2qwv8sopXGM2NESC68z920cnGQaaK7euFz5I0mv7Z4eymzGAnMMYS7y2Vc6x1
         r+opdh9Xs/txuegU1ymO9/CNE7A6m2JKINrKG7hhHpoV3H9+u++GLIdv6KoKHFqgCQ6N
         VvGdi+mJ5XlqIGuaLznalkCuMSkNQOhDLRp29TWbhz2MHnb3ilr+dG5W6hsnIGkTUbNo
         pdXD1AZgAu6U3CHSg3a7zs2vBptuUEln00jc2u2S3p26aDdOjgtsNbI4qQnivv3W0dPE
         kfvNBr/hiqWFomY/Yc+GabtpQvPqli7FWZ1djMpb3tH2BY22qTgWFrOWW1P6jro7t+J9
         oDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ri2HwsI51qtq6+Fe4jioYyU67KqbswxWX+W8Sq5ZfPg=;
        b=hFYePciHIJWigPjf/1GroHyXQmB5iNGK4z1f63lzsdPgQ5TtIzBSoQIxd1AxP1E650
         4ETaXuej6wnqGrH8K/vd1tMRxbWGjx5BBRRMtyn70spjyWUWCPo/g3cTJaZe17wVP905
         Oy+X+aUqD33rU/1wPpGithDI+YPRBzgp7wrsoIzJywbSpjDpsYJOfqbzWTkc5RVS3vhr
         95V9ug7J6WKyRf2RkKbGMCGJ14P4S3c9ku8fcjbGk0HEZQn9Yd2J/CyrqmQLGDJtXd8V
         l9ko7pGQuSgAI4s0PgIa/emAONEjxz/L9/1pR8UY77RiH0WlVAjlTM3+Rl478KDYQqT/
         cPPw==
X-Gm-Message-State: AOAM530epMLUlxOnFFiHPoxh+VOYEywDG8w0O1M4qpIxcoluNTw9MY8I
        vyZpTgMkjGLyaMLbiadGQL0gX01YpvwkF7SHYgU=
X-Google-Smtp-Source: ABdhPJyqwar6S1h71dumSeDPhYFXfSb9otkfF9hnTtHzrA3dAm+mZLUSN3TJ26mw6PHr+v+tlzTHO9JkxZIsqumbvAo=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr29647424ejc.356.1638622194529;
 Sat, 04 Dec 2021 04:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20211204030452.1482507-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211204030452.1482507-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Dec 2021 14:49:18 +0200
Message-ID: <CAHp75VccS43XVophOW=+5=A4p4cUiwvXdwGp-yU+BNDN3cOu3g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Assume 0 by default for PNP UID
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andy@kernel.org" <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 4, 2021, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> There's an EHL board that the DSDT doesn't have _UID for pinctrl device,
> and that causes a NULL pointer dereference in strcmp().
>
> So in the absence of _UID, assume it's 0 by default to avoid the issue
> and get a pinmap.

Do you have updated firmware?


-- 
With Best Regards,
Andy Shevchenko
