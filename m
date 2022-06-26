Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944C655B0CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiFZJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiFZJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:23:13 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E4910561;
        Sun, 26 Jun 2022 02:23:11 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y18so6873667iof.2;
        Sun, 26 Jun 2022 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+LUHC0DYaulPNo54n0DeVDYRCFGg0Z9uPUo6eao7cY=;
        b=gsetRLCAEWRpYTa+ktubHph4GACN1etqI0SW0ZaKl+tXJgFgfvNyI1sIMBOmdufqWn
         5VGXphd8iVaSX1K2KdxgbA9Tu6tDn3QkShLII6lmA9jRvcRB9xuu5MTQKHfyZQ+SkgPr
         yfUc+O5FVteVBQBBwq7PGOLwpXa7VUqpPrdVr+8ycLThEc+SuTBpJjnc9gV1XJEYrkkY
         XUxSf+Qs6glluHVKhscIZCgYFlGtsRpDKgItYzC9UhZrdea4CVB3JsW37QtCtpq8bkyK
         PCtX35olaRNIHekoPkIx9yqE55q5ylkOwVQ3OTaO4IiGbdunNDS/nQ3//R8J7Ws2Njgb
         rLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+LUHC0DYaulPNo54n0DeVDYRCFGg0Z9uPUo6eao7cY=;
        b=ao84SzjZLBpgw097RmWx9ZWuZ2gO6xzeI2emxKoJoUn9FNc/dgExfSm5tjA7HdHspR
         I7NS4IEpjtQUE6M9z8gvLhwVv+K/IJ4BCM0p2oYG78fHLRiImd3SnnvV5HSAvFypha3r
         qEE3iFXFrHIbMv88oBtO0uRI0dF+BnEw1H4te4kLFOcW41qvG1sBLscSN8C+N5L+Iusb
         L8Xhvwk2cdxygGiDARrZL4pnOcw/c3qrDlPuxdf1Dc74AGmCuVOEPBxfS5hBxGsS6ubE
         avYHjFJN2ub6j/GbpWPmiBzjGHG92ZMg1DDlWTdQd+Sa8xuS47iXO+adIC9mAtFMsd+J
         vFGQ==
X-Gm-Message-State: AJIora/gLASsNMauMnj8fso/L/jI0IOD3xV+IDEx2VUglS32g3wILz9Y
        f7SYchUZgWEcU3+esL6rglRKFbBUoSU1+6DxeOM=
X-Google-Smtp-Source: AGRyM1sTPyrwAW7cGfkqYHJ4SWTFXqK2TW3q006TuQYS4E5Jki/zc4K+pbjxw2exH/ObCFtwMxxZS7iRr4Q8A6RfMLo=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr3954751iow.172.1656235390597; Sun, 26
 Jun 2022 02:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656234456.git.mchehab@kernel.org> <94fe771609d32583fee41f47fe29433cbce5b04e.1656234456.git.mchehab@kernel.org>
In-Reply-To: <94fe771609d32583fee41f47fe29433cbce5b04e.1656234456.git.mchehab@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Jun 2022 11:22:59 +0200
Message-ID: <CANiq72=0HHiixjrBqbdEWjiOL0tAtLz=zGe5N3TqRoeq6Rk71A@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] docs: zh_CN: fix a broken reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alex Shi <alexs@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 11:11 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> The location of the rust doc is wrong (probably a typo). Fix it.

Thanks Mauro -- it was the old location of the document. For some
reason, the translated docs have bits from -next.

Cheers,
Miguel
