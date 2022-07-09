Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2E56C57E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGIAh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGIAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:37:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92988E4ED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:37:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r9so256192ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=f0Wi5SC0HtQdvfVRWT5d66DGdWQ7dl5qGrvDVhZg5RA=;
        b=lZX9SzzKAsxhMIED81vuNxy8zolVLhmmHT9YL4WyrjmUK7FLBvhJeS18uPujgfcAgw
         uQK1ZjKcCsCd064QKdgZhNDlIvjc/FEd1/ObosAI2WBow92h7RSvyKFqbY0C9K/eWDNN
         wZQjMWIhJlLRy3ilQaSlylpNJtLNubFQESHLvrx0RPk3b7GWiua9S9WNQg/VdciNwT24
         JgZenf/VkUgGbtGUpXeYpsdlwONELEswrsB7awAlTFLzlIk6qkbBrRikAO3rBkecrl1V
         Mxs/nPF+NLc7frHCs5jSQqAKDv4caqAJGBpGjIj6u0ZwHKHe3+frNXnFdVy8oucT/PMZ
         +niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=f0Wi5SC0HtQdvfVRWT5d66DGdWQ7dl5qGrvDVhZg5RA=;
        b=YVCntav4tYHwnRd3gO5awgniN+0N67uWx7Az01tFRpJ+qqu9xLskHtgSiQC7IAh2BO
         dt5mtaKZu7h4KMKhAzBuBhcIaOBkkNdrDtP/hLEPY9KA+s2NrJ8LQD3/WR3cpACGfF7j
         Q31MfqKznHtk1Zjkx79mfRKWTb50M32ZfZzrgMtGx0d7CSoaqj+EGWjcXYC+JcGZC8UF
         mEll2p8lS2EIUHVruTymA01A3P1UbH4k+U895Afk8OLwfFUT26CSwOaloiCAkwICXo6L
         aCSSwAkqZAH70u8jO6ONVhoLEqjBDYbSr+e3W+2hJxmsu3JCiQC6OeYsOwc/MBlWeI/Y
         3Exg==
X-Gm-Message-State: AJIora+Lcxsrxt2j+9u5GPQRQwqjdofdgekcVfaQ64azBmFnL/ZY0Wa3
        nNqlX8MivVYrtseKoBGIHMHbwqBhUQLSd5iggLo=
X-Google-Smtp-Source: AGRyM1sx5YuF1DuOnc36ljQF8oTd0YmVW9F0yx8H2vKeGwKcfUKrhtQvl5S10mlCE/lUFlQ9h9mgIF+vVckJLCgBT/g=
X-Received: by 2002:a2e:98d7:0:b0:25a:73c0:fdde with SMTP id
 s23-20020a2e98d7000000b0025a73c0fddemr3229171ljj.15.1657327044061; Fri, 08
 Jul 2022 17:37:24 -0700 (PDT)
MIME-Version: 1.0
Sender: nakodegbe@gmail.com
Received: by 2002:a05:651c:508:0:0:0:0 with HTTP; Fri, 8 Jul 2022 17:37:23
 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Sat, 9 Jul 2022 00:37:23 +0000
X-Google-Sender-Auth: 0EUaiVxtXcDFf-as24mSWVxUYwc
Message-ID: <CANBqjYbMmKwSEFvkpLeJ+_G0k70yPQktdqRgDumNxcnS=1xnjw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello
Nice to meet you,
??
