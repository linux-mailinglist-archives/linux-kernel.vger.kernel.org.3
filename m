Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D374A3AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbiA3WEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:04:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41456 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbiA3WEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:04:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997F760E73;
        Sun, 30 Jan 2022 22:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77A7C340F0;
        Sun, 30 Jan 2022 22:04:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KdkceY+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643580269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
        b=KdkceY+ABohtajtYs+mgka9CtODbV6UuC/F9HtPSST63Q/sUO97KXi2Nv162UVV2cBdsMB
        uRJHsSU6KoZGnh2vkeJrnM/46uE2j7Fbc2yACbPf+1D1rF5XwA/4MrPXRoqlvAwG8UI/Ck
        D0VnfhPB4NR3zeCMI6tMoiYr5YkHvj0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3d3d37b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 30 Jan 2022 22:04:29 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id w81so12636280ybg.12;
        Sun, 30 Jan 2022 14:04:29 -0800 (PST)
X-Gm-Message-State: AOAM533jfB/vCUF6cJXCqhOCyBReY4GcSLVaG8nRhjmUTFiRQCkL/76g
        pX9IZ4GyDCQ2iwYhSLVzN9QkrRW6E7OMs8SyDiw=
X-Google-Smtp-Source: ABdhPJwRjsAm0oH5Fpb+F7bxZFdXUW/6DZ820FxIiN8k7wHR4CdIg9JNYtJdJVIQtnCoPWnzxKcOTRNCNrrUXtUKCok=
X-Received: by 2002:a25:bd08:: with SMTP id f8mr18668269ybk.121.1643580268518;
 Sun, 30 Jan 2022 14:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20220130210320.3997-1-linux@dominikbrodowski.net>
In-Reply-To: <20220130210320.3997-1-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 30 Jan 2022 23:04:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9pkg0AJPSv4=LhvJhbP3ifoO9RDxT7G5SGmbwurU2AdAA@mail.gmail.com>
Message-ID: <CAHmME9pkg0AJPSv4=LhvJhbP3ifoO9RDxT7G5SGmbwurU2AdAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] random: access primary_pool directly rather than
 through pointer
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.
