Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B7536D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiE1PUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiE1PUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:20:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F310E4;
        Sat, 28 May 2022 08:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 376ED60EFC;
        Sat, 28 May 2022 15:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BA3C34100;
        Sat, 28 May 2022 15:20:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qE1HKzO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653751247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JkDzc0LO3wwyFpVhlqaIJZm7f0ZEKGy7IvUB5AiIpI=;
        b=qE1HKzO2mc8ewbLzhWfVQyEPkHOa+2D7Ml/eLEuVPkrCEBvtuW3xvL2S6BnY/PYYwusLRG
        fMKl15b/0LtL9NsDhP8+jYOLU3+/cSZkGmLeK0qeYL+QIKzwJxoaoqFdPE/wN/NgNiEqVE
        6SXy6tnLK9/UtdSBhRVvNIF1zwRAgf8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 12101297 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 28 May 2022 15:20:46 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ff7b90e635so73364547b3.5;
        Sat, 28 May 2022 08:20:46 -0700 (PDT)
X-Gm-Message-State: AOAM530H3tqmjsHvzdCMrhsmOqJVCzbCgkOeEB1//nKQu74nZ0JWSCW/
        BU5acq5JyrG0M6xN/eELYavh30cz6YidhlUuVw8=
X-Google-Smtp-Source: ABdhPJxa9gI6GUshjPfnm31KDdrjwhQZ6ZM+t9sLo1ouvhBaw0GtT9VkU9LdsporNFZiEcwJ2OdJylg3+Tv1n1tTCuw=
X-Received: by 2002:a0d:ea14:0:b0:300:4bc2:ee31 with SMTP id
 t20-20020a0dea14000000b003004bc2ee31mr19524491ywe.396.1653751245268; Sat, 28
 May 2022 08:20:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Sat, 28 May 2022
 08:20:44 -0700 (PDT)
In-Reply-To: <01a7891f-7295-3be2-73f3-5405b1e18f45@molgen.mpg.de>
References: <01a7891f-7295-3be2-73f3-5405b1e18f45@molgen.mpg.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 28 May 2022 17:20:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9oFDjHjxR8xvns3VCDqGhtUDvEf7rhEy0fgD7NOmkKn=Q@mail.gmail.com>
Message-ID: <CAHmME9oFDjHjxR8xvns3VCDqGhtUDvEf7rhEy0fgD7NOmkKn=Q@mail.gmail.com>
Subject: Re: ./include/crypto/poly1305.h:56:46: error: 'CONFIG_CRYPTO_LIB_POLY1305_RSIZE'
 undeclared here
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert already sent:
https://lore.kernel.org/lkml/20220528110918.256550-1-Jason@zx2c4.com/
