Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67C4C2C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiBXMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiBXMuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:50:35 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5120428F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:49:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d21so3527280yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pa5+KWLWH/xTD6y1ZfeTwhABwlgMcIDFHCErhQl8iX4=;
        b=EyiUlPGVtlaHR9wd6DW1+l/f9ODohMsj4HGRY/2BTWIK/BLyQt0ZtO0RuX6k/iBxhc
         +nPJJhatdFjdoF+vM7Pshx+BPZuk2J5VNcAF7IJNjU4zM9d+9uQdnBRSDTxpu0ZVR1lv
         5cXRxThBq4+HLgwPnlW0YLtmHQAze2vPyy45fRVqLG9xpmwXt/f68yXnYqYlR1/tad66
         hHRlnel2WHXweVnECfDTfOQboxLSPDP3ughXh360ohAiLYCSdyCvrmZZoKe/qGLb/5d8
         ZMWF8qULbRWL7tiPIWrm6Er+ojnCgl8WtaHwX2Il4dEpYdPcv+l43fv15yCiwdKtC6dx
         TISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pa5+KWLWH/xTD6y1ZfeTwhABwlgMcIDFHCErhQl8iX4=;
        b=O4DIw9UlloAWHLsy6BcrWrBfnYzYZxMFzbRS7NKxr/aCa13OJtPNWyl3HPu2WCkO4s
         NtKYwb5OdRrW4RuPQ0tkD+VYNENTq++BP79HGvopY/AZM7ds/3PI38yZVLUEAHBlOari
         jkbOS4+hE645euVxsDLee6knEI0oArJosDzScwtFJqDxRKYoH9uVPWOeTbzPtkaTU6cZ
         SkCaHwylYfeKeCguUxCz2qghbN7m3M2QBX3iJ2kmHzkJ44nEXf5+McNx40QlvBONPA7B
         29waEhNOYh3bQTJfiP7agLcuSItfwY1JBMgh+V14U18SV3SiFNGflBPwigK0Cpza+XKk
         E2sA==
X-Gm-Message-State: AOAM5316sJ0+MiS6QdXGxavIBljcMNzlAjW8pU8inLz+TRu1D67BrEq5
        qiThm28Fie7LUbcQkdQUEQNoauaxq2hEd64cpbU=
X-Google-Smtp-Source: ABdhPJzeW43NC84eHxp4YNAaFid7Y6XFHwPboEoutFHFmx/BxmLfqDkBrvRdhJUXx29fBrOiTNpMjcSiT55h8lIhGZM=
X-Received: by 2002:a25:1bc1:0:b0:623:2a4f:5d04 with SMTP id
 b184-20020a251bc1000000b006232a4f5d04mr2150670ybb.155.1645706997320; Thu, 24
 Feb 2022 04:49:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:90c9:0:0:0:0 with HTTP; Thu, 24 Feb 2022 04:49:57
 -0800 (PST)
Reply-To: michellegoodman035@gmail.com
From:   Shayma <shaymamarwan08@gmail.com>
Date:   Thu, 24 Feb 2022 12:49:57 +0000
Message-ID: <CA+HOoT2=AM3pJuZZAg2wNO0-2JPUBjtpthe442GmTiY84s+bFA@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shaymamarwan08[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shaymamarwan08[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht bekommen.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
