Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE84E6CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358174AbiCYDOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCYDO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:14:29 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0BA1441
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:12:56 -0700 (PDT)
Date:   Fri, 25 Mar 2022 11:12:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648177974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSnl462JoNiMZLMQN3qva88FZOsk+DZtdNDO1IBwIjs=;
        b=m46wG9j+V2PkTxDMurasClQF+bLz1TsSrsR7n5XtoL1WLKKhzLJ9OTw7sizrFxV9GcDAia
        UC9dp6XYq4jIBvDrGBaUK3voc4BzVHsmZJyYD5hvFwGGKHu78QJFhnlpSYBYONgNAqr0sp
        VIEPTwxawOg/0ztDfO2BjxLwY3XlCQo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mm: Fix the param description for 'size' tag
Message-ID: <20220325031225.GA9073@chq-T47>
References: <20220317022631.10570-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317022631.10570-1-cai.huoqing@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 3月 22 10:26:31, Cai Huoqing wrote:
> Using "size of" instead of  "end of" to fix the description for 'size' tag.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/gpu/drm/drm_mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
> index 8257f9d4f619..c2eedfd264f8 100644
> --- a/drivers/gpu/drm/drm_mm.c
> +++ b/drivers/gpu/drm/drm_mm.c
Ping :)
> @@ -956,7 +956,7 @@ EXPORT_SYMBOL(drm_mm_scan_color_evict);
>   * drm_mm_init - initialize a drm-mm allocator
>   * @mm: the drm_mm structure to initialize
>   * @start: start of the range managed by @mm
> - * @size: end of the range managed by @mm
> + * @size: size of the range managed by @mm
>   *
>   * Note that @mm must be cleared to 0 before calling this function.
>   */
> -- 
> 2.25.1
> 
