Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2234F0118
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354659AbiDBLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDBLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:31:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43F49FA9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:30:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so4761844pjf.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=NqY2TCOszCZkPSHwC0/0PBFkk/WFKJTEsan/Bnl2loc=;
        b=I5eMPNCdZy4QHVXW2k78M78CbiuKNzdWuoQw7dj/ph3lSbA7w0OCb3gZ2LG2r2oih3
         /9niWAGUPhDx4CYQHYfFqrGcd+HTC8wuuvCse2HIquoJOlhPYJgKp7GV9DoV5LnUx5cs
         ANN9AUPUhhUm5h0e6ZuWlY0JQi/WEbkWi92U0c63VssY+xf4Jsuszq8voU9Zw/pE2bdJ
         scs+fE/Fb0EFJ8mYeFmePiw1s4W43k9Qw/BSXbR16gqqN+36VP/BzXt6EIJeftlyHg7T
         hs4EU1iCIfN6e+ZjfsK2B/opMgEfCR4E5FNoe04P2JFpeqNvZDe7shjVv4ZMBxmfEhwO
         mdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=NqY2TCOszCZkPSHwC0/0PBFkk/WFKJTEsan/Bnl2loc=;
        b=6rqntQygrBF67wNRR3vwjJszFzkgrTgKExf8kiTqWXE9t8MXO4Riz2hn6/5OCFTVKT
         V4geU1MdQLM7zsbXU6PpYKbcxDRKe9UPnhaYK3h+FO5Box9ElhPZ0bnOMMqyN2qHmJQj
         BQsV7L/vXueZyw0cZl3/qzn6i0pXth2tVln17rlV/DTHASZrQqhbOdCU2YFPHTSWgJRr
         75JHcfWQ6y/RMzgFXdQYZQvLOXnGSMbh+D0BO4gd06oBXwMpufNaB1e5QgJR9UdNDhxK
         MQRFfew/nMsxOv9NVPnLhBw+LCeVQeQQW4Q2xbtjkxWUImZt2UdCRGcfkXUk3bh76SHD
         XtMw==
X-Gm-Message-State: AOAM531+OOowSzStM3ekirpDgbo1HR43FsUroBqAQh2Bv1kjmBRk8v2q
        0rpQ+UWzVi7iXrV0zt1AWgPapEsdZXn6T7pCAQ==
X-Google-Smtp-Source: ABdhPJzZf6QN5YYeG3w/LxvQpN6gNmoj4hIbeF4Jx0NrZKiFUJFFXg1/+Xm310/lTrAFXhBHSHQ0V078DubfWXFo6B8=
X-Received: by 2002:a17:903:18c:b0:154:9ee:cedc with SMTP id
 z12-20020a170903018c00b0015409eecedcmr51600938plg.123.1648899001742; Sat, 02
 Apr 2022 04:30:01 -0700 (PDT)
MIME-Version: 1.0
Sender: cliffordmama534@gmail.com
Received: by 2002:a05:6a10:8e8b:0:0:0:0 with HTTP; Sat, 2 Apr 2022 04:30:01
 -0700 (PDT)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Sat, 2 Apr 2022 11:30:01 +0000
X-Google-Sender-Auth: LWNhgMImPCH_E7LbdRSPoMOktg8
Message-ID: <CAOAvPBt6YVwfuSak0f0FFT6mQMVv2ZpDdWa026gPDPQeryXZbQ@mail.gmail.com>
Subject: hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cliffordmama534[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cliffordmama534[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.4 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello dear
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow. My reason of communicating you is that i have $10.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which  am the next of  kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor.I will want you to use the fund to build an orphanage
home in my name there in   country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.  Yours fairly friend,
Mrs Yu. Ging Yunnan.
