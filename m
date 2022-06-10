Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197E9545B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiFJEl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiFJEl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:41:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C2EABAA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:41:56 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id q14so24418701vsr.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 21:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=hAz7EJlFKcAPV0dtizWhcBtjfq/Z95B5QKl+XIwk3PA=;
        b=mjnn7ovwSujFuqsikJ/LTgeqn139VKVnwRRrbt3orzBr+gjAMfpFEtMsCG+Ntzw2Or
         qzLy32kiyH+8ONED/EfSorN3MxwsEb20/tQE0R0oCoIDpfCilCb+bKe2x+TMdHz0OjfH
         7YLrf0WmEx8kz2KOrmivRDqmGWCAOhqufyALQnfVfaYL+RjMsfiIPTgw827cg8Gqclfr
         lT4AQEjqOiEq8d5uvnn39vg/vivfiDLFa6nFouTdwmEM297q5/eDgJ3BlDsdZhJBflgO
         sWXankQSd4DMwz18knbXZ5xSpoKedwTv5rAuiQ0M2e91An3vIChbfQeFEIGxjpt/3qcB
         me/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=hAz7EJlFKcAPV0dtizWhcBtjfq/Z95B5QKl+XIwk3PA=;
        b=2t2Aw2wmjI3pNnpxd/qj8mMdTpQALhXnFcBXldhG7qSKuj5TkZgekbNrUuJU2auScz
         RnTZlDXy762xLkbTD8bBpLOliRLpxOBZ7lIUrzClKc+9d1tRk4ooQPNOvlkHEVO5DUVh
         vOwQKq0xpDMYAo7hXYeed9DB4afp9LtTzFne9eSioqI9CLD+CzPUyKUzG1PirBl46Pwk
         d7LtSo/KzTd9zLh2u+rv7oiE1hO6ukBzxKDmGgOFoqihoRZijDtBhKj8mtTi5215vtvJ
         31L2eIANwXS+ANDbSyxIOd7l2HStZo362u+wtJLkHZ4QjR7mmQyZe0zNg7dHAbgOlX2r
         7+FQ==
X-Gm-Message-State: AOAM531cHcNdoKxPDcTKBZBHbCOxM8Iktam5DGimmaTi+PISOBtGFecE
        0GjZu2osaSh4UL0cdlUv4WitwcWIzgIEKk4/fEE=
X-Google-Smtp-Source: ABdhPJxzj+p4kJXtBHHjULKnw15iFe+XjfxftJ08x7e57wQzTkR8YZEPNwlAvmUwtLv0eLJAVu7GpfbSudmrIEi/9h0=
X-Received: by 2002:a67:fe0f:0:b0:349:f37c:963f with SMTP id
 l15-20020a67fe0f000000b00349f37c963fmr18197725vsr.52.1654836115250; Thu, 09
 Jun 2022 21:41:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: azzedineguessous@gmail.com
Sender: dr.daouda.augustin178@gmail.com
Received: by 2002:a67:f651:0:0:0:0:0 with HTTP; Thu, 9 Jun 2022 21:41:54 -0700 (PDT)
From:   "Mr.Azzedine Guessous" <azzedineguessous@gmail.com>
Date:   Thu, 9 Jun 2022 21:41:54 -0700
X-Google-Sender-Auth: QX5LALxhFEg-VDNobckKxYBBEL4
Message-ID: <CADQawC1kKORmUwez3r25wHwCzsh=MC6XjFdOfAJ5W373oBoOoQ@mail.gmail.com>
Subject: VERY VERY URGENT,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good days to you

Please kindly accept my apology for sending you this email without
your consent i am Mr.Azzedine Guessous,The director in charge of
auditing and accounting section of Bank Of Africa Ouagadougou
Burkina-Faso in West Africa, I am writing to request your assistance
to transfer the sum of ( $18.6 Million US DOLLARS) feel free to
contact me here (azzedineguessous@gmail.com) for more clarifications
if you are really interested in my proposal Have a nice day

Mr.Azzedine Guessous
