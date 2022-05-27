Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F65365AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353102AbiE0QGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbiE0QGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:06:40 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7511582C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:06:39 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-f2bb84f9edso6237595fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=PKkGEnLiiR2bbr2WU160kqkQTGPehhinyPPDDKuTVF74E/kLHJZ/YODwfPKAARv06g
         2L/LyyYl3drKyy2mV3a12hLh1cjM9KcUW+YDzLtnhgokPHIAab84KkLPptGVcwK7qH+q
         ciPtEHt8TOwHHgK8ThkLvJxDsMT+fusLc7PsTrlCC6aM+E0+jb8WnFk2Atdrgt+6oqQN
         QUjP0i7AO7+/ArKlUjtj5/MCirkj6dGAtlnhnuTOONXB1vQ5+5Vvd6manphlHAOzVEOk
         o3JOsAIIp3uH6hqAZJrmgim/uREbgaSqaNV058oqul7tQcBp6y6cSTcQqKrE0shnV9hP
         OGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=o0MNK4+fTLGo05NpA0jq54vF7WrdBlJPjGhz3o2/kBhVAZEZdjRJCejixqhQMdPIFn
         xb7yG9ulEVO43wGfSNbQ0Sz4vzMNptCIXGyUxIffkjRoKYDZyGDqAAc/bItj+20GcHhL
         kpfT8WOJ0OdfuPqWSBvezYFFBNLSAXcSwRzzt9DsqhvT2JHOVJaklx7z5h+Sk3rMaxJJ
         NjWFZNbOSralQF9B+MU6udWGZtqm68jbGzbPgmPZSC/9OiziIRXdGTh6uYEwstiZWwTr
         hj5/l1+hMSaq7O5dD+/e+cmuW0XibrjC96vWlHk2fJNOX+0Rf2EjH3McQ+9fGtDIIx99
         a8Sg==
X-Gm-Message-State: AOAM533mcgtGBaXm8md6q+pcCxVn6dDYIVZksQ9zFJzWjrQxEzasKGew
        S0YSXdyYAyEcRIi0b9FkputKQtAHkZ8Os+JhcG0=
X-Google-Smtp-Source: ABdhPJxDWTnywBMQ/RDfi3eNoQd3wXXTkBid6yxGtef/nxw0LIJCFbe/7tVI4EFqlbLD3N24VcjbrllOnW/s1FdZKEc=
X-Received: by 2002:a05:6870:1716:b0:f2:fe7b:f688 with SMTP id
 h22-20020a056870171600b000f2fe7bf688mr1213757oae.268.1653667599125; Fri, 27
 May 2022 09:06:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: atminstruction@gmail.com
Received: by 2002:a05:6830:43a5:0:0:0:0 with HTTP; Fri, 27 May 2022 09:06:38
 -0700 (PDT)
From:   "Dr. Tracy Williams" <tracy0wiliams@gmail.com>
Date:   Fri, 27 May 2022 09:06:38 -0700
X-Google-Sender-Auth: 1dJ-2HeTjNQbIXrt_FeF4Sx9kJw
Message-ID: <CAGNbUyF=J0Yvm5AxQfhqWj4RC4MHK-MSH3tNd3Dfeotav=1scw@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [atminstruction[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drtracywilliams89[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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
