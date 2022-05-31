Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAD5389EE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbiEaC3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiEaC3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:29:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B09346C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:29:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r71so11608452pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTMqOEWwFqPjCBnVwjlOgGC66EofdLuSUHGdwSY9I+8=;
        b=ifK6uC52NIu+skSIrfHV4J0Njr/BqESkbdnpQzfXZBHNX484VlgcJ10oKykmGIxafE
         0EDDPPYN4F8OVULDZIuwqS3yV0AF7gZ7Vpp9BgC/aWqaFBkVC/9BXmLFLceF7f2ufQx6
         lSRznUnCv6gFoEqk6Dp8bGhBwn1/vD+QxF7bnz9kpitHp5WhwB3EHf7a/y0lrEeST0sZ
         /zufRzC13BMCmsNSXP5+HnTefpCOWnzEXM/7Y0pyHUrDvUlnTGTIFlb7QPhEf9NBIJEu
         d27c64bECTIj2R8mvRiNHgZqktfyZkNueqCLPBTnZiei9NBEepPd8Cu1UPLPb/Be11j2
         LAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTMqOEWwFqPjCBnVwjlOgGC66EofdLuSUHGdwSY9I+8=;
        b=pSry64PfdIt7PHnLeMpdg6Pru/IT31VTMSNm1+iJmdZBRjCCLzB4e8AhkaLhfZapON
         DaNs/qbz/RsVeqve9yPO3MnOCM7xKZ7oJW8gjVNo303t57yYcXNQkbojxnbl9xMsCukf
         KlmeYFD8gX8+JyMeIRyDTGNWu/JD513BYrVn1faG5yS3WYfp9k6DBg2BVjOA3l6iLcrT
         v7w7XlgPar3BexdSKEUMonI2FAUNyqRMXPpIKFXV5k24zSRmm2WX9oJ642supKoN5bUz
         Tfam3lbpv1q33rA9LLE+AAyz8Vf7TYY+ImNwmInusmuPL1QRsNci2pAM+h+J33XWwRhk
         0/Sg==
X-Gm-Message-State: AOAM53327PX+F6LfAOzBzELkwyFuKZ9VgoDF3JscsRJYIDkOklx3lpA4
        W2aqErBAf2tpcuTDPTVmMkLIIaAAqM/3ng==
X-Google-Smtp-Source: ABdhPJzahjwX8i93rNK2hQ9Yjfe9NmcWBos5aMcxAe2dGetSUWu3B4DPJ7deCw59XuI8/a5VaFZnRw==
X-Received: by 2002:a63:688a:0:b0:3fa:a80c:a228 with SMTP id d132-20020a63688a000000b003faa80ca228mr28184578pgc.182.1653964187033;
        Mon, 30 May 2022 19:29:47 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d10300b0016152774878sm3631059plw.176.2022.05.30.19.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:29:46 -0700 (PDT)
Date:   Tue, 31 May 2022 10:29:41 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: remove obsolete comments of kdamond_stop
Message-ID: <YpV9lQ3IAMmIJFCw@FVFYT0MHHV2J.googleapis.com>
References: <20220530022016.11771-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530022016.11771-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:20:16AM +0800, Chengming Zhou wrote:
> Since commit 0f91d13366a4 ("mm/damon: simplify stop mechanism")
> delete kdamond_stop and change to use kthread stop mechanism,
> these obsolete comments should be removed accordingly.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>
