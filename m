Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4F5273AF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiENTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiENTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 15:12:32 -0400
X-Greylist: delayed 1811 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 May 2022 12:12:29 PDT
Received: from bosmailout06.eigbox.net (bosmailout06.eigbox.net [66.96.189.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65982FFD7;
        Sat, 14 May 2022 12:12:29 -0700 (PDT)
Received: from bosmailscan02.eigbox.net ([10.20.15.2])
        by bosmailout06.eigbox.net with esmtp (Exim)
        id 1npwiX-0004rE-5X; Sat, 14 May 2022 14:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dk-gourmet.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Reply-To:From:Subject:Date:Message-ID:To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XpS+Diu++fXgeFnxyb4JL/DLuGi3J7B35ax20U4tmTc=; b=RC6qxkV0WOWcGNaJLauDOEb5VD
        IoykpYCtN7kvv1mO+dIIyiYqvMLyP9Bj9CQ1RWC299aZdRWFu8cu97lwn3wcHczzcRy3xgNpLsX1X
        yrYXiUQEoy17Nu5sw7xJTLFo4TP19VnRYT1mkE2Web+O22Y30qmGnb2l5rTw6CvWpFySPAh8o/Y7I
        hZrizZ+VOjENXnYB98Szdz8DJMNQQb6AlmLgEIc+vTcs8QDfzXlPHTUsPE3NW1+Wt9TDm7d0bZiS8
        xuB8rRtI3b/UQyxvGEBVRSKRuoiprOcqJRx8fAvFVIUneCt46nQO50b7RtKik5KO18EreGkD9ChAv
        BUAhEqoA==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan02.eigbox.net with esmtp (Exim)
        id 1npwiW-0000Ey-S4; Sat, 14 May 2022 14:42:16 -0400
Received: from boswebmail03.eigbox.net ([10.20.16.3])
        by bosimpout13 with 
        id Wii72700803xtia01iiAyJ; Sat, 14 May 2022 14:42:16 -0400
X-Authority-Analysis: v=2.3 cv=A7b3w5eG c=1 sm=1 tr=0
 a=SF5U9W3/y4U5SwJCMiC6xA==:117 a=9cW_t1CCXrUA:10 a=8nJEP1OIZ-IA:10
 a=oZkIemNP1mAA:10 a=fr78r-2cmrJcU9aVSrMA:9 a=wPNLvfGTeEIA:10
Received: from [127.0.0.1] (helo=emailmg.startlogic.com)
        by boswebmail03.eigbox.net with esmtp (Exim)
        id 1npwi5-00082g-Iq; Sat, 14 May 2022 14:41:49 -0400
Received: from 192.168.151.0
        (SquirrelMail authenticated user info3@dk-gourmet.com)
        by emailmg.startlogic.com with HTTP;
        Sat, 14 May 2022 14:41:49 -0400
Message-ID: <dba1da532a28e5eecdb375f8e8f2b93e.squirrel@emailmg.startlogic.com>
Date:   Sat, 14 May 2022 14:41:49 -0400
Subject: Good Day Dear!!!
From:   "Mrs. Dale Karla Norris" <info3@dk-gourmet.com>
Reply-To: moppelchen@schmusemail.de
User-Agent: SquirrelMail/1.4.19
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-EN-AuthUser: info3@dk-gourmet.com
Sender:  "Mrs. Dale Karla Norris" <info3@dk-gourmet.com>
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        HK_NAME_MR_MRS,LOTS_OF_MONEY,MILLION_USD,MISSING_HEADERS,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [66.96.189.6 listed in list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 HK_NAME_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Good Day Dear!!!

I am Mrs. Dale K. Norris from Texas, United State Of America, presently
staying in London, United Kingdom. I am married to Engr. Chalmers Norris
who worked as the financial director under United Nation Development
Programme for Africa for more than ten years before he died in the year
2010. We were married for eleven years without a child, he died after a
brief illness that lasted for only four days and before his death we were
both born again Christian.

Since the death of my husband, I decided not to remarry or get a child
outside my matrimonial home as it's against the biblical belief of the
Christendom. When my husband was alive he deposited $12.5 Million USD with
a reputable bank, and presently this money is still with the bank;
recently, my doctor told me that I would not last long due to my cancer
problem and the one that disturbs me most is my partial paralysis.

I want an organization or an individual that will use this fund for
Orphanages, Widows, propagating the word of God and to endeavor that the
house of God is maintained. The Bible made us understand that blessed is
the hand that giveth. I took this decision because I don’t have any child
or close relative that will inherit this money as I was raised as an
orphan and my husband relatives are not Christians, they even have a hand
in husband's death and I don’t want my husband’s efforts to be used by the
same people. This is why I am taking this decision, I am not afraid of
death hence I know where I am going. I know that I am going to be in the
bosom of the Lord. (Exodus 14 vs. 14) says that the Lord will fight my
case and I shall hold my peace.

As soon as I receive your reply with a guaranteed word to help me fulfill
the wish of my late husband, I will communicate with you the details of
the said funds and how its ownership will be communicated to you as the
sole beneficiary to that account.


Yours in Christ,
Mrs. Dale Karla Norris

