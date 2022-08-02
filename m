Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9135878EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiHBIVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiHBIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:21:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943AE26559
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:21:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 123so22563912ybv.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=8v205cQ/ieAUhL/Vo4tOV+N+9VBgqw+bgVFiUzCohIE=;
        b=fyjSwVqQ7j/8JAmGMKlTYKqcY2ocCDo4nwZKotKi+q3IbfWw3pRbrrAJYujSQsaHD8
         Xdan84tPf3yoMXEMXgWh81jQdZRAU5KShWT3dnHYp8qAbf8RZf5drrDYPA1E3TJ+jdzI
         b2YpDedRTtXD1A0fhN68WHMg3yqw8vM7ALDB/xbuJ50Q8cYsBB2np8DIzElBeg06Uv+6
         Cj+lIK8IHmwzvYenHnih81eNjfTpbRkzOtLj8zR8IqUvE7I2fQ52NFQzgKIBQmp5hMH3
         Y4VHM5jPm31E6g9DXGwKaI0Mj8Afatf/yOBN8q7a4osvKQCB6fMA5cvUeBp01DTo+94E
         Giiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8v205cQ/ieAUhL/Vo4tOV+N+9VBgqw+bgVFiUzCohIE=;
        b=jO9+Ni8S6s84M2aeOzsH+Xts4xeKDMqjtsJVrSUCe2oqktB3TaQUfIZk5UGega9PPI
         pgeMa684CsH2t4qqb8vo97se/YihDNJaDcKe21en6v4t7QWGZZoHx8Kpd/B3v07MDG+w
         rpi/+v1r1UqSUEJJL3nErJldlis0DLectdhn3AKcbYqtaRTLX0eB/W3krjhTDom3YV21
         JDR86PryhxCQOCwBYQBdlOak5NuGchpOFNXNxgRE+aWuddkzWEgoRLvIw3tx9J38JN1/
         dJmqEk3qqaEDsI8WtH8iU7zlnRjneItkWW4JglSp0kAQq3v2N2iTCtEnXlc2NOgLTZCU
         NmrQ==
X-Gm-Message-State: ACgBeo3aESY7ASldBQ2Ol8UL67HnXyyMBuhIPyWQ5E/p1Cu5d2Stougs
        V+EiqhgJ7CD4Hi8gtaQyNasY4hUFn1drRCWSDEY=
X-Google-Smtp-Source: AA6agR6qFy+310eRX/r/RRc6NxP0bRnCAZO8QGIYvLuOJC00rgxrJjGj4n0fpkeGTLBKLbr7CqedUMypJ5OJrPv0CsE=
X-Received: by 2002:a25:9849:0:b0:676:d67c:2522 with SMTP id
 k9-20020a259849000000b00676d67c2522mr10299768ybo.487.1659428460550; Tue, 02
 Aug 2022 01:21:00 -0700 (PDT)
MIME-Version: 1.0
Sender: drabrarzebadiyah@gmail.com
Received: by 2002:a05:7010:42cd:b0:2e8:65bb:6021 with HTTP; Tue, 2 Aug 2022
 01:20:59 -0700 (PDT)
From:   Mrs Evelyn Richardson <evelynrichards10@gmail.com>
Date:   Tue, 2 Aug 2022 01:20:59 -0700
X-Google-Sender-Auth: EziLD2nfewVDvq-RfxYSQBe1pWk
Message-ID: <CAB4WHGvznPcVhhyTxpp2DOxaPfuDco7bvkWQYabxBkznaSq5SA@mail.gmail.com>
Subject: Dear Beneficiary
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_80,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8194]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [evelynrichards10[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Dear Beneficiary.

This is to inform you that the United Nation Organization in
conjunction with the World Bank has released the 2022 compensation
Fund which you are one of the lucky 40 winners that the committee has
resolved to compensate with the sum of ( =E2=82=AC2,000,000.00 Euro ) Two
Million Euro after the 2022 general online compensation raffle draw
held last WEEK during the UNCC conference this year with the
Secretary-General of the United Nations Mr. Ant=C3=B3nio Guterres in Geneva
Switzerland. This payment program is aimed at charities / fraud
victims and their development to help individuals to establish their
own private business/companies.

However, your Compensation Fund of =E2=82=AC2,000,000.00 Euro has been
credited into an  DISCOVER CARD which you are entitled to be
withdrawing =E2=82=AC3000 Euro each day from the DISCOVER CARD in any
DISCOVER CARD of your choice in your country or anywhere in the World.

Therefore, contact Engineer Account Mrs Kristalina Georgieva, he is
our representative and also United Nation`s Coordinator in United
State of America that will organize with you in Dispatch or handling
your DISCOVER CARD to your Destination. You are to make sure that you
received the UN Approved DISCOVER CARD in your names which is in list
founds in names of U.N world list to receive this UN Guest
Compensation.

We are at your service.
Many Thanks,
Mrs. Evelyn Richardson
United Nations Liaison Office
Directorate for International Payments
United States of America  USA.
