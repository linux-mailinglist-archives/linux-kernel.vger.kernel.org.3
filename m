Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B22556F37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiFVXkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFVXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:39:58 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38222EA33;
        Wed, 22 Jun 2022 16:39:57 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o190so1445345vsc.5;
        Wed, 22 Jun 2022 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXbi+L+NkZbRlKgcqfJAgJsUF1nNxwKZOCLWcU+nmAE=;
        b=XQUS7Df/bBAuizAHoQu+LA8em3uvsxxvFrdbARCbpS133hVguFrig2TAJcNPlp5UEr
         EgTeOaYdu74/ND+AhbNgt6EZjWLgNRBvIYB/7L8vgqSYICyjjieVTc7iSUABgfMO+2pL
         BkTXCc2RtppZsgypyPl8uuq4uEJRux0BQK1lzhh8qXP5XVl+/Lcqa7rTJuxDAs6oVM8T
         81GwU1CwUKyxBxNPWFAV4J90mSXFmZeWctfFlmRSb81pa4L86+Bpk0dwFxF/XdZ4HCAn
         DA7iTpWVxpEfVnn0/qyu8CUbCcw3H3h3XqAFFr6OaRrp2OOCsHn4uGWkf9Mhwru43DDd
         Axug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXbi+L+NkZbRlKgcqfJAgJsUF1nNxwKZOCLWcU+nmAE=;
        b=i7G76ErT/jENCUvByN5Q99OwB4HttApEsguRiKhzq4KmuXpFWfrCzRNVgG/IklR1OC
         DspYUdsRmJObJpri/swJ5OmeyptyrWLLSZi1nZBXegrPnwHLduhW9AWJXRohGjPZj7R4
         /S82Nj2MLHk+fPdN3UU9gB0wornWI3MtAgMWjXjHZ5kjIvRRhHb1z/DJ9C0BlycWpOO7
         iq9Z0/vVBjsQRTxlM5NtJO8P04OYLa6XNYWGx/5ej0ykCv/RN0UvvI49nVbUkFwOOLEv
         Q0QI+YWbl2w3y3er4ICB/cMf9GEAGD5yz8HHU9jA8fJBJ1uUci3OQH+UlNYA35dEUWT8
         8VMg==
X-Gm-Message-State: AJIora/OdylhNqASiRiQ16LGc9/oQRt3vXpepBCAxqufkozXuNWH2ZDQ
        nLOhTHFK/F2yjYiepZ3mjt9p+xmVuGS7dzhis4HCvK77
X-Google-Smtp-Source: AGRyM1sYH4MvxuOccbW4jhOcD6WNYrHm8xEa3ZbzpVv2MZHPH0Y/fmqoH3L4Ipx2nh1dtnImz+/VLQvcVHN7C/SpiRE=
X-Received: by 2002:a05:6102:15a4:b0:354:6370:333b with SMTP id
 g36-20020a05610215a400b003546370333bmr2755572vsv.29.1655941196781; Wed, 22
 Jun 2022 16:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220623033347.55c86333@canb.auug.org.au>
In-Reply-To: <20220623033347.55c86333@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 22 Jun 2022 18:39:45 -0500
Message-ID: <CAH2r5mvtjzQfaZJFET-Ux1SU-tL9Q5s6fsH4wNikbja5acJmfQ@mail.gmail.com>
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

On Wed, Jun 22, 2022 at 6:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   cf1f97ccd084 ("cifs: periodically query network interfaces from server")
>   3864f0cfa996 ("cifs: during reconnect, update interface if necessary")
>   e0a746e20c4f ("cifs: change iface_list from array to sorted linked list")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell <sfr@canb.auug.org.au>



-- 
Thanks,

Steve
