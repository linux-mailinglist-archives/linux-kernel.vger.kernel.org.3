Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F594FAF5A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbiDJRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiDJRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:40:25 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2EF28E13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:38:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so14900935fac.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRJ1jNqE28imGI7c3KAwVBu2kMXYwikyn3C4D2W3iNo=;
        b=jda4TPC9ehpKNQxn2KF6cOe16kaYExIa9GB0ZSbtjxHec21YeUFvk8JJf1r//I54Uc
         985gz2HKIFDFtutQVg34xjYgOaWz+4GjrsFrrM9/rxzIZn2ZSrrEWfcxSQUzzAHLP6qz
         qT5D/CHXqmjLyIVvZRkrYKolD1nXhbEPByc92Z57Lrb6MVekybMphKdub9QMij8PI8EN
         jqpUqNSiSOOrNl7/0GxJM1D+VZiu5jD9DfPCn2G/j/uLD4UMC9hZWv8vdh35sQlIjHXy
         YP2fMsmxpVWbMfBWlS5li9XuRZaepocmL3VqhqcuGq7q1qlOUkBUC1S6lLS6JyuOgEeP
         ZSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRJ1jNqE28imGI7c3KAwVBu2kMXYwikyn3C4D2W3iNo=;
        b=INC3ME2JzaaRXNFTqbmmycLx4YvOquaihuBdzUZFzuMN2fSXgo/TXwqa0PHEQqdHXu
         1uItwKbthxZtr/o9tehpjLI6qH/q0YS4iSi4TsmaiLzsofHd2AevtLDh9qdicIETQMSH
         LsDFKxgD9A3DPoqo9bZeoWRC0uVIvqa/I4LWgkl2a0OQMPlVRGZKM4fZM6lWdtpMxkX4
         Cb7ZGDV+mfhhhvHGTyIaPX0cJeQ3f2tfjiAX5HFbEzm7zKEnUcpmrZnk98ZwFeU75hbQ
         xckl5jkg1OxBVGYueKRB/NRAuHRqxDYSFwtZ7K0MYnT4/khXkdyJPeChIGlX2daSAIoW
         4tBw==
X-Gm-Message-State: AOAM531lDs9PTtLp8vtfjR3trXmrkEzJ5fqh+u8jHENjxDDVAB8grboW
        jsjA31S74cUoigsEDRP4+ao7Rew/2yYSvuPp5J0=
X-Google-Smtp-Source: ABdhPJzwTW3uwroGYu3j+q5A853r1EPrtOF0Dmk2K+UyXmCYAbuguxdcR1kMcRILj7K91t5TJVp8ROjWnCzpKKvpfmA=
X-Received: by 2002:a05:6870:51c9:b0:da:b3f:2b75 with SMTP id
 b9-20020a05687051c900b000da0b3f2b75mr12624326oaj.276.1649612293601; Sun, 10
 Apr 2022 10:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220410163117.3964-1-makvihas@gmail.com> <20220410163117.3964-2-makvihas@gmail.com>
 <783d850ce7778e9d8f203155034e432910553b1b.camel@perches.com>
In-Reply-To: <783d850ce7778e9d8f203155034e432910553b1b.camel@perches.com>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Sun, 10 Apr 2022 23:08:02 +0530
Message-ID: <CAH1kMwTPkPV=gLg38m=yq=n1U2Mqa4+1XNtB_5Kc2y7O0mpMpQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] staging: r8188eu: drop unnecessary wrapper rtw_free_cmd_priv
To:     Joe Perches <joe@perches.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
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

> On Sun, 2022-04-10 at 22:01 +0530, Vihas Makwana wrote:
> > Remove the unnecessary wrapper. The logic of rtw_free_cmd_priv can
> > be moved to _rtw_free_cmd_priv.
>
> If you are going to drop wrappers, my preference would be
> to drop the underscore prefixed ones.
>
Yes, that was my initial thought too. But there are already some init
and free functions in the module with underscores prefixed.
So I didn't do it that way. Maybe the developers kept it that way for
some reason.


On Sun, Apr 10, 2022 at 10:38 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2022-04-10 at 22:01 +0530, Vihas Makwana wrote:
> > Remove the unnecessary wrapper. The logic of rtw_free_cmd_priv can
> > be moved to _rtw_free_cmd_priv.
>
> If you are going to drop wrappers, my preference would be
> to drop the underscore prefixed ones.
>
>


--
Thanks,
Vihas
