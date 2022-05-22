Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93325306A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiEVXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 19:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiEVXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 19:00:15 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7238DB0;
        Sun, 22 May 2022 16:00:14 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id z6so13207151vsp.0;
        Sun, 22 May 2022 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SF8GydDc0GrVQnk8HXDQAYHPmkcAYm0hZkZSE4F+/Mk=;
        b=lm6jR8+5QtZGNHO23qu0pS/uTGBdJ2p35Nn8Z9bH9jQ8UyxD6ID9QrQ805maUkbdpu
         ydZlalnPYIQm7CHX4GqxdFIgDcZPiJwxaEGGz2PzPdC9WjfgLqYYYXUpJfgJI6+dEONr
         KuAFLY1sp0WJmhuWo37nmVtdtSbRYrY+cKQpPLGJEuglOB11GxW+dtqxvBycMJljkT8s
         G8yZJvyhfPnVkJ3U9sWmswQhvlD6GIpVz1pC0XyFfAjVmxV4tN6UQ85SeAiz9Qth1YnF
         1enGrNGSs7YTuep8oIdgFIQivYCQKWyyHh76xcgjpdanOZTNO3ECitixu6kD4GPSt+Bk
         34sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SF8GydDc0GrVQnk8HXDQAYHPmkcAYm0hZkZSE4F+/Mk=;
        b=YFkvDdR9Zs9bgLeXbR8HrI5mkapTOACqG/c71Htl12z4Sf5bbIQzwn1toEEVz7xnFZ
         84/n4LtszfkhYbrxOr7q3dkb8o2NT93gIGmCqZ+4eiQZYZfBNB0cnkXhd8qf/ukOMNRP
         lNmp84k1fnyWp/tJCYqCpZT85KKx+EIyh0mXL6vTx6Xi/HYEwzzhnbfC5tecGVwv6Cdm
         M++5XBx+pWSWsexJh0SfUJH4qqJgTTqkaIAE8aeVPB62Q1LxuRNFgWHwP5q4BHYXUnx0
         PcknXq3wDleuKyWEzQGaZk2ognJbG2s0GNEkd+31phJ/uHwJCH6q/UKJR0mazM6V5I+u
         3iDg==
X-Gm-Message-State: AOAM531ILwSBDXNBO7nz5kfmxKwJzxjHe3tJsGq4lyMOrAPlVawQJJ3O
        Z44+vF/VGe79tMOMThP09DZLXsfHW7FYzSxam7Xwlb84
X-Google-Smtp-Source: ABdhPJyWO8zf5D/YhtV5FcffI/x394ipbzxX+5SQUfl7UuxsZe4dKs6EW3pHTnZHlQaVb72Vj4c9jNDoPjE2A7uE2ao=
X-Received: by 2002:a05:6102:3a0e:b0:337:ab1f:3a8c with SMTP id
 b14-20020a0561023a0e00b00337ab1f3a8cmr1272232vsu.61.1653260413547; Sun, 22
 May 2022 16:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-69-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-69-Julia.Lawall@inria.fr>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 22 May 2022 18:00:01 -0500
Message-ID: <CAH2r5msEi=DrdQfJ0LJmft_w2rMio8e2hn+qznOHuywV_2iSqw@mail.gmail.com>
Subject: Re: [PATCH] cifs: smbd: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Steve French <sfrench@samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
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

merged into cifs-2.6.git for-next

On Sun, May 22, 2022 at 2:51 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  fs/cifs/smbdirect.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index b3a1265711cc..c3278db1cade 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -1350,7 +1350,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
>         wait_event(info->wait_send_pending,
>                 atomic_read(&info->send_pending) == 0);
>
> -       /* It's not posssible for upper layer to get to reassembly */
> +       /* It's not possible for upper layer to get to reassembly */
>         log_rdma_event(INFO, "drain the reassembly queue\n");
>         do {
>                 spin_lock_irqsave(&info->reassembly_queue_lock, flags);
>


-- 
Thanks,

Steve
