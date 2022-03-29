Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62804EADF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiC2M5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiC2M5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:57:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5165C4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:54:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p22so20830334iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3+Cpn3QBTFnNdXLUgt2gDYydMPEQ4a72j7+Z8LurE98=;
        b=E8CGMrBFG3lyBAUu5VWx8Uh51ODVrRfh1hrkWcHZ6lu7lgVTnmrScCKLh2LlEYlwfR
         Ltpr0krRu3zJzjgARIhqVDyU58qslqu+M0a8R6u5euPpJUxSA6c0/WWh6qdsomwTtAUd
         D/Yy6nHfepzfC0U/wtFIgI0nnkyYmY20hRKs7V1pAZxTVIw9HetYQQX0pG7hdmb4+662
         4mJJIYKPGWYbKWbiRyjFMw4OJDZ1z/FgS54PwXGK3pT3GgpZbhJVKsZGQoubqrjV+olb
         lFvHUHPXeWuv4Z/hBf2PVipFL31h/+JT+KEbmEFuCA/a/WDGttQlvOSFrB3hDHZM4+jt
         xg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=3+Cpn3QBTFnNdXLUgt2gDYydMPEQ4a72j7+Z8LurE98=;
        b=3BRaBuHc0sQD7KZ9Q8tGyd0GOCPAPIy+F4fxy7S6qbAbHrbBNowhI+C94aKzsgM2m4
         6NUq1MHBdfd58a54ajQ+BGckaRzuoKhdSFoFnHLKRxpWxiiqmWpF+RrJaL/KYgMygzRF
         bo4A8ZDcAyuTY3UL15btI2jxVp8dMC+kZedIythZyL+51xWObrTjAKREC6rZGIpD/PCI
         N8nzXejYu/qzWOjAanccPyjxH/iycehixyT+/PKqjHHm2Y6lgBPL00rZ0Ts1YCrGn31V
         pJfoojyloP4jwq+iKlAo4fNpIhykpm5MX3VdZYIqCv9e3Ri4HidL5rwY0UT/abzL1W2a
         5wGg==
X-Gm-Message-State: AOAM530rEeHHkztA1c0m3oklT5uPSWFmQSxJe0yqlhecHeqnc9UhlN/b
        RSnd+W3qyMh9Yc6zWxWKx+grWX8+4gL48+QlfvE=
X-Google-Smtp-Source: ABdhPJzZFGZ7ywXKSEtOxbCrBuu7dE08B+tJB+70BYJwHXrg8t0AtHxr2V546FQK0aaqCxp6XWNBRdN/mAbnmMAyMGI=
X-Received: by 2002:a02:cc16:0:b0:321:446d:2977 with SMTP id
 n22-20020a02cc16000000b00321446d2977mr6432056jap.178.1648558472121; Tue, 29
 Mar 2022 05:54:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:a00b:0:0:0:0:0 with HTTP; Tue, 29 Mar 2022 05:54:31
 -0700 (PDT)
Reply-To: westernunionbankdirecto1@gmail.com
From:   westernunionbankdirecto1 <johnpaulsq752@gmail.com>
Date:   Tue, 29 Mar 2022 12:54:31 +0000
Message-ID: <CAEiwd2uPgpUH_yQGHkO083FUcx8qhf7fJwd1PbbaMXS=T_E1zw@mail.gmail.com>
Subject: hello
To:     westernunionbankdirecto1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Irod=C3=A1nk el=C3=A9rhet=C5=91s=C3=A9ge: 2554 Road Of Kpalime Face Pharmac=
y Bet, Lome, Gulf.

Ez a WU bank igazgat=C3=B3ja =C3=A9rtes=C3=ADti =C3=96nt arr=C3=B3l, hogy a=
 Nemzetk=C3=B6zi
Valutaalap (IMF) 850 000,00 USD k=C3=A1rt=C3=A9r=C3=ADt=C3=A9st fizet =C3=
=96nnek, mert
megtal=C3=A1lta az =C3=96n e-mail c=C3=ADm=C3=A9t a csal=C3=A1s =C3=A1ldoza=
tainak list=C3=A1j=C3=A1n. Hajland=C3=B3
vagy venni ezt az alapot vagy sem?

V=C3=A1rjuk s=C3=BCrg=C5=91s h=C3=ADr=C3=A9t.

Tisztelettel
  Tony Albert
  BANKIGAZGAT=C3=93
