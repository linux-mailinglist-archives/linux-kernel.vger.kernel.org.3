Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CA5918DE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiHMFUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiHMFUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:20:34 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74BC64
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 22:20:33 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-31f443e276fso27091767b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 22:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=S2u9Q+tjkz31iCRfklDeKGl5LtO3Yk8kTNoA3qpbsNs=;
        b=Hq+uZa5BeZuwK4iRGfpv/2u6mpf33ct+kodJ6Gj6RpFVEDLQO0OyiLirTBk5x7e8FK
         HfoELfYq4Z0j7kUNokiZrFZ8QxjKuYnCF4WeRDmtU5bhzy4sbgF8cOgwPmcRY8mF3k97
         DEMov7LQ/VOwpji/QPALtev9jxUyS9slrfEuATq0PasY7hc1daWGfFd2XcAft9BDmiuc
         dVn3x7s9UpAEpe6TAp3xuP3TPj1Dj51NcEXT2F0qEVs5qzr0aETgmJ6BYNqdfAERLPgG
         k5fHLfxTGkDvzdfiZawozlJyBWZPWb1Qp4Ml0xsWN3K/NzfDOzdp3zLU5bZ2tko7J4xo
         TfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=S2u9Q+tjkz31iCRfklDeKGl5LtO3Yk8kTNoA3qpbsNs=;
        b=NyemR9g0ip5b1uBt9bg4LB36Aol5t1dRGnFKrT20JLkok1UueUASUUtleo848BdFo2
         YSZaU7EZQw1gT/h0r/SYrAPPX6cv1v+V25F3GM7BuDIW8zu1Nondlcd2HtEUBMTnCNdG
         VnM9vcDSEp5wKLsrbxMQTlsmF6VeYTT5zJ8W65xZThr8V56xrwj147qn40wLPTs0Vu17
         Nc6m2jTpVjxDR+z8gM4Rj0NuYJ+M3KiTyxV6sedAwPoCPo1PGC7cek77vM/7SYrUm5qE
         cSmD8m6p5S0AHlM3IgP3chOaL2p7Jj0+kDuJQxmTdINuWI712JfrpO2KU9ZIbO/KERvz
         PO7w==
X-Gm-Message-State: ACgBeo3nawdNE8FhLGwfLBseHE0hLuCkug6m0HdsJtmipckWGNUFMx9w
        4itAa+J6OrmEtNsl6OYfqTjDI9yvqouChk/qdlY=
X-Google-Smtp-Source: AA6agR6JoMisepX9ioFanx4hKvxl0wZogZ3kGfd1ltySiyDyQayn0SscImIAOPaw2Rdvj4q2KC2Pd8C77vDqSADrFgg=
X-Received: by 2002:a05:690c:397:b0:30c:1c1e:6dfe with SMTP id
 bh23-20020a05690c039700b0030c1c1e6dfemr6465920ywb.113.1660368032538; Fri, 12
 Aug 2022 22:20:32 -0700 (PDT)
MIME-Version: 1.0
Sender: mrfaisalsamae36@gmail.com
Received: by 2002:a05:7010:a40f:b0:2e8:9cd4:a608 with HTTP; Fri, 12 Aug 2022
 22:20:31 -0700 (PDT)
From:   Ariel iah <pb589847@gmail.com>
Date:   Sat, 13 Aug 2022 06:20:31 +0100
X-Google-Sender-Auth: oSSL8QzJdAyIwK3-kn2D2_A3kKI
Message-ID: <CAOkhqeq1DCj4GofaxFYiPwSE5uKMfnF+tavbxwVAT-8kbNZgVA@mail.gmail.com>
Subject: REPLY ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs  Benaiah and i was diagnosed with cancer about 2 years
ago,before i go for a surgery  i  have to do this by helping the
Less-privileged,so If you are interested to use the sum of
US17.3Million)to help them kindly get back to me for more information.
Warm Regards,
Mrs. Peninnah Ariel Benaiah
