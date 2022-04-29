Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE305147AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354512AbiD2LBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiD2LBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:01:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6BB53DC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:57:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j6so14663746ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kh7cG0R0SMeE4jm3EWRld6u5ddyYFj4+YrMk4VBJgW8=;
        b=GTFuxBgUOEchycqCqavOLLCBbzS6CfSxXO0rgSUwCs0H8J8P7yRd4VYn+ih//UR5xL
         hZokdb3P44yN4CHC62sWCzuSabmnPHIwV0cqSt83+GkTWAOUDH1WnrTSikxwA6vFiXR9
         5Mqg7H8GGOY8hqWTnopAUqUFogOQi+J9b5ty8LZHWfxM6JD67BGlCNT/ny7OlJg9ztAJ
         AfUKBEkB6dKrfneiQjaKj0M0ZhgbBgHWvnft+myjIdUxtydW0VKowKttz7gwgInHL53h
         IZDoA3lYu4fTZdc8Cr9dMBdLmDFMDfFfQwNmfUVn52GEWvwE/xT9oO+mC3I88nsO4Gp2
         x1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kh7cG0R0SMeE4jm3EWRld6u5ddyYFj4+YrMk4VBJgW8=;
        b=7a58/h4OTi4XywZrV9zJmig+mvGPqFKW5A5VnYkGD3JFm+BarodpsMxdqyiQ0iyvBN
         FUiBpkFTQmIpVoK905jdJIldnocKv5ZdkbCaqTXNdqWw9YcevQb719oGyopLRtr8UFtt
         ZFyvG9cqitsGPlWTLc21qQVfOQE+zWjl2Xns7f5wkmn+CiRu2h6pDX1fio4LdEoVmZdg
         ClSfAnXEmLnPRNIgPjjW8w1p0eNyrvkBsIqWxT6woVuKJ2tcgRGCOcZs1cqHg6+4U+Pl
         9hcH3T7oIuyZPrFrgztqex9vR/ZGVWT0ceDE5tOfCm+pGUuj8T43OKOUkPnORiJPVaUL
         JWKA==
X-Gm-Message-State: AOAM532jhkop91H9BfC/ekkRz0GWshBjQn9zcHZlrovc+BRtrrJflOBw
        9mXlE+KjYg/YxSDjC9pOD2udm9+aCEnEmdKG8To=
X-Google-Smtp-Source: ABdhPJxjZnFIUavnzePAJF9brVDJFEux6qXARizED533tTUaLxu4IciRVe1Y3JZ5JrMSrGaOeswfRvQfzc5nbagfrEs=
X-Received: by 2002:a17:906:1841:b0:6e8:872d:8999 with SMTP id
 w1-20020a170906184100b006e8872d8999mr34869485eje.492.1651229870707; Fri, 29
 Apr 2022 03:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <202204290610.SVJgr8qV-lkp@intel.com>
In-Reply-To: <202204290610.SVJgr8qV-lkp@intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 29 Apr 2022 07:57:41 -0300
Message-ID: <CAOMZO5A-ZbMUM-17n2JPN2+w+DWLL9fnGwo2SrS=O024M4v0MQ@mail.gmail.com>
Subject: Re: [sailus-media-tree:master 55/60] drivers/media/i2c/adv7180.c:573
 adv7180_test_pattern() error: uninitialized symbol 'reg'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Fri, Apr 29, 2022 at 7:30 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   git://linuxtv.org/sailus/media_tree.git master
> head:   ea1280040a678f38a4ce6f1817933c04cfe74552
> commit: f3b4b140d87dc7f256229f20a8d70429a7549aca [55/60] media: i2c: adv7180: Add support for the test patterns
> config: microblaze-randconfig-m031-20220427 (https://download.01.org/0day-ci/archive/20220429/202204290610.SVJgr8qV-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/media/i2c/adv7180.c:573 adv7180_test_pattern() error: uninitialized symbol 'reg'.

Thanks for the report.

This problem has been resolved in v3:

https://patchwork.linuxtv.org/project/linux-media/patch/20220427135025.3036234-1-festevam@gmail.com/
