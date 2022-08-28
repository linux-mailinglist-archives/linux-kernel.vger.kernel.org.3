Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB905A3E3D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH1PMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH1PMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795EF32B8F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661699568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BUHt8viGrNndwp37shsvtUW2KKbCQVW2cJW1i0ePY94=;
        b=IEl+WyFWqPRU5+2R57PmUvkYDGE24sRAHbtwjQouphZmMVIOo2P2uomXyU7wzS3l4urhhY
        EUoGGJsfLZsVm8BkV+qTH5fhbJ/2H9fgdRJ41lCB4WmFBXIy9vOnIpfF/G1yJjLnrlZ2Cw
        xurbeVx2YQZKyd8M0yfqVwrFAOfhdkU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-YkyWXcRwPri3No6NkYPM7Q-1; Sun, 28 Aug 2022 11:12:43 -0400
X-MC-Unique: YkyWXcRwPri3No6NkYPM7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCB1429AA389;
        Sun, 28 Aug 2022 15:12:42 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED90F2026D64;
        Sun, 28 Aug 2022 15:12:41 +0000 (UTC)
Date:   Sun, 28 Aug 2022 23:12:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 06/11] ia64: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwuF5oobjhahuybe@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-7-bhe@redhat.com>
 <YwHYeiBP4EKi1Hd8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHYeiBP4EKi1Hd8@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/22 at 12:02am, Christoph Hellwig wrote:
> On Sat, Aug 20, 2022 at 08:31:20AM +0800, Baoquan He wrote:
> > Add hooks arch_ioremap() and arch_iounmap() for ia64's special
> > operation when ioremap() and iounmap(), then ioremap_cache() is
> > converted to use ioremap_prot() from GENERIC_IOREMAP.
> 
> Same comment about the commit log (I won't repeat it as it applies
> to all conversions).

Will do.

