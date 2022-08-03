Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A752588736
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiHCGP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiHCGPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:15:47 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360291C12E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:15:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id h19so5626535ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=8v205cQ/ieAUhL/Vo4tOV+N+9VBgqw+bgVFiUzCohIE=;
        b=NJX3Jf42gvUGRx3Ymsabn4r/cNODe9DJw4rpD7tNJjcQFg28wuLiLCvHUkE/tVaSDy
         +WWRrCWZQSfMMwwczWSijieoXCbiMbKIuM5hO4BFD8N8z5KgSzq5+rkgxU5ES8B8bPYr
         tW/3ulDIP/vS8qkx3tVDAnMhKlaFP+fvHGEBiw/dOYrat8wkMpUh7TjtTUc2orr8VOVi
         6QUZlaZw4/X0o/gihuk15ztLbkg1vd2JIhA44+uJzypR69D4U8xALUaL766+CqlqxKVg
         f7myrTK0Xsw1IyRiXmedS5AsHa3k0OYGWD+9iraPLN1z00Q2YxIg9aAXAPiOTutYrjHb
         LpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8v205cQ/ieAUhL/Vo4tOV+N+9VBgqw+bgVFiUzCohIE=;
        b=qjgQQwoF0uhSQIEXf2C9kQjxTyQLUI+Y3pQ+ZwPnvDDzrvLTCMw+GXutYCpknDnb11
         cakt3b7A4fTOJ3nJg8pf7o7kIK2UEnxVurUNIT9jyNRQd2NTejC+QtIwNJ+2F+U6CZD2
         8kzw1GsDoCXOXQ8GGHDIRliCWlC7C3nygsEbrPyWIG6hl0vOrXU2NuWHHoNP7sQymU9o
         YwQ/aQ8vZyb6U3eivm0uPPBoSydoIlO6KKz8vrE3vVNAvT4DrjGPg6NrPztXyrTTrPW1
         TlE7zNwxjqPo3IkEu2toF0/f18wHm8JYY7CH1rSKyepAG2RmuEeIiyFR+REVzOxfAYS8
         4/jQ==
X-Gm-Message-State: ACgBeo2b2kkFrVTjSO+ldxzKIT6kozHCW6gIQTabZp5zBtl66A09vLtM
        YlpEVOApbgrUblq8FZV5y9rD5c2c1Kcq5cb7sTE=
X-Google-Smtp-Source: AA6agR6DvHiSgzukh2QJjn17m6PdDdcokrS94+Km2109aWjmWUiBEdWBh/UkOgeS5Y7qG50c1Tzyhu1ffuZUSEtSqUQ=
X-Received: by 2002:ab0:7a69:0:b0:384:dc02:a08e with SMTP id
 c9-20020ab07a69000000b00384dc02a08emr9479105uat.4.1659507346112; Tue, 02 Aug
 2022 23:15:46 -0700 (PDT)
MIME-Version: 1.0
Sender: stgmonicabrown01@gmail.com
Received: by 2002:a05:6102:3e84:0:0:0:0 with HTTP; Tue, 2 Aug 2022 23:15:45
 -0700 (PDT)
From:   Mrs Evelyn Richardson <evelynrichards10@gmail.com>
Date:   Tue, 2 Aug 2022 23:15:45 -0700
X-Google-Sender-Auth: M7vgGz_0YrfqfXePzzU8ZieqbfM
Message-ID: <CAOZrF2LMNrt0cCzhbfYU0OEQhVLdS-FoNf4YTMzyq73KCsjbKA@mail.gmail.com>
Subject: Dear Beneficiary
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:941 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [stgmonicabrown01[at]gmail.com]
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
X-Spam-Level: *****
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
