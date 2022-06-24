Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406955A344
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFXVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiFXVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:05:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57B27FD04
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:05:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so1268131wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4FBq55ALNoB8I9/Jp2eahFZ3TVuZO8zAHamAFfwJTA4=;
        b=jtNLzbazAZ3Ty+PCe4NJUDW5r9cbkHlRd8h2mbV7+waX1Tx9erQtwlu2e8BUxesIDH
         SpaHCfUHUYE9Gcjqbo0B/IDMs/JrP3lo3//ZjLcKnRD7/2NuKlxlUOPrugPQ8PeHKwme
         wzVoLofv+/w69KJivy77K+FdWGQ9xTFTuR8C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4FBq55ALNoB8I9/Jp2eahFZ3TVuZO8zAHamAFfwJTA4=;
        b=abfeze31CuMyQoiVur6Djj4cJ1QdkVHQ5t7DOeX6nVrXThIBY7b5QA5DoM5WQWEDZV
         eloz0jMnKqh6RESLXlBtPPw6GaN0mUf0Y0uzSkLj1hVOJiukj9xiUQcqjWjmotVmj+Ja
         EgiXrySzhN++MvPODiLlyfHmVRInLGvWivbK971a9lLdXAR3wVCpMseB+uEdR29IKo2K
         toS+8jH668Pw84WEMlKXA9s3+DQpU2RTUJWVgH1J480j4a5mgekvRtYSFCyA5UGJeAlC
         mon5f/PA0Yx6rd5/buza7jcOyJIJZrxHpZWy+XqdMhW8VyT6GKfbhC8ZprSW/+fpNm2z
         Xl3A==
X-Gm-Message-State: AJIora/zapPR4NcLzaFdV7IMBmMJsCBazJ1pgjMWPtbeA5NQGAmdZRPM
        lbcOmo2E6UYdHU8ntOIvmkYNQQ==
X-Google-Smtp-Source: AGRyM1s3Pl4EVQvFKsoBwid6w18frt80sinR1W0DhYBmiX4lMtmHCpKONBuPPCGUsGyEmAfWWb+3qw==
X-Received: by 2002:a05:600c:3553:b0:39c:63a3:f54a with SMTP id i19-20020a05600c355300b0039c63a3f54amr989149wmq.61.1656104739492;
        Fri, 24 Jun 2022 14:05:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003974a00697esm8995188wmq.38.2022.06.24.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 14:05:39 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:05:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Please add another drm/msm tree to the linux-next
Message-ID: <YrYnIY2s2Nj5C66N@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <5dbc0159-cb33-db5b-20cc-05f3027af15e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbc0159-cb33-db5b-20cc-05f3027af15e@linaro.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:19:42PM +0300, Dmitry Baryshkov wrote:
> Hi Stephen,
> 
> I would appreciate if you could add
> 
> https://gitlab.freedesktop.org/lumag/msm.git msm-next-lumag
> 
> to the linux-next tree.
> 
> This tree is a part of drm/msm maintenance structure. As a co-maintainer I
> collect and test display patches, while Rob concenctrates on GPU part of the
> driver. Later during the release cycle these patchesare pulled by Rob Clark
> directly into msm-next.
> 
> During last cycle Rob suggested adding this tree to the linux-next effort,
> so that the patches receive better integration testing during the Linux
> development cycle.

Have you guys thought of group maintainering? Single point of failure
trees freak me out a bit, it tends to build silos pretty hard. Simplest
path is to just toss it all into drm-misc, but at least have one tree for
your driver. Building new single maintainer silos after I've run around
for years collecting them all is rather meh.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
