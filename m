Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C040B5AC491
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiIDNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiIDNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:50:32 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDB26ACD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:50:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-324ec5a9e97so51296047b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=8JC6EsSfafXmIapFg+dMsRIDXE8++LB1Nr2fu20u/vM=;
        b=duhFjZDteDpu7z3VF1i5MCwnIverAbFhBHyPGZQGAveFaeP+8rcuETFwoF1BfUzpZW
         dIpDgaoAQYOs+9YTuKOTAXM8WKBkwnDXub9e29JfXe3CHdjuj8+EnbdWa7ChKfVH/XJJ
         59uNZoSxBokjpFlXHEPaBT4ATN8OQXFXTqZu0F7IpEmBXplGDni3KiMlN1yLCZ4oMzyb
         J73U1gL8OA+Z4SlBZg8kP9nD9XyI4Xv+nXJJVELTdKQ7PlDwtNR2eteThdBCVP00eY7Y
         UBcqXzvh75F0xDlKwMeddKYfKc0VzSA58E7NfJwwYN3SxuwHIk7Auo3k532XD+thhjow
         9+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8JC6EsSfafXmIapFg+dMsRIDXE8++LB1Nr2fu20u/vM=;
        b=JaQBJWyI70qZZUBNPLsOEmcXPvjyZhcuSjmkGapUq6S/kwvgSEgMjSN66AyvVkOnfq
         7VmOCjM5eBeDrlwXD+kV/g18RhC6JI3KMXNui8z2jyWnG3tWCk++fNo5g0i7neJJpmB2
         wQ2r8ivQTi9FIjQOAUjO+Ig1a5poElE7qu7tFtv7eVupgEaonwx+l0XvcMHoxH+bkPXF
         lVbkWwf8JDUlEEAY+4yIUPgr4W6tOPeOhs+uzb/89Zk3uW7+5gZDZ7E6HbPDNQ6epz5s
         38js5P9GqOqkh44SDlkAXDDiCc6eH4GrzsfW88CdRZS157AqQ78Gj7iP+GDL6OQE3rsc
         8Rog==
X-Gm-Message-State: ACgBeo27LcgzXUTwSMwiPUMzCJU4Id3ALUQpngscWzs5KlxMAwueZL/K
        0o6OheY1MnIwoJ+2VcTlhBosm2E14+8DMVYKRMs=
X-Google-Smtp-Source: AA6agR65SsFfKYctriGVjs1lUk0TPQVTZ9F7E+llK1oHr/i8Cm6+sEdj/YlWG6uV+TTT+WxVqdEUDDjXhQlXILei2gM=
X-Received: by 2002:a81:ad59:0:b0:340:b000:368d with SMTP id
 l25-20020a81ad59000000b00340b000368dmr34373948ywk.397.1662299410698; Sun, 04
 Sep 2022 06:50:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: paulassidubroker612@gmail.com
Sender: sambieningbabe@gmail.com
Received: by 2002:a05:7010:26a3:b0:2ef:f144:c87c with HTTP; Sun, 4 Sep 2022
 06:50:09 -0700 (PDT)
From:   Paul Assidu <paulassidubroker612@gmail.com>
Date:   Sun, 4 Sep 2022 13:50:09 +0000
X-Google-Sender-Auth: wRbsIi6_qlrKebq-AJQvWkP04jY
Message-ID: <CAKz7bGYzKPcEAFxcOFCZO9Uaa8UnN-=u9f-0V2Bs4VseG5h7WA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, trust you're good. please check and reply my previous emails to you.
