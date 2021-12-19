Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7E247A2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 00:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhLSXMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 18:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhLSXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 18:12:20 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FA2C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 15:12:20 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bf8so13218554oib.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 15:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+fitUhnopQFJlSmWEit/8ewNmmVdw9mIHee406vaxc=;
        b=V5GYThmgzC4Ae64KEcxIC8RlauvEJH6/3jZhB6A7HH8fcnDw1pIxlkC+gAceo0fr/Z
         SxbSAt1GgqdgQJTF2UHkiOR8fpibf9djGpgandxiJS9JpYoc9xw6ZbNwuahR2MkVmbxT
         Ixqiaf+Z/BWDCpUXWhs3f/dEKv+Fakh+Vyfby+QYTGGYzpGFyAaQPDPNlQ23WI5SpwOg
         muIFti0G6WffPMk/8ArfTz1H+/aUzmLJ7w29qj6U50pWsFGLaw1LWpTOe956NRL7fICq
         dn9fDHNHXpUvdxFpcFThURzFRBXnrw54gLd4wrSjCuFUOzyGW0BjOIg5fMbSTAcEWJqA
         o9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+fitUhnopQFJlSmWEit/8ewNmmVdw9mIHee406vaxc=;
        b=BZZobe9Iu990q/8TokvK3t07XeKG0jEJ/xAl1tNRPj4hv4YLsy+dp8/Xp6G71uAS+K
         Nqgizwg2fWibnJxDof8nVWA1B1f8SyQibDJbXwSpeZBP3oPpetBLUyz4ybUnPogN6UBz
         Y22ZE9+DFaIB61FeYRWPpuv4v5VxAfoMI6KgY1XEyxAI6W3RMKMc4YlS5V7tNUqt9gcR
         rrqG8iQpDHSHtH9GWC754wt2DuzLTiteyyfPy5JUzR/X1vtSkJEq7W6nK0vhh1YMeGzs
         venpSz7an8tt9nLdNojXIxp/KPUrE2SCBjDkGWhQV4xZSHhQMs3EjFxrDXOc86NXv+EE
         2eGA==
X-Gm-Message-State: AOAM532wpThQ+lr0DwO79YQDK/MTxzYPoMlBdbr3cxeLpNTcXmHWN6gV
        TX8gnhhXY7mRQ8MVbYpb7C/JJb6LLvBwDQScI9WmgdEd7I4=
X-Google-Smtp-Source: ABdhPJzViiZ3xuGjyJBQ4tb4QFHx+cBq4f3roEVtZ9ytkBtrhOCQK5RiawS318NDT/imvycu2I3EerJP3ce31XMeQWc=
X-Received: by 2002:a54:4791:: with SMTP id o17mr10432122oic.114.1639955539779;
 Sun, 19 Dec 2021 15:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20211218144927.GA6388@standask-GA-A55M-S2HP>
In-Reply-To: <20211218144927.GA6388@standask-GA-A55M-S2HP>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Dec 2021 00:12:08 +0100
Message-ID: <CACRpkdbceLrbrORrJKxYh-1n-7xOpgqn2YPA237NBFWe1-iSkw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: ux500: Document missing compatibles
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 3:49 PM Stanislav Jakubek
<stano.jakubek@gmail.com> wrote:

> These compatibles are used in Ux500 device trees, but were not documented so
> far. Add them to the schema to document them.
>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
if Rob wants to pick this up for v5.17.

Also queued this in my Ux500 tree so I don't lose
track of it.

Yours,
Linus Walleij
