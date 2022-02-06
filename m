Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4934AAEA5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiBFJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 04:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiBFJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 04:43:00 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDDFC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 01:42:59 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id w18so14904058uar.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 01:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5FeNV6IoX1x8bGptsyCBCGGVwBQsutgr12XFlQJxbY=;
        b=EnbOH6JLesYZqMo/FAvLTNX3NaKPyPrUxvTCUqvirqmz4TE/Kz79s/VKu6LNO3P/ng
         TTw1Wvf5uFHQaWyKlD3qOFMxd+sGu7c402B3h4lgTz5Szb1CXYwCPT30FNSNBzgrQFdT
         YVT15tOBBtdmRT6QJZrcbPJRrOWRIy6Yt7kkPfWZm0C1RKNwcYw59uuODhxB7TVWLpuE
         L2bGIlfXfyn5uzqdA0kXb8fedgpe91qKyu4GJYh38p9r+27TZFCORcFfcgH/ky38PiXn
         FxJUxhTNZvI+8nzzNTjZAIcwv0ChTz4ljB3pRvSKE0V5kzGgu5zDRx058rEosbUEIRg/
         SRWg==
X-Gm-Message-State: AOAM530EefNFYLZsikdHcUaRtA7AxvzCbTi3bDsaeRFxlBx7hhKT99/M
        /7srBWn7L3kpkpO4vlvxXVmtQq62mZLl1w==
X-Google-Smtp-Source: ABdhPJxXSCx2CKEGeUCdMkpuPcXntUNACPasMmDMBDGwwOAUPLjm35wUBdJQ6ClDa2JoV5UulJUNBQ==
X-Received: by 2002:ab0:7783:: with SMTP id x3mr2113381uar.72.1644140578688;
        Sun, 06 Feb 2022 01:42:58 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id u23sm1699642vsg.25.2022.02.06.01.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 01:42:58 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id e17so18192353uad.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 01:42:58 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr3001774vsb.68.1644140577849;
 Sun, 06 Feb 2022 01:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20220206013648.3491865-1-shorne@gmail.com>
In-Reply-To: <20220206013648.3491865-1-shorne@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 6 Feb 2022 10:42:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
Message-ID: <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
Subject: Re: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Openrisc <openrisc@lists.librecores.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

Thanks for your patch!

On Sun, Feb 6, 2022 at 2:37 AM Stafford Horne <shorne@gmail.com> wrote:
> Remove the address space override API set_fs() used for User Mode Linux.

Note: this doesn't have anything to do with UML...

> User address space is now limited to TASK_SIZE.
>
> To support this we implement and wire in __get_kernel_nofault and
> __set_kernel_nofault.
>
> The function user_addr_max is removed as there is a default definition
> provided when CONFIG_SET_FS is not used.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
