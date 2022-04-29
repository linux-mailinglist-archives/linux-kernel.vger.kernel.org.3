Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09180514132
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiD2ELg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2ELc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:11:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE0BAB9B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:08:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p6so6089532pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=rXVwUyo3MVtNL+xT25s/lfq5oTt/QcTA09676NshD80=;
        b=R8jspA1z8zI4wj7V4Mmv7Wq4x1y7yKKLVBUuSP0AIL4vaV41p+bfsLzJGx7vJO3ZnD
         pDqKr3iPrkBpbHMqFN3P/8hKo9YiLb7HtaiNmHFDeltG5deBKT0tZOJa5yaQHFRuZ+iX
         qSP088dxWwZAcoo9/V3kWYEAM4OsMP/XPA6AXI8zUgn9Fa+XdE3T4qKTy6fWbSanP+XA
         gGfeoXo7b9Ua0yX3JP+4cxsmrIBtE0PLLcL3WN5I72q1ygHBC7QuhHphfrAmpJkoOFz8
         nHlNRNWGxulWUcrd6txMoGDJHZwGmCwqnLU3oku5hvqWKgAXqiNUXjoBaJv7AV7kJhGD
         qd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=rXVwUyo3MVtNL+xT25s/lfq5oTt/QcTA09676NshD80=;
        b=3tfZTN9zK6aiyaNNiNrGGYybjNcwY/Vkf7N1ush9fkouSQuY6+MCqu0t6DcD0Az7fw
         t1xeeLvb5NDziSke4FWC4GWnXd/sRc6x0hF1LQBPvCskoZtpLzJwanhGfiGP8X8LT3aJ
         VRSw1riudwrQLXHjaG9PAgh4w5HkQ6bvFVtaVk9U1XrRPj+0MuJbctdW6IE874FxpIZh
         pIBYfMh/y4BQmh6tkr5cTjLutEOhbAjYvxzEWEB0Lj+4JFNqUE9vTksqm9wFNYBetWRZ
         q7EnsOkVI08GmRcciHDA/RhNPO5alGEe8gCwJ5iY3sBRNaugMlt9QfCL//0EL4DmkWaJ
         xffg==
X-Gm-Message-State: AOAM532M1Ua0rZ+lrPR62NGrIGAyhqbYreP3PC2GEh7mAwCOCyg2xDkO
        XzGuL5Xl1nOv80N+ysxiK6wYlVnY0ZQD/6HxwFY=
X-Google-Smtp-Source: ABdhPJzWx7eqOlZZ5CWyrof7ztAGo4ScI7uP+9t4wfRSrDVNUYq7hjht1UWBudTgSU1h4JV315XS1KND17nwGPn1fqA=
X-Received: by 2002:a17:902:bb90:b0:158:a031:2ff2 with SMTP id
 m16-20020a170902bb9000b00158a0312ff2mr37089061pls.117.1651205295242; Thu, 28
 Apr 2022 21:08:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:390c:0:0:0:0 with HTTP; Thu, 28 Apr 2022 21:08:14
 -0700 (PDT)
Reply-To: ahmoussah@yahoo.com
From:   Ahmed Moussa <ahmemusa.med@gmail.com>
Date:   Fri, 29 Apr 2022 12:08:14 +0800
Message-ID: <CAHUSESTpbgbQq8UZVBAgor+R5+MZM4GfrjGAe3awLJd=GLvkuw@mail.gmail.com>
Subject: Personal/Corporate Loan Proposal.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1034 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ahmemusa.med[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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

Moussa Ahmed.
Director.
Website: https://www.internationalwc.com
