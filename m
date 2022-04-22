Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B850B1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444932AbiDVHlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444917AbiDVHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:41:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC2515BE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:39:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j6so4917799pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=j6k4+uRS4RtRRD9pAYteN/2lL426z4uuqpmrOuos+wU=;
        b=AogUBJAIdPjw3WIHVleCnkWO9vgpvIT+Yrl9ktgobZ91CmrJq3MZ9WFScmADlcCaZm
         0HBkEk1MIBQf9Fh3UWNifXi63bAjTva3JyBKFtoQojhyyA3ndLKRaWi5bbnIWRP2L3kq
         N9DSILchSERKEUHpnXIf52CYMa01dPoTpGetE0s2k5NSna9D39/e47EfZfOX4wnkTe50
         s+aGNFOmxNftxO2/ELCN0dJ3Cq9lpt7P7ffAXK5BGLCGEmvGka/VIRQH2u/u7XQUGekG
         fIrfHbZA3j4vRnfiVlpi1LWUFLjwqPznnze+UTeUPnWtoYvIV3qbKXjKnWQfkZbsaU32
         o31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=j6k4+uRS4RtRRD9pAYteN/2lL426z4uuqpmrOuos+wU=;
        b=hllkaHVoGYu6qt/d2rfnAPK3/9l4MEKvsR0TJ/Ww1129yLZobz0iRp1nO+qq+plML3
         KwFiZU0bA3sLf28Ea10G73e9lJxoad77P1dm2HPYrjnQpi0tisztMCYTl3nTNPV2ngjr
         iykIfFJdYe5YJetbhsgsvgXUBlyN3XIcdoR5W5CsTvLUUs3A6QD8KW6DyDs5Ci584ZVR
         lUtQmHSzMSSTfho0cE0y1QUUDMjFrootxm4ScpYiIAq19q9R70jjE7l14C4Gn++SmKjy
         LkAgBW9fuNtG8OaiAaFTqOILSv0Q8H2Kl482UOPhylzFB+kJb4O9muCGcx+IwI+NSU4s
         XRtg==
X-Gm-Message-State: AOAM531F+eNxRaAt0z/jcy7e+614rkX1RfZGRHKsWZGAYx84yMSwLaSD
        2z8feN7jzxIlnUVbB90nvDcTmbzRTdVnj9xDNoPAdG7jGfs=
X-Google-Smtp-Source: ABdhPJxbd5bPh4lt5ONxY7lFTRBnwMNfh/xWnOoLOMOwzor+E5BC3MZ5BBi43Ce6Z5sVsGf74adMlD4ANPNbi0uDGZY=
X-Received: by 2002:a05:6602:2ac3:b0:657:391d:3020 with SMTP id
 m3-20020a0566022ac300b00657391d3020mr1417130iov.163.1650612821119; Fri, 22
 Apr 2022 00:33:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3296:0:0:0:0 with HTTP; Fri, 22 Apr 2022 00:33:40
 -0700 (PDT)
Reply-To: mrs.bill.chantalone01@gmail.com
From:   "mrs.chantal" <ppasca920@gmail.com>
Date:   Fri, 22 Apr 2022 07:33:40 +0000
Message-ID: <CAJJB4p8Dx53joexYRk7HtPzesUfGb-XpdC2J4PGbCJFa94iKUA@mail.gmail.com>
Subject: hello.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ppasca920[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.bill.chantalone01[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ppasca920[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You have been compensated with the sum of 5  million dollars in this
united nation the payment will be issue into atm visa  card and send
to you from the santander bank we need your address and your
Whatsapp number  + 1 6465853907  this my email.ID
(  mrs.bill.chantal0101@gmail.com )  contact  me

Thanks my

mrs bill chantal
