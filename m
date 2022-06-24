Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09CB55A24B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiFXT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiFXT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:56:19 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48C82884
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=L2S/OFHbcpw+xHxvLQ3UDGLgLWA81oGSjbaZ5d/JL2U=;
        b=fvBVa5FjqbaMSj7d3h8GJOiDOhNQtm4pj8bR+uhSgg8QZqfe3rSLii+hqpViFb8Wus4lO3J8LD9Mm
         w6OCEg3FjqfmXAQ6UvK9Tjr+oi+thjPukK2AmXw2xy64W+2dKTi22sLe9qfxrah/7wzQ31KsAzx4bi
         0erWdOWDwo14D3gVtM0AHDXUyYjgghaIxUWWrC2ViPdXPvnenvFb6IA0aXp6s8ZvJV0VimUpZat/BS
         iWSbs3ML9zTFoj7oVIzbisasVRudqI08Rk1E72PvWyCNFnui4SzR59lBxd8iltZR+Q9MXwuoI1q+gz
         dcnifK0A2Ao7icap4xJCUP1OgXbCSuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=L2S/OFHbcpw+xHxvLQ3UDGLgLWA81oGSjbaZ5d/JL2U=;
        b=p7Y9a1/kth4MA2s6M+u2c/wO7tRfghbrrdz0IU4csAxiuwxiL0dhSTiY0AuyGHdg5Yn1O9o5f2fzb
         /0JccsXBA==
X-HalOne-Cookie: e3690c5f0d18ada9bc06b0d6752c537c11a0ed0e
X-HalOne-ID: b5385afe-f3f7-11ec-a6c4-d0431ea8a283
Received: from mailproxy1.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b5385afe-f3f7-11ec-a6c4-d0431ea8a283;
        Fri, 24 Jun 2022 19:56:16 +0000 (UTC)
Date:   Fri, 24 Jun 2022 21:56:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panel-edp: Add LQ140M1JW48 edp panel entry
Message-ID: <YrYW3wdX10js0ibD@ravnborg.org>
References: <20220608020614.4098292-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608020614.4098292-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 07:06:14PM -0700, Bjorn Andersson wrote:
> Add panel identification entry for the Sharp LQ140M1JW48 eDP panel.
> 
> Due to lacking documentation, a delay similar to those for the
> LQ140M1JW46 numbers are picked for now.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Thanks, applied to drm-misc (drm-misc-next).

	Sam
