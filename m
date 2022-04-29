Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD251494E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359150AbiD2Mcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiD2Mct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:32:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A11C8BE5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:29:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso5029647otj.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=kl9WqAo4MaM6HF4/MKbHBkT5G5dpJG9gi4XjoXg7GOe8Fj7f/l5sIyJRFgIBZTWpx7
         ju+YYVKQLvSaVq1fvipVWqlFpR8SwwAphUly62ZtWBBW9hDo4fvV1TQVyHgHe/miRgB2
         aMXWC0ikikhj2bJUINFFKR4UklQ9dUxO4MmiJNbdb7k3RdfBWiIQQ4DlY5Kgo73cGf1w
         Mmt4kAD+hCZajQec8S72jzEEbFDXc5TIXqEOLxFVzDOqzjcDNq+98wOVQtlZcNtS79ai
         7YZziTdKjP9huNckGLr9rjUJ/+943M2wzAi2fCEhcCfdS118XGcgmfKmLz+5UwRFeEEO
         RpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=6O9Qt4rzL+mVPG/sZ4Q8BSJzeOBrcgr0MuApdc5q9X6GxC9CiKAIpJPAt5M4mAEDPG
         lmca8rhhNLq12PGvEROuFbvSlFvVsHWyDFwmcpSh5aGHaST0x2uZSsuov8kO4WZmNQpW
         GO3F3gZICqBg57orpuhIwaQi59iRY0I+9NAvhgI8PwrLnZCRlQpSvHo2E2E9dKH178SR
         igj1j15Zkp74JM+QCeiYoR4lgrXq8zlfo+U5fdLc7rGS9T6dVQqw5lhriYLYIw8pZ09j
         CJbq9p0iNYy8eDmgDa3UUeg/QqFw25F3bq+pB4Wk/K/tdGEJgy6SVeX5j5qAsvQDgmcY
         J4Og==
X-Gm-Message-State: AOAM530SOFHmJtjYnwrYw1uRlqteXQt5esMrNqOEez6Ut2wJ5C3DWt0n
        sVIIhyo/Gez2hwnEwgyEdWJY+rOYX8B5jWS6xcs=
X-Google-Smtp-Source: ABdhPJyIDtS0bGblW91YZ3D07d1K4UybMWnH/9fPmFY2W9oktb974uEsqeAXdaqkkk0QtWeOjmH8J7u3Eev2Hiekte0=
X-Received: by 2002:a9d:7548:0:b0:605:54d7:44a2 with SMTP id
 b8-20020a9d7548000000b0060554d744a2mr13360116otl.23.1651235369761; Fri, 29
 Apr 2022 05:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:2ad6:0:0:0:0 with HTTP; Fri, 29 Apr 2022 05:29:28
 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <luben8213@gmail.com>
Date:   Fri, 29 Apr 2022 04:29:28 -0800
Message-ID: <CANyAdH9tZP0eczgCeeUE=6icJJtnOj3RTwhiYSGuTmzLb5+VhA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [luben8213[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [luben8213[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi Dear,

My name is Lily William, I am from the United States of America. It's my
pleasure to contact you for a new and special friendship. I will be glad to
see your reply so we can get to know each other better.

Yours
Lily
