Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F26530C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiEWJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiEWJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:03:24 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE07D2181E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:03:22 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id m2so14283602vsr.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=SBQ7DoRX5gke2Q/mjE+5kshDm2ZXV5BSYmR3xP+RX3pizdNdkCqCxwZrCgfW6Q6k4a
         AKhYxKrlrZgoBKIk666rQM60dgh96ZLXCodT9cE8VCfRB5eeOqIicLv7+kpMq6cTQ8c8
         ejMQHBueujEz4f2ca2RGM/qT1ARLSRToVZg652lvR6HAxp89cw3HP4bGZlMJKEG+QAvm
         r86VM89JrzA6yRZke0E3dver/UrlZjAUmxTIZo36unDem/m6AJKkjagAlJH3Ciznu6ds
         yUnVQimunM33yRnSjP9MkOG+sWZDqgmT2sKDVG99aI77xfneLLNxzdBeyLvNZxS9taTj
         u92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=QGRpumgR+EQVdQDvot7l9lCxjS/hed/oJtroSRYFW9DXYmXNqzYQAbQtCFSULhXrKY
         bLlmayrKhIPXfGr/SkvXl14YGjdPgOcyfTyjFDuF8XawKa9985OJTzfz4E2New7bV1y7
         j4iATZJAYitiv3WEYtYl09uxdntvoEY3xNX9ekVVFtwATyvXdALoNGDHRrY2nok9Vgbc
         6klmDmOXG/9knpjWn0+SDKjO3Zz3tDz17y9TXoQXyrieJ9g3jGa2WxypvT9y3SZdsPhj
         KFqYi3a8H2Nzg4xyo6L+h6btjnrVddyGkRp5+RdOFuqkJSouNbnZ/HJEGaDyOPv4z0zQ
         LZ/w==
X-Gm-Message-State: AOAM531lcnMPKoN3uEDWBEJgDqgLPnwglYTFAEzwT7736IZlSqtwYuO2
        7mSgkVLCymLUfi/ENqYMh7Z7t1dtaUUIwh2AGt0=
X-Google-Smtp-Source: ABdhPJwMg466ObMsD3WrTt8zEdOs/0VcOJ/Yk/gB2CP4n7eyAnjpKdhcr4ygj6r3b4Kyj2NIG6DIoZDQ+8V3K7C6UJU=
X-Received: by 2002:a05:6102:23d9:b0:335:e916:b99d with SMTP id
 x25-20020a05610223d900b00335e916b99dmr7336394vsr.70.1653296601763; Mon, 23
 May 2022 02:03:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:1095:b0:2ba:f7f:f651 with HTTP; Mon, 23 May 2022
 02:03:21 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <kodjoafanou2001@gmail.com>
Date:   Mon, 23 May 2022 09:03:21 +0000
Message-ID: <CALgh3en0h6bgLUPfRkvH1jy0X-S3RY9AJiKQuw+2X7O994kH+Q@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kodjoafanou2001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kodjoafanou2001[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
