Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB08F5A8081
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiHaOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiHaOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:45:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3FF2F3A4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:45:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p18so11541936ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=WfJW1iDKdU58AQ3xIWQtfybNImbhPKgKfgcmrCUP9cg=;
        b=YY7tVS9V2XkEOlyiJpou/6RhgqXDu/e9SL00TO11lD4hAzy3DSXn0YTH17/RiFYXLk
         GlNV9f3BqxFpbVprPhqGKrV9xVzrfqpPY7z4E5q83ziDTiaxJJ749txcrzpFWNh7H45R
         fplsEJG78OTxoOGhT1rV5aNfDzn241puLVNEMX2NrEuCT7n50xzT8R3hdrDbPHFFUd6I
         YA7XjIGBMPhNo9FrAaMMmAAbdK5lXoIj2LMgr6Gkat/mt8qRi9PVq1NedGV6SpZ2TC60
         MkUYHSNFE2AZb9I44pPVzGNwsJp1M1FE/pNcxpYcxjkL1He1rWCOfz+sIZgYV47ZUtdo
         Jj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WfJW1iDKdU58AQ3xIWQtfybNImbhPKgKfgcmrCUP9cg=;
        b=iDcqVC/MU3LQ2MMSnBL0qTREeVCOcBbe+BpvpMWW3Ie4IG3ceQfWUGRBfUsO4CVr5S
         FbiHo9eFEfltSbnqtRH+vO8PMNhwZ8SO/SD6u1JfzYrpuyx59Fwul48peDSVdOSGFJQQ
         XHLztU4xh6jc2/UpSZgn4fKV1IyzZQyVqa2tT1Pnlgg8rmqNXSjFT1e5CrgtW7j0Wf8Q
         KANOQFSxYjfOgFQlzQMpDxWOzpmbmMaeaeroCf5n6HxFPZ9z2aoABzx5Gr7D6uqxgGhI
         U2O2BLNQTH3+Bc4EWSSmELS+WE9NT5RKKhTNeXL5ZkPt2NDXaluGqhcndw4YvORBlkU9
         1NIg==
X-Gm-Message-State: ACgBeo1nn88woJP9i/a4wKbiPcaiKiYDb5NkKmQm/J+7WXavlEV/4zpV
        zYIHwNiO5rLRUhy9aK08v57N33UOjFMJz8vKqTs=
X-Google-Smtp-Source: AA6agR6s2mfyhDM5lup7dUh9kRjDcROA4QD4PMQCTvbPmT7o4BO4hcwzRAfxoCXRWCdLE1nRREKCMrVfL8PEWD/yJSI=
X-Received: by 2002:a2e:a801:0:b0:261:91a3:bc44 with SMTP id
 l1-20020a2ea801000000b0026191a3bc44mr8420414ljq.497.1661957106996; Wed, 31
 Aug 2022 07:45:06 -0700 (PDT)
MIME-Version: 1.0
Sender: klin.mlin122@gmail.com
Received: by 2002:a2e:a54b:0:0:0:0:0 with HTTP; Wed, 31 Aug 2022 07:45:06
 -0700 (PDT)
From:   Aisha Al-Gaddafi <aishaalgaddafi872@gmail.com>
Date:   Wed, 31 Aug 2022 16:45:06 +0200
X-Google-Sender-Auth: 5l4GrNDmzKVU1xwLCHklQbM9eX0
Message-ID: <CAMwUt-p8Ofui3O1KOxBQ2P8=-ymAB_FYxtJGwrXOwDCEps-UGg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_99,BAYES_999,
        DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [klin.mlin122[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [klin.mlin122[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,
With sincerity of purpose I wish to communicate with you seeking your
acceptance towards investing in your country under your Management as
my foreign investor/business partner.
I'm Mrs. Aisha Al-Gaddafi, the only biological Daughter of the late
Libyan President (Late Colonel Muammar Gaddafi) I'm a single Mother
and a widow with three Children, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia. I have
investment funds worth Twenty Seven Million Five Hundred Thousand
United State Dollars ($27.500.000.00 ) which I want to entrust to you
for the investment project in your country.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds.

Best Regards
Mrs. Aisha Al-Gaddafi.
