Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8325211AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiEJKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiEJKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:08:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FAC1DB585
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:04:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a10so517698ioe.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vjJ/DPgH5OA8A+lItdmXvfVjesRSStJY4gQ0upgp36A=;
        b=Dvb3+l2dOcBJa7de2OMoWNS/oOovHKNWDiART07JN04YL1eI9u3r/Vn2Yk0/0Dhuo4
         ejZOuHy46axmH8Xy23UNfudpJpdoRRCNGDhBkjHBvZvDcZl/5tJsAXqeRihg4Mzyasmz
         WIiUQVJB8BsLV8Hgs9+SjX1/UqIvm3jM0Gi8vQbBUvMHdTG05LS3CaNvcj3Dq9FSe9xy
         pw7rG08WF92cvRg17MuCSxpntL/eYgPOUVbhOEcV4gfHnhaX0niPItbb7X5I4xokas01
         UuRc2l4C530nvs1+rXIjU6iIvFmxhkfpFsBYbE9o2vmpzQ21OcAfGqVP1erRtG4ZtZed
         RNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vjJ/DPgH5OA8A+lItdmXvfVjesRSStJY4gQ0upgp36A=;
        b=prNEyCgSoOLjDu8AyzOa2oY6M6sVxzg4YoPF7wpw4f6UzKyOiu3HGLJdA/0QNFkLcY
         LasqLzVZ34aeBISO1yHWlmOvCWmZdNq9Mmn0KvyXHeoeT0xrhYOdEhB44diKg7h/UTQJ
         962EdKnHzDRux9rffDhgu1yWjk5kRAH9LZE2gfXr20nftLGzC40UHON4vZD8/N/pMPqR
         M1SnmUENMyvweHnbOnjVootA2RI6qc2LYgOzXjhlCg/kRld6D563E/25+yHGrnAMJmxr
         xj245Lg4hrtImCo5i4uxr+zLLfauWWIwXGBkM1YOypj0SFzLgm4ygoazQinmEB+SCqad
         zK1A==
X-Gm-Message-State: AOAM5326t/XOWyPN3vq5ScfRg5DQKIRf0nC4kKHBDbT7BhZj5njq09CI
        SZgKEosqJV81Z4lCGoLczaK1q27ntRmrYRLc15I=
X-Google-Smtp-Source: ABdhPJzN4dorZFX4EYBFEEtTxl/ghge+4imOU6I4uS5NPI+ADFzwzb3+p0YHRGy+qM0BYyWa2gVnLC7PcvkrCQUkbrI=
X-Received: by 2002:a02:a06:0:b0:32d:c5ea:58bd with SMTP id
 6-20020a020a06000000b0032dc5ea58bdmr545613jaw.163.1652177084442; Tue, 10 May
 2022 03:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1ca7:0:0:0:0 with HTTP; Tue, 10 May 2022 03:04:44
 -0700 (PDT)
Reply-To: qatarfoundationendowment1@gmail.com
From:   Qatar Foundation Endowment <philiplawrence58@gmail.com>
Date:   Tue, 10 May 2022 11:04:44 +0100
Message-ID: <CAKhidwUUqnuOwkbPSXwO29qsNpuGJGRSdFhtBC8U0gN=Qr2ybA@mail.gmail.com>
Subject: Dear Beneficiary
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [qatarfoundationendowment1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [philiplawrence58[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [philiplawrence58[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Beneficiary,

You have been selected to receive (=E2=82=AC1,000,000.00) from the Qatar
Foundation, kindly reply back with your full name and address for more
information;

Regards,

Mr. Rashid Al-Naimi.

Chief Executive Officer of Qatar Foundation Endowment.
