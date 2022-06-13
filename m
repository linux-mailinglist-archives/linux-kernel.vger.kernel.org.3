Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9889C5480C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiFMHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiFMHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:46:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A951D33A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:46:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 15so5048420pfy.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ZFmksVYvbPvpnPd9Y1UZ7lKdTWDfMwooXrCkG9TXPEg=;
        b=Iifsyf5qg7hB93BS7sgA61Sn8gcyN4L1EB1JotKZ7QHZ+IHtl4Pb0PwM+vN5/QtLN0
         wuSODY88WFwSI0uWF0RHyFv0NxMmZA824Iup0ipcrxrF+wDWaFhODC/+d+xsXNZnVGga
         rHuxtNG3oTBJl6v5IJPv19eNgqj9tEJX/Qm5oYYpuNMnN2IpKyGJZchuEJHZYQmbAp0D
         lqr0j5FMGvKHvW4QDnazZVG9EMQ4N6ZhJWRtTsHPucyhl/ORhzYELuE29zj3WHBjvu7k
         oZW1RC0vy8SPO1sxzQW8PvTv3mGKZcJPST+7qzmkKJaTWO5lf8aV+16WfpTvI6F5nnJ3
         lwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ZFmksVYvbPvpnPd9Y1UZ7lKdTWDfMwooXrCkG9TXPEg=;
        b=6lwzY/i1CpkkK89xbZ1ja7u933Tkc8L26rLjxYMpwG/vGwSogo5yvc4NuloehcozW9
         74SYGfXwqV3DeKPzIEhNZXpIT6pRfzNG5GxDM8RuZ8FvcCEwm/xNUMQ1ZZoHZqdQLFkb
         EqZ9bwXfD4ukPNswRNJEchWr+BOmXy/hz8QkGsywXtIldFWU5A1EsMvvjhv+3gZIAu3q
         52XwIpfvrJAA+udYnQ5kbtVweHixFaDx1rKdd8Rx3rr8MD7mB+vW8kuRfhZyH8oco894
         0ZU9MFlhk7Jtnn4Wbo8qNgY8rjUf0FxM8iqPUby3o26o6OLfD4WsEFqCNUx87kOCwNLV
         7PXA==
X-Gm-Message-State: AOAM531L0pIFaL136p97TxS5NjAYOf3x8oocpv0McDDTHlvTJVZVEKGT
        LKEkhdxMZnsyT7xEPefgjS/QTwUXhlwkMWUHQHw=
X-Google-Smtp-Source: ABdhPJzvwiag6Cv2tx1+xC/7Cbm3FzWrjMzpkVHnw/3zvJdNS/6OKny5+XOIboWAOCxsG5P7UOlzt2S2AezEsZywL3o=
X-Received: by 2002:a62:e116:0:b0:51b:c452:47e6 with SMTP id
 q22-20020a62e116000000b0051bc45247e6mr58153356pfh.25.1655106393404; Mon, 13
 Jun 2022 00:46:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:c1eb:b0:44d:3785:185d with HTTP; Mon, 13 Jun 2022
 00:46:32 -0700 (PDT)
Reply-To: dimitryedik@gmail.com
From:   Dimitry Edik <dmrdavidnikiema@gmail.com>
Date:   Mon, 13 Jun 2022 00:46:32 -0700
Message-ID: <CAM0vfExSMHq3pWhEFc-kXke2jSdpnF9vxz_inebjy0pCUXE+Tg@mail.gmail.com>
Subject: Dear Partner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7436]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dmrdavidnikiema[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear

Am Dimitry Edik from Russia A special assistance to my Russia
boss who deals in oil import and export He was killed by the Ukraine
soldiers at the border side. He supplied
oil to the Philippines company and he was paid over 90 per cent of the
transaction and the remaining 18.6 Million dollars have been paid into a
Taiwan bank in the Philippines..i want a partner that will assist me
with the claims. Is a (DEAL ) 40% for you and 60% for me
I have all information for the claims.
Kindly read and reply to me back is 100 per cent risk-free

Yours Sincerely
Dimitry Edik
