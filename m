Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7908568323
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiGFJPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiGFJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:15:08 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA371B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:15:07 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id ay10so17348206qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyuJdlq0J6ZQ1JNEf5bqR4BNFIBiYk0Fgz9plyVNlpI=;
        b=7Agsb4H8P9pJcMSCSOi3ZL/uW15KdEpbeuDV8U9W6SrzfhjKj7VZFatCSuzxQPAXOf
         H/B0l/qIA8AZ4cv+rZFTpJMXuAh3EnFo3fFDXGMDKYMVnlK4tsp7IGqOc5V/5Xn7y3Ac
         zB776/0+/laNt1NdvGVAFgl4YRBjl+CeZH3aWIj+juY5up9sjYFxfN3xN+tPgwQ/b0Vt
         /ojhegXO9dZAmIQXBywuQqUKIorDsQTRr9piY9xGI/mOPWCCv7wAegT0L+UuDYAYctq+
         CIZ9HdDD0Y/CCORJp3yliwjeM/A+QLji27jmy67bpAAGXSFFgwma0eg1zxjZfzAbR/Js
         IfRw==
X-Gm-Message-State: AJIora+a2G4JV6OfMWr5DEPprF/SJfkbxCZeoMG5jwEt3wihUBGu4ie4
        ejduHdSSN4l8hhnlrr/CN0L/ZvC+w8RRyg==
X-Google-Smtp-Source: AGRyM1vV6lnZ+NPJCNVSn/VINosnBdPTs9eCq+56gQGvUERn0yjserzDyrraIbMc/DBZ9rkrrPlLVw==
X-Received: by 2002:a05:622a:14d4:b0:31d:3db8:3d00 with SMTP id u20-20020a05622a14d400b0031d3db83d00mr17579296qtx.666.1657098906206;
        Wed, 06 Jul 2022 02:15:06 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id a186-20020a3766c3000000b006a37c908d33sm28683498qkc.28.2022.07.06.02.15.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:15:05 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id o2so21030284yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:15:05 -0700 (PDT)
X-Received: by 2002:a05:6902:1143:b0:66e:8ad6:34c with SMTP id
 p3-20020a056902114300b0066e8ad6034cmr5217971ybu.89.1657098905609; Wed, 06 Jul
 2022 02:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220630085037.72420-1-jiaming@nfschina.com>
In-Reply-To: <20220630085037.72420-1-jiaming@nfschina.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:14:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWg=8aAN6xup_MUy+3GvRuAOH2s55NQvXnNMdFk8Hr10g@mail.gmail.com>
Message-ID: <CAMuHMdWg=8aAN6xup_MUy+3GvRuAOH2s55NQvXnNMdFk8Hr10g@mail.gmail.com>
Subject: Re: [PATCH] m68k/mm: Fix spelling mistake
To:     jiaming@nfschina.com
Cc:     Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liqiong@nfschina.com, renyu@nfschina.com
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

On Thu, Jun 30, 2022 at 10:50 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
> Change 'writeable' to 'writable'.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
