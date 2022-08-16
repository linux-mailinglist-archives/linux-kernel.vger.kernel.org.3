Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1D595358
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiHPHFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiHPHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:05:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B731367C1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:49:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f22so11776378edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=2kS2xa0k8qAhDZ7gENPx91Pig/qNDmJRpjQL0fi5H+A=;
        b=Y9aDIEePMDFJ73rwyTk5XP9I2dj0WXpoQSmauN0kdRrpZ9EEazBl8IzDErvUzfoyhG
         JORQ0mWKYMs4ZtFNs5KCOWyn+KPB71+d6UR5ZfRCCI2U4uPbT95Ci7fTWWHeFmxEhsgc
         rLKKXppjracKb7V9aU67cFz4Dfa+Vs6dmFU2MnwUT1ecDNCI0fx7wYCvOdVIW0F1Bj6T
         wPTB9Yqxj9Bpj2AFZizetzRexu+4nfY1ycoqGrIJXhv5u71pi2vWO3bzBgvNOn/9xo7a
         vYvYylAtSqneLPUFmxUVkanz9zX1ll0EAA4fLmrN9ZKicGxtPv2ZR3sjMkDghyQb/pLw
         dedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2kS2xa0k8qAhDZ7gENPx91Pig/qNDmJRpjQL0fi5H+A=;
        b=7xX/IJB+9L9YxfNynK5e0I4o5lARKYyfgRsnYfk9djeaamCmvJ2FZ88r9oG6hysydq
         0ieatphnhgJOz3cAQ/69jNpQr+jFXykuOZyHQ96HXRMakfYQS3IR3oEzxHZqfRmNM5Zk
         3rjICH65DKQoAw3G9hxutCH9QcORaUhduonIGYXUc6LXazNDjw+9mSH3MpQmXL6Gxm2U
         mVl/KBvEPB9MBDcgwyeXsUzuj0MSKcSwFOQFUT9T/07ca3qBFj4GRDprrCRVmvWpz2I0
         Cit3eRCbZpE8dp6zpHHg6rrqcY6dcdgKwhdqPE8n/3px9t4g0uGT7nho3d+JoDeMrYyI
         tDhQ==
X-Gm-Message-State: ACgBeo1Q7beIjsjBNDLqig/QH40AM1nUSglCkDnnwPz8GeqMBP/ztwbB
        g47DoxOUQIsxPpBzJGEipK9D86VYl6LwnFs5dRE=
X-Google-Smtp-Source: AA6agR4gBhAQBJ6V5lHN2mHUCBiwo0ZvSsyZKWjJiVXToZIk6MQQgGTBThwbcDrmqb981CldR2iknnm9jEvS0ssNz28=
X-Received: by 2002:aa7:d653:0:b0:43d:151b:5939 with SMTP id
 v19-20020aa7d653000000b0043d151b5939mr16783539edr.278.1660618167775; Mon, 15
 Aug 2022 19:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:874a:b0:730:f0c1:9102 with HTTP; Mon, 15 Aug 2022
 19:49:27 -0700 (PDT)
Reply-To: claytousey2022@aol.com
From:   Clay Tousey <sb9999679@gmail.com>
Date:   Mon, 15 Aug 2022 19:49:27 -0700
Message-ID: <CAJt-6-Md5zn9qr93+fRsEC2y2WSccaTcdYshqp9FxKrJVp2f4g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5645]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [claytousey2022[at]aol.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sb9999679[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sb9999679[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
You have been rewarded with  =E2=82=AC2,000,000.00. by Clay Tousey who won =
the
Powerball Jackpot of  285.6 million , for more details
Email:
Regards,
Clay Tousey
