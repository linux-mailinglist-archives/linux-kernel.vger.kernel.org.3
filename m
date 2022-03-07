Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473774D034B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiCGPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiCGPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:49:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834D3A5EE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:48:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so27070169lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LgEES4/rPa8CVMjAOxZ+enRD8k6L+QVpRqkn7PoSOSU=;
        b=RSZc176zZ2z6DKzBAW0/0ma/pjDQ2eWWeThHXLuAHZ6NG1gQGBWxhvwoseB0qIHs2I
         xtwJvLWK3Zvprycj7zHLJJfUxOS0Vo0Apl2CgCbiZT/PXiMhkFAEMpIeCU+rzPDoXfNx
         qTpt2XqrONNnqoyPxCYe9G4ydQhC8Skt4XznS1sD3gVW/30VXmUCRK48X0ve36+tm3qV
         1Lus/aBB0wDJYDvec0+TWFvMi6U8QAqvKJloePoTJkKITaikbNczASLAASzyhAFjLjoO
         hbv0Ov0PZwCva7hFrYnK9id86QWkC2WzEx+XLhxhXDmC//r2kwXnHXuHPeDw/1LNKP9X
         Q/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LgEES4/rPa8CVMjAOxZ+enRD8k6L+QVpRqkn7PoSOSU=;
        b=YxP71ZmxBV6t6PEt3vbhcR8qbxMDySqoC0T8GNl/SS9k8aeusd5YHQyTMMXRpgAMfO
         XQE4fOcxsPGQQ7/LrJHyv4gTdlR+Iwf7b9ycYvTMOCbSqjnpJTlpUjuBrhSbsgqP79K3
         iBu0G/TIAynAfD4Zfuz1Cv2YVrGpEVwojRvKIJIek07XdKihFaXIdwrLhgGELTeiG0YQ
         6jv/RG06TpwALcpjpRhCjlYmZjhje8rG5PII8Uzl3Hp/DvDg9xSiXZuRnwr+u85LbvBc
         tbIMjp98xt17jk7gtwwclCVH+s/ScyL8IZlIgKX7os5ChK0GU5HBqVUU8Hh2Wi0xO/bL
         d/NQ==
X-Gm-Message-State: AOAM533Xh0oc6oWZLSrVoGnbXvv3sCHVvQSg5LeWUSjTkRlG8aVOn5g8
        ryTDD+4Im0VSwmoCUMfYtuP0QpPEiSYYmA==
X-Google-Smtp-Source: ABdhPJz5+MA6btAr7UFrQUtyNqVwC20nVSI0t0VnU+K02P5BiAvwNVFHWtOwh+IQ4NSMbkMrvAOaog==
X-Received: by 2002:a05:6512:1287:b0:447:5c8a:c9e2 with SMTP id u7-20020a056512128700b004475c8ac9e2mr8227893lfs.64.1646668081667;
        Mon, 07 Mar 2022 07:48:01 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id k3-20020a05651239c300b00443c5f9175bsm2909978lfu.46.2022.03.07.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:48:01 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 7 Mar 2022 16:47:59 +0100
To:     Bang Li <libang.linuxer@gmail.com>
Cc:     akpm@linux-foundation.org, urezki@gmail.com, lpf.vector@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: fix comments about vmap_area struct
Message-ID: <YiYpL3I/OrPJPWXo@pc638.lan>
References: <20220305011510.33596-1-libang.linuxer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305011510.33596-1-libang.linuxer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 09:15:10AM +0800, Bang Li wrote:
> the vmap_area_root should be in the "busy" tree and the free_vmap_area_root
> should be in the "free" tree.
> 
> Fixes: 688fcbfc06e4 ("mm/vmalloc: modify struct vmap_area to reduce its size")
> Signed-off-by: Bang Li <libang.linuxer@gmail.com>
> ---
>  include/linux/vmalloc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 880227b9f044..05065915edd7 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -80,8 +80,8 @@ struct vmap_area {
>  	/*
>  	 * The following two variables can be packed, because
>  	 * a vmap_area object can be either:
> -	 *    1) in "free" tree (root is vmap_area_root)
> -	 *    2) or "busy" tree (root is free_vmap_area_root)
> +	 *    1) in "free" tree (root is free_vmap_area_root)
> +	 *    2) or "busy" tree (root is vmap_area_root)
>  	 */
>  	union {
>  		unsigned long subtree_max_size; /* in "free" tree */
> -- 
> 2.25.1
> 
Agree, those comments were messed up. 

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
