Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A450D4E262A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347253AbiCUMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiCUMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:16:52 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB75BD30
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:15:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l18so16462762ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zztMJWEFOlzDgRxG3RHAQs0FMgnSxT7U+TQFBO91ZQo=;
        b=ejp129zM4VOE1CvQqCIYK5uwZDD2EJqdCisa17rzdxZ2tfZAVLPXQkcqJ9+E06vdxB
         S/M8jUrKteMetNDlKcMmEwu6O9hAs4k7BkJEaZRW5JJjwvHWQk8+cu09p0RwdXQhC2xB
         9KKJf71ZtOsla61QmfHadR2Z9z+ZLln8tCoiON9w1B09MC5ahVCB7TZYedlZ9ozg0C1R
         Yp/wlGM8iLQJLIfDDLWk/bCzSRMdds9+r8kCk58mVtiMo+ZxAS80ENrhjg4dF4tj6XBf
         ODUPLt2DGab6BObgcgv17VCAWFJN93hdCVCm4lyvmm+aZilZX9Uv57xaihdg4ioS6/KK
         1KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zztMJWEFOlzDgRxG3RHAQs0FMgnSxT7U+TQFBO91ZQo=;
        b=xQCExlUgiwbH+JEwU47NgkINlKlZKWsOn94mHvdWZGVTJ7OLTiqWQ5l0hDtiuNXV2w
         HduhyFgtjnoCqMtF/q0uZVr7WiJY2nEbyz2KAsONNuhWm7HaafG2Zn3ZxxI1ZHA1TJpe
         /8zUDWGrlbRJvTaEVeC0r+FWxy2G0wSL2CAVyGc/xkdPnUbk4kAdn1p1TP3MGOq63Jn4
         F1RIVbmOS8UOJWyyoi/yAZPhLt8NhlyiekBMUu+79O2E8XuR89v/oZ+Kt6AdMWK58emZ
         PxXJr3XYOraqsRVgpor8/eAFVcHnl82nnINKsexGMZkD/cCerBhz3+rq3dyIdmlEkOjD
         d3LA==
X-Gm-Message-State: AOAM533QeC4zIBm5k4o1HnDIkPbhT5vkADL/7iP79ZFjFVRpwN7A7c1c
        T+9im1GqSPMSGWFj/LehJVga242PZtNfiq0yPQ0=
X-Google-Smtp-Source: ABdhPJxxxt8Vr6pgBQcJ5IBc2VG41LBHcLTT9Dk8Dj38W0gurgQWGeb3ojg4zxFELgOL4hKKScSgmTBhFCKHkjelrJA=
X-Received: by 2002:a05:6638:2505:b0:319:a7f4:131e with SMTP id
 v5-20020a056638250500b00319a7f4131emr10425565jat.309.1647864925957; Mon, 21
 Mar 2022 05:15:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:148e:0:0:0:0 with HTTP; Mon, 21 Mar 2022 05:15:25
 -0700 (PDT)
From:   doss doss <barr.dossehjo@gmail.com>
Date:   Mon, 21 Mar 2022 12:15:25 +0000
Message-ID: <CAL2gNhCGACWQszEThi9gB1oqihMPTp_fj7CiS2toySPzJanNeA@mail.gmail.com>
Subject: URT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barr.dossehjo[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear friend,

I am Ms dosseh jo accountant by profession, I need your co-operation
for the  transferring of $4,500,000.00 USD to you, for both of us
benefit. If you are interested in this deal, reply me back for more
details.

Awaiting your response.

Fondly,
Mr dosseh jo
