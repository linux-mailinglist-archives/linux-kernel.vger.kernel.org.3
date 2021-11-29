Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327E6461FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhK2TRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhK2TPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:15:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD8C05293B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:33:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s13so37769799wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NTUQ6aLhKD5jn8vygozqrLUU4s5A3V1kXbkGA/ru7lM=;
        b=HVzF6BkeS36kyfG+xhXLEfxtbXCiiG/rILiuPP4Fm4PsRykXWuBQOq1ebLsVW5XbVC
         95EXaGYX2KadOC3OLsUpmCr+PV24wovvVOQp3WiFEj0qISMCqG/eEEArA3971cRC80/G
         dwZnChO8PzFenjS6ReFCoerZwcjT+q0Iaem5AslenQ04adryZLoV+Bk24/XbqGe6rApq
         a7ax2GcUHB2LobsfqLVVZaPPYpxF+dLCLAwVo1yGdD5SPA2++n6xpC6em3KJlK1p5+tl
         hN6nBA1G1gTQ7+yGf6VxKTly7FI28S4I9xeo+2RtIubH2IBmQ2RSq3IetRJ4Iv+X12F5
         OdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTUQ6aLhKD5jn8vygozqrLUU4s5A3V1kXbkGA/ru7lM=;
        b=0Ao2vyNn9+NxQTNuF7avTJD/LWn5zwIvaqh/dgZSSOntMd3eeu1gcgSny9EeqhKJE4
         22T5By749CpRrF5Fjt9k5XpLOQvYMehzJyDzz9D0BbZsr1fdbzpbrsjdYQK78TplQW0d
         tLzFdg8jR8Gwf2fHWs7oaRYWSbkHDPUyqpMmtnHOX6ML5jAM/yWFWpbT1tef3HuUNwz8
         xhUPJlkZbXEhMhOHlII14XKLbSIbU9RPl9yeXN/3JEV64IMEXFGeEzXuFCNbScV4xV0O
         UWiZ7jYsC51gOK4iOdui1GWGlZcq2vvLewfc3luxSiWZGAnRoOZXlxeQnSeqwrc/CfdO
         OKMw==
X-Gm-Message-State: AOAM531cCNCLWpskhCZ09G8McrHlBPYr9R4yyVkGaHUmPVs4vsb4PXRD
        Uv0Z97n1sAGu3WI69U4z1iuKPg==
X-Google-Smtp-Source: ABdhPJyuq3ERsFsDH/xpS1bayhStVieKQtcrUQihIbVIry9BiRsUSwe1lWVq20WEpHG3+o4ITfyuAw==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr35021998wrt.419.1638200011561;
        Mon, 29 Nov 2021 07:33:31 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r8sm17738405wrz.43.2021.11.29.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:33:31 -0800 (PST)
Date:   Mon, 29 Nov 2021 15:33:08 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Message-ID: <YaTytI6P3/HEwVrQ@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-2-jean-philippe@linaro.org>
 <b9068111-bc1e-cc0a-155d-04585d6f4138@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9068111-bc1e-cc0a-155d-04585d6f4138@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sat, Nov 27, 2021 at 08:59:25AM +0100, Eric Auger wrote:
> > @@ -36,6 +37,8 @@ struct virtio_iommu_config {
> >  	struct virtio_iommu_range_32		domain_range;
> >  	/* Probe buffer size */
> >  	__le32					probe_size;
> > +	__u8					bypass;
> > +	__u8					reserved[7];
> in [PATCH v3] virtio-iommu: Rework the bypass feature I see
> 
> +  u8 bypass;
> +  u8 reserved[3];
> 
> What was exactly voted?

Good catch, this should be 3. It brings the config struct to 40 bytes,
which is the size compilers generate when there is no reserved field.

Thanks,
Jean
