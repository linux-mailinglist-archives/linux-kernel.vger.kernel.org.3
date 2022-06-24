Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B555A1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFXTeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiFXTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:34:02 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB987A1A9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Sihz11luVbLnMRxUqT40UrsUUIvpNZ+iZ5XFmcP949s=;
        b=fvhFy7tCy17aa75hVRKipc5JOYdRa1Z+RHBoenbtgriuGr33sLd85dLt4rr0BZOGVw47PyRE1fpkC
         pKJIpOzBY6k830ZRkM951a5iRedSU35/iHW/WrMzzV6Uj3H35r86dE2id0AQ9uAgPWMUxFgZ84HLxQ
         UhVA2j5/Rqqhko6KleF0iMHt8EbD+MFsYnz0ULbpZbG8491f/xvE8kKoRPOa6EpfcZdBey3wD8C2UT
         n4i5v7GGloV8NxaydiDBv/VY4KqliThyLs28AM6FX7+HKE37RQ9HXitKGR4Q8SFa81jn1oem9pOmjd
         VYOMSI3oUiJRZenZDIbYBPnlhvUsYCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Sihz11luVbLnMRxUqT40UrsUUIvpNZ+iZ5XFmcP949s=;
        b=8n9lroMQRcWpKMLu+unfvxTIumDzZX5gumVYDE20P3bgMXlOjnxe38bbVMAApCEO3vVTybIPOVmC8
         rnB6Y/QDA==
X-HalOne-Cookie: 2f5100d8768ceeccfebdba1eab392d44dbdd208c
X-HalOne-ID: 97d51f3c-f3f4-11ec-a6c4-d0431ea8a283
Received: from mailproxy1.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 97d51f3c-f3f4-11ec-a6c4-d0431ea8a283;
        Fri, 24 Jun 2022 19:33:58 +0000 (UTC)
Date:   Fri, 24 Jun 2022 21:33:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linus.walleij@linaro.org, thierry.reding@gmail.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panel: nt35510: Remove duplicate 'the' in two places.
Message-ID: <YrYRpfRapDZllh01@ravnborg.org>
References: <20220621140151.14404-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621140151.14404-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:01:51PM +0800, Jiang Jian wrote:
> file: ./drivers/gpu/drm/panel/panel-novatek-nt35510.c
> line: 193,214,253
> * amplification for the the step-up circuit:
> changed to
> * amplification for the step-up circuit:
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Thanks, applied to drm-misc (drm-misc-next)

	Sam
