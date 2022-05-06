Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C938751E0D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444377AbiEFVN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444355AbiEFVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:13:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5016F4A4
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:10:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so8600126plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=VdEsURPboYf6YVyd2JA3coY+Zd9siu1NK9r2HrgtDbwKJZYrxh1flF88fcCJTS+dlL
         mTLzGGmgUAb3aWxjkgcLdCoTbW7VmEudA1vvCSqqg/L2KORd59QjLtZ783O+oXgLnTgH
         5T7ZW3gc1OLjNZeuGr8ljDm6m8I7SiNnFrIiHcrY8fm4q4eSjOx8aG4XDx+uUD/JtE07
         L75XTILWeLzuMHewbgqTTYiFieallqMy0St8COBXAPkZqH3exbIvjZlBlIJK0exwM3AL
         zbV1vMzZ2teZWwxoICYSfUbTkFTcVScPEL5D8Cxrk5uIeYBjtR6ynGfLhP22bKfjcqe5
         cD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=4sHEZSFLcr1kLwi5ndraMFMUoiuC/S+n3mQkPiUY2hn1+HgDCWq26FuzUszEBCYTaf
         hkYSdyfKM3pQx1s+Ne9RGEkwO4667ZBvS3AOK6xCIdhJO7wW51YEvCIgUxirojpPwLjN
         pyinYupZc78xzTCU3sqqpIZZUqgNwuHIMg1iGUFMHdCJmxtm1evRxU2VoIVz9TZBb5tl
         NUAyO6Lrt7ETwmSI2adzA8j+IHKayXayiagHbXM7Ih/lEVWPMFJuIgmZTiWQT4Oezp+1
         HTud7Lm3xjjpfzSOz5Gu26b78DboPz3PGg9xxsbzgtFjjQLHfT44Rn31ZKbmY1Yq3x5B
         1kMw==
X-Gm-Message-State: AOAM532fBXF0jCsF53uJyLRD3kISSHA1mF/aQFF/ee4w6WBIKdAG1JDh
        w7TYBS5RBRinfQDAkyNEpB5MrP+HGgvq7r2awQ==
X-Google-Smtp-Source: ABdhPJzGLXwubMwfByT/FvvB+BHwD/9XnH8cwlvkuC62NNyApkc/4sz/AfkhU6wH0Ix386UR46zKN5UiPR1b5a2aE+o=
X-Received: by 2002:a17:902:edd1:b0:158:8318:b51e with SMTP id
 q17-20020a170902edd100b001588318b51emr5661320plk.89.1651871403145; Fri, 06
 May 2022 14:10:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:10:02 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:10:02 +0000
Message-ID: <CAD_xG_qn6+T=yoduyrHZC=Dzocy2+w7=_oQMHJv2vz-a36DPjw@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4819]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
