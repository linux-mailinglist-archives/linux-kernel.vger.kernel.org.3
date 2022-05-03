Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D73517CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiECE5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiECE5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:57:51 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250F3EB9F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:54:18 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id o132so7457030vko.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=j6k4+uRS4RtRRD9pAYteN/2lL426z4uuqpmrOuos+wU=;
        b=X3+OREgzoKbkR52iSFa+ODyi84z3Y3eFEPvZy4Z0Toi+pWOyIguOJw7WZKPSuusELW
         oMmYnXbdFYk25o8PV/X8oO84lPkVInsBXipEbSs4yW4Fc65rk7UmWMaqzy8r7CEILwaU
         KGD4E+OOZGNTdd4W5dwsuNMm0SKUzQEiYgyOcUxANR3LhK/18hb6pF6FdpaioYcr3gNP
         QPb85KnFTC0F3o+NzP2cZfMO/yhoIeJ4mUDbQM/AtAkvSWY8mupn9UWntFm8t1iAf9OB
         YB4i+Ii+b8S5UtwTIW+2dYknhlrO5THd8JSKhPGgT50nBkpqixe9umyPe+zqBtumRkjd
         d7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=j6k4+uRS4RtRRD9pAYteN/2lL426z4uuqpmrOuos+wU=;
        b=FEqwMxS9Lw98DXfsDXRpmIxnBpuRo3srTjNAbWJYSlMS7+rCVP5+YxgSrUR1VFmJmd
         KKly3uY0dTcVJnh2XoHDstUYOh/daCOw0ztX1AZDPXeOAxSy82JRf8kCdeYVVbKI2Uxe
         v4UEq1AWvTkNFnapKjA7kPtCfUxkvCpbbRNwabSEu4cMjY3RKJStKB43n8OWEQETSZxN
         v6ZoB5jADnK6CpYVuNG3GjCdRekzbuiMu1ph9yG5GAPJa62CwaKsN2I5T2uunef1PkNr
         0TuU47nRjskU4UfjuW0P6vk22LBbuCmdhNqnDknqxSpwVd+AMAD9RWDmvvwczRYuENgC
         vUhA==
X-Gm-Message-State: AOAM533BKcOlTvveTbpBhheZniz/HWs32m4oMtpbV9Tp4tya5Go/f3Mf
        Yhna2pw6cerMafl9c198Oalyt0p//0ZsHXo394o=
X-Google-Smtp-Source: ABdhPJxi4K7ooy7zP18S8ctwiI71GstX9ECLUp6QsclPPYhrdPsrt1N8MkntVqS22G8/6za1j5Qtug0zTB3MbcVi1uo=
X-Received: by 2002:ac5:cda2:0:b0:351:cba8:d5eb with SMTP id
 l2-20020ac5cda2000000b00351cba8d5ebmr818072vka.23.1651553657717; Mon, 02 May
 2022 21:54:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:470c:0:b0:2b5:9e73:ceab with HTTP; Mon, 2 May 2022
 21:54:17 -0700 (PDT)
Reply-To: mrs.bill.chantalone01@gmail.com
From:   Mrs B Chantal <g123355t@gmail.com>
Date:   Tue, 3 May 2022 06:54:17 +0200
Message-ID: <CAOyzzCnr_h5jnmByFqwDRedYYeCdA5jwiY1J+ac6ix2gc28dpg@mail.gmail.com>
Subject: hello....
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [g123355t[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.bill.chantalone01[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You have been compensated with the sum of  5 million dollars in this
united nation the payment will be issue into atm visa  card and send
to you from the santander bank we need your address and your
Whatsapp number  + 1 6465853907  this my email.ID
(  mrs.bill.chantal0101@gmail.com )  contact  me

Thanks my

mrs bill chantal
