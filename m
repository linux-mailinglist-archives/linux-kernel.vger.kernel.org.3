Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC6550A56
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiFSLrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiFSLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:47:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8614011C32
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:47:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eo8so11630587edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=cPIBgpwOnmButavmlwJuuG1NWqAGhAI3+3vxmohoLXY=;
        b=QQdEW03kkwSskjmU4+uzfe2OmCDpKr4COMCtRa6V+KyYBwfAVqpe1sVu7uOjYapxFh
         KY2yvzsKuu9jwsO+Lp6wbDKtzXwFEpwXVMaD6/AW7cqedlIfLSXeLdNKWjbcPCGKLQHz
         H5uo/hw3l1G6uAXkTAvFHY4gc+3FFvP2/mQLRidhKCTCtrBeaNyuu1c8FYZ0TyXSGvww
         cuDG07tCvQHDCrnFwVRjaotNdfFmqipYROgSEc4BaUUwwLX/ngVwTTJQyD6WjZm3SXH4
         KlWhkeydXYBitZGB51sfMThgB0j9xLS8lRZoFFozAwhxsglcGiNAWL0Ub1RR+ofypCQY
         GonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=cPIBgpwOnmButavmlwJuuG1NWqAGhAI3+3vxmohoLXY=;
        b=2Bxzjsi4V/WrUwr5OuevMteMroRzyOJoYwNEYXdrnMqS/RlhgcS+a5jJ2TCuaxwRS4
         5+Sy+N88LsxH/ug4smXbQjRL0RmPERul4BuVsK61Qp8i1KEc1g5hF+kr8nfgEojEsVL5
         Lp89UVB/6PMEQEhQvIV0rkRtLQjBU4+NcvGgJNcFC9PU7CSh00NfTi1GiDKC5obCvkYg
         +2MripJxDE091PHnt4+cj5N0guMcafh9iBQr5M/7E79sQ+QFsky9NMBS9HHo0+9McjPJ
         LqqPXbMIS94yN8IHvpNB5eUpqc+K0P+sOWJ9lYtYlaUd1ph6D6KRBVoaqxWyRo6h6f/s
         MWRw==
X-Gm-Message-State: AJIora+BgyM+iuQ5Nn6xezr5iIS/9sEOEEgVczaTNwQfDjSFg11BrzPq
        /+OK4XGOLuKDjjrhxhk7mJ0u665DSjnlRn5Spvk=
X-Google-Smtp-Source: AGRyM1v84PCpIqzXMx4/oGdvWHjojFtYYFvW7rguQ2xFw5Q9jZGSm6f6qyD98JQ3xaHAfVEK8dsxTjbqQ7SuwmuL5po=
X-Received: by 2002:a05:6402:401f:b0:433:406a:82c2 with SMTP id
 d31-20020a056402401f00b00433406a82c2mr23660227eda.289.1655639255981; Sun, 19
 Jun 2022 04:47:35 -0700 (PDT)
MIME-Version: 1.0
Sender: djmacdon5@gmail.com
Received: by 2002:a54:3347:0:0:0:0:0 with HTTP; Sun, 19 Jun 2022 04:47:35
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Sun, 19 Jun 2022 11:47:35 +0000
X-Google-Sender-Auth: HfqqbUEXandW0eQGqc6XQzwBZEU
Message-ID: <CAKGPEqgyyGs1kPSnYt8yJjKA3jCjKNQP_ByCsApCs85F+E3-nA@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5009]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [djmacdon5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dinamckenna1894[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear,

 I am sending the same message to you. My names are Mrs. Dina Mckenna
Howley, a widow diagnosed with brain tumor disease which has gotten to
a very bad stage, Please I want you to understand the most important
reason why I am contacting you through this medium is because I need
your sincerity and ability to carry out this transaction and fulfill
my final wish in implementing the charitable investment project in
your country as it requires absolute trust and devotion without any
failure, which i believe that you will not expose this to anyone or
betray this trust and confident that I am about to entrust on you for
the mutual benefit of the orphans and the less privilege. I have some
funds I inherited from my late husband, the sum of ($ 11,000,000.00)
deposited with the Bank. Having known my present health condition, I
decided to entrust this fund to you believing that you will utilize it
the way i am going to instruct herein.

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35% percent of the total money for your effort in
handling the transaction, 5% percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country.
Therefore I am waiting for your prompt respond, if only you are
interested in this humanitarian project for further details of the
transaction and execution of this charitable project for the glory and
honor of God the merciful compassionate. Your urgent reply will be
appreciated.

God bless you.
Sincerely Sister in Christ Mrs. Dina Mckenna Howley.
