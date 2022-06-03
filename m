Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5153D20D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347857AbiFCTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349626AbiFCTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:00:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6029C8F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:00:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x62so11314615ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xnJF0s+DhPlMr/HYXjLae5Wk0Sa6uPPzZeUkcl9q+2E=;
        b=XFuK/6hZm84zzAH8/P/v+b8NNsb6tWVqn5dUCTudK5sS1y0FtkVAjlnFsumrQwY1zB
         I7rgPca+1rANYN/wwIAD0zZpKTTjZtUyjNVstnLrTF6laL7iJto6bCgUlLwMG0F2tO9N
         rGIqETh3xVReRqRfNTGmqZh9emKj3S7vxEKJRb9FPXQxgAtqyAqslXMb66g83iQTcxnn
         FPG3ueiBYsjMVxzwU8S9JYxfoXaSBWkuirKaOgbgvOXb1lSt45Ill39/BfACwGd0lZ+N
         aHtGgonfyFzAM5Vq4AYSiq1ivshG+A3LLIPncJjwQ50I4hID/3Fz/7hWKB0XMxRl2xtx
         F/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xnJF0s+DhPlMr/HYXjLae5Wk0Sa6uPPzZeUkcl9q+2E=;
        b=5evqplwwRTHErBWlSl+xrNp55dVkGgjwigF69pEOfH0dekV/8PZwWqWvaa41I6CLll
         Opq1GpeiLTs0Abnx0c9UtQumLQF8Pbr9BMqwbRGz4jpCeJ4maZZ02h9e/lIpug4evED2
         /6GfPXcYVDIRuO38AZFVjbrXLpMB7/JcE3I4a9f3TrmeMri8CXuuuCXhPtIS0E4kHuhY
         zron6AjkhJC8SkhOcJPKWE6Paxou1gMGEbRaRJBWnVuC0OGiGchBBlQXTwxqWKwGlvRu
         B1fzqENLYwYr1ER15uXh6kc612SUpsQYQMmkjgYxMpeReZvlgwRNsIGT8/JECIL6xk65
         NLvA==
X-Gm-Message-State: AOAM530+ekXjzQCuU8HuqGC8ePi5jWsAg9dB63bhoTjQ2USkVhcy4rTd
        AaLQcT46K0VbQwXDjq+27wo/UNRzEXyfc5xOyFk=
X-Google-Smtp-Source: ABdhPJwJPdoWScyT0BX0ZZ5XEqt+6/QqAVTB5lNPSd0SekccrmIBfJB//OppesdnS1NeRpFXEqYsCl6C9HmjIk2/32o=
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id
 eb5-20020a0564020d0500b00425b5c8faebmr12484501edb.273.1654282834775; Fri, 03
 Jun 2022 12:00:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:d54c:0:0:0:0 with HTTP; Fri, 3 Jun 2022 12:00:33
 -0700 (PDT)
Reply-To: headoffcedirectorwu3@gmail.com
From:   "headoffcedirectorwu3@gmail.com" <wwheadoffic@gmail.com>
Date:   Fri, 3 Jun 2022 19:00:33 +0000
Message-ID: <CAPafwPL32enc-dF-+AnLxkdh1jhOs=h_wjL5Fv6cno9_XKW0iw@mail.gmail.com>
Subject: e
To:     wwheadoffic@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,FROM_2_EMAILS_SHORT,NAME_EMAIL_DIFF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hell=C3=B3

Szeretn=C3=A9nk t=C3=A1j=C3=A9koztatni =C3=96nt arr=C3=B3l, hogy, megkaptuk=
 az alap irod=C3=A1nkban
biztons=C3=A1gi =C3=A1tad=C3=A1s az =C3=96n sz=C3=A1m=C3=A1ra. k=C3=A9rj=C3=
=BCk, v=C3=A1laszoljon tov=C3=A1bbi r=C3=A9szletek=C3=A9rt.

V=C3=A1rom, hogy hamarosan halljak r=C3=B3lad

Szeretettel.
Mr. T=C3=B3ni Albert
Irodavezet=C5=91
