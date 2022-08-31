Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE05A7ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiHaNc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiHaNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:32:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9FD2749
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:32:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso6396074wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=JD2a/BxPdgGVFO6iAaclLZx23xJZbjT280bRPiOSCyE=;
        b=IVS6bNNm3qqkDDuos+B1OHd6nU91G4D6TQG62Xx4rtio/KirkFRSq9W1acAyEhe/qb
         rbz4OLuUlLNc7TouEw06Ww3bdJmZh+WIx72qmWsAZtjru47v1EupWmjoBReqtRY2DSlK
         baq+9eTQgFj0UC3qZ3faf7zt+dFe5oriaAQuBubjtfu3rb/3102GuSQMddHyhE8695R7
         /G7xsgqfsANe/ftvIOHpoXZmBPTUEsuOgFCwcZ54MgieX9ZXZWDMbsfmMJ0aGh5svS/F
         zBuPnwx5eVS1rr/8dxmoj+1ghrmBndu6b9Xa0AD8kUHZDyhG4xJnuztdrcDt+nEFMTmj
         JYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=JD2a/BxPdgGVFO6iAaclLZx23xJZbjT280bRPiOSCyE=;
        b=lnyH5ZHoKqSBwk9ZEN6wVraulrtqIyLSnwtTCvXtLGVa0XcKNR+PPpFsJjqMCepST8
         1PKev4OG7vZrHaeDBn8u2oDEanIm8A1qP+Bmup5W2A3F6fiEvJusszRHIANdnSqF4966
         xjNnfyRLN08EagEJHsGdKOacHtDEsMZ6+HeG403YGPikMfkVNL8SOUUf3siDOGmG+xpr
         iUtNHzn42CvR2XJcq1R9LB6qyelVOjQjtLmGk0D112Sf6dZR4bSAUEpKu/IJ9SiDVQoO
         EE2IweJueFtxcUgrMwXQIv08uzsMvDXp/bfrhrqRAS0S/ROPADy2AT9QCFtYN0Ocxouj
         cjwg==
X-Gm-Message-State: ACgBeo282tDV6IKels/DAClpQ8nY3QxyMngOL2x+dGZyOPCQ0JeQFL+T
        Mw1uHZ3QW6eo/qXWbIRXxyJr++DEidxzx2cu+L4=
X-Google-Smtp-Source: AA6agR6YmQ8BP8UY122kU+V42hN6vnFjSnQSbyGEtPeS4LqozcAwvR/vhIM/NskrCRs5/5UuztVEBWTjHEqy3vGQnoo=
X-Received: by 2002:a05:600c:2315:b0:3a5:c2cc:1bee with SMTP id
 21-20020a05600c231500b003a5c2cc1beemr1972584wmo.55.1661952768465; Wed, 31 Aug
 2022 06:32:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jerrydosso1@hotmail.com
Sender: pete8569joe@gmail.com
Received: by 2002:a05:6000:184d:0:0:0:0 with HTTP; Wed, 31 Aug 2022 06:32:47
 -0700 (PDT)
From:   Jerry Dosso <jerrydosso55@gmail.com>
Date:   Wed, 31 Aug 2022 15:32:47 +0200
X-Google-Sender-Auth: 6YboQs3dGngLHS-ZDRi7ou7BjNM
Message-ID: <CAGa4MpATRdrJ0-PvDryf9HbF-XwBhoop-tUCN-4V-YxiX0mBVA@mail.gmail.com>
Subject: Mr Jerry Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jerrydosso1[at]hotmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jerrydosso55[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQnNC+0Lkg0LTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQoNCtCS0Ysg0L/QvtC70YPRh9C4
0LvQuCDRgdC+0L7QsdGJ0LXQvdC40LUsINC60L7RgtC+0YDQvtC1INGPINCy0LDQvCDQvtGC0L/R
gNCw0LLQuNC7Pw0KDQrQoSDRg9Cy0LDQttC10L3QuNC10LwsDQoNCtCzLdC9INCU0LbQtdGA0YDQ
uCDQlNC+0YHRgdC+DQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0K
TXkgRGVhciBGcmllbmQsDQoNCkRpZCB5b3UgcmVjZWl2ZSB0aGUgbWVzc2FnZSBpIHNlbnQgdG8g
eW91Pw0KDQpSZWdhcmRzLA0KDQpNciBKZXJyeSBEb3Nzbw0K
