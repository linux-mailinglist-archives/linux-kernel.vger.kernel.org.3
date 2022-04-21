Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663350AC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442653AbiDUXpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442641AbiDUXpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73072DF94;
        Thu, 21 Apr 2022 16:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32C41B82936;
        Thu, 21 Apr 2022 23:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964C0C385A5;
        Thu, 21 Apr 2022 23:42:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NVmiYK09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650584564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIzHio+uxVuTQw5AaXIBz3IslDSgrYMj80mgg85aq28=;
        b=NVmiYK09KEDShaBadngaz4Lp+bC64fimPUzeMa1CJeDpmBhmSSpuiwC/mhyueCcIB+wPna
        xyuaHO3VBpQf3O8bQss5Oib2otF9j3ALCdtVlWLN88XrRDG/ugNGkFzhFBAajV9dPeHDTx
        /Aq+G+QvwQKG/CgbdUQMCHCW/LT4haQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8cec7543 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 23:42:43 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec42eae76bso68827087b3.10;
        Thu, 21 Apr 2022 16:42:43 -0700 (PDT)
X-Gm-Message-State: AOAM53089ijOGAjwEHrvooWdP8NEoEpYvV0ObJMfLng5u/MCas5qXnTM
        Ere8k5Ftx94Pan62INvgGOzgq64pSoD5Pqo4nn4=
X-Google-Smtp-Source: ABdhPJyhwBhwVx853EkJ6v1OHlANWFc0m51HpFCbvj021jqbLAw/CZSPBJWVYXr7iLFAu7q6T/xDWZIk+aRkFG4U4fI=
X-Received: by 2002:a05:690c:39a:b0:2ef:67cc:ddd6 with SMTP id
 bh26-20020a05690c039a00b002ef67ccddd6mr2353983ywb.2.1650584563035; Thu, 21
 Apr 2022 16:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220421204320.258010-1-ebiggers@kernel.org> <CAHmME9rtrjyE0Cqk9qvW_xxhFduvbMt5-cmjD134JCxk2iLKDQ@mail.gmail.com>
 <YmHrWy2o72k2cFLM@sol.localdomain>
In-Reply-To: <YmHrWy2o72k2cFLM@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 22 Apr 2022 01:42:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9ozRGG9V=jsf=Ebg-ipXpyU_3uyFcRn=YYXSgdgqhM33Q@mail.gmail.com>
Message-ID: <CAHmME9ozRGG9V=jsf=Ebg-ipXpyU_3uyFcRn=YYXSgdgqhM33Q@mail.gmail.com>
Subject: Re: [PATCH] siphash: update the HalfSipHash documentation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Apr 22, 2022 at 1:40 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Well, this documentation starts out by introducing HalfSipHash, and then moves
> on to the the hsiphash functions.  This part is still talking about HalfSipHash,
> so in that context the mention of its use in random.c is relevant.  But I could
> certainly reword it to make it all about the hsiphash functions, with
> HalfSipHash being mentioned more as an implementation detail.

Alright, so let's just drop that hunk for v2 then.

Jason
