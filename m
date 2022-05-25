Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC45346BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiEYWiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiEYWiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:38:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C818373;
        Wed, 25 May 2022 15:38:01 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id g14so41030uan.5;
        Wed, 25 May 2022 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xL0GPea5kQ7bxn6UyaRJEOf51coR3qwJk5kMICLIwEg=;
        b=HeaecojxpHwJKSvyziRxjH2T08gwGW2bUNjB5Mq7Qmx4PvvBZqOSQmtkTmBVTRSQ+2
         mY+3b2HL+/bCV9avlowKyW/RQT+aVGgK1TtHtmFFdEgvM0Zh0eob74ztm4GUDZ584Zvv
         /PT/KPhqBrmsBrxBa5kOdoYaUpWSAPdIK9+tsmXtVK8rQ6X6s0vw68hs0wlC7Etf0WHO
         wpY4CdYtuIq13R86nPTXwvc9bJPcnCINlGidR43/NpwlJhzgx8Lk8a2sKKxu0R27X1xt
         bIgzki6XQaS8lhVNMfga8znigW2IMGsP4lgJvpLR32V1p/VQwUHRtO0Oioo7UOFQL75K
         JuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xL0GPea5kQ7bxn6UyaRJEOf51coR3qwJk5kMICLIwEg=;
        b=qe+hl1txoQxgnenNjCEYnB0hyWtjlL61PElioofymTi/rfKIagrJlc//Yhgxjs3KB4
         2XB2UsvPinzUomO7s0GzazA91KbIM+/8O6ndyYXK+jn2Jev7axXw1+BPWH45Naa9+xnC
         z0XzC9cYQHBLTXlpmEHujRJ1gowo55i9JERksdwJmqKrxabveTZ9seIhpLRVm+zmw6w8
         jsYzfVdfAY9vtxIn08kjYfo0aJCKtEFl8mngterPXbKf3C6RGdhaS9xyiLhzFayuEFNn
         p10gXcBKxS4vu57bvhN94hhRBRb7TpqZoALVs9YcswATmarGTsMpRhDkRuhfpU56Q02/
         eykQ==
X-Gm-Message-State: AOAM530U3yGj8CeSP0xqernxxlIrcImH+e8Hgo+lPcd5JYQ4GioVpHeE
        6e+c6899hYw0f3GQoKCrh782TeLvJvJjhBX/StSJIHze
X-Google-Smtp-Source: ABdhPJzxKTpDsnqDJeqVWlDQNk2VE6k0KiIEioMZsHkMxJy3+0MybX6uvYAiir8IlAhEqo2VEyRV8oQJBF0ddSte8f0=
X-Received: by 2002:ab0:2008:0:b0:352:2b3a:6bce with SMTP id
 v8-20020ab02008000000b003522b3a6bcemr12718658uak.19.1653518280740; Wed, 25
 May 2022 15:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220526082420.0717c1f4@canb.auug.org.au>
In-Reply-To: <20220526082420.0717c1f4@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 25 May 2022 17:37:49 -0500
Message-ID: <CAH2r5mtmWr7CWghhEgq+KQKL9A1shttdXY2zraa3T32VaQErgA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
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

fixed

On Wed, May 25, 2022 at 5:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   a92c6daedb08 ("cifs: Remove unused code")
>   d0c4bb4b3c12 ("cifs: Change the I/O paths to use an iterator rather than a page list")
>   da59e9982665 ("cifs: Add a function to read into an iter from a socket")
>   13ae847ba07e ("cifs: Add some helper functions")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
