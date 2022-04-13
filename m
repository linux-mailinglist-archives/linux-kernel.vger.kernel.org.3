Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AB4FF1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiDMIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiDMIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:25:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C0340CE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:23:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lc2so2331395ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDdCO2Z9sHAkcidfpKBTGhIx4GsRFl2YRA+5zMVZ7Po=;
        b=EQSfe/OGM1bDLSi6whKMEjNq4/6t5obsX6B3zW3tIoZLjKAB8+dPT5hT7TZitAkSiT
         fTwT0mW7viCTIF4OAb5wBT0PlPjORofhAKFSzh9V9G3tcQa7lEhUL13MOzBriYY+fqmc
         IVVRwfNl3wO2clI7usFeV426Mk2ctlMr3lIpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pDdCO2Z9sHAkcidfpKBTGhIx4GsRFl2YRA+5zMVZ7Po=;
        b=PFwDlX6qcFcPhAEOqZuYSzdoXtc1i+Cs2Ntu1kUl7t0imw5vUcYTs4yAuoz1cWsFk9
         ZTXmwiuZ1D7Ub4B6LRQg9IdH49imqALUG2+DQC6uQI5pXcZezDNf+ay6PhZnMjI+a1UB
         tMITxRBs/Qg7ygPBrAjJgI/n9HJxoLkGNocEFXtlMmuepai3MaNxGVfk1tIETrA+8L3K
         4pxYM1euEB/++kkiTB+qSkjdq8BV4WfuhbHbPa9raCvjwk3HwFL0kS3UO1gweoP3Dtk3
         srPU2RsfqXr2/giIgTyE7agVijtU1XZoOV6H4Tr/lBWUvM7zJQ9qyuLKpiFnW0OTSWUv
         WLSg==
X-Gm-Message-State: AOAM531zOCmcnqGcgWbbbUEuPyut0kfM64hrKPr6Rg2au+IxGmwID712
        3rt/W/1T1MUxCgdGR2/TEQdnyw==
X-Google-Smtp-Source: ABdhPJy6vkhPnQjZPHpvyKo4dmGeTKsNWOhUCSOfAThna7ZkD4GSLlcdAsCMZnlM5vvm+zfGBdc8Tw==
X-Received: by 2002:a17:907:94cd:b0:6e0:b001:aeb6 with SMTP id dn13-20020a17090794cd00b006e0b001aeb6mr37652242ejc.283.1649838213381;
        Wed, 13 Apr 2022 01:23:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k11-20020a50c8cb000000b0041d97e9fd46sm879363edh.83.2022.04.13.01.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:23:32 -0700 (PDT)
Date:   Wed, 13 Apr 2022 10:23:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Message-ID: <YlaIgxknwmPbsg1h@phenom.ffwll.local>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220406155030.0dacf051@canb.auug.org.au>
 <20220413100448.6f5f4de7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413100448.6f5f4de7@canb.auug.org.au>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:04:48AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 6 Apr 2022 15:50:30 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the drm-misc tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > include/drm/ttm/ttm_resource.h:226: warning: Function parameter or member 'pos' not described in 'ttm_lru_bulk_move'
> > 
> > Introduced by commit
> > 
> >   b0e2c9ea5afc ("drm/ttm: allow bulk moves for all domains")
> 
> This warning is now produced by the drm tree.

Christian, do you have a patch to fix this?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
