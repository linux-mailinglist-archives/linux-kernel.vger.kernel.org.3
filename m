Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D74ED189
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352478AbiCaCLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352473AbiCaCLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:11:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B96582D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:10:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso926203wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+Y4Clr/KV3RmCQxfUTOx3L8tcl6/qhhWFZStvbs7AE=;
        b=IRNA4dtWN35P6LcruP2XmfFRfHUIeZxTdcIDZkazItppUyO19PVXKrjN6Z2gBpvYX9
         665wkXXe/8yk9G+1anKqrIDJHlX8Qofa7yWrcfbbHB67DcluoZdssOl8ENobi8QpTook
         qBWI9lD01RRhdNDJSeWenT2uFZtge5oqmhFLznMuDBI2q7uuDq/D9eKfakbGsbBcyEcc
         0VGTDUzy44vmSNXKfV5JmVrHwqtuJIBMyCFEJCAWhUmLDMUJedR6dMa989h9EjTJwS5Z
         R3uv/T+QNbGBmvbE3N4d/HawXTHp4k6ASz8e3xe/at7nFPK7ZV1/HUQzwktnoRP1xazv
         MtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+Y4Clr/KV3RmCQxfUTOx3L8tcl6/qhhWFZStvbs7AE=;
        b=orkVRzZv5kKKCUWIo4SL6k8hNoXkShKvuee5F+OpkZb5+xGS68GJob9pL5FL+mW4Q2
         oCtEir9EX/rhjFPXRKJK+MXEhlu2mqKr842qer+LwNms8YOCcAUn/KV3hHh7vDC9PFD4
         FPs+k0wEIN4eRf42iH9O9GHTH8B+wEV0orQ4l1oz1OnMX6WbgCqSvl6yhFNrKc5fL3iT
         RhkjaIgjEh1lP328XHW6W9CA2EMEsyE80FMY1Py5eTJAicT7JmZjiLzDeDTP1wVBULVT
         8rcsJqx0071kw7+DVxSmb244pnMequs1jctVNAv1C19/GvdFngw+UYBN6ClqxRCDvAKA
         M8EA==
X-Gm-Message-State: AOAM5300tMcO5bQCUEAQTIU2/vINDGmUgrgdpbImJSlHi7DRUI/fLbdS
        UMBE2+rsrvQvNazXZ8c4HHtcccNUitZzuMWHbfEtVg==
X-Google-Smtp-Source: ABdhPJxX9ikYBf74niQggS4KpIrzIpWarfLSBLv4JdiFkCpZEqGhtcFVRLzgm1Hpstkt8udcLZoMEcwgyQ39Z6R2zz0=
X-Received: by 2002:a7b:c541:0:b0:38c:b0ed:31c4 with SMTP id
 j1-20020a7bc541000000b0038cb0ed31c4mr2624910wmk.141.1648692600105; Wed, 30
 Mar 2022 19:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 31 Mar 2022 10:09:48 +0800
Message-ID: <CABVgOSkQFdGmBZsWqhFifzWAi2+1VOvYy3Q8F_umMa6AV85AQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add a section for static analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        julia.lawall@inria.fr, Hu Haowen <src.res@email.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 5:49 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi all,
>
> This is the third patch version in the direction of complementing the
> testing guide documentation page with information about static analysis
> tools.
>
> Thank you for your suggestions and comments so far.
> These docs wouldn't get so helpful without them.
>
> Change log v2 -> v3:
> - Changed the paragraph about Sparse to make it sound better (hopefully)
> - Minor adjusts to make the considerations about Coccinelle sound better
>   and be precise
>
> Change log v1 -> v2:
> - New patch adding considerations on when to use each tool
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable
>
>
> Marcelo Schmitt (2):
>   Documentation: dev-tools: Add a section for static analysis tools
>   Documentation: dev-tools: Enhance static analysis section with
>     discussion
>
>  Documentation/dev-tools/testing-overview.rst | 63 ++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>

This is looking pretty good to me: thanks for helping to improve the
documentation!

CCing Hu Haowen as an FYI for the zh_CN translation.

-- David
