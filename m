Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503A532E11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiEXQAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiEXQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:00:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA99CF29
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:00:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2583228pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=UnKMmMD3fOlvIFzWHDMM6DCJwQhQo992ALQ6L/aTNU0=;
        b=S8Al+yJO3o/H3vFCNW7UqVBnyDwdsPyE1vJPKReVwPBdTjU1yzYQqBGMnWU3BQm1g5
         DujLuZpG4CcyrPnl+nHV4WACwTmiT42LGLkbnIKyVg+/Gxir+ZJVfET7xd6X9E1jrDLi
         8S0lqE/5DdbrWF4xOtsqP8y6t8XYQFZCtUfLJ8hFXMwwxRPG4nDAAJidoo4mzvi8codj
         FFSqsl6MN3ND6fFLRmGc/wLmin+2k/fu6h3PxsT8GW27omB31olWA4lBJtR7hihUMjlH
         NlFMprJCljvI7DngN3D6aKn+3bz2nUS1b8Zn+ym+qzxX279LKwfWwjzg1j6FdDGVpf48
         ghtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=UnKMmMD3fOlvIFzWHDMM6DCJwQhQo992ALQ6L/aTNU0=;
        b=hVa2Zm0jlegCkB5bSDrWREZpk7twmECF3Os58NP022xrGySRKKjVffWCWhqRhbEJ9j
         KQ7TRfFiGvaxS8aa0Ax1v5C4/L4q7wbNVNVR+caU3OXalcm/8pmZQtO8dTtJ5Yvah3Tq
         C22QEbeLm9ApSrgUP7s82b6PHCKXg6ftqOJvhmRs/OUHOjrx/9/hCe008ytRw/wRYf8/
         DLfJ5VGSAZUypt8dbgMv3aesEHrIq/J46Lnx9CWLA4Pft4VQ1SOlZRH+jLDnF81yA1jc
         hiGQkE+jO8QLaeqnfUVvg2MWk7vAx1afwDqP/eJEJ3VPg8JOJBokcIpJT0zI9iqdWDUF
         cSHg==
X-Gm-Message-State: AOAM5327N3GfufKcgvdnXAFm4Ok2bUy+/xfZBUaC4Qj+dqsrYJ5a7mzP
        R/5qGWwNVJvyGQJ5O4A2mtJhTD/SZuuah7I+02E=
X-Google-Smtp-Source: ABdhPJwOY/bOeKqZYWms3iQnctryZS9KqT8CUgDjMduGuY3vR1U/CmWALqWpb8NHoBMffX5oUTnsgf73nPXZBTQfQ5U=
X-Received: by 2002:a17:903:32cc:b0:161:9539:fd49 with SMTP id
 i12-20020a17090332cc00b001619539fd49mr28707734plr.117.1653408007755; Tue, 24
 May 2022 09:00:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:4897:0:0:0:0 with HTTP; Tue, 24 May 2022 09:00:07
 -0700 (PDT)
Reply-To: mrssuniedwendy11@gmail.com
From:   MRS SUNIED WENDY <fatiouballe228@gmail.com>
Date:   Tue, 24 May 2022 16:00:07 +0000
Message-ID: <CAM_BD9tdHsEdjN-F4KcmQL9u8cDqguTxA7SWY12OmUYzdbcQnw@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1030 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4802]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrssuniedwendy11[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fatiouballe228[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fatiouballe228[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I hope you're ok, you got mine previous email and No answer from you
all this time.
Please kindly contact me on: (mrssuniedwendy11@gmail.com) for further
conversation.
regards
Mrs. SUNIE WENDY.
