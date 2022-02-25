Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F824C4C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiBYRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbiBYRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:25:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC451C469B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:24:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s1so5511193wrg.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnzsbpdTokjeYoQbiPr/+t6TgoCpWDGcyPSZBp89N3c=;
        b=B8FXv0FhWSmI3cLZbbXQKoNr//vluNNa5zkb4CrNOWqo/wY5gvLhU2EYYtwCvhNFBT
         qYJTcWa6Tj/29ce0IqRrs3/NNwfYFzK7gHS7/uKmAW/lz7M6/GPtndI7nPmoXrksE2o0
         uZw1VmsxLoH7yGJXx6VEJwtdI+Cp+5vjXYBJtG+7k6WNNQlnTRAJAQ5isgUg+jdQPeHL
         tyGarn2WH26OAQT2zoziqGG3p+tdOyz5atnWTBbAR6r7yU3OXsCBfLLWfUC8ZSgptX7a
         UaIzqx9MmkE3nTXAUR5+HSIb3iPa2WDdiRIX78mBWJRH9+gljN+Lu5IWBN2Gls77lJb5
         9zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnzsbpdTokjeYoQbiPr/+t6TgoCpWDGcyPSZBp89N3c=;
        b=G4vC7Tap7boWS0Xzoij0R7S2d6VcFyrtL1TON2mAqvjiQg7jq1+fva6hN3B4tZP6Xr
         rggawgVIwzXUNEo7Xp3Dl2MBeK+ASe+n864CjdxeMvc41YNjL6iabzjehGokK1xgPPCU
         b1Z/DPp4xjUVNuyN0+x6gSCOdy5tFSs8s6BeAeVZ98Cb1Yd6JQuJweg63h4u0zymQp+i
         RE7iRz4QMhp3Bu8y2jP6biHT6GPJKGuB2M1hxowkXKqsVQHfgcju9Xfdg/ov0te7ei33
         6XUZHDhQtZxe19a2d1+5KSpWLEEUoiF04fUv1BrJtpjwPS/9XHcxkrjKI05W517bEi7L
         mM+Q==
X-Gm-Message-State: AOAM532kGp8ZCJfw06E6IgXUpxdOuBOnZGEpLkKfAvNRNT+DaUYpZ0i3
        Lb7FVfnZVW/4J1PY6I8MbQJ42X2bFA==
X-Google-Smtp-Source: ABdhPJygam76Nuh9SogpjMaoXyliR8wOs9/NmSR1w4fOil5yv20XEl3WzFGil+CHhPuPjXFNCt/ryg==
X-Received: by 2002:a5d:6f1a:0:b0:1ef:6254:bca3 with SMTP id ay26-20020a5d6f1a000000b001ef6254bca3mr3086708wrb.119.1645809889632;
        Fri, 25 Feb 2022 09:24:49 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.217])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b00352d0e1de62sm3017396wmd.24.2022.02.25.09.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:24:49 -0800 (PST)
Date:   Fri, 25 Feb 2022 20:24:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-ID: <YhkQ34tN8jEOR6SJ@localhost.localdomain>
References: <YhiQPhsoODiXRAPy@localhost.localdomain>
 <59387c6677af43c18d434b4f3c1e5430@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59387c6677af43c18d434b4f3c1e5430@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:01:23AM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 25 February 2022 08:16
> > 
> > Putting declarations before statement is relict of single pass compiler
> > era. It was necessary to allocate stack slots before generating code.
> > 
> > Recently added static_assert() is a declaration. -Wdeclaration-after-statement
> > prevents its placement anywhere in the code for no reason.
> 
> That could enclose its declaration inside a block.

It could but why put useless characters on the screen?

> But then it wouldn't be usable at global scope (is it anyway?)

It is usable in global scope.

> > Placing variable declarations in the beginning of the block increases
> > variable "LOC lifetime" so to speak and chances that it will be misused.
> > This is very low probability bug but still. Declaring variables right
> > before first use will make "LOC lifetime" smaller.
> 
> NAK it makes it very hard for a human (some of us are) to find
> the declaration.

What?

Which editor are you using?

Shift+3 with selection highlighting in vim works just fine.
I don't believe Emacs doesn't have an equivalent.

> Indeed putting them anywhere other that the top of a function
> or the top of a very short code block makes them hard to find.
