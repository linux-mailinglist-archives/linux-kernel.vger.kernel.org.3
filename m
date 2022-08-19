Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3738759A80C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiHSWE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiHSWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:04:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6701E868C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:04:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso8737106pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=74wEGWS15Ryw3zFbO/X3Z90nRuqUFF8IupqlkBcQT1s=;
        b=HLSSMjBlUz88i2pGz84vqzh/zI4YZ8d2kuaY34wQqceUFslS3vA4zBgxOla0M1lxZZ
         tvLJ5MnKnKzTcAIIrE/Ny0DNv0XvFEA3PbOuydkrltarKcGSQ7YLUzjompVyrMkVNjwZ
         gg/XlnDhupAjDk6gTIMzXJ+pGBENM3qWQVBwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=74wEGWS15Ryw3zFbO/X3Z90nRuqUFF8IupqlkBcQT1s=;
        b=w1gGZjSzHqAwX8sAJMgEKycUU3Dydp5SCpCFVOYL+lqEOu3/DJWllU1aZJL8KLyZMF
         kDDJUQxZvIR+hMzrodWfxbMv67ZxVrFClktxCpIPUN9e819JtBdliuV6SMdPcKkTxW2c
         OBG4uEvv2pQ9BZpFvUMrXRkFBMjw893Rw8dopzKlLa57MZqx1WNNrg7ffBjko79a/Ay9
         /A54OLXUrXJDBvsfhWnkjT446+n0aaQsb6B8EKTBmWGRgpgEhlYU/I3Yat3IJ/qlMS5D
         eO1bMh2VdSmQa4UW8RK3Ca9MrFynxi4hteLEdB9GlpxnGNEDTW6ZtJwOyoMuUum5VSu1
         bywg==
X-Gm-Message-State: ACgBeo1SHmJ+Tl7fc+OAvBHnfs9LbYjmPjv8ZbA0eeJ2Ctgty4zroOWD
        /VQHs2jhQM1lpJBm29M97EHAPQ==
X-Google-Smtp-Source: AA6agR4bT8jXfuIWDjJPW6AL1KI1/ece+fODuZEKjqT90O2y5jZsYd2gbJ7jVGHHYKmfzUJ7uc8wVw==
X-Received: by 2002:a17:903:1ce:b0:16f:145c:a842 with SMTP id e14-20020a17090301ce00b0016f145ca842mr9108436plh.83.1660946690358;
        Fri, 19 Aug 2022 15:04:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs11-20020a17090af28b00b001fab208523esm3640576pjb.3.2022.08.19.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:04:49 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:04:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [GIT PULL] execve fix for v6.0-rc2
Message-ID: <202208191502.FF4B023@keescook>
References: <202208191202.5F5A43A0@keescook>
 <CAHk-=wjd2EX60OQJgmjQDzC1wkzX6Fb9ypT+AJQdPnNZ3QzZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjd2EX60OQJgmjQDzC1wkzX6Fb9ypT+AJQdPnNZ3QzZGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:11:38PM -0700, Linus Torvalds wrote:
> On Fri, Aug 19, 2022 at 12:04 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Please pull this execve fix for v6.0-rc2.
> 
> Hmm. I've pulled this, but "fix" it isn't.
> 
> There's no actual bug in the old code that I can see. It' just that
> local kmaps are the preferred model these days.

Yeah, that's true. I figured it was better to get it in ASAP to help with
the transition and avoid having both APIs in the same file. Thanks for
taking it!

-- 
Kees Cook
