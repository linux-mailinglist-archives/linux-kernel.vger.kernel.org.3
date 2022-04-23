Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D29E50C8D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiDWJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiDWJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:53:56 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6711344CA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:50:59 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r85so11719526oie.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=ihb//KNhn4xHQf5JSx4Wc7mc1hs3HO9AFAFhkuGMHVoUNZW19llk/AXEVSTV6XQXtA
         7BceJEs7jCjNL2/SQgFn28BNZhYD6uu/SJVNRZYX+pUDKS+PaO0Kf8dNTRJ2YbRt6x3x
         VqRepSGpuxlOsD95rnYsQEkplIZfWr/0bk7y9/6oppy/XXeU8e6Ifnz8zzUzIuT0dEup
         b+IhM+5NVdiaDtzmYrTzkrJuLcHMCDH0EqU3yKDI1oiTlo1bJaUL2q/UbpzXPbjOCmwh
         pwEZJZk9p2ExCTlN2S3z7xvK1LJ2wwuJDsmXcJWYeHUWFGI3mfnyR39XQPCKs0f3jxU8
         crlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=Q9xg59xSNPwxKKMZnVgYyu+b1XGMzEr7aVabvXmUcePyNJIYcxkdMZ/gpomC+lX9/u
         xaOBlwBSEwtMdzY8OWExBidyGjbPMwBtwmz9amzOon5cMYAh0tHbqdV1Ljb8ha+VcN4n
         /WnbuUhGu+nKejkC2VqA9Tu5Iy4Y2TbNu2wM3An1uDpSmpNX3G7+MDLYeefYmHRY7Lg7
         WnyCqqR45acp5Bo4rAE3Mpr3g2wF8CHbDPasX/fsDkBzcikawWEbeu3FiMYkzLj/TZYi
         PwdUpAH2kKX8dMr5H0e97L/gbR/Nn+ciQt8dOeh6WpTsblNBkss51Ux2hkFwNnwSlr4Z
         gquA==
X-Gm-Message-State: AOAM530DTq1bFEx6NLUFaww1bSn41idJg/ee/w4BPVc82NY18r6je6Y8
        1qcencaPAyMiVTzCkB0+Wj4R3neGAi3jYvcSqco=
X-Google-Smtp-Source: ABdhPJxHSBMfeaKYdgm8S/TjTdw9dzTcYWXQi8jQPG4KJTC5wQl0WA2KsiveQ0ykB058tglFg88RKeLPKo37yWOOVDU=
X-Received: by 2002:aca:c056:0:b0:322:4f77:517e with SMTP id
 q83-20020acac056000000b003224f77517emr8478386oif.18.1650707458812; Sat, 23
 Apr 2022 02:50:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:55ce:0:0:0:0:0 with HTTP; Sat, 23 Apr 2022 02:50:58
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <alassanilami71@gmail.com>
Date:   Sat, 23 Apr 2022 09:50:58 +0000
Message-ID: <CAEg-_2V-q2q8YAzUtuL8H4jyW426ah6en0e0vrLs6_pT7j07Wg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
