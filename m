Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD147EF04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352865AbhLXNNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352766AbhLXNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD311C061761;
        Fri, 24 Dec 2021 05:13:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y22so33403368edq.2;
        Fri, 24 Dec 2021 05:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1HOHy0keKQpVOdFGSD3b7czxWNidYu54FMob3Fejw/c=;
        b=ESSrB2GK3yeEN6DHbA1RPADMjQWU8OnZYs2QJnd5CjEooRgJgU7fGtziObh5mCUp5y
         DDdfiKXLQGFXZbAF7vo2yjbVKaSW0xhw/IJyojow7d7AuMMqnNuaedAClFO4BWF0d5SP
         u3aIt1Ovs8LI3SDhcrxejnkvCcaie0Yxp1uLpC0y9PNF+v4FgZpzveHvzsLgk0QGtmEc
         Krg9d9oWleQ4+/UmXfwznmThSAU6ZC2vkXMKGDOWKbnLnoYqFoRUMXq7kidRrJ5lclw5
         nS2X2izt9cjrIrI+DPKCnx09X6zK0KndiNWoKLRmfdHeFSr82o1yL6QfkLhDm0/1muSm
         TIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1HOHy0keKQpVOdFGSD3b7czxWNidYu54FMob3Fejw/c=;
        b=vVUzMo5zAtnyjZzvwUbDOyjY4Sxh3/Wyc5d8kugOCMH06ymRU+YNR5BoxxZdZ98yH2
         faGZ021hTjFe3HuSFUW58oi1Ri23C41gWVbDk6gFDNfZL+SGppg4GKEtIuRt2pATXl4b
         tLirv0Q3VxO6bGSNjU4mgr/6qGp7bDE9QRdOug45YDKf3inKZmZbohgX1D5qPYCYnRto
         XkY/GKFQWlXkrl5UoAYO0MdCsXGMiUgd96njo/QrSbBZA5El4PGVHo114R33YmrULkY/
         kXfeQiejbRT9E4cddfJHG5Wy36vWSu6nJ8LGt6R/5G2YTJhaM2bNUeoo/FcPm/6R0eN8
         Et+g==
X-Gm-Message-State: AOAM531BEOg4jmoozsYVKBpcycK+gxV+DdZwqa6BAvoW9NxipSTNKA5e
        iyHT9oLs9EGRaC+d7hazM2s=
X-Google-Smtp-Source: ABdhPJz6jKKfbHIAecMUs3UMcUpV1ym7wAu3gVdxWZgZvS1hCKJzH4op9tszz6o5Nkpl9fLTWal0TA==
X-Received: by 2002:a17:906:4796:: with SMTP id cw22mr5557920ejc.594.1640351598286;
        Fri, 24 Dec 2021 05:13:18 -0800 (PST)
Received: from zenorus.myxoz.lan (2-248-181-218-no2390.tbcn.telia.com. [2.248.181.218])
        by smtp.gmail.com with ESMTPSA id 5sm2636998ejm.132.2021.12.24.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 05:13:18 -0800 (PST)
Message-ID: <985cf51402ff6ea2c199869c3501a43a6588ae4f.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] zram: zram_drv: add SPDX license identifiers
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Joe Perches <joe@perches.com>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org
Date:   Fri, 24 Dec 2021 14:13:17 +0100
In-Reply-To: <b71570d5bc14181c656f8dd7ba69a397fd775495.camel@perches.com>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
         <20211217063224.3474-2-mikoxyzzz@gmail.com>
         <b71570d5bc14181c656f8dd7ba69a397fd775495.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-21 at 01:33 -0800, Joe Perches wrote:
> GPL v2 is a permissive license and this SPDX tag should probably be
> 
> // SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause

It shouldn't be GPL-2.0-or-later, because the original copyright notice
doesn't have an "or later" clause.
