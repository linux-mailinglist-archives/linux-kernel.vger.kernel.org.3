Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F655F153
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiF1WXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiF1WWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:22:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F873FBF9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so19643150wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BeXPYPsPcks1vJnkCiVR+AZ4T0LVp8r4SqdR8q577ps=;
        b=GPDc5Ne1/t+yvsW3Zw0uTBJiRPqABbV7d6iM8bfuusK5H39x+/WZITaYKgU8TsNogF
         TlkUn6WfF0pK/0V1ftgApLGmqueyGM4ePfk1cw+ofrd/xlGAqZ+lki61xMTZKtEH2q19
         DJHmL1e1ScMdpk8ETbUl33lEtxw3EyTcbuvPr9h35Oy5gKF5czZ0+11hfoyCB6T5lJkm
         brY+xpKK3dY9dUCTlkZkYsUMAeCqMjQGFXwMaUnxEO/lHkKVuQJjAseYsc6NPvEcsG7o
         7FX0RuohRm51uxkjTI19J5OFzEYkC2rKkC9IXUnxb3YB6vAL/5yveRMijZ/WXt5UTV9K
         lcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BeXPYPsPcks1vJnkCiVR+AZ4T0LVp8r4SqdR8q577ps=;
        b=5S12+GN9P1FhV5mBpyzL0NQE6lUITU9vZXM1IyWsMmTm7MQW1+doWwvim2NcvWseA5
         GTHgYKq7k3hVcfaEClJbnQqW5rxHMKJ2atBfGXAV/QEOnhe5b10Ug1idMWn46KNxBtJZ
         0GV+N8DByEBgN2Q4ildmvBJVzdWd84AefvI/H1LJeTvFCSj26H1KIBPtVvq55QQv7YJr
         Jzv1exsW6QEHrr5+kf7Vgahxwb6h5dLn4E1X/2Qn6fkbeYj43ROLW5UynmRRFbhWyN61
         gObB6qWt//nkahPNNe/XVxeGoNQANx8MJTpPj3NH6rN/jlkOumsHaVsABLKTPJRRbw0s
         mQhw==
X-Gm-Message-State: AJIora+g9eJqHMMM/knVjMl/DNVAeA9HCtLenCjQLwJNuxAAqUFNebcx
        2fbwsu3nc6c/ASYddgAfnkovU4JvbIGbiW/RJdw=
X-Google-Smtp-Source: AGRyM1smyTQMQyrdcmp1N5CRb2Pq7Og+0Qb10LZ8nhgBoIqCtQYN4M9y+PhLb30lIJ1vBLpKwvNk5SnNivlVnlMjO4A=
X-Received: by 2002:a5d:4a48:0:b0:21b:9ee2:a6e0 with SMTP id
 v8-20020a5d4a48000000b0021b9ee2a6e0mr36896wrs.468.1656454708330; Tue, 28 Jun
 2022 15:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4bcc:0:0:0:0:0 with HTTP; Tue, 28 Jun 2022 15:18:27
 -0700 (PDT)
From:   Drzulu Nelson <dr.zulunelson09@gmail.com>
Date:   Tue, 28 Jun 2022 15:18:27 -0700
Message-ID: <CALWycZqSf3Rt48JZMftt2pVEmBCSMAujxZJ9a5P4zemVHFwMFQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dr.zulunelson09[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dr.zulunelson09[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.5 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20

--=20
Ordering beneficiary,

This is to inform you that your payment file has been included in the
first batch,Consequently, payment approval has been issued by the
International Monitory Fund (IMF) for an initial payment of =E2=82=AC
4,650,000,00 being part of your long-overdue payment.

To facilitate this and avoid further bureaucratic bottlenecks,an
accredited financial institution has been appointed to handle your
payment file as well as others that fall in the same category.

I therefore request to know if you are interested in receiving this
fund within the next seven banking days or would prefer to have it at
a later date within the year. If you are ready to receive the above
mentioned figure as explained,let me know immediately so I can send
you contact details for the appointed financial institution.

Kindly reply through my private email: ( officeauditor28@gmail.com )

Yours In Servive
For;The International Monitory Fund (IMF)
London Ln,Bromley BR1 4HF,UK
Visit our website: www.imf.org
