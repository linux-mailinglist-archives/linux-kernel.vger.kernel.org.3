Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B126147BF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhLUMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbhLUMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:16:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39AC06173F;
        Tue, 21 Dec 2021 04:16:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2DF061539;
        Tue, 21 Dec 2021 12:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BD3C36AEB;
        Tue, 21 Dec 2021 12:16:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DgJTaCfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640088961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6beE6BpDwprNkz5y9zFhhfAFukSjI6VmGUxpjYaFcI=;
        b=DgJTaCfrx62rsura7yioTit46WL+PTpOeFmQflbxU5LaDcBKyLwg2ZVzEfSb5LczEJzPqW
        jkoyoH+/ZhvC4irkavRHrIBRt8TZfuPulY85cvGkGNOmZkAVHvyzpAgHxF7sMM7XLpbf8S
        JJn4TJBqHQ/TvMZn+6t1wCx/H1k7Dys=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b7b68377 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 21 Dec 2021 12:16:01 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id d10so38360732ybn.0;
        Tue, 21 Dec 2021 04:16:01 -0800 (PST)
X-Gm-Message-State: AOAM532Fw4tVpba+xWwiIsRZl+FfDmPw77MO5tTawtCHtvdf4o0bxcN1
        CAtsOVavNBO56ZVIZ6umDcP30xoIgaJBs4I2K24=
X-Google-Smtp-Source: ABdhPJz57QnKVwQ9hv0YAy2Bqpsa9tzj3gqzbEN070k0vjXv/rMSYP8S6XKJ7m6zekUWmuYDNV/ADTwtnJxTDMWj9G4=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr4301968ybu.638.1640088960502;
 Tue, 21 Dec 2021 04:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20211220224157.111959-1-ebiggers@kernel.org>
In-Reply-To: <20211220224157.111959-1-ebiggers@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 21 Dec 2021 13:15:49 +0100
X-Gmail-Original-Message-ID: <CAHmME9ocbi=F2n+u=G-3Y=Z5mwXJAaqWu2J51=FcpThbKP5McA@mail.gmail.com>
Message-ID: <CAHmME9ocbi=F2n+u=G-3Y=Z5mwXJAaqWu2J51=FcpThbKP5McA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] random: fix some data races
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All applied to crng/random.git. Thanks for the series.

Jason
