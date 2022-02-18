Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3D4BB8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiBRLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:49:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBRLtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:49:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4476F170D71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:49:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j15so4876604lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=pvR2wjIpC2T5CmITljP/vaEXSCGtvFfEKXeRfOwBGJs=;
        b=TjH0MJqzSw0/Nnmu5FnJNC0DKtU/qJVbJtToot5Ym0cxE3Hic+L8agoEmjx0GdtgbD
         mrFBhjFZh+wOAeZCEsZtOqgWD/crRx9YpnAhBUYxQ01v0XtRaKdUQrqBmKJ9ZfHU2yxz
         mwoK8DjE+rJmqy0qOawr9XyfIP4tyJrB8zCVxOavzlsL1f3lRVPoFidEPQthmAySOg8O
         9aNpox/xS0Q7dLAUpI8cGqTtahcRYAWyvSCJDQl0Eygl+NPELcwtGmtRGRlC/rNEEExb
         YtfHtvKSqX2VcmOhhi4y1pXdtHVLcT3vX81OFgyCLppYXfKW37CE1nvAHiDbVmr7GEAg
         pn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=pvR2wjIpC2T5CmITljP/vaEXSCGtvFfEKXeRfOwBGJs=;
        b=2O31HDuQsfNpte+mOg3WiQ5iPcwzy/6K+CTs6yvm/DpWCfvPfQ0Kj7D7iYK6dSuE/2
         NSyaoYlLUrQdxU4J1zxzCRC5KC3X+33gECPTuev2hgZ9tT3HXn2TmOW5Lm1/9uNxY/SR
         5jdcp6qZWMFRgIo0njdariPkqPSwwiznoVbkfkXzc4PJEXCqiGumebmeQNNvxWx6k9yA
         sOn7FAP7AJSDuaRKOL8a+3jS3L5uiU03Rffg2pIr4Kpzm2xstWcil7haTSTECel0zm3T
         /rgipl9z/8TEBnqrUfHOsUWlMAndfZRGZkGgXOipvumT2kAPcQPmpMVYXZnh6thFrNy6
         pFxA==
X-Gm-Message-State: AOAM533I2sml/Ww0rxK7BCHdM89uNR1K8ayjzgC4SNfH8M6Hm/zMSxvd
        DZSCSsfUPXf9LZ4cpKxh9L16QGiRRcb+VHAU15g=
X-Google-Smtp-Source: ABdhPJx/WjF/ZOq2Y8ELCgxQFWqxFcDtTY6Wdei6J5kXtmhz8mV9suBP9ppVn6I+7k5VIlpkXZUocTb0artTw7iDfVI=
X-Received: by 2002:ac2:50d0:0:b0:443:15cc:9f78 with SMTP id
 h16-20020ac250d0000000b0044315cc9f78mr5077485lfm.80.1645184960600; Fri, 18
 Feb 2022 03:49:20 -0800 (PST)
MIME-Version: 1.0
Sender: hgtrduyuihoiygoiu@gmail.com
Received: by 2002:a05:6520:517:b0:19b:a942:a982 with HTTP; Fri, 18 Feb 2022
 03:49:20 -0800 (PST)
From:   "mrs.sophia.robin" <mrs.sophiar.robin424@gmail.com>
Date:   Fri, 18 Feb 2022 12:49:20 +0100
X-Google-Sender-Auth: Pgf39q-TPHtwqSYIyDYtmSyOOsM
Message-ID: <CAGWMNqqR=e-jcRxfP7qZAGRgKeK1_2tYdNK1zhHCxU=XD4A9NQ@mail.gmail.com>
Subject: Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_LOAN,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hgtrduyuihoiygoiu[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.5 HK_SCAM No description available.
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.6 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest One,

  am Mrs.Sophia Robin, a citizen of the united state of America, I
work at HSBC Bank in Milan Italy, as Telex Manager charge of wire
transfer department, am contacting you personally for investment
assistance and a long term business relationship in your Country. am
contacting you for an important and urgent business transaction, I
want the bank to transfer the money left by Dr.Cheng Chao, a Chinese
Politician who died, March 17th 2020, without any trace of his family
members, he used our bank to launder money overseas through the help
of their Political advisers. and most of the funds which they
transferred out of the shores of China, were gold and oil money that
was supposed to have been used to develop the continent.

Can you invest this money and also help the poor? The amount value at
$15.5million Dollars($US15,500,000),left in his account still
unclaimed,if you know that you are capable to invest this fund into
any profitable business in your country kindly send me your details
information as listed below to enable me draft you an application form
of claim along with the deposit certificate which you are going to
fill with your bank account detail necessary and contact the HSBC Bank
in Italy for immediate transfer of the Amounted sum into your bank
account direct. Percentage share will be 60,for me/40,for you.

(1) Your full name.....................
(2) Your address................
(3) Your Nationality...............
(4) Your Age/Sex.....................
(5) Your  Occupation.......................
(6) Your marital status........................
(7) Your direct telephone number..................
(8) Your photo..................

Thanks with my best regards. Mrs.Sophia Robin,
Telex Manager Milan Italy,(H.S.B.C)
