Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA75AC934
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiIEDpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIEDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:45:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A382B633
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3xUDN/K7BDvm8fEF8dNYgHrYYixoZ8ei2hxCzGNSHY=; b=t9xS4saB9x2HbpDiwecUms0k3i
        x+OgwiiMBba/FDvDXEsNKDs/abcBhBP/M3ytZTmTVoldn5nOcn3yY01anC0t9mmJTbQL4YUE1yIpi
        bKLwsaE5+9/p4fiEA2rASUrYDYiX0JMAgw4jacoLJ0DT5/YaTZ1monpO/dvrWSTaCP7+Eio237RkF
        Sf17rWKxAnxmMtxZ4tbE72ugu656HJoPJryWOwlhXynfO6mnI3zOxgIQYbra0j5kOc6Vr0sopadUE
        EJw7yOlN6FFmInQ5kIavmZTjZhUO2be+2l0jvN9k9u6qLmttmJDFRxIqboJCGAyddWflaVoojF0Vs
        zmnKqKCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV32o-0099En-5M; Mon, 05 Sep 2022 03:45:06 +0000
Date:   Mon, 5 Sep 2022 04:45:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, npiggin@suse.de,
        ying.huang@intel.com, hannes@cmpxchg.org, corbet@lwn.net,
        mcgrof@kernel.org, mgorman@suse.de, keescook@chromium.org,
        yzaikin@google.com, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, osalvador@suse.de, surenb@google.com,
        rppt@kernel.org, charante@codeaurora.org, jsavitz@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -next v3 2/2] mm: sysctl: Introduce per zone
 watermark_scale_factor
Message-ID: <YxVwwndLt+bsUDK0@casper.infradead.org>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-3-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905032858.1462927-3-mawupeng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:28:58AM +0800, Wupeng Ma wrote:
> The reason to disable THP is khugepaged_min_free_kbytes_update() will
> update min watermark.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>

Don't include this 'Reported-by'.  The kernel test robot did not
tell you to write this patch.
