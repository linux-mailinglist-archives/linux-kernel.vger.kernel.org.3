Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF45F52E8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347700AbiETJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbiETJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:25:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE58225284
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:25:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a11so7309571pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=i/OUnOpe+L6EXkV0g2GBLh/LlkmTO2ABKbDeNNYBAIiqPBi7Po+V9JEX6+911ykRjL
         t2M2j+RYB4XkLljq6P/kRFKJivx2S6CKWRBFLoXzRplrC+xBWkkeGBV6APfYjVsvThcF
         rl8Fk/KxCGL7b0xFltVLp93SeGngyXLI31mpnRoXCiF8eiTVtcKBD67n8/P1KubzjsGF
         jGJlbvut5C1a21qOhynvMcTC55oQ8VqS8dhTaKuBakv/vW/GwhYobJJ/+kY8GgISfyer
         i4jZemgrU2cd8yv8hzVxS2NHjcsJTqpANPyZy5YXcbXUxRr/CvcOTGvvGWeRKYJgZNfX
         VOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=7RjnGCmCo3Uhoe5vuz9xPk6jZ7mIHywlvSeSkoN9WRyPuHUWwVJTd8xdsDAjOdJSWX
         zHsuvUQfO9AHd/8R+pVChA0kLPP05Zk13VbLI/vjaScappJLN89j8SWhj3i3idkUPIxg
         zHfpSTtD7nUy2sMU4m+uLHI2+kOTrezhqoUFpAHvMM1QFLaIQ9ZQILYpmAaj8Upy/ojS
         mQX3PYLlcIwrG8aG/6nTXN1e+UoFioHWa7RmLHG3Z//iO5ZenlTi9jDNE9wYPnKd03Jh
         rW/AirZTRzdxDuQzf/uY4rkP+7nksTJ5oXb9JehXTVbz6lMKCmNCGaOETYe69bQmywga
         vHow==
X-Gm-Message-State: AOAM531g0uVUrxzYUTYgcIDUIz5VHf8zZnOsNxjmsh1JptDAspaZckzH
        hQ9diZW+/5amYNOvKovsozg1kKbhwK4Zbccc+Cs=
X-Google-Smtp-Source: ABdhPJzJ6l/pbV2vxgCsyyxnwB5/t9MO8LaSN+KONN6ZVqHZxtZAc5RvBOStUiQ/kY2EEDNsINNgUm+br2kawyaQus4=
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id
 bo14-20020a056a000e8e00b004faa52f59cfmr9075732pfb.84.1653038733395; Fri, 20
 May 2022 02:25:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dr.tracymedicinemed1@gmail.com
Sender: traorekafando07@gmail.com
Received: by 2002:a05:7300:7685:b0:60:d395:5d14 with HTTP; Fri, 20 May 2022
 02:25:32 -0700 (PDT)
From:   Dr Tracy William <ra6277708@gmail.com>
Date:   Fri, 20 May 2022 17:25:32 +0800
X-Google-Sender-Auth: U20KsUiIlkHSeO5Q_W5tV1PMHSA
Message-ID: <CACGK7qsTaCVASty7JP9vk-t75BQ5=VGvK7NsStSFO8Ld+ZBjng@mail.gmail.com>
Subject: From Dr Tracy from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [traorekafando07[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [traorekafando07[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dr.tracymedicinemed1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great.

It is my great pleasure to contact you,I want to make a new and
special friend,I hope you don't mind. My name is Tracy William from
the United States, Am an English and French nationalities. I will give
you pictures and more details about my self as soon as i hear from
you Kisses.

Pls resply to my personal email(dr.tracymedicinemed1@gmail.com)

Thanks.
Tracy,
