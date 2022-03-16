Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9BB4DAE63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiCPKnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiCPKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:43:30 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C363524
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:42:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id pv16so3332449ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=pCUEHN10myOuGMzfV+RIG8qUsAfphC6ZOLsiZ/PG9Bh07oz7YZCqIfU3eyztiG6Ul9
         RQdEVB7MYtE1U8kXFuj2hWNrdEZ1z2C1bKFhnxn/VRVlZOjhIRpZtAOrossjS/V1dMhJ
         09EynmrqTdjxneTwQojhNwD9GHaSfBNxvBwq7oCfsWihSW1ZMfcWZ1jQTu08rYSmlMDr
         Xmb/ZH/W5LHDiak+50SCEfqj7ckEpiaD0BcRmNFguwl1j0u/zc5/T6K6FW4/faRYGOCJ
         Y5JmMmAvz69Eb+EogNRxDIqlW+tg4RO8asM/p4Kj/l3/oDaWM0oztY58NdekDSNvGzzI
         PYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=C8/6sWoGNDp7yFz6dozFcqMksN1IMiucHZLukbww+tyRLdP2oYODVhmeLAqkkGolXl
         hcdGC44+NMpIRbxFb99eHrEREqoMwCDn3pRfDapdG/f8YYxj8xPHz3jt+InxKUhZmn2m
         R4zTQzVGsBPB0Xwv8ZY50obAPTsEy5832N7hGYruqaVodabBAqYO81EtV/fvQgxd6WCQ
         soOv7J2ZGSKiGN0wTCj5ATsV2HScmHCy4Ltn/asWiI/d/dLqkpnOPIDlRsVk/wkS1q9G
         cS1wCmrbIyBsSd0uNLbxAkyPcH+YvWJc5KPGQ76gMnvV/xKQKnWPhdidJ+QanMFlWMJ6
         IUvQ==
X-Gm-Message-State: AOAM532f9AxNAGX8XcjI4mkOJO0kQ2g/n1Yci/BC0+ARXj95KKaK3qz1
        tBa1Te0+JPy45YUgk5pIZZLsca8LVlSquHivjzkUQ27Yipw=
X-Google-Smtp-Source: ABdhPJzvnhih2zlpFz7uXBPiOfYd/SBhOc6wD8GTmT5UKj41RyRvNtQhva07lDaW0pkgLEpn0LeHJeFVij7xTGkzUlg=
X-Received: by 2002:a17:907:971b:b0:6db:32b4:f262 with SMTP id
 jg27-20020a170907971b00b006db32b4f262mr27792396ejc.522.1647427334909; Wed, 16
 Mar 2022 03:42:14 -0700 (PDT)
MIME-Version: 1.0
Sender: mrslila67hber@gmail.com
Received: by 2002:a17:906:1751:0:0:0:0 with HTTP; Wed, 16 Mar 2022 03:42:14
 -0700 (PDT)
From:   "Dr. Nance Terry Lee" <nance173terry@gmail.com>
Date:   Wed, 16 Mar 2022 10:42:14 +0000
X-Google-Sender-Auth: xcl_3Vncm4BWj_72PGJzXqj2R6w
Message-ID: <CAGq_i_2w0jw4q8NwMPSrSOQGFqtdvyx+ahkre4D3=HQc1eg0cg@mail.gmail.com>
Subject: Hello My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslila67hber[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  3.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
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
