Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1031749BA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355506AbiAYRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbiAYRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:35:45 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20B2C061751;
        Tue, 25 Jan 2022 09:35:45 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h4so3805194qtm.2;
        Tue, 25 Jan 2022 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yVJgv+46R+iVcs9RtG4FewPPN7Oe5szgAktholdMCSQ=;
        b=opAm1WoYeQnBuA1LM6os+SwLTDYSra807LsTGEREgVzsCh/+OMrlzuHQMXShxa545C
         zpra7QREhGs0YDpf/Z+O0h6PaJL1jkldQgWf+tzDnj82KU/MCUj6OmAeDHQjudU9obyW
         YZFDzGIzW2hPw6eoFPX8/1YPJEo2UVlA2tbZlkKQ7A8t6Goxal4PFq82AJ6zWq+8JCkI
         X7VebQv7gP8eE02dq5pUu9Ex8UTYGe2NJ2Y/FoLq8LIVBZF65sjRxJ3jm0/ti73xxUgt
         L8DndnVPR4afozmy2gJ2s50DPpRl1CnzZUbN9eZj3BpGmx+JNUNzCYDfQphptxxK/DNd
         vyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVJgv+46R+iVcs9RtG4FewPPN7Oe5szgAktholdMCSQ=;
        b=gdMIXYCKuBdPpp7aVTr6AQ5aYSHhN6CfbpNkIzx8vlEQNO/VQsHAlH6qam22h5buKz
         OX1HcTN0ZOiwsOkn5sdvXzPz/8o9HfuZHkNyX7u9QgW1yHnxCDJ7ZDhOQqH4Vftvfik5
         /fkd+AOg7Xy4/3tnW7gU+83Dr4egApYTwZljyujCPZSi2BAmY2rk9XL3mnDL/d4uSrFk
         /ut/KqRtdXisfz5Bb+MDOxvyaTdZUvTwswy0PvE/HYzU+W8li9Zk9MvGl4uoqkYww0gs
         5I9e7m5wbKTGqDYtUbN0Z3T5BsCcQ3B4WzS0fUHeSgqqVUFnMbPT7LkB8a0ab2tuYVw/
         dUNg==
X-Gm-Message-State: AOAM532iPI3ieHYSg0rUxmYaxp7KAeQ9d0fm05UmzDygmiEqoNaEQ3z9
        ar6L5OrTbckFgCVklgV/WkQSR1hCb4Y=
X-Google-Smtp-Source: ABdhPJwp7wWMc/nz5EWzmBTPh6oHiTEh8ssQzLQHCrsLy2sIHd49658aaJvcFr2XEcfnrI3/b9JZbA==
X-Received: by 2002:a05:622a:40d:: with SMTP id n13mr17480123qtx.511.1643132144606;
        Tue, 25 Jan 2022 09:35:44 -0800 (PST)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id m22sm8914855qtk.37.2022.01.25.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:35:44 -0800 (PST)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 7E33A2B1C6;
        Tue, 25 Jan 2022 12:35:43 -0500 (EST)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 7325C603828; Tue, 25 Jan 2022 12:35:43 -0500 (EST)
Date:   Tue, 25 Jan 2022 12:35:43 -0500
From:   nick black <dankamongmen@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] console_codes.4: ffix
Message-ID: <YfA07xh8an0c4AIt@schwarzgerat.orthanc>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <98d87c52-da33-9ee4-b9df-253c8ae8e093@gmail.com>
 <YehE3p7es9/4wBuM@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YehE3p7es9/4wBuM@schwarzgerat.orthanc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nick black left as an exercise for the reader:
> if we're going to keep it, we ought add OSC to this section by
> the same reasoning. i can do that and send a fresh patch, or you
> can do it to my patch, or we can do with what i have.
...
> sequence, especially since there's really no user-relevant
> reason as to why one is in any given group. but i can go ahead
> and break this section out if you'd like.
...
> put another way, some people might read the man page wanting to
> know "how do i change a color". i can't imagine anyone ever
> wanting to know "what are the various OSC-prefixed commands?"
> that said, i'm happy to introduce the substructure if it gets
> the formatting fixed =].

Alejandro, would you like me to make some/all of the mentioned
changes, or is this patch fine as it is, or will you be making
the changes? Right now the console_codes(4) page has nasty
formatting errors (addressed herein); even if we make no content
changes, they should be fixed IMHO.

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
