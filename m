Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C3599B64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348708AbiHSL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348019AbiHSL4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:56:52 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E740D9EB5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:56:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-333a4a5d495so114599407b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ae2M/2CL+5PRIbx8obrCR6cKlh7vPPGl3U6ivb4owUM=;
        b=KhcJwGdRdy4WZQqqQ+yTrEZp8fuJeh72dMUxhCLnH/NfNqLSaRXEtaF294rC90vV0k
         r1X0ItK+ZVh8KGMQljWZ0myNCHWyd21LSoNoj+mRgSGJCAJnAPOBcdxUBqdsLtDgRvax
         IZ/VvDpqSpE6k/TRgG8fqTfQR7t7i8kgb6mzwkApzRhiIs3EvqpzDolk3ZM0RD/MdfoJ
         lgchYOWTbSLSV2t3MqJga+tUfxEY+PLs5PAZHZFoAL+cI7qj/El7TnOai/P3eL7UaTcN
         UQQ/qCoVSVtoG/xVOGmknKYchmFSBPZH/gIruUIrUZnJEO9yqTQMkBwqbkQhQdtjobLw
         mCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ae2M/2CL+5PRIbx8obrCR6cKlh7vPPGl3U6ivb4owUM=;
        b=Tf+U/9V8ybVj/DoFe9JVmaj9AhzrgYYCINHPuVWeDmiLC7xmXchK1h1VyAgAKnchPv
         l+JqZX6Tv5tjeHjBZrKt983YtKVoWAr2qgBkOQxwlioFS60zL9KnTgn0Vc/xbMhz8ZNA
         kW/bcilTkbeUBCVBZ3LE41X8Fd+LpElGLHfkug7JlUGs4DSuaQINchHFOS8Fcixa65FA
         PUZkhZFkx9UNoB0Sh4S+OnBoK6wspUkJ1Czx23eFh73rARzg9m0TFtXmHxnqlgO5n4yc
         Mr3xjSSO0LbLOqF4PebaGOhzVFY+pBNa5uvMCpXuWIOXzbEplkJAdpcOze9g4W6HKlbl
         s9fw==
X-Gm-Message-State: ACgBeo1NPq0qQyj9AQrWs2P3JHhqtz+JNwf2kzaQ0AG6MbEIVsFLwp2u
        GjEZOEloAvQ3i1O41MzaocYKNdkJZdmwkwvTsr8=
X-Google-Smtp-Source: AA6agR4Q8GnKn8QBs/EIHNCSOCUJXdFTeObJRLpP58g+lWUkg2+9pJyLMHhGnbXpYWlzV+bkB9s2MXXzC8GlkuPvK90=
X-Received: by 2002:a5b:f4c:0:b0:676:d681:1820 with SMTP id
 y12-20020a5b0f4c000000b00676d6811820mr6878361ybr.148.1660910210634; Fri, 19
 Aug 2022 04:56:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:4a8c:0:0:0:0 with HTTP; Fri, 19 Aug 2022 04:56:50
 -0700 (PDT)
Reply-To: hegginskate7@gmail.com
From:   Heggins Kate <hegginskate7@gmail.com>
Date:   Fri, 19 Aug 2022 11:56:50 +0000
Message-ID: <CAEAJ=VygFUf5MAiTo=YgLHW5t4Dc6z4yAN+Bspbmz1NSyWexow@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Katie
