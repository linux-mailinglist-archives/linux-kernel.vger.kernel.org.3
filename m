Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2F4B3019
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbiBKWHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:07:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353941AbiBKWHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:07:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B353D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:07:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so9279000pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=2ntYYhI8g2rNOG/Ph4KVVGNf7Zafsv4NgM7iosIB+1s=;
        b=t36CmCEhd5LUHbFU2mQH1te7W0Gj5+kOv7tYgZfVJTiUx2WwRbBMoCTdreVh2aPHmo
         AJNGx+9i2ljf1yZqxTBiXtRZov0hZlzd5ac1W3UnrBunDoK6p50e34Tl2ivMZvLrHCfD
         /rhZhIiHXNSU+LiwDRV/QmNKDhBNkhe0Akw5vQp42+ri400V2bb72/uWCK6CRUNpVVPp
         uafw5dxdMisE9NkDMHgAnhdxds8AAz8701Y1PVt5tvFSSEMMzYuWp59L+y0nQyNZfqhJ
         Dmk+MVgaCPevd5i0LPl7kMWHeUQ4VyiMDZAAKvHpJrlPKY8Fb83VHZlYm9GCqrKP4FAb
         5uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=2ntYYhI8g2rNOG/Ph4KVVGNf7Zafsv4NgM7iosIB+1s=;
        b=D0fJmW+ZBPRM4ug1VNkZj9cDHcaLkLKYls1u0NJetArjYkE/KJxN9P6apm/bkGAMzj
         Uw5X2tRhEsNL3YRWKwVchPacz2LzNteQXsXMu+7dlgcWYHG5Fb9OTXg61Fkahw1OIKBc
         waOE5xZcRk/u7cf4+20U2FXwRdkYcZ1GQufbOxGo5ZVz4xZentLuL1EuqdDtw9tsoTxt
         R9U3nZdXj0vFziOtEeUd/qXqVhuIS608y8xwzL6wTyGFNKh4kQO2FAesWTZHs8lUreFk
         pfIh8U+v5clUjhtDWanOJ0ng56dBpMg2v7WwdP3S+LPPnT6qDRpIk5koFPXwrr56uyRj
         JBgQ==
X-Gm-Message-State: AOAM533scOQwRqsNL3hlXpe+ZFQndB+x1cfydbb+VQrQZvBrPHDRAO8J
        PKX1R1gPSt5vLOIvHyOIsSL7gw==
X-Google-Smtp-Source: ABdhPJz1IialgtYb1gyHYkv3hoI1Z7BV+qGjuUbXC5v9mGLYRvthvwk5eJL+wswkaIV71bNM+jOa+g==
X-Received: by 2002:a17:90a:30c:: with SMTP id 12mr2551805pje.74.1644617268258;
        Fri, 11 Feb 2022 14:07:48 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nl7sm6633049pjb.5.2022.02.11.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:07:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     corbet@lwn.net, linux-block@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>, linuxarm@huawei.com
In-Reply-To: <20220207074931.20067-1-song.bao.hua@hisilicon.com>
References: <20220207074931.20067-1-song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] docs: block: biodoc.rst: Drop the obsolete and incorrect content
Message-Id: <164461726734.22569.18318246299123214260.b4-ty@kernel.dk>
Date:   Fri, 11 Feb 2022 15:07:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 15:49:31 +0800, Barry Song wrote:
> Since commit 7eaceaccab5f ("block: remove per-queue plugging"), kernel
> has removed blk_run_address_space(), blk_unplug() and sync_buffer(),
> and moved to on-stack plugging. The document has been obsolete for
> years.
> Given that there is no obvious counterparts in the new mechinism to
> replace old APIs, this patch drops the content directly.
> 
> [...]

Applied, thanks!

[1/1] docs: block: biodoc.rst: Drop the obsolete and incorrect content
      commit: 2e2f0199a20780463945e1cbffb3a191fa84bd9d

Best regards,
-- 
Jens Axboe


