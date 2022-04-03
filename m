Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B34F0B37
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiDCQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiDCQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:25:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD837BE2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:23:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d142so5915679qkc.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=owGcLPcPA8pCKHTXfjrJbH6tlONJOWdLBDMya4XOEgo=;
        b=gLPvMkcf2YsDRZMVErBXUUlDFihRtsWI4go0Nx1C/1/NWadip1qzEwURuDLJhbw1NK
         OGl1uPG0bIQBJO9TQ/FsUaLIV8ZSFJgF4HkJ1rmBv+RMcjCd5fGhhk8YtqyVz/TfiA04
         F4Z7eVq7EO4qlg9q3Z6nzWNj0zSt8QSwx8yUz1BhuLQ/bCFWavKkRqlCE3rjNpvpwPYf
         eTEBGsvxS5xubco0hB58Xe+ReKph9N48w+Om9aCeePmM1/MIQHJzvaUbbJ2rIhHu+vu7
         3yiqivfMrHUGgZoiiy4A0JsbdFizaoM49RzchqMyfYBm696ASPATJL9KLEvxxvSAD2mL
         uTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=owGcLPcPA8pCKHTXfjrJbH6tlONJOWdLBDMya4XOEgo=;
        b=3tOAe9dzT8vqVQ2poGzNVCRriBWKmajQW8G12SUPItQ3/ZqVOcdEGGG1lWibStrwki
         U5syoiC2gLRHAY5iFaj+bPcM474V4qqjCWge5NEtiapgq7vh7x0Z4FHNTTGVgR5fB50z
         Kn8efiQAh9vdCHJGfZhqqFK09ZkNW9Ve9A6qFOON5GPqN3tNo5ggIRMuEJE/bD0Wl0r/
         fQ+f7XNj2fYOz+da1GlQDr01Pa6yMNr0GUKaGG9J7DsRe2G7oTpUNQRXtX3GT58r/Ruj
         M0wyffYv08YJI3gHBK0MSrOJNPoR00FDpDSOvhLizTN0/hl/ROYtZmhsWMQsSlOK118v
         1Emw==
X-Gm-Message-State: AOAM5325CR0HCvDOBIDircSq1SJiNgn2cIU2zKCzCGyrSbnaUT6/NRjW
        pPUk3rUH7yuRaJLpY6KlIzmPClV8Hlwx3W2KW8s=
X-Google-Smtp-Source: ABdhPJwZfvbCI4tO/Id1gNsTpws8gKqIekhZoVvbXgaFcyHUZ/iG7idCKaaIjmI8AQjN2kQ7ibojQZDiKw5FPcvxCFk=
X-Received: by 2002:a37:6cd:0:b0:67b:118d:81e8 with SMTP id
 196-20020a3706cd000000b0067b118d81e8mr11739547qkg.88.1649002990988; Sun, 03
 Apr 2022 09:23:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:242c:0:0:0:0 with HTTP; Sun, 3 Apr 2022 09:23:10
 -0700 (PDT)
Reply-To: syemoh_med@yahoo.com
From:   Mohammed Syed <mohsyed.med@gmail.com>
Date:   Sun, 3 Apr 2022 12:23:10 -0400
Message-ID: <CABfuGTor2OUJo0pgGQQPhxTdBGwy3sP4NuMXdtuKt_HxC90Vgg@mail.gmail.com>
Subject: Corporate/Personal Loan Proposal.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,URIBL_ABUSE_SURBL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:730 listed in]
        [list.dnswl.org]
        *  1.2 URIBL_ABUSE_SURBL Contains an URL listed in the ABUSE SURBL
        *      blocklist
        *      [URIs: internationalwc.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5027]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mohsyed.med[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr.,

We are offering Corporate and Personal Loan at 3% Interest Rate for a
duration of 15 years.

We also pay 1% commission to brokers who introduce project owners for
finance or other opportunities.

Yours faithfully,

Mr. Mohammed Syed.
Director.
Website: https://www.internationalwc.com
