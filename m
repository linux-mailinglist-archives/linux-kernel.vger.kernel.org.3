Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC247346C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbhLMS4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhLMS4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:56:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:56:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so15341514pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJCP6+iFI704fJLHeelcLIe6Hw/wRcn0APt12d5/mrM=;
        b=zKLq00KTzrSGBWxx6JLxVOXIO2GUn7/mI5io2de8PnzRUJz3C8hoCicx/zfpjRTnxW
         vKrdmNa/WQGvkiIpRxjD9BD6UGRE6YLOmaQigLfc6P+HFkFVHQpEbzOIH5gYVZuC0Ll1
         VhGUSBbZiKvTQ9+jIYNN+8nNfszJtkBVHkfCQ21bBpsSH3LLfXSfHqH6AHuOVhwona+D
         LbIcW0NvvuBosXSspfgTTfZDZ5Itd+BLxQhPxi+P8Q+X5kBlAl2JfYJiRfzGVMsBdR61
         G6aLhP5ZZaISHPyCn4PEVcbovtNv+GeDL8TJU6H/7rNvHFUIhEzzASb/mtjt+d6hgS5L
         zmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJCP6+iFI704fJLHeelcLIe6Hw/wRcn0APt12d5/mrM=;
        b=pOxzgz+OoMZZuPQH9p4eh8qcxO4M/ZdqqiHdJ33VH6XXmJfRxwL6bn+jbJgzHG0cDW
         pzFuLKx1LtultohV/0nBUE07PuUDHlSIPfzNPvkfGBqtxBRjoWTubJGx7bknIw5J8zZU
         ehMPcqd6wJallpijYa7xbHfT7f+3b9eHhS3eAOZkkyjLTkIV3yviR9WXucOzRU7JIqSs
         NRHc+E1p/BnLFeLD3fyFPKXI5VHQNmW/xH5cr5dEc3cXiA94r5QTskkZd3DPbu9uZn8L
         cuYyL3m1wleLSyDtfdpBX79sSra4IvTa+yCLazRzvow6BmJ3b0x6DDc+XOk8YBSZkj7G
         RUrw==
X-Gm-Message-State: AOAM533eM0YMnChD7t9S40siEFTuapmKE/YCU7dvcF5QBZ6KQHGaLUii
        mcP3hPhM5FhnLnkjmckEdTykVw==
X-Google-Smtp-Source: ABdhPJyU6ipdEUJZ1AQOeECnhc2f9+8ci7d5w6GsmsnQdw3Cp2wG7Roo51+MGeRMnIXwn9dCg0Txtw==
X-Received: by 2002:a17:902:e8d8:b0:142:5622:f9e5 with SMTP id v24-20020a170902e8d800b001425622f9e5mr538973plg.42.1639421769036;
        Mon, 13 Dec 2021 10:56:09 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s5sm13631560pfk.65.2021.12.13.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:56:08 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:56:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: core: fix typo in a comment
Message-ID: <20211213185606.GA1474575@p14s>
References: <20211211090221.241529-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211090221.241529-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 05:02:21PM +0800, Jason Wang wrote:
> The double `the' in the comment in line 732 is repeated. Remove one
> of them from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 8a18c71df37a..88653d1c06a4 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -729,7 +729,7 @@ static inline void coresight_put_ref(struct coresight_device *csdev)
>   * coresight_grab_device - Power up this device and any of the helper
>   * devices connected to it for trace operation. Since the helper devices
>   * don't appear on the trace path, they should be handled along with the
> - * the master device.
> + * master device.

Applied.

Thanks,
Mathieu

>   */
>  static int coresight_grab_device(struct coresight_device *csdev)
>  {
> -- 
> 2.34.1
> 
