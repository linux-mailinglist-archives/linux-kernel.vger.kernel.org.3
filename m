Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE058C54B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiHHJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHHJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:10:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF56585
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:10:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z5so12691338yba.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=BXONmG4NT7Ps0k3vlwo+5xQkbC0wR7bD23e2Idydv5gt4/tkSJ5iIaQb0wq3ab/A+a
         aUL4zwLj5a1eyo3a+CLSLsCb3hAaSxhjIyJ1vgl5GpaYgi5OC2bqFCXv/cD6netBbbX6
         Tx3nJqFmDlXHOgv/8N53WShK1xRedTz7YizG0EQ+d6+Zn54cQnePxEwSsvpJ9Bm2kAh6
         rcy4zTsy5gz0KNlNIf7ZoxH4nRwifKu05WcmJrn6aJtL3dAK08hL8lPgIfWygcqSGBwi
         VkO6uLjjD9F5LS5eaiWYQOwnj8jaKMC8wLjTgmKV972zelkc2S0ha0Lb+w+BtCW4FQGH
         9qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=yHI8ZUCJT/2fNpgPBT/s7owQiGHi+i4nU4OMrMWHs2unQsuherEHToLwziUnga4IjZ
         m6K06PQHgdb9QalOu1C0SFLBYtsXNkuhHPHno+PFjh8h8wsRSN6+RNTiruh/DmG4r4I+
         CIvKTcu+MXY+yhbuU9leSFrRUgLU9raceQtz65rs0AGuMmHDy6e3NhW6lne1viJmZKDK
         cPrKlCyyG7YDKAy8QAIjWrC0zBO7yftTd0mAm+L0Zq1Zo0/6ZviwVqL8W+ueWXSdcStH
         vjiIqoD4WgshIioAEbAiAnApQSx+rWfz+/A8ycP2giZyS5UMy9eahFUFjnT7JN4ogkWn
         5etg==
X-Gm-Message-State: ACgBeo3NRcWIk9k9Y+G0ca7aCxjhUCcexXnjOWbCEUjt/D0Ly4Bv8KGs
        w4Aan3v8mcHtBVBoL0ijTv9vsw7HRM+KPrBYV6s=
X-Google-Smtp-Source: AA6agR6ww8LBWAcj4WbUTZx9wZCglfi8vTK455s3Sjg/D48I0T3JlccLImfEudV5PbJMV3GB6lWP8FnqDqG6iWKcIFQ=
X-Received: by 2002:a05:6902:690:b0:67b:af6b:bc92 with SMTP id
 i16-20020a056902069000b0067baf6bbc92mr9677412ybt.459.1659949821415; Mon, 08
 Aug 2022 02:10:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:4a9c:b0:18e:7ed4:6c87 with HTTP; Mon, 8 Aug 2022
 02:10:21 -0700 (PDT)
Reply-To: Drlisawilliams919@gmail.com
From:   Drlisawilliams <grahamkhudori@gmail.com>
Date:   Mon, 8 Aug 2022 11:10:21 +0200
Message-ID: <CAOPDNSG+QRY9xPP8WKYA6+BxbOe-x_QGsyRVE9MG-w8RHz5yVQ@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks
With love
Lisa
