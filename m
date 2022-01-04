Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE34845D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiADQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:10:55 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38645 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiADQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:10:54 -0500
Received: by mail-wr1-f44.google.com with SMTP id e5so77161330wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 08:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dLfIM00O/Ipr0crkhKZyqpI5imxvGGmn0KKsbMAqWes=;
        b=uN1ZdPaEjsvQWEJoS2Vu8KTYGGQzYvk5QzG3pP0Jmbgh4UZjWklVANb1GzqUkl6Ecr
         zj7emgjF/Et3NpFif7D8njdiVzdl54X68Yqu7z6Lec0nCw2FdPS55YFprR9qtYPTFWbb
         LfGnBFkk1FW0d3fHADMRMtkH5Vu7U9JBu6VoodONvZC/JvHKoVRUydK9JhcU+vOXHWQ6
         AAjh6lJXGNppAvn3qAJPkv/UPwp9ESk33rroOMDm+2UIDX2ShMB2EotfrV6xXbEUDKSa
         T1xOyJGe3eSkOiThX8+EaDVDT9VgoSpuY8S/opggAItts4EveL/yep7zlrU965Q5riq5
         Civg==
X-Gm-Message-State: AOAM533vyCHMByJTjjT6PKkfNjVIc72CPnWxW38BPfPY6lG75NKtx+ms
        ZgVVXWpwBd6XZ4TImKAFaMoBxeX/0pc=
X-Google-Smtp-Source: ABdhPJxAPRVEKFC6iEdVbnzKtmgbxeyx+Wsc6yqjkxA1VCzgkvg7TVaN0aQ8+ZqqWU4v4ZEUkUnhNA==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr38257101wrq.498.1641312653549;
        Tue, 04 Jan 2022 08:10:53 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h204sm38564690wmh.33.2022.01.04.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:10:53 -0800 (PST)
Date:   Tue, 4 Jan 2022 16:10:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <20220104161051.yyvxjfb7ghg67ryr@liuwe-devbox-debian-v2>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
 <YdKrxgnpT0Dc0t2T@infradead.org>
 <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
 <20220104150307.GA23792@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104150307.GA23792@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:03:07PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 02:51:55PM +0000, Wei Liu wrote:
> > > Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
> > > function.
> > 
> > Does this look okay to you?
> 
> Yes, thanks!

Thanks for confirming!

I will turn this into an ack and apply the diff to hyperv-next.

Wei.
