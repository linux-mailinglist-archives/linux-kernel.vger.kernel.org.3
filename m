Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5310650D680
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiDYBWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbiDYBWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:22:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947037B13B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:19:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b12so8817097plg.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UC3UUz3+3Li+KSXitsNBzOD/5C0DEIQhctDbkXoSxco=;
        b=Z7rboODG/yWX8bCEnoh6B7AguUHh2w+BdLUv1l6MHxHitsLsTr1vaekb/aXKsHftt+
         g5rnbjq1gN5Z2noUFol5RLkEVQRutGiXnKaQFunhyxa2JgGt6WPZoF5/msdQJianTXVv
         nRcAoXcZf+Xy3/UTBNOpy2fjVR7mxgv51/51R6IJJBhrdmKAoOCmhRwH3lPsKUlZcQia
         rreoDsZXbuQrOYPTymAdqR6E/shpOMIPKpr0E6u1+cvU9D0JV4Qkt5xjRrkpKzGBChFU
         kxdr4I3Mc5fKYd2JQ7HUg74A0+T7jeJYHNYuDd0HQo4HUZ/sR60he1eICFQl1ZnqGWqn
         zKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UC3UUz3+3Li+KSXitsNBzOD/5C0DEIQhctDbkXoSxco=;
        b=qp6jOOJA8sq6ZM5vrQL/dvdQISfmZdjYUEj03UCcTq/otUhkodxdl/ijY1J6jeKsFM
         S3qql2Nt9pD13t10ryNP/hYFa1DvsuLgixeC3gDJILdDKCN5UdUWpFSDMfGZCAcBbNVz
         Ob2h6Qcojb7gTLm24yjBWzu9MGG9Frx1xIyD1q1Poh9oSV0YwyF9lHCKDcv2bP7HX3nQ
         eSUq2/Kh3EHtrEG/QdOe+1N0ywxwLhS2g+fIGhGmkY1XlgRW8PL1lQk0/iqphQTvS/Yf
         n6Fm72ceJeHf4Vngbio/+Lsd4KEHCKvNoMGjk+r+0RdNIM0gdQhxpjm6NyBBCsfDKR/h
         SLyA==
X-Gm-Message-State: AOAM531oqZdFw3rRSrhbR0cfTAI838HZ9OFKHH39VDIpGUBT+FqmSHDI
        KT5ohPCz7EIqvOIXvGnn1Cc=
X-Google-Smtp-Source: ABdhPJwu0pHVzic4N9d0cQf/8eWFhfTH4BXxnUjj0DLOSheOLv6NcJlGfGcXfNZUfAvWCSoBUMEPgA==
X-Received: by 2002:a17:903:32c5:b0:158:f6bb:fae0 with SMTP id i5-20020a17090332c500b00158f6bbfae0mr15689329plr.62.1650849589122;
        Sun, 24 Apr 2022 18:19:49 -0700 (PDT)
Received: from ArchDesktop ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004fe1a045e97sm9483399pfj.118.2022.04.24.18.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 18:19:48 -0700 (PDT)
Date:   Mon, 25 Apr 2022 09:19:45 +0800
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com
Subject: Re: [PATCH] Revert "staging: r8188eu: use in-kernel ieee channel"
Message-ID: <YmX3MYF2dAaARwFc@ArchDesktop>
References: <20220425002735.112666-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425002735.112666-1-wjsota@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:27:36AM +0800, Solomon Tan wrote:
> rtw_ieee80211_channel to ieee802_channel causes a memcpy bug as reported

Apologies for the spelling error. It should be ieee80211_channel instead
of ieee802_channel. I will amend the commit message and send it as v2.
