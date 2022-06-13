Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14F547EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiFMFeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiFMFeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:34:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FD12AB1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:34:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 15so4825653pfy.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BmKmItauB0QK1fexecGEc5RrAzRWP8QWkhCF3CuVtEs=;
        b=dmYBvMavHPkpAPA9l+YUAYGq4n3DqRmj9aFuDZbC3JpOEzToMFb9BOKuA0zp0W2dNA
         1xmDP36LyDTR0UN2yrQBqIxLytyqs85zKKk/yB56ry6yKmmwtyHR/YtFue4EZe4hgmJH
         csrtPlnhZgDQWtlr3fdJqmYE/Hn7MMMscakz2ebo8K4ZQGOG6CgGL/1NarZ7tayUpaW9
         352OXYgnPOzL5dX2ORer1GHUyUA+Dh60gGDBZwciwCBudOtm8cj5z/Qqkfu4Jquu4gve
         Vz5HcKvYpgGE4cIaaft8JSEc+AZogKGo+2s2phIXU7M36IzfgyqCkZeCLT1jQsTpDQ1y
         kIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=BmKmItauB0QK1fexecGEc5RrAzRWP8QWkhCF3CuVtEs=;
        b=JuVr5Z2Z0ZEANuDF/f6DCqqI7eSQV/BEhLwTife5wrKqBk0qRREwYRu/U+eYgL4rMh
         nPgYZA7mSnyZEDA6mK/M8RnNmtYRq0qArjP1IJ0uhe1wjVsNVfEpKE3Ie4NFJd0u5+vP
         3cENXbql9hXTIBXR6yhcC91Xn6rFEwEUAI+yDeblhMUQdDxLdbFVL6qnMgcRfB9YleRQ
         xfixY66kYUqnElhCmm44r1mxEAMaV+wz9k/HeMqD5ew3WK1xnxbsydU05BzGwMJFOIys
         6ZlYvl+TzBcpwRTZGINMpVV+dRS2dPVz3kYQEnfvoiZyVq0y8muRHoKhpXAVUsVL1N6k
         vN1w==
X-Gm-Message-State: AOAM5309hVa3INx1gWJ2BuBZVfQXHaNaJWmkcnWzw6dclG0vi81Ug09g
        eX81z4DVoTSBWCaQlDu+33b0w/u8rh3CoJVo2uE=
X-Google-Smtp-Source: ABdhPJziRUHr9yrra1SMc4p+7u8arqpmUhEeyuPwuuTb2dSNP5dhMpBPtP2weq5pAFJH3QWJ1wPRIH2oMANSjma6TOk=
X-Received: by 2002:a63:87c3:0:b0:401:eaf0:ff18 with SMTP id
 i186-20020a6387c3000000b00401eaf0ff18mr14655449pge.153.1655098439755; Sun, 12
 Jun 2022 22:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:474d:b0:2a5:e0e1:4d87 with HTTP; Sun, 12 Jun 2022
 22:33:59 -0700 (PDT)
Reply-To: wwwheadbankoffice@gmail.com
From:   "wwwheadbankoffice@gmail.com" <dhl.directortg@gmail.com>
Date:   Mon, 13 Jun 2022 05:33:59 +0000
Message-ID: <CACPEsNt2Z=rxc0Xf8Pk3fKJXaFjAm-A=9H_yOeAxqS4vg_aS+A@mail.gmail.com>
Subject: h
To:     wwwheadbankoffice@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FROM_2_EMAILS_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_PDS_TO_EQ_FROM_NAME,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
 Szia

T=C3=A1j=C3=A9koztatjuk, hogy megkaptuk az IMF-t=C5=91l az =C3=96n r=C3=A9s=
z=C3=A9re t=C3=B6rt=C3=A9n=C5=91
biztons=C3=A1gi =C3=A1tutal=C3=A1sra sz=C3=A1nt =C3=B6sszeg=C3=A9t, mert az=
 =C3=96n e-mail c=C3=ADme
megtal=C3=A1lhat=C3=B3 a csal=C3=A1s =C3=A1ldozatainak list=C3=A1j=C3=A1n. =
sz=C3=ADveskedjen v=C3=A1laszolni a
tov=C3=A1bbi r=C3=A9szletek=C3=A9rt.

V=C3=A1rom, hogy hamarosan halljunk

Szeretettel.
Tony Albert
Iroda igazgat=C3=B3ja
