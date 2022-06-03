Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E753CD10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbiFCQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbiFCQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:21:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C039808;
        Fri,  3 Jun 2022 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Kl50zb1H5h1iw6GsZC1FYxxnr0hwKKM6SR7HaocL/H0=; b=SxBQ9HiA1HndIQD8kolM150WZ2
        d/VcJ27ZLABBbIjDapkcYxgNxsT6xBZcfbrfEZ5Wble60t7DxVNcOMlP4EN7jSUARESl213ef3DMK
        NZR+K8RgNpHhDZ2hTCNozVHAba5Vyzxrq+dKSrVGxOY05O9KBuh4uf3xGm55N8OAd2VdJzNy/qkFh
        HWmY4FhGrV5mlTmNVVlFrX+IZkIl/iyDiL66Dby9TmjiGv6C489KGCFrSwKJtvbLrS9ZmZMis9NYo
        1RZ1Kw1LKHSLG0z5FK1vphBsiVwZHGzJsrARPGoVuUr5dttM5GniCdyzW0n6UlACU1fsizsVVgxDb
        M4o4HbzA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxA3J-008027-1v; Fri, 03 Jun 2022 16:21:33 +0000
Message-ID: <727bc913-794a-800c-9b06-31e9257870ef@infradead.org>
Date:   Fri, 3 Jun 2022 09:21:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: Tree for Jun 3 (mm/memory-failure.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220603144935.5b67f75b@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220603144935.5b67f75b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/22 21:49, Stephen Rothwell wrote:
> Hi all,
> 
> Note: please do not add any v5.20 material to your linux-next included
> branches until after v5.19-rc1 has been related.
> 
> Changes since 20220602:
> 

on i386 or x86_64:

../mm/memory-failure.c: In function ‘__get_huge_page_for_hwpoison’:
../mm/memory-failure.c:1545:2: error: implicit declaration of function ‘hugetlb_set_page_hwpoison’; did you mean ‘hugetlb_page_subpool’? [-Werror=implicit-function-declaration]
  hugetlb_set_page_hwpoison(head, page);


when CONFIG_HUGETLB_PAGE is not set.
The inline function hugetlb_set_page_hwpoison() is only defined
when CONFIG_HUGETLB_PAGE is set.


-- 
~Randy
