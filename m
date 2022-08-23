Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0F59D553
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiHWI2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbiHWIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:24:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2013E0D;
        Tue, 23 Aug 2022 01:13:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id p187so7903664oia.9;
        Tue, 23 Aug 2022 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ElG2z9ds4FvCowZwp6quOzCFLXh5nG/0Vuy4pRDUUBQ=;
        b=W5TDAm/jykNYHzQHtJ8EtJ2w0s+1rZ4tfT02UbCcdQFe4wlHpfHrLGFglREemP61lq
         ENdhjpsglSIpkZd4GL/UrMmJj/MtK+omqDcs5IKk6I8MOMeLdfqz0mHSsT39BXo8cpo+
         PtO5aNfEWRuwBtqPdm/JI0D3Z2Oj9/8//1pcT2rf4a5p2Eptn9A6CKVDZZiqCAFwhGpY
         1qpWJ6kDhtS/tW33xPbB/vyG81pxwO3rdHOs5GNCmypNZ5YKPfI8L55zGXBY0oL3ndAC
         cNBiG86hU1f3gCSQpU0klvl0Pt7whmSKsFqZKYXa0pxVIUEmp+M5UfAPbG90LHTHgQX5
         pB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ElG2z9ds4FvCowZwp6quOzCFLXh5nG/0Vuy4pRDUUBQ=;
        b=HO7re06VsqbsLvdlgaWHiMPQ1aK2dCMcqu3vgh7W+JVM0vEZTIt1lnG+VIX99r5dR8
         pi5qa5jWbjX4GHN8wOnvgfXZCuK+DPuc012ujSA8+bUh6m31CRQIXawMkAzEgtv6LV4s
         3Mxrz0GICJub78Jl7qtV/EZj3gXYnLz6M6Xm2/w95pKmN0BRFQv+o8EbW5voAmwD3cp+
         TJ9kYcj9RMZfB67BZckjGq0V6Q1qVSw6QGJ6/gGUzmja33/AsQVuQWOLAuKHEFkVQQSs
         laZPulKBzC+a6Lm3qmTwONJ4Fsxs6XEN3UDcCxsqA3K5YUOUrqMu8HR7nGLEpT7Xi4jO
         gQ3Q==
X-Gm-Message-State: ACgBeo3uPO/yaRYvp9Gw3e2v7WhYuBvHo2E7Wi0tt1eiWtoX5qy134V9
        T6//mb1kGv79kbe23CelHXjaYRmntcEOzjl1KLc=
X-Google-Smtp-Source: AA6agR5N7gQn0g2Usy+qY39qoJWjhWNRT6YITfXN1LCui3xyQhZKhEsBFqF2BKRc35FUoipeENupSxTM9pOAq5qvyyM=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr844226oil.194.1661242404994; Tue, 23 Aug
 2022 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220823025441.30708-1-rdunlap@infradead.org>
In-Reply-To: <20220823025441.30708-1-rdunlap@infradead.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 23 Aug 2022 11:13:14 +0300
Message-ID: <CAHNKnsTdmPMwYa1f7DBJsEXxL_pzforPLar=eO6Jp=COmCXrtQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath25: clean up non-kernel-doc comment warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
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

On Tue, Aug 23, 2022 at 5:54 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Don't use "/**" kernel-doc notation for comments that are not in
> kernel-doc format.
>
> Eliminates one warning:
>
> arch/mips/pci/pci-ar2315.c:6: warning: This comment starts with
>   '/**', but isn't a kernel-doc comment. Refer
>   Documentation/doc-guide/kernel-doc.rst
>     * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
> Fixes: 3ed7a2a702dc ("MIPS: ath25: add AR2315 PCI host controller driver")
>   but backport is not needed.

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Randy, Bagas, which one of these patches should be applied:
* https://patchwork.kernel.org/project/linux-mips/patch/20220823030056.123709-1-bagasdotme@gmail.com/
* https://patchwork.kernel.org/project/linux-mips/patch/20220823025441.30708-1-rdunlap@infradead.org/
