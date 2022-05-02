Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72C0516F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385023AbiEBMXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiEBMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:23:21 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB963167C2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:19:52 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id 63so5219568uaw.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=gT0qunonoqmQDH3Sx35AGkd9jYv/vMqV6NEmgNMh3r8=;
        b=dFcz8ypIAnXfZ7anVS/39S+ZtLVDJ/NeAjLHwnHSEUX21zr5wlz6jreY+lgJTLY8Oe
         KrEJv0PDKWzF7wGMUqdmPM9g2f5cQYn2ppe4K1omWmvMaGvTmpqc7jmwdOMbScKZA1D/
         fPVjtAcaIXl9P7u5eBqBQltzeWQ0JdRErYvq/NnUd68bRPkEwjSqoJEnxAnymoOqqQzx
         GW7i8hrPHWBCJvJ0f3Vrl41FrNbuDiUkSvLMuagEi5gYw5CpAItxTf3ff/TS1B8ccHYg
         popZAxv47qTt0TWe2Fbk8xKvvf/hWSoVavGmYeS2AoXsJtSxz69bTHjgXJIktopSX2c3
         sm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=gT0qunonoqmQDH3Sx35AGkd9jYv/vMqV6NEmgNMh3r8=;
        b=fc2mYC5BsFbokeivG67GLO7QrBANOrd8bywCEaShbTui+DoSsexLB4fCby+3PLkOes
         wIUXnmKbZCo+T2cGxKcl/2VqSBkP4g93HcnZI9J8Z7BC/F1xwJQP350YcpR1fu6jCeuD
         nUqQQFfS9/EL9Oe3tFlry3Fd5+bdYAoo2AxHJv1KFLOlGrcXunzU/XAohttB+1zQnEEU
         E/9/O12q1XNpQ/SZfO3L1tM0hQHYanSZow1MGUKsw/+oC+3xC6NEubtehjQ1bP/iaC4a
         XYeuDq0+y5MgFxR0O5C+6RPdHWp1fUyHqUd/Ju0bnu5OnWaFJWtwDeMiwM3HjOTJaogH
         GrIg==
X-Gm-Message-State: AOAM532XdKT8y2DI4rVE5J1uEW3xPOubElzUcCHtK6FBhmivcJj8VlGk
        3pEpT40F2//cPieycRe6vvtaxTEQnhHNOEAyV1K0NgJemps=
X-Google-Smtp-Source: ABdhPJzq7dVPGplp5gf5UcsgUfvx1f8/5a7bYCIhAjqxzIUIcjSgML0o7x+GIV+UUw0botlBc5ibYAhi+FyTGypaDcY=
X-Received: by 2002:a5b:603:0:b0:648:507a:b9f8 with SMTP id
 d3-20020a5b0603000000b00648507ab9f8mr9677937ybq.497.1651493981860; Mon, 02
 May 2022 05:19:41 -0700 (PDT)
MIME-Version: 1.0
Reply-To: nafi177z@hotmail.com
Sender: haman1zakaraya2015@gmail.com
Received: by 2002:a05:7010:45c5:b0:28b:99ed:bd86 with HTTP; Mon, 2 May 2022
 05:19:41 -0700 (PDT)
From:   Ms Nafisa Zongo <msnafisazongo@gmail.com>
Date:   Mon, 2 May 2022 05:19:41 -0700
X-Google-Sender-Auth: EArB_TKY3Zv8awAlwAOz7IQfceM
Message-ID: <CALXn+=XLwDpa3CBVGjKNX8s-EbJBKR5uJiWYUQc39JsMY9SHBA@mail.gmail.com>
Subject: RE.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:92a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [msnafisazongo[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [haman1zakaraya2015[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

I seek for your partnership in a transaction business which you will
be communicated in details upon response.

Best regards
Ms. Nafisa.
