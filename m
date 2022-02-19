Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA85D4BC946
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiBSQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:21:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:21:03 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B87192F00
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 08:20:44 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id j24so4224266oii.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=YGuSFSLMkF7GFHzJh1zqvsTAAW1n0gFqILKWnKfACMFpCNUOd9on+3A/w/g+pFJqA3
         xZQAWO0SLB5+FycsAJgX/cvOihauJ8tPao7eOOrZJHrNCdFSGMSfNiDxznT0Qp264Wa0
         wcjdFy23DAMLuRhcuPGXryVHTDdSSJ+We/F/w6Soy+MFRHrq1OFXoao3g91t+WAKN89h
         31+aQQ+JHm0HvpPUGGT/7cpaV1375Rd4JR/Eszt1vMtUtIUUT4JSyQ3G2brNnktJAs+5
         fG2Ynx0an9GV9Zch2mWYqjYmKzAxk+gSY0J93Fu9ulrg33DGRqt/MMMjU0uUVwXBqJLi
         KKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=VAjBQo6zPuLFd4QdTf8B4kwRRQmzxQ6OmjqBSj1WsNmYlk9urJm6bXgTubRqwU+/RZ
         iP2CpMfheHeqKszwlnqz8/qV1aK7pG5km+MPzYnbiQlwmTQUHdgY7MaPqZnFLWqGMfuF
         Y6NpjaTJjT8cSLOW6f8HDBhgdv8C+GAmDV3BKyuY/c9r/Tk3ZFBwUrqldjahpLKITf/L
         5Z99BSMuiK1GYYxxzq9I//X0/cj9Pc4ab7l55KKj5rnnJ4A71hawvCy2zTAIUcyL6+5y
         CeVkeGxKdBYXafbGErk1XQ6bcHKik/85v+K508y3VoeU7XCTAiBHoQVD9UNVEsqKeGBi
         awpw==
X-Gm-Message-State: AOAM532MOP1AyCA/LLIWVnSpsGtw4l5/HoXMzcor49rNI2yer83JHBya
        B1phrt5KmUCe8hQPqwV0lqeNC58tU3Pj9aa9dZU=
X-Google-Smtp-Source: ABdhPJzCJlq2Z4mJhRtmGY/+epx36XQ9YLljdGHJdJsTOhd1dOYvK8/WDkWMp0xWdHWLetRM0hdHDTx5iP9oPoGhViI=
X-Received: by 2002:a05:6808:1596:b0:2d4:956c:ff1e with SMTP id
 t22-20020a056808159600b002d4956cff1emr5023216oiw.189.1645287644327; Sat, 19
 Feb 2022 08:20:44 -0800 (PST)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: bellomamuda46@gmail.com
Received: by 2002:ac9:3e81:0:b0:409:fa75:363e with HTTP; Sat, 19 Feb 2022
 08:20:43 -0800 (PST)
From:   "Dr. Tracy Williams" <tracy0wiliams@gmail.com>
Date:   Sat, 19 Feb 2022 08:20:43 -0800
X-Google-Sender-Auth: 61EM1B7xmffbp1nO53uLyycP9fM
Message-ID: <CAPs1NfvjkvnvA=itbkwu=5m+fEz16ad688B2c2Uzsv=jLcqLRg@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
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
