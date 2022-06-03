Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35B53C98F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiFCLuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbiFCLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:50:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AAA396AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:50:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id v1so4738334ejg.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=LJDMOxckFAK24DxWosFndIxVXyJ5871kAdJ4U+Za/gqZAX6YIe28gA1N8LwiX6VMg3
         /RiTHAxmt93vebTarSQdrhx9g0cDBrip7GCTb7QeaEGwiOtvAEXYNzouBlJHfaZtGnIp
         9kd3Rkn2GdJgQt7GKt0AxfiGtxYoMS6x7zJbPKn1EhjKjX/6HbzGrBYzHm/L+RVfxeXl
         yGCPFnNj5AnaVgT+LdQILcWL9h/e3hpcHkhmWiUuWhKzU4wJTFDgwC28KQww1eZ/fA5w
         1qIEApN9QUxVqi1jPGC5U+KPn0e+40Ey+8fM83sRuZXzpIoSBj+axZZ89mVd7uO1145v
         USjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=aVXvR1uYQwS6t1LHGqheroFk7QsMURCehBy+kuECHSebJj+bz4ODkt5p8bt41xTABx
         AvG2pmS66MvKFotcqzUDUSMgutEC3P4GJmH4gQ1xuApppgzBhmH+IU2aBX2Foi5zbvSI
         j0gYbLn4IqEUMPfZFs3zCoKpEfJmULcuwkEYmetHpluHmFltaB1lL/InaIOPyYYgtZpq
         DZUiJvLx7TFDMwUCNN+bT4I3V/BaRlh9ImA2/gspufRxC0fkats4uEt3LZS4LUe1X8Ua
         6zVruWNkMH+d39tenULhZZUOiWrXeeLGvMB5fChvNlql7rR2fLhBaTfrCQKJJv6pUFT0
         L9/Q==
X-Gm-Message-State: AOAM533sF7i/9VGAvGgucwcgFQGnE9SN+GSKOgO8/s11EJwiMi8aNRy0
        CRiHZIcgvOrdk8m8onA9emYeXWdKTGPun15Ghfo=
X-Google-Smtp-Source: ABdhPJzTv2MI0828AHZqcguQk3H+rfebIkAHqRkMyfzwkV4KxW8la7adocRhXXGirAq4IKWJvANSpiq4droyhqTNz8M=
X-Received: by 2002:a17:907:971a:b0:6fe:bdf6:b67e with SMTP id
 jg26-20020a170907971a00b006febdf6b67emr8024871ejc.312.1654256999252; Fri, 03
 Jun 2022 04:49:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: salifnaba@gmail.com
Received: by 2002:a54:3d08:0:0:0:0:0 with HTTP; Fri, 3 Jun 2022 04:49:58 -0700 (PDT)
From:   "Dr. Tracy Williams" <tracy0wiliams@gmail.com>
Date:   Fri, 3 Jun 2022 04:49:58 -0700
X-Google-Sender-Auth: h4NJfieM4bGBsDGviCvgQAHzQ_s
Message-ID: <CAJ7ceGespMkjvj=6TeP0ctcMjczECKrVvuiF_cqESNgH19AGXQ@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
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
