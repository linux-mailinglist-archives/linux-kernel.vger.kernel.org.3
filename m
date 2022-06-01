Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9453A2EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352194AbiFAKo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiFAKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:44:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7B7C14D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:44:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so2011400lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=zXFFUI7MkCd1isgXt46KYNwqCOMiNbgCqyPP3a+S96Q=;
        b=QmM/MTjXzwZqiwWeeSoFeMUc9WOCYYLu8JwCe++Vpo+sugBltKeg9Dub61przj8N+B
         4s3pJjZm6joF8/8+JsQBMmToh3KtOvGxSqHcANOPlV+1eq2vJ6N5RqHJQxbyzDABHrKc
         AjPjo9HOoV4Egt7k4ycdURkhO17XHNCAYhc2t0J/rxoa3XtWpNpljpZ9MLDD5GBo03ff
         FlB8mXPNzV2FvYBnYTrV17G/ufN641l+wgHfbBq//6imvYCBXtnx4iMvmXxfIiMy0dK5
         OokSxVhrhAWMC0pASMI8aeHXVdCTHUcVJACLC9BA62Q/CukumX0BJ/Hk8f/KGBJ1vnzW
         YeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=zXFFUI7MkCd1isgXt46KYNwqCOMiNbgCqyPP3a+S96Q=;
        b=7F7b75VhLI5KNEK7bMAslFEtkeQ0T1x62a60thp05YVAhdSF9lSt3meUXAAv8qOooA
         QrrvKJqpvtVi8VjDScWPjD50KU6gZw7m+uHbXY9V2OxPt8ZDvOGWwN4r7WT/yNpHABes
         ExLoSvp+H1X/1+kdBxhOCt/GNZb5sCOHXvdbkvfEubDBgGxbnlhHZp3B/Q1au5+DJvWJ
         Fc0Jpg35gGcu0vHObJV9UZGsuMFFrEEToldtf/lIHmzLcfcG7hYsmZHHfG1mYSuaYW7X
         UjbXTpxFJKvO0Gtrb4ZRESDJ4fpcHvuwgQJxDDhqc8g6vnY+CuHoLrovT5+74Fe18ex0
         cDag==
X-Gm-Message-State: AOAM531XLMvn1plWGlggQesJmdKAxFVydWLF1WvRsmXCtLbB369In3LC
        38XmrUdKeX0R4AfLVcV5ZMmcSqpYewNwo3hdPHg=
X-Google-Smtp-Source: ABdhPJyiZKR11YRYBypri1qPkxv2iqmXFmulUJYWOb2Wm7ItkUuIl7erHYZcpX14W9gD20IUepwX5rALI6Vq1pVjoI0=
X-Received: by 2002:a05:6512:32c1:b0:478:6f08:b755 with SMTP id
 f1-20020a05651232c100b004786f08b755mr33791938lfg.660.1654080293476; Wed, 01
 Jun 2022 03:44:53 -0700 (PDT)
MIME-Version: 1.0
Sender: luzynamelad121@gmail.com
Received: by 2002:a05:6512:1329:0:0:0:0 with HTTP; Wed, 1 Jun 2022 03:44:53
 -0700 (PDT)
From:   Qiang H Castro <qianghcastro@gmail.com>
Date:   Wed, 1 Jun 2022 12:44:53 +0200
X-Google-Sender-Auth: eC1XkpmQsjwLEThL12TX3ArT9Vc
Message-ID: <CAHnvgG8FXOX+ntWnhhvn1kAKVudY8XLeTB9AZu1dfE+JMP6dtQ@mail.gmail.com>
Subject: Hello, Dearest Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dearest Friend,

I Am Mrs Qiang Helen Castro, I have something important discussion
for you, please reply
urgently for more details give you further information. And I hereby
advice to contact me by this email address  qianghcastro@gmail.com

REDARDS
Mrs Qiang Helen Castro
