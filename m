Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53F254F734
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382340AbiFQMGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382331AbiFQMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:06:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9056BFCB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:06:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a17so1736820pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qq9wIiVWHN2WAUtj0B7xD2yz2moOuwSz6aN0pUPieSs=;
        b=ffP4cIIJvUKEGCEKLAV5bzY+scPezC5GRCF630nNUaVMB0HG56g+JIvVlt0n66BSa/
         ZYJsWCufTnZMupicIhWV65u4Hkr0qLPY7x6STuI1+EgcPRYkUKplbk6Z2qweRN0wUkwC
         qQBPE11YGli11HrcsD/WDlXdr3jbPni5axUAVG19tDhmk5byMnjde7FLXEun3ewuh8FQ
         UC7Xi96uPPnv4X/xEmO5aFmMfC6T/LjFwubgWqo2wZ0RqDPpaXsia9SFA0Qk04Xy0CQH
         c5WTmz4xzJpSWqJFqkV/yHXg5rT7gOEiFFY3hgX9mfnJhaa8KdiOxdSKqgq9oRHib8ic
         zH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=qq9wIiVWHN2WAUtj0B7xD2yz2moOuwSz6aN0pUPieSs=;
        b=jlz9mRanvVCVm69zT6pW36GehU+q2ipLBU5ztic0ds6h7dp0LB3jz3vgHCCaL35r3g
         YZ0i9M2asgMQrp76MdNNHDfR+MsMWjXcwqjnLI2m8vnkLcFQfMJeYtmjNTKditQuebfW
         Mp+dxUn8nV8Vylbfv/QknvCaRqJk9uNRcic+OD3QFU2KtHPT3M4Q9AJQdoxFrvdkIixe
         wjkrfzyW/Ag3+3vmqJlfqSRLYJoJjO6aWd4GBqUdj23qH8pTwBHy9zSxhXx9RBqejInH
         zF06uywh6UAQz2sx0dq8+V7QqMhsLHBm0JteR8disnsZgJ76IODs8Z+8V70iZVaHe9Jb
         Rx/w==
X-Gm-Message-State: AJIora/xXvfDmy/FQAtZkVJ/UZZnjal7QTbMYvQRlkrGZ/VL/q/Afj2m
        DWBjnayGmJnJ5hwBmMilEuPDtv0dBKhbdpROGg0=
X-Google-Smtp-Source: AGRyM1sHppfgplhXPbaVJ4JdPy3ila6mcHswApozQsfMLcfsW5U/FxFIvPQX0w95+/Ce3ASJOlBqWNHThR5pE5oiqm0=
X-Received: by 2002:a17:90b:4c4c:b0:1e8:6f9a:b642 with SMTP id
 np12-20020a17090b4c4c00b001e86f9ab642mr21220763pjb.21.1655467560783; Fri, 17
 Jun 2022 05:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:818b:0:b0:4df:4ce7:4928 with HTTP; Fri, 17 Jun 2022
 05:05:59 -0700 (PDT)
Reply-To: attorneyjoel4ever2021@gmail.com
From:   Felix Joel <wzer2100@gmail.com>
Date:   Fri, 17 Jun 2022 12:05:59 +0000
Message-ID: <CAAjkeQO9F6d+UjxKatN-XAKbhj=v4wByJ8U9P84kEkafPS2D_g@mail.gmail.com>
Subject: =?UTF-8?Q?jeg_venter_p=C3=A5_svaret_ditt?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo,
V=C3=A6r s=C3=A5 snill, godta mine unnskyldninger. Jeg =C3=B8nsker ikke =C3=
=A5 invadere
privatlivet ditt, jeg er Felix Joel, en advokat av yrke. Jeg har
skrevet en tidligere e-post til deg, men uten svar, og i min f=C3=B8rste
e-post nevnte jeg til deg om min avd=C3=B8de klient, som har samme
etternavn som deg. Siden hans d=C3=B8d har jeg mottatt flere brev fra
banken hans hvor han foretok et innskudd f=C3=B8r hans d=C3=B8d, banken har=
 bedt
meg om =C3=A5 gi hans n=C3=A6rmeste p=C3=A5r=C3=B8rende eller noen av hans =
slektninger som
kan gj=C3=B8re krav p=C3=A5 hans midler, ellers vil de bli konfiskert og si=
den
Jeg kunne ikke finne noen av hans slektninger. Jeg bestemte meg for =C3=A5
kontakte deg for denne p=C3=A5standen, derfor har du samme etternavn som
ham. kontakt meg snarest for mer informasjon.
Vennlig hilsen,
Barrister Felix Joel.
