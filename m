Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9E44D0DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbiCHC0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbiCHC0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:26:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913B3464C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:25:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so599831wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 18:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5+oocItIt02OkdY+m5813Z7pgg3BMDr/tC5w+npdJZg=;
        b=AiMI3ic+c9W0lQVT8Qc0s7bhst8oB6Hu/315RokaPz1HE3f5gq0/BkB8ZVLe5pcBMn
         sx2gpITRQi37OyRdMym6wRU06to20t+o0kodwef6tWp0tuMfeyJPucsC7sk4EAQ/P5Vc
         1Lsa7vvfX5862J/NZ6J7VpLYtO5/j/qlFRNaJT9izyKsZ0kQ3I01etlEUYWi9DgxlIVP
         9zvL7DdUapu8rxAz3sjWv4splWzQaADev71rC7QxrdI6V9C2VnmwUG/IH3xRS3kmK3Jj
         zwvAPiXYdf8eHOOdw5nrHbcRlh9FaCW437YkZMUCo3UmtZJcCokDLxcuC3DnmlpCq1mc
         xQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5+oocItIt02OkdY+m5813Z7pgg3BMDr/tC5w+npdJZg=;
        b=a+VrtV16xQT+tVRPXXENnbvSfVN5ZUQ48n0WX/Wly7Kfxu7V81lakEKSsJikFE+SsQ
         xAEMgbvDvRNjlznpw3wtbtToXbkgqyxy0EMe+8JsHWithVCDUqC0i38hDrO40jbkM/sP
         oz6UMjwV39MswAPbuiQymQD14h7exhh5AaWRozb/rZ1k//MuGDbOBOtYv5RX3ZEDvNmW
         QfEL6J58cLvVY+ir2CUaxqNGp+e/EYMsPwtqPp6/bQ+11kR/foZe+/XYEhM8tg0wyO+/
         twvPhjgTT5h7+WgDtLxJeWc9s2W/4uvJ6MiVmeMD5PItszNnplU7juw21g1f6M3fRnJs
         PnyQ==
X-Gm-Message-State: AOAM533BQ45b1dCL10Zo0uiZ+iy/eWvm6Q7/lM5WYn7nnzU4MGGT52gV
        27DgEQgbermyXP+jcGyw/XSteLYF5qr6Bnjqwmw=
X-Google-Smtp-Source: ABdhPJzTG9goj0wNUF4bEiD9RmpqkpN+LLR6otxwoxd1Ki4BJ3fygxI1QvYTS/DthC0czGVGHSFR0KHiqAsl0CPXPvY=
X-Received: by 2002:a1c:f009:0:b0:387:6fea:8ebc with SMTP id
 a9-20020a1cf009000000b003876fea8ebcmr1540672wmb.84.1646706325119; Mon, 07 Mar
 2022 18:25:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:47:0:0:0:0 with HTTP; Mon, 7 Mar 2022 18:25:24
 -0800 (PST)
Reply-To: fatibaro01@yahoo.com
From:   Fatimah Baro <gandofat@gmail.com>
Date:   Tue, 8 Mar 2022 03:25:24 +0100
Message-ID: <CAFRQsC3k8q3t3A6PCUK-78QUHUAz1prJ5a=oYRHoZETwmjH1Ew@mail.gmail.com>
Subject: Business invitation
To:     gandofat <gandofat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4378]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gandofat[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fatibaro01[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.5 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from Burkina Faso,
I need you to stand as my foreign partner for investment in your
country. Please reply immediately if you are interested, so that I can
give you more information.
Fatimah Baro
