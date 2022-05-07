Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2F51E3CD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 05:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445444AbiEGDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 23:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442292AbiEGDfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 23:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04C5F69493
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651894285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=74AbjzsgVUW4/zsFqHgAZ5XZOQsx1xf/ijiUOqjivO4=;
        b=KXDHsl8ggynp4H0RdWI/ePIkqF4NvrvLsMoFrupN8Z1f7gnHDgeDWBbX+TbW9fRAseUjl2
        bKDOxuwx6Z8Hs2gCwsbJ/XEzHLHP66Mk1XnK2G1mDRARP0Qem8+D8I12xUP0+ZXL5fWPjf
        XwMAmoThLoAmS6FA0BWQId860HgakCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-iVzmzOU6N-yKeM5q6cBPaA-1; Fri, 06 May 2022 23:31:22 -0400
X-MC-Unique: iVzmzOU6N-yKeM5q6cBPaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 401C4811E76;
        Sat,  7 May 2022 03:31:21 +0000 (UTC)
Received: from localhost (ovpn-13-18.pek2.redhat.com [10.72.13.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C2982026D6A;
        Sat,  7 May 2022 03:31:02 +0000 (UTC)
Date:   Sat, 7 May 2022 11:30:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v24 6/6] docs: kdump: Update the crashkernel description
 for arm64
Message-ID: <YnXn87JnfUxI2lC2@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-7-thunder.leizhen@huawei.com>
 <20220506231451.GB122876@MiWiFi-R3L-srv>
 <6e662eae-e788-13d3-368a-e88ed159fc85@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e662eae-e788-13d3-368a-e88ed159fc85@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 at 09:41am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/7 7:14, Baoquan He wrote:
> > On 05/06/22 at 07:44pm, Zhen Lei wrote:
> >> Now arm64 has added support for "crashkernel=X,high" and
> >> "crashkernel=Y,low". Unlike x86, crash low memory is not allocated if
> >> "crashkernel=Y,low" is not specified.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index 3f1cc5e317ed4a5..aa44c61114aa4b8 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -808,7 +808,7 @@
> >>  			Documentation/admin-guide/kdump/kdump.rst for an example.
> >>  
> >>  	crashkernel=size[KMG],high
> >> -			[KNL, X86-64] range could be above 4G. Allow kernel
> >> +			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
> >>  			to allocate physical memory region from top, so could
> >>  			be above 4G if system have more than 4G ram installed.
> >>  			Otherwise memory region will be allocated below 4G, if
> >> @@ -821,7 +821,7 @@
> >>  			that require some amount of low memory, e.g. swiotlb
> >>  			requires at least 64M+32K low memory, also enough extra
> >>  			low memory is needed to make sure DMA buffers for 32-bit
> >> -			devices won't run out. Kernel would try to allocate at
> >> +			devices won't run out. Kernel would try to allocate
> >>  			at least 256M below 4G automatically.
> >>  			This one let user to specify own low range under 4G
> >>  			for second kernel instead.
> >> @@ -829,6 +829,11 @@
> >>  			It will be ignored when crashkernel=X,high is not used
> >>  			or memory reserved is below 4G.
> >>  
> >> +			[KNL, ARM64] range in low memory.
> >> +			This one let user to specify a low range in DMA zone for
> >                                           ^ not needed,
> >                         Maybe Catalin can fix it when merging.
> 
> Delete "This one let user to" or the entire sentence? I understand it to be the former.

Oh, I mean the 'to' is not needed. "This one let user specify ....". The
'to' is a grammer mistake.


> 
> > 
> > Other than this, LGTM,
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> >> +			crash dump kernel.
> >> +			It will be ignored when crashkernel=X,high is not used.
> >> +
> >>  	cryptomgr.notests
> >>  			[KNL] Disable crypto self-tests
> >>  
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

