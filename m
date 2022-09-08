Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A45B1CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiIHMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiIHMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:23:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248711228CF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:23:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 097005C010B;
        Thu,  8 Sep 2022 08:23:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 08:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662639788; x=1662726188; bh=Qr
        nUHhscABFVHd45MeVYCEuM6pGZuhTaWiCVqnUwT08=; b=wBxCVchf8VL3cCwNnW
        PctMZ+6b1KjGX3Qf6ZDgWKKoCyl2ptw1UF8tHaM6mS4D9N4Rhfqyu0IjQ+AOxKav
        D3kqVGhg3Qmh+KNx3xbiQRVsMCEkpUphY5Vm3XJHTNAZRyrSXHRzYVI4UKQzM+kn
        VktRwMD63mwWJu2G4QY2GV1KOVvgQxDQrx/mICky2eA0RLZGUvDYSdqU3VkvRr9T
        cLPbEq/HmtBi49ukvLokNnZtu1l5R015inT0WHrD3TGaHsGMBippDo6/XoUpfV+K
        YGYuDeBLs84+Qxf/xYbNBKyf9zKh4mUPEWpCYsU0H21cJUf0Gwq4pioxVf2rPqUW
        OWLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662639788; x=1662726188; bh=QrnUHhscABFVHd45MeVYCEuM6pGZ
        uhTaWiCVqnUwT08=; b=Xz4bvcfjuguIoJU4t05mV2Qpx+VXlR4YOO0qd0mkADaV
        Bp0hdZGnLOMeKu6jy+l2neyXRHf/VY5cpor3qxJ9NxNjeAJz9WBbvCIVNK/vV29i
        fp1la3Wsf8DTV8AxxkonJ/iQXdjVWWI6YPmGJJ1hIdSBFoLMFdNbwTjHdqGPaRaY
        pVVQG9D8xxohhQwqswQPbZYpNUqyQfqQdwE+l3+RQlEcV+VAdBbcl8K7jCfm5hl8
        K9v4CfwldX7Bt2vASmT5JXa3Hv6gML7F2fKYrF5lIYG9wK27PV3Rn5A9HAOVWNaI
        be0ABiT59N2PMcyZbS0v39WRVKtiu86M/XvxhqRITg==
X-ME-Sender: <xms:q94ZY28WjE6U-xekQoJ3iGNsUsNHG15jDdmZ_tGdgZtKTuB3MOwsFQ>
    <xme:q94ZY2tjF4a92v0tRflSQxsGWOrRMegQT6aZ8LV0S_5edN97Ld_QIz62SqdT4Ne_l
    R1ZDWVs2OZ87Rz_I6A>
X-ME-Received: <xmr:q94ZY8DOS4Pp8DwWd3IckOpRrRz5ew25XkwfLE6rJuQFH6_r7dFYLbyCC9pCN8Q1AT0n4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:q94ZY-fz6mBlSXZX3Vq_cxSoQtAf2k45uXKX5eobkGbVk_Kk3oE3_w>
    <xmx:q94ZY7MnY8Ii34B8RDEFlTxXv-SozsYduUB9qe3Ca9ms-fhqAQOFGA>
    <xmx:q94ZY4lVzS1i77pf9NKr_KQwqU0D47TtJu9mMAZc7A05UyGHaFWlrA>
    <xmx:rN4ZY2rcULO-yw7z0XJaibjjz_P04LvNPNLgi23r1pkWuAiVaLk73w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 08:23:07 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A1DE71037A1; Thu,  8 Sep 2022 15:23:03 +0300 (+03)
Date:   Thu, 8 Sep 2022 15:23:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: use pfn_to_online_page() in
 split_huge_pages_all()
Message-ID: <20220908122303.7pofcdcmbuq4ou6u@box.shutemov.name>
References: <20220908041150.3430269-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908041150.3430269-1-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:11:50PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> NULL pointer dereference is triggered when calling thp split via debugfs
> on the system with offlined memory blocks.  With debug option enabled,
> the following kernel messages are printed out:
> 
>   page:00000000467f4890 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x121c000
>   flags: 0x17fffc00000000(node=0|zone=2|lastcpupid=0x1ffff)
>   raw: 0017fffc00000000 0000000000000000 dead000000000122 0000000000000000
>   raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>   page dumped because: unmovable page
>   page:000000007d7ab72e is uninitialized and poisoned
>   page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>   ------------[ cut here ]------------
>   kernel BUG at include/linux/mm.h:1248!
>   invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   CPU: 16 PID: 20964 Comm: bash Tainted: G          I        6.0.0-rc3-foll-numa+ #41
>   ...
>   RIP: 0010:split_huge_pages_write+0xcf4/0xe30
> 
> This shows that page_to_nid() in page_zone() is unexpectedly called for an
> offlined memmap.
> 
> Use pfn_to_online_page() to get struct page in PFN walker.
> 
> Fixes: 49071d436b51 ("thp: add debugfs handle to split all huge pages")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org> # 5.10+

Looks good:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

But it makes me think if there's other similar cases. "page is offline" is
rather obscure case that rarely covered by routine testing. Otherwise the
bug would not survive for 6 years.

After quick look, kvm_pfn_to_refcounted_page() looks suspicious.
kdb_getphys() too.

Maybe we should make pfn_valid() false for offline pages and introduce
other check that allows offline pages which can be used in codepaths that
deal with offline pages explicitly.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
