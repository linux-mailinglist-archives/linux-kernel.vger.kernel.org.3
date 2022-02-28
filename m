Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C14C619A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiB1DOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiB1DOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:14:15 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EAF424AE;
        Sun, 27 Feb 2022 19:13:36 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id p15so12158041oip.3;
        Sun, 27 Feb 2022 19:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irZ3vtTDcOVe9lhdyrIDHtvqpgy0CIvn1ct/1rY01sM=;
        b=fqxqrmmMW9Q2TpxlcCZQNIdYVqW4RJ4JrKYN4kt7IJK3Pb+I9Rq1E7vD2Spf1tdZXY
         WHbtbuGPK0fKeyxfl3yzQNUU0G6pICSnT2L2bukplbFtPRYhSNGh11hSdQ8/OST0QF9I
         SCvcRO2gdxSJT3zYMdxu24lOP9cPM02WjxKmKj/1L0Qb2BYmzH5D2CoxAPWUyVUt4T3i
         ZlG0THb1BBF0zL3W7Qm/M2aKDl5StNt0PlsRHklgJ9uKA0SpvZUju5FIjjrae8u8b2Hn
         qSV2/6F1uI6OCKpxoc9QsozRq7Y+K2f/aFnOfFa4bDQxGHNzPB071/Ot6KDbxV6TH6jC
         z3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irZ3vtTDcOVe9lhdyrIDHtvqpgy0CIvn1ct/1rY01sM=;
        b=NwlAgjpL7w1Ze79vTcu9U7Vnt2ztYJREBz0+iflo/5owgl5VXPz7IlG2W8wsQnC6O8
         qI9Au8oQyVHjFgv72afZpkD0fc5sQn1yzQ0xzM/qWW9VbZJUpVT5RtzVYUNzbi27Zbqk
         FdcjCa1NI/A8TlkAVSCWIkvfrPxV/JFj6ul2FeTG0xUHgpoUbvrqXlJ3CiY2JYiAZH49
         2pKs3yp/Niu8mFkAjeoIgOrj/VPsqWViqyXPbjNSkIX+oMKYUJOGvF67nAUkkI/OsasA
         d/mHdAPD69dT4eX6+WxHj4HXiwGbpWh4+8PbWW8sGKm6glOQkRnD/h0yDFImOJG5w491
         Bvmg==
X-Gm-Message-State: AOAM5314a1ZlEv6xafqwNvm5haqrC8Rq3NZRNXZQ27DchRAEEA2EMGaZ
        +Fumc709unjFVVm/vZzfffxjBR9LO6MyjTsqwfk=
X-Google-Smtp-Source: ABdhPJwsmPVfi2U2U8YISc0Ux9faqPFpemM9XzAW3oKT8sNfojwZ0xmY8OllbRHgqpxdJFjoXzLwKzcZsfgL6j7E2Os=
X-Received: by 2002:a05:6808:f0f:b0:2cf:3d64:2333 with SMTP id
 m15-20020a0568080f0f00b002cf3d642333mr7097588oiw.23.1646018016354; Sun, 27
 Feb 2022 19:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20220228025646.1665265-1-wanjiabing@vivo.com>
In-Reply-To: <20220228025646.1665265-1-wanjiabing@vivo.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 28 Feb 2022 11:13:25 +0800
Message-ID: <CADvbK_f9G2-yTOd=n_0ywFjs15Cg9ZAqvzyQYjgxBCzFqDbeLw@mail.gmail.com>
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in SCTP.rst
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiabing.wan@qq.com
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

On Mon, Feb 28, 2022 at 10:57 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix following 'make htmldocs' warnings:
> ./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 5e50f5d4ff31 ("security: add sctp_assoc_established hook")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  Documentation/security/SCTP.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
> index 406cc68b8808..b73eb764a001 100644
> --- a/Documentation/security/SCTP.rst
> +++ b/Documentation/security/SCTP.rst
> @@ -120,7 +120,7 @@ calls **sctp_peeloff**\(3).
>
>
>  security_sctp_assoc_established()
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Called when a COOKIE ACK is received, and the peer secid will be
>  saved into ``@asoc->peer_secid`` for client::
>
> @@ -270,7 +270,7 @@ sockets sid and peer sid to that contained in the ``@asoc sid`` and
>
>
>  security_sctp_assoc_established()
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Called when a COOKIE ACK is received where it sets the connection's peer sid
>  to that in ``@skb``::
>
> --
> 2.35.1
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
