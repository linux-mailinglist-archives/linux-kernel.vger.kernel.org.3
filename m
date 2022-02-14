Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0C4B4217
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiBNGrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:47:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiBNGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:47:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BEE50459
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:47:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so11006536wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1RyHqCxoLsTpmMsHtqy/wdC2TroVDxtcrh2h0YEDbOs=;
        b=paDH/jpntrQo4Exz0E9rX1YvJ6pkhQbdWxqD/Wm5HHbLs6PtMK3gsM4Mn7Ik4ju+LK
         GGu+6OxWNMH08M2khGXoOETNdx7qBuqhsqTwFRunP3XCuPdZzTwyJGpGnd2/f7VmK+sj
         386PWgktW/x1Penhb0xWOwqBZKUzjUmGqOZbi1f1WLkAGjcBqyNuPqcLIqVVRETry+vE
         xDJvty2Z+pQzcysnVKzPfB9PuJ4ntib+RB0x3Q7hFcQlW4C3Jdhy+7u/rXi26nVmVNrg
         Xn6Tpw39GndU7p3rlu20EW9XCTZqOP7TJLPZmTl9gsSLrwFzvM+xcR+qkOtgi7K2y2tw
         PSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1RyHqCxoLsTpmMsHtqy/wdC2TroVDxtcrh2h0YEDbOs=;
        b=NZGAsfCcIzKNUSGRd1U+PfGvGSGWd5vu+JJpV9WhFKWon/DK2w1pr0qauhVsMz2pzX
         /9L0XOaFLEPCaAlzHn314ZJksubROvA2CX5IrOhBBX9KyJHWYxBdCU6Dd4+QJNlIK/I+
         wMk7iA2/tGBkRyRiX+gMR5jY9isqNS0YOyxGGbBgdL8XHDzAwpbGwi39VTUNUifXD8a/
         kcnLVjbMA/l7PcSAdx4XZZGgfHgFm4Y83NYZNghWs+e9UL3eEfqvDyxBRNiIwvsAe/H3
         m0WjVPwRf7m2d3qiS1ixlvEL4SOdBnulE3ECGQxPaISxJwkOhezgP4iSFvgVb2Ma2tG0
         n5HQ==
X-Gm-Message-State: AOAM530pSpRiy9N9BfiQBz98H6xMeyBfKFi1CHEdo+u/48rdTzEcTdAo
        Qmg8gAoPBPjkCKgB/RMFC0rqOF7ct4Fu79Dqv0k=
X-Google-Smtp-Source: ABdhPJwmhZTWQUgWHXBQOZny/J0lX4LlVWsrTRQOBfMRA4Gqu2bOysMJNUIB1oqMGqurp9p9+jVPYSFW87WKb9KUSxg=
X-Received: by 2002:a1c:2645:: with SMTP id m66mr9862247wmm.39.1644821254249;
 Sun, 13 Feb 2022 22:47:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:6d8e:0:b0:1e5:d586:dc44 with HTTP; Sun, 13 Feb 2022
 22:47:33 -0800 (PST)
Reply-To: sophiaernest566@gmail.com
From:   Sophia Ernest <dribrahimaziz00@gmail.com>
Date:   Sun, 13 Feb 2022 22:47:33 -0800
Message-ID: <CAAJnOwAK5Mkbu+_i5ML2TOdJrSBVuWtZzHjBpXTLGPdU9nW8DQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
Sophia Ernest
