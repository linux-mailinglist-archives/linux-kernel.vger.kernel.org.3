Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33F529693
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiEQBMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiEQBMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:12:17 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEAB3F306;
        Mon, 16 May 2022 18:12:16 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id s18-20020a056830149200b006063fef3e17so11253432otq.12;
        Mon, 16 May 2022 18:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzmZo2YkXapalY01gbU69/F8H5BheF6O+cgYDUlXq7U=;
        b=E4EhByWWPes9nVPaHtba3sih6lgDRsdzFBkCMt+76NuUpsnvc8VV1gEKKLGlkNY10C
         /5DvP97G2wFJ5JLrHqQqRccQcfBVKTkLd/W9+y9XcRs5UGMO5tFfrp/eOfkK1TjxsppG
         LkjPrelGYKnOTdMru6KVnxv0q0BJxvGNZvC0QXVeHoF739tNxCq+7rlJuzVz+8/QNCNt
         coBxVOSQlbwePbseUiUmq6PqNWYIS+wgMM7Cy6rEFBczu5ducHafVOi/hwdwAL652ovp
         hY3gUcOoS17VuOfvV2AcRD1TwpjlA7cq1XlH02gL3ZQmRwZZa5Yv3C0/UmzQM33cPcGz
         K8yw==
X-Gm-Message-State: AOAM533rQ81/hExrdVQo1WASnC3h92GhkDjnW4F5GoyJ96L2BS7aBpuN
        7YfeWTqO3M1hmBJ37Zqta7qxdxjnAA==
X-Google-Smtp-Source: ABdhPJzMkXbTA1eJGBp4UUjdcKY4fcP+I+U6booNd0xf6bYXgoGjRg8MdPa2IKuLBMwaTrucGUEDwA==
X-Received: by 2002:a05:6830:1c38:b0:606:1248:2444 with SMTP id f24-20020a0568301c3800b0060612482444mr7520962ote.181.1652749935647;
        Mon, 16 May 2022 18:12:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f25-20020a0568301c3900b006060322125csm4620819ote.44.2022.05.16.18.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 18:12:15 -0700 (PDT)
Received: (nullmailer pid 3726482 invoked by uid 1000);
        Tue, 17 May 2022 01:12:14 -0000
Date:   Mon, 16 May 2022 20:12:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Remove example file on dt-extract-example
 error
Message-ID: <20220517011214.GA3716531-robh@kernel.org>
References: <20220510221333.2770571-1-robh@kernel.org>
 <CAK7LNAQYL7rkqsWfNSdS53_sf-SLqpuVeoSmZuGqRNNtScT6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQYL7rkqsWfNSdS53_sf-SLqpuVeoSmZuGqRNNtScT6Hw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:27:00AM +0900, Masahiro Yamada wrote:
> On Wed, May 11, 2022 at 7:13 AM Rob Herring <robh@kernel.org> wrote:
> >
> > As 'dt-extract-example' writes the example dts files to stdout, a file
> > is always created even on an error such as Ctrl-C. The resulting empty
> > file(s) then cause unexpected errors on subsequent builds. Fix this by
> > removing the output file on any error.
> >
> 
> 
> Did you really set it?

Set what?

I'm sure I've gotten empty files which then throw errors on the next 
run.

> The target deletion on interrupt is automatic
> since the following commit:
> 
> 
> 
> commit 9c2af1c7377a8a6ef86e5cabf80978f3dbbb25c0
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Fri Jul 20 16:46:33 2018 +0900
> 
>     kbuild: add .DELETE_ON_ERROR special target

You're saying I shouldn't need this change? For some reason I do...

Rob
