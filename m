Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63654F7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380888AbiFQMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiFQMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:52:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F738780
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:52:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me5so8621676ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=bFRHS+e3DCPBMILvIVMirwW3oSnos3gVcBwfK8+hxhk=;
        b=FFMv7SyqWm+wbnSsil+mG8b0H0eyakhdFmDk8cyDVjcAKjRGQrErld2UH0R3lYU7DE
         +N36g3QRQHu7m0Wju/qfITx/vaHuuy5G4HSbeIiR/So5WqbjZ5kVSQ1Vz7Gt+eWjwaW8
         pGJN5BTuoJQfL+459XYa36k3i+kUtcKWbRG54fWNI7kbxu4Z9pNwclT4AIKVZnT1oknH
         M4+SKpuB4T6RSg/v6xpq3zhis9gGk5M9926w5pZY10ow2OUOFJpGs2T+haNnd98f++Me
         BRbVMhRq3YspI4yHuDg86nPtyONxFrDpSakCQXqLSPALjZ6ixqdDMZ6sXXoUl5djmQJg
         bnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=bFRHS+e3DCPBMILvIVMirwW3oSnos3gVcBwfK8+hxhk=;
        b=6kjCprCOzYf/OffWwNuePxVpoM/WEV3+F9HjFJvLHDVQKnF5DZchbTRNIL/s/E+xXa
         zvKCMVSpHEEOESrCtNAN100rc54QzOKCTTHlqHpUw5R4sQcITUF1L+RXj05DF3ZF2W2n
         nwM5erG3JbBI3L5ZTP9un21d3NWaT8szg7zHcJs8irN8z/rzqDJutdRmAz9axXVMYUXl
         P5qH6NQ3blKmb3gMgAN/8RtgxS2U7LERK84XKTCRu/znizaOo81uAuoZ6IigRwUsFc5d
         Vzu1H516yW0IyDZt5zOBc/QXmfU0W/87gJ/ksZp7EpF7kR0mQaasp56wydHsSFK9tK7F
         GP3g==
X-Gm-Message-State: AJIora/3TIKXy+ozwYLvGOspfmEj/o/zdNhGApN+tOgNGwW2q9KQ+Uel
        M8bCNzWuoAlUqbVITVbfmxaUfZ7PQDwuABvQOdc=
X-Google-Smtp-Source: AGRyM1tutwyotk1mwNo3nNTFg/S5p5YliA4CylmSfVcaOOegh9rs/gTrzG/gXcpfOBeCBjH4JMxkpekHKkm1zQpbuuc=
X-Received: by 2002:a17:907:2c65:b0:711:d06c:e61 with SMTP id
 ib5-20020a1709072c6500b00711d06c0e61mr1026521ejc.201.1655470349291; Fri, 17
 Jun 2022 05:52:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6400:546:0:0:0:0 with HTTP; Fri, 17 Jun 2022 05:52:28
 -0700 (PDT)
Reply-To: stevengoodman1226@gmail.com
From:   "Mr. Steven Goodman" <iu7307906@gmail.com>
Date:   Fri, 17 Jun 2022 13:52:28 +0100
Message-ID: <CAM0-eksYmP6xnA77yXvckwhLdHW=+1rtwEibuAY6ksBsV5DZuQ@mail.gmail.com>
Subject: UEGENT LOAN OFFER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stevengoodman1226[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [iu7307906[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [iu7307906[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Do you need an urgent loan for business or to pay bills at 2 %
interest rate ? We offer business loan , personal loan , home loan ,
auto loan , student loan , debt consolidation loan e.t.c. We also lend
in USA DOLLARS , EURO and POUNDS ! kindly contact us back for more
details on how to get started If you need a quick and easy loan .
Kindly Contact Us Via This Email : stevengoodman1226@gmail.com
