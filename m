Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16454BF65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiFOBq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFOBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:46:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0635C344E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:46:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so322268wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r9ef50fmTQlY+arQUpzjat8jbkWX2R7fnNOX1JGtMao=;
        b=PnPEhnJXDYjIr+BURyj7QooqI4UBkjhJF1t46GkjuhDQEVf5o3gL8JmWqs/aw9L7dV
         1uK9G/E5Pz5HYG+8u3c2Yb7KN6VtmW372a2zzmjmemApfNsCYzQ4eEYnRJFB3QJpsjXl
         nuDcihVyWGshYC52PJqcapvthMn/V5lDba3SvmJNYt6n+S7nvpXMG8Hd8DLYaVnXKROt
         O9Jl6Ee11exkCYXqMYgvakZ5eY4fm0LwmRXtXcpCdppe+U2BNWicoU83ehQ5Su5UFMd1
         1E0KAbxWaH+9ogmWTBj20nYMu9tjbU5Th8e/j3HTvS4ObtAu32qYorlNDggI0dN8Kq18
         fGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=r9ef50fmTQlY+arQUpzjat8jbkWX2R7fnNOX1JGtMao=;
        b=Zx5EyBlJWjr9ABXDp8R0ot9CcfC+leLz+x/OfhHJlKpVnHLOIJBk8u1ytVH7rCXvxD
         13On9i7+Oj7xaY241WBKSn0Efe7oPd0Pu2V8pdCILjmOUqSfLhz6wgLAk/IduAMrxsTN
         scsWXEpf6XhG8PfYIAD3SWRLoWjKvTBZVaHIYAX76IUY/NUYY1W3/rS0OpBrvyStjwPW
         zCVya11CCClIt10toRGqwqz5TBr2vnWWvCFCTiPcXtQ0iFNlr4GEWfUyy4GIO6O36gav
         MHNe9ALHpHeQBbfrrSoGAFGRH0JnOZButO8v8kJ+BPoGHcTADQztSOZYSp47Sv317cO4
         j96w==
X-Gm-Message-State: AOAM530voZev/qCQSXW9Zxis8vC1BFgpO8q2ms3w7zLlQhoI/JBnvNCy
        XzI+Og6xNkmYjmuOq2DwqOHr4WdJVwbbKMklIW0=
X-Google-Smtp-Source: ABdhPJxpF+hH6KbXRZccJQUsiMBmPmXIaiD4eJ2YqLSp1mdQx7ctnJSkH0lOxEQUWpkb+2FOK7rrem5oYx/iteB4tpM=
X-Received: by 2002:a05:600c:3229:b0:39c:65b2:8935 with SMTP id
 r41-20020a05600c322900b0039c65b28935mr7094623wmp.155.1655257612283; Tue, 14
 Jun 2022 18:46:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ffcc:0:0:0:0:0 with HTTP; Tue, 14 Jun 2022 18:46:51
 -0700 (PDT)
Reply-To: cfc.ubagroup09@gmail.com
From:   Kristalina Georgieva <ilofab436@gmail.com>
Date:   Tue, 14 Jun 2022 18:46:51 -0700
Message-ID: <CANKxEgjogDtPV5-wexibj6ic+mmoc29vg=egRPipn=SQ0spnKQ@mail.gmail.com>
Subject: GODA NYHETER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

B=C3=A4sta f=C3=B6rm=C3=A5nstagare,
Jag skickade det h=C3=A4r brevet till dig f=C3=B6r en m=C3=A5nad sedan, men=
 jag har
inte h=C3=B6rt fr=C3=A5n dig, nej
Jag =C3=A4r s=C3=A4ker p=C3=A5 att du fick den, och det var d=C3=A4rf=C3=B6=
r jag skickade den
till dig igen,
F=C3=B6rst och fr=C3=A4mst =C3=A4r jag Kristalina Georgieva, verkst=C3=A4ll=
ande direkt=C3=B6r och
ordf=C3=B6rande f=C3=B6r Internationella valutafonden.

Faktum =C3=A4r att vi har g=C3=A5tt igenom alla hinder och fr=C3=A5gor krin=
g
din ofullst=C3=A4ndiga transaktion och din of=C3=B6rm=C3=A5ga att uppfylla =
avgifterna
=C3=B6verf=C3=B6ringsavgifter som debiteras dig f=C3=B6r alternativen
tidigare =C3=B6verf=C3=B6ringar, bes=C3=B6k v=C3=A5r webbplats f=C3=B6r bek=
r=C3=A4ftelse 38
=C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 W

Vi =C3=A4r styrelsen, V=C3=A4rldsbanken och Valutafonden
International (IMF) i Washington, DC, tillsammans med Department of
United States Treasury och n=C3=A5gra andra utredningsorgan
relevant h=C3=A4r i USA. har best=C3=A4llt
v=C3=A5r Overseas Payment Remittance Unit, United Bank of
Africa Lome Togo, f=C3=B6r att ge dig ett VISA-kort, d=C3=A4r $
1,5 miljoner fr=C3=A5n din fond, f=C3=B6r ett st=C3=B6rre uttag fr=C3=A5n d=
in fond.

Under v=C3=A5r utrednings g=C3=A5ng uppt=C3=A4ckte vi med
best=C3=B6rtning =C3=B6ver att din betalning har f=C3=B6rsenats av korrupta=
 tj=C3=A4nstem=C3=A4n
av banken som f=C3=B6rs=C3=B6ker avleda dina pengar till dina konton
privat.

Och idag meddelar vi dig att din fond har krediterats p=C3=A5 ett kort
VISA av UBA Bank och den =C3=A4r ocks=C3=A5 redo att levereras. Nu
kontakta direkt=C3=B6ren f=C3=B6r UBA Bank, hans namn =C3=A4r Mr. Tony
Elumelu, e-post: (cfc.ubagroup09@gmail.com)
f=C3=B6r att ber=C3=A4tta hur du f=C3=A5r ditt ATM VISA-kort.

V=C3=A4nliga h=C3=A4lsningar,

Fru Kristalina Georgieva
