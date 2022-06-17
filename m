Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988154F60F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381496AbiFQLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiFQLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:00:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E53674C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:00:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id bo5so3880048pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=oHUQws9klDy102xe181qlI0yHmpW5hGnZAWYwASUqB59SroYSaYFLFBugsizgMYXLp
         sfeC7k27rt503d0CUN2/Jw1TN3cL3vtiAFVMN9ZDzcYdcP/K5p8RvIRxo9DRQFiw11C2
         +Tl9KV4udFUTBNb/b05sjpTj6YGgcu/a1qHsINh/p19fkgBeXVXQSa3EI8wPxjF7DASM
         wo24ZPaXTblWrP+piRiklMfeyTBxyRUP0HyNCwcabdQXABG/3R6gUgyl//G1rE16dKr5
         GcKGH5EcUhAf7ogzCp3IU0O0PGQ73K6AuOh8e4tvyYvqXr9Iqr9h59YcJrUOQuhFikye
         zZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=m264FG2EohC/VlaRDMlBXfmCcTSxLvZwG8mOHT7w30VJXJ9SAXX+94/usuh0FQa3Kq
         dab81UXKPHOkCOgAxMlRptvqIQy8lKqKORZ+TcuCIalhaZe5TPSW8d5a44WDacN4z+DM
         cESbHd63KAPS3DDBEIStbt9XKEruferjrvVkO0uMHBwbcu8FLl2eTF7k841SAZzBA6SL
         QqaXaujoSAmNRck//UhJYxwf/jMCXN1FhgDDrilnLelMHKAdM35Zzk9QcGi/CqE/Ju+X
         lEEOkKNcWVfPZB9bNZtW0QeWeohteD3quAszZPm6l3I948OtSz//LHrsog64SyR8o62l
         mkzA==
X-Gm-Message-State: AJIora/WBktziBU4IqlH8bPeajvasqt39maKrL1e4HjaTFJYuBYTjT3N
        KpaooEGF2aZQpfMC2itAWkmF59otIyNDFbhFqk8=
X-Google-Smtp-Source: AGRyM1v5cY+dFzRT9PErmlXyb5sKF2+OgYSjWe1wbHnx86b30P+tcWK3Ku/PUlcHQiuu3eVl3GchbpW/IusCqZEJFHA=
X-Received: by 2002:a05:6a00:194d:b0:51b:eb84:49b1 with SMTP id
 s13-20020a056a00194d00b0051beb8449b1mr9346731pfk.77.1655463654005; Fri, 17
 Jun 2022 04:00:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:b0c2:b0:44c:e1e2:d595 with HTTP; Fri, 17 Jun 2022
 04:00:53 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <vaidadeo9707@gmail.com>
Date:   Fri, 17 Jun 2022 04:00:53 -0700
Message-ID: <CACtwx-c+4H9owgdAwvZ_sjRKzAj2XjFypumOFLsSW2cWc3VTiw@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
