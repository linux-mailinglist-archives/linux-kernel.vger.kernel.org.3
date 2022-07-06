Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E201E568371
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiGFJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiGFJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:23:33 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06362B77
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:23:31 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id i11so17386466qtr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPeOBkcoQYbxVD0wRneW2mTNAwjpOVPDYXCesVf/zic=;
        b=v4WiqqyUHJQmhA2GUc1xKb7Gi1T3oE83qkvew2LZdxI6KB2aZZMcJdHMFZcnzDbsrX
         jzZKpuGfwCwF/XWsx4pe6KVPDsyTF/1lVlAp0FNHrrF8usLipb7mjIUpzJ1B3sQIsXmx
         QCZHDZx+CbgaYC9BwX0rvTacnCQMYee9woZcTFxtQhrf02y6sJp8OPM0aJNVseIDzyFO
         j9xynqrq8SbE7hz+53KR51QCNp1byX8SlxMz/V2k8R88yrKV1sbOaUEuiY7jR9QRgmT+
         PD6baIiFBZeoFP1+zJgv3jgx5K/9ymqjqI7N1TMJEOBQp7OiSK+8VGTndhCJ4ps2nTRt
         8D1Q==
X-Gm-Message-State: AJIora+lw71073WVHv3eqXuAkShi7LPsDXB9ZAoj0NCQBBruOd0GEK1h
        Jp7HVFZyAiwCNU6CE8/nUnt0jmSpSfr45g==
X-Google-Smtp-Source: AGRyM1vGk8aHacRFkEI0CkZkgXbqFRUGvVXuvFYlevIxgyeL8G4slLRWBqZg2uDsRtcvmlItncC1MA==
X-Received: by 2002:ac8:5c08:0:b0:317:e856:bcff with SMTP id i8-20020ac85c08000000b00317e856bcffmr31963889qti.615.1657099410629;
        Wed, 06 Jul 2022 02:23:30 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003177f0fb61esm23021378qtn.75.2022.07.06.02.23.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:23:30 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id e80so19084540ybb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:23:30 -0700 (PDT)
X-Received: by 2002:a05:6902:701:b0:66e:a06d:53d7 with SMTP id
 k1-20020a056902070100b0066ea06d53d7mr762670ybt.604.1657099410009; Wed, 06 Jul
 2022 02:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220524075848.21684-1-juergh@canonical.com> <20220524075848.21684-2-juergh@canonical.com>
In-Reply-To: <20220524075848.21684-2-juergh@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:23:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrQXhc8MtzGML596podVrT6gkr7XrSAOSCppMc+6qPqA@mail.gmail.com>
Message-ID: <CAMuHMdXrQXhc8MtzGML596podVrT6gkr7XrSAOSCppMc+6qPqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68k: Kconfig.cpu: Fix indentation and add endif comments
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juerg Haefliger <juergh@canonical.com>
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

On Tue, May 24, 2022 at 9:58 AM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
>
> While add it, add missing trailing endif comments and squeeze multiple
> empty lines.
>
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
