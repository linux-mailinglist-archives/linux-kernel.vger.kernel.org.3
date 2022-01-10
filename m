Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBA4895D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbiAJJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbiAJJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:57:11 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E6C06175B;
        Mon, 10 Jan 2022 01:57:09 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g80so36618724ybf.0;
        Mon, 10 Jan 2022 01:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d84IyUOyurvFvSv5LzCsSavV50bnV4A3aqd5IY6z158=;
        b=n1Jwkx5Mf+1c/hDk5wx8AYKZgxTS6CYqlAM7OC1v31FwzX531Hlcs9476ZzHKmdlZU
         k4e5Y91Uk//wMKAsqYLASYVHz6P71GAwTYUl35aE1cCQzd5cHZA+JohWXsbDX9ZFKiUe
         irXq+j+Qr+7pFmbqsPAxPOLJLAq9NseoTbJJmQZpVd3Wi6s60d0yq6QQVvEBuj4pFZzt
         9JNOAN/OgBw40Yit0zzmGq+z+fIdS31USLtnG8qbBrjeV6EoGzBfc++t6ilg7qL/JenG
         obEFoTkA2+Y7VoKRC+a/K97LLWWanngUgJt7iT7I4jkCQsX/HawrhzZ2QBgTy627Haw2
         F8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d84IyUOyurvFvSv5LzCsSavV50bnV4A3aqd5IY6z158=;
        b=6/nVe41EhxIabXyOZi4QmteV28PyMT70Uy9zK6lLBJclHOek38l+Gc7ND4mo4fMbU7
         mc1g1cS7Vr+fZlOG15col8PPzqZDu3cKVV/n0K9WKUL1F8whKJZXxPWb9NnzQcQJ1HYP
         NeUGIX9QCUSohSE30iKdasgj3nAAK6iXKrPwVqc3TQtzBO/SDs5aOJ073u2YLRuQDqBe
         X/SaMO8WuGVkUOwQQwSUzj38njZOfStE5aaMdfdwFOEFgXB662aOs8u3aP2S8TTr1nwI
         vIQCJ2yAA7/rQixJMJJ8ukWm+AAuEEF0tW8oQjJ6LddRG0unQQDwNRZvz293+3jpbipr
         MvUA==
X-Gm-Message-State: AOAM533oORwwN3XcuyIrsw7ep7lJGRkkJzHdg5H2tCYX+m6lgFp3NSx5
        6dAY/Ja55qU2RVX8WpxhijgmDWl2K6WB7Q1eKMA=
X-Google-Smtp-Source: ABdhPJwVwWhfyHOvXBVycLJMUGG08bR7R08yhc/BPFfD/PcUUlXSuZShmbXi6vZjjPs/eKeTTdwAOc72VwRW/Jizwy0=
X-Received: by 2002:a25:d44:: with SMTP id 65mr83645207ybn.510.1641808628617;
 Mon, 10 Jan 2022 01:57:08 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 10 Jan 2022 10:56:58 +0100
Message-ID: <CAKXUXMy8ywQXqqmOvvm9wKL_ikixRJOFgCcgu4OdPUPhjq6MhA@mail.gmail.com>
Subject: GPL-1.0-licensed code for files drivers/clk/mediatek/clk-mt7986*
 included with commit ec97d23c8e22 ("clk: mediatek: add mt7986 clock support")
To:     Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sam,


Thanks for contributing the mt7986 clock support to the kernel
repository with commit ec97d23c8e22 ("clk: mediatek: add mt7986 clock
support").

You have marked the files below with the GPL-1.0 License, which
./scripts/spdxcheck.py identifies and warns about:

drivers/clk/mediatek/clk-mt7986-apmixed.c: 1:28 Invalid License ID: GPL-1.0
drivers/clk/mediatek/clk-mt7986-infracfg.c: 1:28 Invalid License ID: GPL-1.0
drivers/clk/mediatek/clk-mt7986-topckgen.c: 1:28 Invalid License ID: GPL-1.0

The kernel's licensing rules are described here:

https://www.kernel.org/doc/html/latest/process/license-rules.html#kernel-licensing

The GPL-1.0 is a deprecated license in the kernel repository.

Driver code that is licensed with GPL-1.0 might not be compatible with
GPL-2.0. I am not a lawyer, and we probably do not want to require all
users of your driver code to needlessly involve a lawyer to get such a
statement on license compatibility.

Do you really intend to license this code under GPL-1.0 and are you
aware of all the consequences for other developers and users? Or is
this a mistake and you intend to license it under the kernel's
standard GPL-2.0 license?


Best regards,

Lukas
