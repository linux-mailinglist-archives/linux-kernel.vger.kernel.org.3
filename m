Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE94FAFEC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiDJT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiDJT7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:59:05 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3870A27CC7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:56:54 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id j204so6636567vkj.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=JbwGbUn5XjC8ixf/oYJOSNQcQWuYPh4CEpwhnmutJxLp6s9gYcraM9iYlolW9y7fF0
         uu43VYQsunooF+hL8h0eusvBm8kjxNkF3Js6kj+A3dXD2gklm1bgnryckpzQukIIEWuP
         /I3B9sgOaoVd/mCkpfNvvHT/c/u6uLuq9VU2ocbeYCm0HuB+kLxVmjsb3PvQZKkYFCxg
         zTPoWtQQBT6sco7SMoiR9vGUS/SAAyolGdXA+UPW+e8eHKpA+5dAtURfxai6sjkVqlzH
         bS/pR4zeCFfQXqSb0onDDB4hMboCRXKLa12NGWnBBkCWafQBKMVGu7KKO50tE93Ak2op
         UXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=QYipRsqOXBNN8K8Ibe4gU4OII8NIvxuCfl+uAP6FHDFCAbgKi/AtnO2NtzC7yFL1Uf
         b4yDYPrNCwrz1FfBWiubAx9CZTqMLqzAma9xdFX63ueILrLTr57s7khV+qxX01TyXQU2
         x62Uyl/VLZvVesiAj8anxy0B4pW3uxBfe27KwitP+uCXTutZBRTIKX2Dz+FPJFTR08zt
         esq5dbUREJVskf9icS+tq9/7yvqqrtqcJu8rH0mS/OQfoGfQisH/SNN7Sd82JP2YF5ir
         baxTEiKRz0rAk9dEnOCMlByZc2t7bm598dk/GOwh8XEutKg1/rWUYwuZvqMfHyYTLWQ7
         ef2Q==
X-Gm-Message-State: AOAM532wfSekqsMTCpQzOVD/a1RlFpg9S2zXyA0/o12+FUVdVkDwj0zq
        DeH3cUTbFgEvnaEXCTpuGsWtnzk1+mLpfJPDopk=
X-Google-Smtp-Source: ABdhPJxZsdwDZZ+Zdnn7iyP9CyMxBGObZWXWkkkiX1K+5XuPBHAmmrBKhSEY5v4vyuEjFdXhvdLI4eMy1Y2sU95r1K4=
X-Received: by 2002:a05:6122:c89:b0:345:96a1:c0ab with SMTP id
 ba9-20020a0561220c8900b0034596a1c0abmr539312vkb.39.1649620612930; Sun, 10 Apr
 2022 12:56:52 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsnicolemarois8@gmail.com
Received: by 2002:a59:d84a:0:b0:2a6:5319:fba2 with HTTP; Sun, 10 Apr 2022
 12:56:52 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Sun, 10 Apr 2022 19:56:52 +0000
X-Google-Sender-Auth: nLbu6AUTLHp2aMjYwD3ZjBCHt6M
Message-ID: <CAAadsjtZ0rAXq_+8x1Oez2=7ERopPs8N1T3ioxaXFZb_gSBEQw@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsnicolemarois8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsnicolemarois8[at]gmail.com]
        *  1.4 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.9 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.2 HK_NAME_FM_MR_MRS No description available.
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow. My reason of communicating you is
that i have $9.2million USD which was deposited in BNP Paribas Bank
here in France by my late husband which am the next of kin to and I
want you to stand as the replacement beneficiary beneficiary.

Can you handle the process?

Mrs Yu. Ging Yunnan.
