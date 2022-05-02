Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E271516C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383884AbiEBImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383870AbiEBImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:42:10 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE944772;
        Mon,  2 May 2022 01:38:38 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id p4so10060909qtq.12;
        Mon, 02 May 2022 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nIzQZnMpTAmjQQOkm7iT5MX1+3DBposIe0eGJZB2fQ=;
        b=cRbKx3/+M9WlbABbBUCHQszesjhhvIYryBaKFV5ctYla7wLTlM8ob04N9RoCQs/CIl
         U0zye1YvAzkEHwKshhfjw7qpry8NE6zMGxpFltLy2TF9ad3mQRW9rQjtRyyze1buG6ep
         7OGRYFbMlw78Z+7iOI0qIsA5+LLC0ssTi2tpP4yh44pXkscvk7FYJ8clnv4bIrCqyZdN
         2x5m7oiX6TPgozu7mFE3WHb9wi69vy8vGf9AZa6GVXUQ6DV+gbnlt/HpY0ZAkr73iaWu
         rN/WQbin8NQ7Prxjp4Lo2eqQYZUH+5NP2AFHWIZfMlaqUA7/A2SxIn4utu1/ca41Lm0p
         Ow4w==
X-Gm-Message-State: AOAM532l3TbJ/8rLWKFXqG2LkcjKF1q4hriBGS+7D37uNv/wL3F4s7AX
        lAv+ikDRYtrtyvAaDMdyIxHPXKgQfb2p9Q==
X-Google-Smtp-Source: ABdhPJwr2719fQ6pAC3tDrB11fGRCbhIipwNS96ZYJUjW7WZ+k61suTavwAjzzh6pu6lH4yMjH6V9g==
X-Received: by 2002:ac8:5943:0:b0:2f3:a0cc:56fc with SMTP id 3-20020ac85943000000b002f3a0cc56fcmr5855747qtz.170.1651480717674;
        Mon, 02 May 2022 01:38:37 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a0f9300b0069fc13ce1e8sm3904925qkn.25.2022.05.02.01.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 01:38:37 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y76so24908651ybe.1;
        Mon, 02 May 2022 01:38:37 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr9787048ybu.604.1651480717160; Mon, 02
 May 2022 01:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220430191122.8667-4-Julia.Lawall@inria.fr>
In-Reply-To: <20220430191122.8667-4-Julia.Lawall@inria.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 10:38:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnbbURooc7bePQX4E0FZVPO+eiKd8kYW2cz0mx3r82ZA@mail.gmail.com>
Message-ID: <CAMuHMdVnbbURooc7bePQX4E0FZVPO+eiKd8kYW2cz0mx3r82ZA@mail.gmail.com>
Subject: Re: [PATCH] m68k: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        kernel-janitors@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 9:11 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
