Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFF54D2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347067AbiFOUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiFOUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:44:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25302E69A;
        Wed, 15 Jun 2022 13:44:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v19so17897388edd.4;
        Wed, 15 Jun 2022 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tp4oIh2zYtBi2+RpvWEIz+CScSVPRmmdz9pJqOF/be0=;
        b=frLOPTAHpOW6WM+y8qwoZMCwMS51iwCN9CSULQFC+7vgTcnCxnQHN9Xby4N7qbkAdo
         LGs8h+xgkrkDVPqB7yJTZgIDNimJ6khTRoo5I3kER5tqQRN5I0wvjkU9wzFoNEoQz5eV
         dg+yMeWxL5qd97o6PEsS9YeeV5pkWyIAfP2B5ChFUC0wvfX1H+j/8BPMYmSUiEg0IBAM
         Bfhd7JN8oO7Q/TSmcUVQtBCfupH0MYL2QQnTyjlFtYiYlynHBzLA2J4cD0TOFtI3tKcb
         07QmU1885KJnriYYcPA1mn58jFG8K1ZdEzpq4dJTCy4CZmP9LAZWxPzLt9B2GETu7oOE
         cVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tp4oIh2zYtBi2+RpvWEIz+CScSVPRmmdz9pJqOF/be0=;
        b=uDln9VdyR3PfOvfX/J7pJQYHsd21B8WS+Gm+6gVSnHgEG99VVf3WX6nbCjmDyu8ee4
         VI7hIvi7KTJr6MOIi5lfXUyGJOUtn+3Ez59QmdiddV92bQ3i3JN19RaO37WRdes58GE0
         po2VbEqUBB1Qz2GA6F5BAtfyC6uVW8pjp4BreZ5qyzB5HdCeInPscYKZh/xTuKaLl8ha
         6c5/AC4vJHFFmhnbg4Lo7ikhqXIYemd5UnNqQRQ7MKYVlBmjONUJbmrAyVYbwiKXs0rq
         ZxDyy+2G3NxZZ8T1+HHxjM4aQFYcrL8gv3Uac3wn/v6teaPWkOxF3L6bchlKb8gvQ6S4
         qJ2w==
X-Gm-Message-State: AJIora/In7A5Ipr7Ypjj7Hr2nLv7MJIisc+6EeDNQ7yR00VI2CCNBvrC
        70upIAI7FyXJkxwIxv+hb8g=
X-Google-Smtp-Source: AGRyM1uQSv1o4AubDZMBfsKjQPuH2QynVWB1oxR/lAPoCnd7YAvz8HbUwnIEOBUBdtfG4T0zFOerdA==
X-Received: by 2002:aa7:c457:0:b0:42d:bd18:4ef with SMTP id n23-20020aa7c457000000b0042dbd1804efmr2116460edr.112.1655325895465;
        Wed, 15 Jun 2022 13:44:55 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709060f5000b00711d0b41bcfsm6777291ejj.0.2022.06.15.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:44:55 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] media: cedrus: fix HEVC decoding
Date:   Wed, 15 Jun 2022 22:44:34 +0200
Message-Id: <20220615204436.137377-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After detailed comparison of register names to vendor library I noticed
that one register has completely different name. After some testing I
discovered that it was misnamed and used incorrectly. This patch series
fixes it. With that, 3 more reference bitstreams are now correctly
decoded. It is also possible that this fixes instability issue I had
after decoding such bitstreams. Running Fluster test suite very often
locked up my board, but after applying this fix, I never experienced it
again. It might still be completely coincidental, but I doubt this is
the case.

Note: Patch 2 clashes with HEVC uAPI destaging. In current form, it can
be easily backported. However, there are few users of Cedrus HEVC and
skipping this fix wouldn't be that bad.

Please let me know which way to go:
1) wait for destaging, send rebased v2 and not care about backporting
2) merge before destaging, but v9 of HEVC uAPI destaging would need to
   be rebased.
3) something else?

Best regards,
Jernej

Jernej Skrabec (2):
  media: cedrus: h265: Fix flag name
  media: cedrus: h265: Fix logic for not low delay flag

 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 29 ++++++++++++++++++-
 .../staging/media/sunxi/cedrus/cedrus_regs.h  |  3 +-
 2 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.36.1

