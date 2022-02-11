Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5294B2E15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353033AbiBKT7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:59:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBKT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:59:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C2C4F;
        Fri, 11 Feb 2022 11:59:15 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e79so12669550iof.13;
        Fri, 11 Feb 2022 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTE4PEJgiaxf9Zf/XXw3l+Lv6i68wKBWa7Qhu8g2aw0=;
        b=mdZ2RfvfkYOGhncEE+gl9ZhajEmPkVTE6kBHGZ9GM5S0rphOod6erM0O8MSrAxvvEp
         rsEejXVhCKnXhV37wdkpTj4C67Z+j/7XCkjbR6QvaJqjLMnLd9TRwdPux3k/OR0xUC2g
         mboCRfdEiZEhxsxY2TkLBhde38zh+cnF3bfZbjH0oAx0WSteu/QMkA+Vkk19RAIiFlGA
         +n6kp+PXlzYSHFC2bjjUaDORHuQS7HW0EGCth/oe32KASJ8rUEadTEUkzpJR+jLi9riL
         t6CvpmV/OLOKVJ3/Jsy4UtjmaDkskQ1zCsZI9ehRh75OdK9K8P2+TxDKpJb3vMNn766N
         ENlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTE4PEJgiaxf9Zf/XXw3l+Lv6i68wKBWa7Qhu8g2aw0=;
        b=sf4V8h/RZkJldYYUBLwBsoSb6x4oPLa1RL4yqVHN7girNH/5wZKjaTsj3Xi1jC7vJb
         CW4b1bYGZISttPcoTuT70aRJ/df5DEy9PeaOiRVlz8G9QybjAijctocFs9sW7EgOdx1x
         GsT+gmwq+JZeTVgXWRJu4pY3V06fjF4o6AeUIBfdTDr6oIZMaRz6jRzV/KbPjzjkE9CS
         /L7CG5Abz4Yvv0/V3nqFm3BgnlBmYAdhHfcshSovN8Eobfa839y7M2DjZt7xJmwGXKkc
         s4lQKgKwZr5v3SGgzHr6Jb56uoKBuGgFNGVa0llODfdsk4VDFOIglARewJhrgp4ow94Z
         rq1Q==
X-Gm-Message-State: AOAM531LOgc2mJumDWKD6E/srARLiHxTUIKDdYcQedTXLeXGCcVWOtaX
        2jooqqvVwS6xfBq+4HTzrpbaIhc8tTt1+9HttTI=
X-Google-Smtp-Source: ABdhPJyvb+nwvs5X64/qk/94eV096UXC73mGwUV+HRI1esH4Rtt5K00hSO8ekx97eTeBjT73BKFLBPzLE5UiUEH/phs=
X-Received: by 2002:a02:aa09:: with SMTP id r9mr1766480jam.199.1644609554634;
 Fri, 11 Feb 2022 11:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20220211184945.7b2fb872@canb.auug.org.au>
In-Reply-To: <20220211184945.7b2fb872@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 11 Feb 2022 20:59:03 +0100
Message-ID: <CANiq72n6=ovz-gjynqXcdP1=XOt9FovBtVzhRq4rvrQEbnWhdg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the rust tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 8:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> After merging the rust tree, today's linux-next build (htmldocs) produced
> these warnings:
>
> Documentation/rust/coding-guidelines.rst:74: WARNING: Unexpected indentation.
> Documentation/rust/coding-guidelines.rst:79: WARNING: Definition list ends without a blank line; unexpected unindent.
> Documentation/rust/coding-guidelines.rst:80: WARNING: Block quote ends without a blank line; unexpected unindent.

Thanks Stephen -- fixed.

Cheers,
Miguel
