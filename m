Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732DA4DE77D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 11:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiCSKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCSKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:47:44 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96D269A5F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:46:24 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id h205so3945461vke.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=bnyYkYuTXSy3IBW9teWGPOkF0QjwCc+qXxfvJHCi4Sg=;
        b=OOb0fwKvd2L/q2I+o+56JvDcCt3iT6ZyLim1mgNu6lvp0rWtNfsAdZwgk3Ri4tOFr2
         pYez8ZEIR0aNtkmvOX6sJAt+riFEWqqDmEi6ZLd9oFSsu4m8yDSPaHsLGuu4KSLHU3gU
         OQc0KU0/IsoF+q8QJMIQrsrMlXYRCFkvhRBM6PDW9sTFhn5htn4qQk2LdhMxQh53aSFA
         eW+eldP34+QSSiDQvx/t5GB0hYnKv2xZIYeCc6qHsOihos6CdI4Q5j2KRpW9lNDuNWje
         AZ2d0KpMur4zr41IVvyjl+oolT8CDTK3R0zUQfqpdVVbsXhI+QoSv+Otb9ARA16vWMdO
         tS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=bnyYkYuTXSy3IBW9teWGPOkF0QjwCc+qXxfvJHCi4Sg=;
        b=mCRlM/hGlFMyP9IkmFaS5TaYrpO4FaJYb4eedGsUdEut/BLXYBcyiOuFRcxwI+HIgD
         deKHL7pLzZ49J+L1ItrNsX3qV6hYh1f8CUp2/Aa2jzZ2abeeKu/86hnQKYOSYCmhlYw+
         K5MrWZ93gpUwvFVumTdXd1CfCRX5se5IDBRzhoIUxYHTvF5vx8T3OmKkR4qbz5Ang/k3
         q31jI58pcwC7RQYKHQ/HqmwtL86wehhWKuV7XnidmiBC+EDWtF+i3oUAIAWxNFlEM/t7
         40UN60DRRB421N37AJeEgLR6jZpUBd97q29abfwJCYeYO1OnNoNTwRHVoweEldhjvat+
         2+VA==
X-Gm-Message-State: AOAM5335EXU41DFxE/OkoZOtDRv2ZppSK/SHD7wGhRjYLzvZofH/cT+F
        kJIBJN2avYYQDHZMd0rmbCqqz6ouN706/ImHluM=
X-Google-Smtp-Source: ABdhPJwIShMQmakQ3HnY+OoZibNwK8nWnONB7X/j2XKiYfgU9mz3ebbWlffgyKOiX85lBjPKGQPKxLU43L7D+D2lNH8=
X-Received: by 2002:a1f:1f56:0:b0:336:f53d:73f6 with SMTP id
 f83-20020a1f1f56000000b00336f53d73f6mr4822645vkf.11.1647686783147; Sat, 19
 Mar 2022 03:46:23 -0700 (PDT)
MIME-Version: 1.0
Sender: warmaloukmane851@gmail.com
Received: by 2002:a05:612c:590:b0:295:6ae3:7777 with HTTP; Sat, 19 Mar 2022
 03:46:22 -0700 (PDT)
From:   "Mrs Yu. Ging Yunnan" <yunnan1222ging@gmail.com>
Date:   Sat, 19 Mar 2022 11:46:22 +0100
X-Google-Sender-Auth: CB6wZEGHjZdH6dtGOAzhxwlgqV4
Message-ID: <CAH3UbtDREsFcy34W-fOpfucnovzUuvPOVff4qtVzUHzW3rJPEw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yunnan1222ging[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [warmaloukmane851[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  3.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avail, am a Chinese woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow.
        My reason of communicating you is that i have $9.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which am the next of kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor. I will want you to use the fund to build an orphanage
home in my name there in your country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.

                                Yours fairly friend,

                           Mrs Yu. Ging Yunnan.
