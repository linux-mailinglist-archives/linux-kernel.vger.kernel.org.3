Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999D531FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiEXAwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiEXAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:52:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD106D860
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:52:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u27so22714116wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Lq05UGBMp/WuXdKNWtSKmclauqI5mopAg+URRW84cDw=;
        b=OUaOh8PeP6weSXE5Hjby0Cbeiajfb2VgiUmK4BhSLsdwpAy/c+aV92tJ/enLW66geM
         bcGuuSNpjwwzz+/UWRNMg4oZWMeqlJMqhZDaOPmeJoyXBbMTvBNsqHw1i6aHfjNF/bxd
         +2oIWIWPOybC0iWS9KWvG+rm77JIijGvGbMyH9uJKaZok3RJIoj+stNpaWQc0QbOpulh
         H+2ccGstsVJwUHZPvqrLEjCvngQrO81so7Uy4RXG3vje3PO7CYaXB5YqcbyyELckuCN5
         Y8MdKBG7ihLyd/7DfXuQAJ9mAp6IOlbNdWTt3xpgBNYT6nyhl3eV+0c3G+6rxTY1xkNP
         vFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Lq05UGBMp/WuXdKNWtSKmclauqI5mopAg+URRW84cDw=;
        b=Z8Iwo/M+HziDTzcmccSdQ1uZ2D07bj7sxuMRbxsfMifsNAKXfspXG6nGUK0VhUxZ0r
         lnQfMdgENSxmW0TTDBH1ocY3SYlxE1cVupQy7UKitA2ZdCqU26a1ljs+Y73TfKsIYLpZ
         eV6qop+anRE4/TZmqeno8ObbYkvpbkCU4K9jJrFUrVOw2VFnCc72+OLEvmCw2f6zA6na
         T4HGbjBg03IFRW0pRz/4ByS3eQCycTbvQLE7k2hkMwUjKKvXTIxC9xfe+tOOr/wytTff
         eKXvtqrxnhPqLdpcvlGc9GL96JOsgklO3sQ5W5+a9cXdUmJIv52MXuIGz4IInVDrcgii
         jklA==
X-Gm-Message-State: AOAM533G34G2O3roKGSTd+mZ/KK4f+HYdjFRLtdZ7PttQnoWtJSrf2Z4
        fuOeGJAgX9XNoM8ZLxGk7lqHFIydSagw51UwN4Q=
X-Google-Smtp-Source: ABdhPJxAk7ruwkd5SnrOuiDaDr9DkqW82WQF48aThcBHlEfplGmY7C8+iG6wLHDT3Cg270CWv4irDdHxPELf7QrawE4=
X-Received: by 2002:adf:f183:0:b0:20d:a92:f244 with SMTP id
 h3-20020adff183000000b0020d0a92f244mr21143982wro.431.1653353550305; Mon, 23
 May 2022 17:52:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4289:0:0:0:0:0 with HTTP; Mon, 23 May 2022 17:52:27
 -0700 (PDT)
Reply-To: mrsalfaro184@gmail.com
From:   "Mrs. Alfaro" <barbaraloken377@gmail.com>
Date:   Tue, 24 May 2022 01:52:27 +0100
Message-ID: <CAJVLsjpK8Zbqz_chboAbC_M27nfkXrm7CaxsOGHF+e4-a4U=eg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5024]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrsalfaro184[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barbaraloken377[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barbaraloken377[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello

My dear friend

How are you and your family? Happy that the Coronavirus reached a
point and goes no further in your country. I just want to know that
your email is still existing,

Looking forward to hearing from you

Thank you for your due consideration. God be with you

Yours Sister in the Lord.

Mrs. Alfaro .
