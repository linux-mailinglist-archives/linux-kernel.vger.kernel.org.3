Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F856CB3E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 21:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGITOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGITOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 15:14:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF8315A2E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 12:14:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id cf13so654493qtb.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yFjPBwfof55JxbmPqLU/8pTY0KXsIbs+GUr373EysuM=;
        b=aPW2jAvVmuhNLR+c5htyB+zDi4OnTDULd1fxcN3eSTbHwJNEOOJgmj3fTYWk7vHHCh
         l1fvjuAxY3beLoJuryNCjix4noRjXUJ96flcnt0Ag3b/W7KNFAm6awKYiAo5K47q8kWt
         MeFmGc9M8gY62wmfmmi0RFya1KWEiH8+8MA4GFRapC/d8t8rVojKnISibCYnqA3uIC9n
         OPokFty2m5Y+Xj/czcYf58YtbU8T9JXUP4t4rrmkkaMmP4OIbOeI4cVOaGhhAia+7wfo
         rXUbuw846m1yySMZtfQrB/2vW8Mtx5yT0sCSD4sS3Ihg0txQGl/NxBD/U+Hb53LHRXY1
         dNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yFjPBwfof55JxbmPqLU/8pTY0KXsIbs+GUr373EysuM=;
        b=3zXieP6fzcdnEc/mlI8ModTQ6kVOBLrEm2j2t2W7S78bnFwK6MgOqf4bMRZH/2xga2
         NwrD/RmdvkoWgt6y61sBrmXh0o930HKhaMUUKV4owBP2pQB8psWbGkHOAzWfyC7OOqGm
         /iE7YupPQ0vghoi2jQ2ywMocw/y2+tb9yLZrAQ4QGXxHXte7EShB0QIw4AiDVlKhDKEL
         AwzCycDgqgOhao5VyIk12xQsNAR0Jf/tSqRO58L5atjBqu9A96zTunKSfdjodoyeR7tw
         uuMm1XfXd/PK3wZbkBddk0SJYPiZmkHK7HgeFDLAcd9fPmYhHL+NJ7gjXGGcICVwsdT+
         CEGw==
X-Gm-Message-State: AJIora/DpVYEj7RpmwpYMXJWvQaYVANAbTQEb6IHFXo3SsM4h0SDvAPY
        EmN+gvA7nFA6OdYffuDY0unXQ29vGUHYn+xsNqc=
X-Google-Smtp-Source: AGRyM1s8Uc00XbGXmfBqcFMckxxCmi4IWvyOr3ucunfbRWdYVZlLl2PNQoJuWPow7udoUHd+a9F0Wn05n+xiL+FYTck=
X-Received: by 2002:a05:622a:490:b0:31d:2a47:c221 with SMTP id
 p16-20020a05622a049000b0031d2a47c221mr8350459qtx.212.1657394086000; Sat, 09
 Jul 2022 12:14:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:1d2f:0:0:0:0 with HTTP; Sat, 9 Jul 2022 12:14:45
 -0700 (PDT)
Reply-To: stanleydenford100@gmail.com
From:   Stanley Denford <sanjosarees@gmail.com>
Date:   Sat, 9 Jul 2022 12:14:45 -0700
Message-ID: <CAMXaW2gae6RAtp72J5LXGYzLEfkMuOjz02J257wSZbQ6xT4MmQ@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good day, How are you doing today

I am Stanley Denford, a Client Relations officer. I got your name and
contact information in my quest for her existing extended family, I am
writing to you on highly confidential grounds with mutual benefit in
respect to the estate of Frances...

The estate is worth millions of Dollars.I'd appreciate it if you get back
to me by confirming to me if this medium is safe and confidential enough to
enable me divulge to you details on why I contacted you.

Regards,
Stanley Denford
