Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E504D1CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiCHQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiCHQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:14:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA774FC72;
        Tue,  8 Mar 2022 08:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CFF0B81AEF;
        Tue,  8 Mar 2022 16:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3347C340F9;
        Tue,  8 Mar 2022 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646756025;
        bh=jXBz2f9tChtMFtKyOyZ4Q3h2mhlA6Onv+Izw71UufzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UnxR/RJqQQzmrMWTZA3iu/62twkicgqrZxqPlgt9nko9YFkMPdzqQdhKoUlmtE+sA
         LsIrzYMHxXsjIhdqok6IGMj9Rq+1a6gWFNyB+Z+70KJtOOsqpOWNvFYljWZILzQJFj
         LCxFHq/7Of/gQbIlyvcaL2wihl5o1JEWd4jIsnhVX/JV05yIIeslM8V9wzZWNaplmt
         l79agZVVIiUMcMfcrko3HrLFLt+J5HqqOBuZ0IiRMIWFolhZ93VD/j8oJUDeiczv1Y
         ubHFl6HiKUy6yf1IWu6VGT4SBvF3/AqCtwo8kPFLx0yRK8d3B/jrDwCqPJscQUbEO6
         W1eCuj5HSAGvw==
Received: by mail-ej1-f41.google.com with SMTP id bg10so40389719ejb.4;
        Tue, 08 Mar 2022 08:13:45 -0800 (PST)
X-Gm-Message-State: AOAM533hLAK4PyqjVZF7+/siNg2hWtL+qp6UE1B7reSgUdnfP5bZkGwz
        oX30SPV1uZ+dQYJUPL2uh7Hde/7sPsfs6O+D4g==
X-Google-Smtp-Source: ABdhPJwgjUirqReFAL6N3dmjsf1cllJkmUJ+TfjKooqF93ar8SLKSqqP4oME9QxeInU2UXWZqXn7edss5wrmTCZW8Po=
X-Received: by 2002:a17:906:181a:b0:6d0:ebf5:c064 with SMTP id
 v26-20020a170906181a00b006d0ebf5c064mr13580319eje.82.1646756024055; Tue, 08
 Mar 2022 08:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com> <CAAOTY_8CTewRw2Le9RjXoCrqF8AyHD0_p01EMiJ2QQ63yf-HKQ@mail.gmail.com>
In-Reply-To: <CAAOTY_8CTewRw2Le9RjXoCrqF8AyHD0_p01EMiJ2QQ63yf-HKQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Mar 2022 10:13:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qqCHvzg8uKx6xaD4cDJJq7hOUvJGME18V7cuLW5OPqQ@mail.gmail.com>
Message-ID: <CAL_Jsq+qqCHvzg8uKx6xaD4cDJJq7hOUvJGME18V7cuLW5OPqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix MediaTek display dt-bindings issues
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        DTML <devicetree@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 5:49 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>
> Hi, Rob:
>
> Would you like to take this series into your tree, or I take this
> series into my tree?

I can't. I don't have the broken commits in my tree.

Rob
