Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9374F11C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350670AbiDDJP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348133AbiDDJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:15:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1651631DE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:14:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f10so7612367plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=lh+EjtFIKAdHCvJIUv5PkFK+/0L/Du57Wf4UKyhn7z7iav3KX8K6/RaTtN45ZTJCY4
         XEg7hC4Zh/ZXwRWutNZ8H5WhetOGyvLMJYPqoGSKzwkPzkHtY6pX1Hu+aNgxK1JypYBd
         Jwcr9qun4cqjmXeeHFPp25TA5qPMrt+fnbMy07/u5FBMZtH0Cvjy712VQX/qu2SNeVkd
         QYFytbPQrzZMskH66n06MS9pkYtfKn5xwuSt9EMcmfMqXaTEx8t3SWRHlNDfw85e2A7l
         jrpEC74mE+KgzbOls8Rl2+Wu60gS/gc2A67MfSh0WbVywBpna938P2f9bX4kOvW4A5zN
         5v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=sWF4ygV+gDVIhqSR1wsRCd2nLyp5zRvbbKgxvmuIiroXlfXils9lgxyruYdpOZrL3E
         TJVCJtOTxeenOqVHNMjvTUZ/su88QiL7XTKBfKGKzX5mKNrVSkryF3xWLXzjXn+tIjp0
         uiDEDeZZYLWOVfPywEBdJn5/y6a4V3oVC98LR/MLosFWrgs5icBAaTIJcRfVin+2Vq67
         m66KazOdwRwCa+eiTBWRp6fkhFnd95692ffxULd9UFNupxF/4ZmbTu0AuBSlRKFSV5wT
         d1ISdWnzK7bHVroyXk5iGm62bQ+ESEZr/2BDK1ZlnT6WcjVyZrXYtDv8TpJbDldWBe6I
         htLg==
X-Gm-Message-State: AOAM531MkprQRE7CtH6PsDeS7mhSjJj1ScthbTwGL+QxYM8HRzK33WBo
        md5kv11jjJJVFRVmrmRcW4krSSZv9l1X0+zd3zY=
X-Google-Smtp-Source: ABdhPJypxjVQnDVYccmDXQNfp2thXr16dSSPLrn4syTWJZf1WfPIvbOb1eC7+WADH70rw8ILXA6Pb3Qz36I2nt46WnQ=
X-Received: by 2002:a17:902:d2cd:b0:154:418d:e3a4 with SMTP id
 n13-20020a170902d2cd00b00154418de3a4mr56953969plc.34.1649063641512; Mon, 04
 Apr 2022 02:14:01 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsestherheidi36@gmail.com
Received: by 2002:a17:522:9e52:b0:43f:db59:7c3a with HTTP; Mon, 4 Apr 2022
 02:14:00 -0700 (PDT)
From:   Nance Terry Lee <nance173terry@gmail.com>
Date:   Mon, 4 Apr 2022 09:14:00 +0000
X-Google-Sender-Auth: 4N0SZEaqhHqncCVG1XV9neqpiXI
Message-ID: <CAAzGkAJO4oPrGtMgjoNAhsMfnpq1o9yZM=7qbfXjAATNj-P0Ag@mail.gmail.com>
Subject: Hello My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nance173terry[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsestherheidi36[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        *  3.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.9 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear Friend,

I am Dr. Nance Terry Lee, the United Nations Representative Washington
-DC - USA.
I hereby inform you that your UN pending compensation funds the sum of
$4.2million has been approved to be released to you through Diplomatic
Courier Service.

In the light of the above, you are advised to send your full receiving
information as below:

1. Your full name
2. Full receiving address
3. Your mobile number
4. Nearest airport

Upon the receipt of the above information, I will proceed with the
delivery process of your compensation funds to your door step through
our special agent, if you have any questions, don't hesitate to ask
me.

Kindly revert back to this office immediately.

Thanks.
Dr. Nance Terry Lee.
United Nations Representative
Washington-DC USA.
Tel: +1-703-9877 5463
Fax: +1-703-9268 5422
