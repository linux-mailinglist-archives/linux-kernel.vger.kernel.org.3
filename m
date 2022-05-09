Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE651FB1E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiEILRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiEILRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:17:07 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3D1B7921
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:12:54 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-ed8a3962f8so14289367fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=BvEpJsdLyWkG/ZeXuaaiBOv1MHVrckZz5qeBUdhD8XTcrZ3uJSY9oYHXGaJjLQIJCC
         H+L4mBcV5datZIH3hhyY3MpB2YgmWgMbl8tnnRBVvA/jYl5NtzOAEGa5xx5BPBsdCYPa
         4sv4+PxoUXUH4BhYI+xl09aFjiAZTenCqC1ikG9a8mcXsda/G3I5PBbi8pjPitVtJCuf
         Lt9u1vYCB5Go1XVhb3atFTHDEx4NIdOiKBEsQNK3iSMQI4vJk+Zc1Jswizx/UujNlS33
         bDvenD5S6OXjblqvdraORZfpEv3DB8XxqcT2ZFCb6EDnQBVdlgi43TIJPuQnsTv+rJeA
         WZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=zHiWeD0a+qICE1XOs3EBLoXXu0NT2KS/ff3Pw8/aJTKUw6RW9jZuJReLzkRRjYP2Ok
         EceWgNua3Br0+tjiURZdCpsdCAeXLaOSnBX8Ns0YvTksI5xmFbPQy1NFz8J0FJHajjzj
         rjB6IeVZa0944DsNyjT6a+oSFi0IxcWJEki9O7Pkpn5hm7HxvuUO4sdkZoj6+VRXiHSH
         Exech9tqO/kJJn+I+2rpy20UrDlHZpJqHwCxBrI/aKJazIQrygV9QCsorUW5ywT+DWNn
         ckIyugV71sA6kGCMsKOlrOEgw0ubT6362mEcWpVEU4/7bpLXVwn0I2mDDAaiDXk0cLz7
         U8lQ==
X-Gm-Message-State: AOAM530HxmGvooSp845aKycypxB14O6ZpgN321F72witLyRCx7baBx3Y
        NQ1CNxWUh3wo5G8wpNx75uIZShapw6vc84/Gjag=
X-Google-Smtp-Source: ABdhPJzHG3CtYpNWe7dPMtQSsG98qUVpK3KpyBQDcm+zogAnGcKehdHJsgFxmQ5NlWHqxfncw2/FUOKpZt719+9Ix7g=
X-Received: by 2002:a05:6870:a9a9:b0:e9:c463:51a6 with SMTP id
 ep41-20020a056870a9a900b000e9c46351a6mr6842371oab.101.1652094773331; Mon, 09
 May 2022 04:12:53 -0700 (PDT)
MIME-Version: 1.0
Sender: giumamohamed@gmail.com
Received: by 2002:ac9:5e5a:0:0:0:0:0 with HTTP; Mon, 9 May 2022 04:12:52 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Mon, 9 May 2022 11:12:52 +0000
X-Google-Sender-Auth: ipiLAXrwzZOzqhvEasrMspRvqhA
Message-ID: <CAO8vdpcnNWmzkW6oOFZ1n6BUyMH2LBk1Pcy7Ecyjc7uwxRGGvA@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5018]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [giumamohamed[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.2 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow. My reason of communicating you is
that i have $9.2million USD which was deposited in BNP Paribas Bank
here in France by my late husband which am the next of kin to and I
want you to stand as the replacement beneficiary beneficiary.

Can you handle the process?

Mrs Yu. Ging Yunnan.
