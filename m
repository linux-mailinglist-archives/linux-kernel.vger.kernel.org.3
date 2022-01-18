Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF88491363
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiARB3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiARB3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:29:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0536C061574;
        Mon, 17 Jan 2022 17:29:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440506128D;
        Tue, 18 Jan 2022 01:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F23C36AEC;
        Tue, 18 Jan 2022 01:29:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D2rBA9Ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642469345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWSz0e0wYGrdPKqE9vkcGgS4bap1xj88VlAUDVMYyPE=;
        b=D2rBA9UlT0YtWLADa4YIXXwYyJrVUpaFcuGCDN3gQ+eZvdrpBVTAlBzZtJgdkHah56H2+u
        uKrHjGQPqd/3vDsq1BMYfrLSLhNv5lcE0cEJ2liGl3ly9QBL3TNnFBKwcdSOV2di3UDzrR
        0Tvu0jLGxaY6CSDbuq3rb6AT+qfxEbs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b21eac9b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 18 Jan 2022 01:29:05 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id c6so51063108ybk.3;
        Mon, 17 Jan 2022 17:29:05 -0800 (PST)
X-Gm-Message-State: AOAM532lZf75AL2C4EhPV4WkGPZX8Z1d4YMwbZMcyad/HcNfTPi5xFg3
        IT9iBpY3MErJPYwGR2yiLNtZEqG3vzzY9y9sD7U=
X-Google-Smtp-Source: ABdhPJzjEYqkqDsVOUUSIyHOV7YjjeXNiAqTVHpvQPpnwwFMYIEN0g+UDhQY8ZukdUCBIkY1cueDMa3CW7w2dpH/LnA=
X-Received: by 2002:a05:6902:709:: with SMTP id k9mr6196333ybt.113.1642469343907;
 Mon, 17 Jan 2022 17:29:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Mon, 17 Jan 2022
 17:29:03 -0800 (PST)
In-Reply-To: <20220117064248.102638-1-julianbraha@gmail.com>
References: <20220117064248.102638-1-julianbraha@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Jan 2022 02:29:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9p5Bg-QejSNqKnMJU8fYaErc01FLjGCOWMH22WHJh2jMQ@mail.gmail.com>
Message-ID: <CAHmME9p5Bg-QejSNqKnMJU8fYaErc01FLjGCOWMH22WHJh2jMQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: fix unmet dependency on CRYPTO for CRYPTO_LIB_CHACHA_GENERIC
To:     Julian Braha <julianbraha@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fix for this was submitted here already, I believe:

https://lore.kernel.org/linux-crypto/20220116165841.254196-1-Jason@zx2c4.com/
