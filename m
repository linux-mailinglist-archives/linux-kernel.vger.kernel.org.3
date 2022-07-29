Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39FC585319
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiG2Pvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiG2Pvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:51:51 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB681F2FD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:51:46 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c131so8832964ybf.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=m3csfU7DGyV83X6zJlkcQN6Z1nTINh3JYfhn02mQF6g=;
        b=Ij1GDpGWgWb9K3ietLZHB2n1RI0BG49K2GaCcSRF3adpT8lwSmINmYYt4iCMhjblTb
         sVpLH/I/i4I0xqRmbnBZjV1KEPBHAui+7KHHnbm/gnAAoTY7uvlFqqs14VEifuqXFZPx
         ZvuA5+9coC4G1tD73IMFVzIlRgToZzsSObbgydoanCf/6Mw5pK10nw1QbBcOl2vdYRt4
         ANvagbK+WNlKtY1n93xXroAtFL81xaVjocDuCUxgdlq8/7/ffoyrLixnlm/0ZzOMCW28
         EbJCRQYuwmvPqiigZIyPpqcyR+q10ufheJNGKp3KqQPsnrsnWgeYs03vFlCg6f+lBx3g
         VZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=m3csfU7DGyV83X6zJlkcQN6Z1nTINh3JYfhn02mQF6g=;
        b=gKjzwUu5M5cQsm6idaYLBBz8GroKfXBfT10H67uw+p9Qmv9GMLjk+IOWpQHHRbONhB
         mLZZI87jNYipTIqxZuT7Mqk06En3U8x0mEyzBVSQARx+f64cXflAdeZ3rveNhorqTiBm
         RPUGkjrKREqgaUIYhGC5K5ZuR+hquKzQ4okvFfLthCD9W8sk09Kga/oUqxi5xEyVrJgN
         Htod1HW0S26DzDgWi0Tpzg3c1gmWqc/9FVA1jeuGAEW7rEy/YsfaLarWYH5rj7ttrflK
         9Pc/m6nRzyldWYCuDDKW7p/VKZJFQWIpuL3/LU9K6VnXpmGBMfC8DWUCdLXK+xMkRIbl
         mInQ==
X-Gm-Message-State: ACgBeo3Cy6YQzvVPAqru7xgDiFifb96nS/DmXzxM7cV2MjWWBvxxKdFN
        L1QwnZ+Y9KC10SzaY0646AdrOJdqAp7EXPYv81M=
X-Google-Smtp-Source: AA6agR4bF/0e3wVYIuukG+WjhFM44DDIngKO7rthT1HlKfk1Ki3IJDW89XCsHsTF1CMT81VYjLA2ayM/EyFtTnPt/as=
X-Received: by 2002:a25:a4c6:0:b0:671:7f56:4e80 with SMTP id
 g64-20020a25a4c6000000b006717f564e80mr2915605ybi.182.1659109905830; Fri, 29
 Jul 2022 08:51:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6451:b0:18d:22e9:95e7 with HTTP; Fri, 29 Jul 2022
 08:51:45 -0700 (PDT)
Reply-To: fofoj6432@gmail.com
From:   fofo john <bojomrdavid@gmail.com>
Date:   Fri, 29 Jul 2022 09:51:45 -0600
Message-ID: <CAFGsVzby7zHCT0+9Z6JNf1=6LzbRTEyVi-w5Qx=Y1Sowe5479w@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Afternoon,

How are you? I guess you're well, i sent you a message last week, did
you read my previous email? get back to me upon the receipt of this
mail.

Thank You,
Mr.John Fofo
