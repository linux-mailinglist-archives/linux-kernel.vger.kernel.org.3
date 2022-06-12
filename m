Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E26547B17
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiFLQqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFLQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:46:22 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005425EBC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:46:20 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x187so3879990vsb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=KF838rfklVqafdVkhj9XodQQLvYR/jXbvHnYHYS9XVBF/QG+SW94Uiv9itdTTsgXpH
         UyTc4PpR9RAv2/jsjIEbKFmaNHB7SKiDtAua5CZO78xra9K6nmRxpMQeykOnglkjk4+q
         CmvDrdTJbpFH4Akzb+2Coy8N1cPglISg2GFTJ70IjLY/CWdudsb/+ecz/9HXTKsr1Euf
         5DujD0+keZarQ+bmI2bPdy/OjeWA/Igkx+ktwO/f9w5mk8d6WUfQYwMGzGxQaS8WoCR8
         313aLiH69EvsMZuWGQlYzd0mO0jH1np10aZmZjXe1AvToGAPj8zNcTUIhQ+YbmOwC3gh
         Qodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=YKWxx/X/qzi0KJxITg7TUlRWdFP4gUOdfoAXV6nkZvsJZXxeDrXMl2YLUknp4kNcPJ
         wzUF7h4Curg3n3jzbq6wwMuiq7xhML6Osw8siha0F8aWnFza2hynjKajTtlSBRCfxFMb
         H/uhR9yieG2S68Z3Ycxi1SZMtptjD5SEA2jROkDFbCqNvGZrN1zzOAaJW49hXg4CkCoM
         UUoL4cVkQd5f1BhXXk6KwFNOMhTTrAEIt8xklxUrhB5K6ZvGG1OanyREIbNX1WFYA8XB
         HMkFQySeeskH3TVMJcte+PCGiGewbXhDeVInFPpqBm3P16A2tpG7tWm6A09CyOPDbXUV
         YhaA==
X-Gm-Message-State: AOAM533cYSWnLuqL69ZxOei1beuHLZRJVYGUD6D+2TTCVHcSacSGiw6d
        lPQ3YqFC3nB9u8JH/pWu/Hc6+96lqQBOLrILXk0=
X-Google-Smtp-Source: ABdhPJz7fOEjHbLf8W9dE+1b2sM+PZBLLQ+Un33DLJqTnrp4/e/SJdQiTauonf6ptN4GcpC2yH83SdSCnkXXASabrU4=
X-Received: by 2002:a67:e3a7:0:b0:34b:9a22:c121 with SMTP id
 j7-20020a67e3a7000000b0034b9a22c121mr20900010vsm.0.1655052379592; Sun, 12 Jun
 2022 09:46:19 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: yeslew12@gmail.com
Received: by 2002:ab0:2508:0:0:0:0:0 with HTTP; Sun, 12 Jun 2022 09:46:19
 -0700 (PDT)
From:   "Dr. Tracy Williams." <drtracywilliams12@gmail.com>
Date:   Sun, 12 Jun 2022 09:46:19 -0700
X-Google-Sender-Auth: 3ItnokI-w6lp89SsoXYm6z6Cj3A
Message-ID: <CADZHuGzN+Ya2UfGdEWk3LYgOcLQYu4g3WJUaPc7zD4GFG2eLKg@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hello Dear,

how are you today,I hope you are doing great. It is my great pleasure
to contact you,I want to make a new and special friend,I hope you
don't mind. My name is Tracy Williams

from the United States, Am a french and English nationality. I will
give you pictures and more details about my self as soon as i hear
from you in my email account bellow,
Here is my email address; drtracywilliams89@gmail.com


Please send your reply to my PRIVATE  mail box.
Thanks,

Tracy Williams.
