Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69B7563EED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiGBHjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiGBHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 03:39:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30A1F2D3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 00:39:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z21so7287020lfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PvPeZNSjmbUt3g4rxRetUVDhzEwblDzwMLQqhjF3auw=;
        b=RJ9jgHsFVDCoBmIG78wAmo4p+Hso/AfJzr5OAO6D4RMIKLQzEDN6w7VvspJG+ntpxY
         wcMP+HfWIowhhWpMwxmFwH7DggmcsR20iw0ke86aP0vO54SxEfkZM2chsTNPuZzdxAn5
         Ynm/I4nn8p2uwu0mWm0y198gPlZ324WFa7/N2epPhXRVXP9DW49jaZSb0fRLyxgcQ38P
         XUkfdm457qohH3OO1UhYhs2uBSZkL4YN8sK/i2FhFpudPj2tKzpzTjW7zBsYSKOyMhcq
         babv8fqsZMIxT1H9JptfMNTSiNdmXgjgalF5JVqQd/lksRTaHhhqhElSz8bAmYt0wYVg
         j7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=PvPeZNSjmbUt3g4rxRetUVDhzEwblDzwMLQqhjF3auw=;
        b=xtJ+LsoUbq0u0hJFNYjhqkuPjxJ6pyPaEeW7ow5WNpcVXat7uHyF517sRM4h5Y3uli
         RgX7HBxZkcU14PSmVTx+mSG+wTusHKUgk7nNHRq+wqMgeeed2QV1AQ+Ym7Oqo0u8vLLn
         4kTpxOoD/cnZXHqWHUBbUZTMD9Um1Vjc1p78snH7W1g1dvu+N2LK8rNxSQ1kuRHv+Lnl
         4YioH8Pj8m/90ehz2UCR9rAhHp+jJMbR/q0uj8SvwbNmo83S0DsiXfBLPYGQg4JQI8vb
         wPoO0HGAsz5Hr4YNDieGwSP6ZBeu7W3oqIoYgMWaooFMRNZUGpBUtD0Kz8T6u10M+7rH
         cVew==
X-Gm-Message-State: AJIora8zZ8Gyrb+YhvzzsFgJ7HHVMKdnElp3+gEY3MSFpo0IIz2CZH30
        9kS5lAAxB0ZfgLKL827LmNnGgFX44jMZ9AtAtXs=
X-Google-Smtp-Source: AGRyM1tAb54b2aqbx1Pj4/VccFKYYFhALtqIP23sEa07NUoFQ7IkfTMKLZwO8kclyPjoZBBol1paMov44ShdQmq5QOE=
X-Received: by 2002:a05:6512:1324:b0:47f:bda5:408 with SMTP id
 x36-20020a056512132400b0047fbda50408mr11740425lfu.649.1656747584519; Sat, 02
 Jul 2022 00:39:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3e10:0:0:0:0 with HTTP; Sat, 2 Jul 2022 00:39:44
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgtkayla manthey <sgtkaylam20@gmail.com>
Date:   Sat, 2 Jul 2022 01:39:44 -0600
Message-ID: <CA+RGHE8Ct0MG2+8A0V7NnckDSoTrP35Gg=2R8g39K0oTJq0-xQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
pozdrav,
Molim vas jeste li primili moju prethodnu poruku? napi=C5=A1i mi
