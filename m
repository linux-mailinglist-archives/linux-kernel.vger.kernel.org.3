Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12059E645
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbiHWPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbiHWPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:43:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119DF296573;
        Tue, 23 Aug 2022 04:40:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id g8so8668138plq.11;
        Tue, 23 Aug 2022 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=HRfba2ZkYZCM1D9aUkoUNXDUBf9660MhvdLdrBTo7Ss=;
        b=AAeqEBL9MB3YAtJpl/qAbJ1vzCqD98FgvuD+7Rk5AdKB6lBVp0jXbIAWVrSSeX6aH4
         05H4uY151vzAPipETs6T4Zgrnj/Fg3qGU3Q3YV5rNAI3ceF3Dz/c9mvDLp8pbF5e4ai4
         hR3q8tyxuScXpx6aszPHzBEW/9S8vpz1L8Y9fu0LHX/OCCe171ZummXza3MSW9B51AxO
         OoRaekDYjH34NJOTlQMWLUoz8V5NFLUR+XSuQoTmOPHXgLpXzqRuALKXd0KrWbtKKlAg
         Beda/HDxoluaLCTp+VQ00kJpd8UXeJFteyXXk8bf67+pJc3kcG5BJs/LoacihQQh98wZ
         2seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=HRfba2ZkYZCM1D9aUkoUNXDUBf9660MhvdLdrBTo7Ss=;
        b=d4NCq2zwTitcD1V9f6nStSu6/XZ9KIxddJRi5WylZwhzuqBp/APb+Evyd8ECgqtnEe
         9ubGwhkbED10Zl1oil5ACTMN4iPipM4dYqTCJeLA7BQ2Be3O4uGdEgptDZaOhjt3hG7/
         gyRtfQoyuja7mY+Vn0n1hdsV1vdUIZAdY0P5J9ugNfAz1hgZgAf+jNCfW61DXKtUFQ8A
         8GD++JobvNySScwNWFfHXA2r8x5BOlCJ7TdpMbj+eKaMR/ZIj6DQ2ezA/ADFv7Rkn6TE
         /cS+uH9B0cGS5Cgb43A8N/Po5GP7rE6+Nz0OsISC67N9x745Acig7PE5rXNCycZ/GXZF
         LnMQ==
X-Gm-Message-State: ACgBeo3dF5Yd8mftlZcUNzPW3X/b0/W5Ob7KhN2ff5PSLnbZLs3LoXKW
        KmYJX9cCemsC0E60lxZmHDZvgs9lDsFhOkXbrUJSRXMf45pukw==
X-Google-Smtp-Source: AA6agR7Xi80ZOmP/zesxSF5UOCSBzj/yY4cxIphiOeR38Ai5oiZ64OVCe9jwC9ZpSafIck+lhkfVn1cdQABanRd+91c=
X-Received: by 2002:a17:90b:3d7:b0:1fa:e708:ef43 with SMTP id
 go23-20020a17090b03d700b001fae708ef43mr2910997pjb.239.1661254788863; Tue, 23
 Aug 2022 04:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220822165646.87524-1-sj@kernel.org> <20220822170500.87712-1-sj@kernel.org>
In-Reply-To: <20220822170500.87712-1-sj@kernel.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 23 Aug 2022 19:39:36 +0800
Message-ID: <CAMgjq7D989Ki-zHN5=yY+MYj2tUqizmg++PSK=5J6epr4isF6w@mail.gmail.com>
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj@kernel.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=8C 01:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 22 Aug 2022 16:56:46 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> > Hi Kairui,
> >
> >
> > On Mon, 22 Aug 2022 18:56:17 +0800 Kairui Song <ryncsn@gmail.com> wrote=
:
> >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > The workflow example code is not working since it got the file names
> > > wrong. So fix this.
> >
> > Nice finding, thank you for this patch!
> >
> > >
>
> Oh, I forgot saying that it would be good to have Fixes: here, like below=
:
>
> Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sys=
fs interface")

Thanks for the review, Let me send a V2 adding the "Fixes:" tag and
your review by.
