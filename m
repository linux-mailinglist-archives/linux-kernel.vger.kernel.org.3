Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912D5A1E09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiHZBSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:18:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE90C992E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83913B82A67
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7ACC433D6;
        Fri, 26 Aug 2022 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661476694;
        bh=xAL9DV0Gl9UV41+zmuVYq/S955LLBpe4w8CM7IzMAPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Rhulgtr8+DE/T+bEgl2/HeE7PC5m3vSZh+0tX0rK4WlUdfCduqjcebXZy7tdIdgw
         Y59oDFrYFn3w5YMOezN+4WYo0s2Z++LnVRF4OcpjFnfPMGa7q0eMf53ls6WLhsyMHl
         c+8vmCzc6eOOKKyL9eXqCI/Mbw34QTxwkYfKJ8gs=
Date:   Thu, 25 Aug 2022 18:18:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] vmcoreinfo: add kallsyms_num_syms symbol
Message-Id: <20220825181813.7a83043882be706bc8391c99@linux-foundation.org>
In-Reply-To: <a151e3d3-db1d-c3ad-dcd5-3f758b4138ab@oracle.com>
References: <20220808205410.18590-1-stephen.s.brennan@oracle.com>
        <a151e3d3-db1d-c3ad-dcd5-3f758b4138ab@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 10:27:04 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> I just wanted to check on the status of this. I got your email about it 
> being added to mm-hotfixes-unstable, and I do still see it in the quilt 
> patches set:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/vmcoreinfo-add-kallsyms_num_syms-symbol.patch
> 
> I see the patch in mm-everything-2022-08-15-02-47 but it seems to have 
> dropped out in mm-everything-2022-08-17-20-59 and later tags. As a 
> result, it no longer shows up in linux-next.
> 
> Please excuse me if I'm ignorant of part of your process here, I know 
> you handle a huge volume of patches!

Thanks for noticing this - I appear to have messed up a rebase and lost
a batch of hotfixes :(

I readded

mm-hugetlb-avoid-corrupting-page-mapping-in-hugetlb_mcopy_atomic_pte.patch
shmem-update-folio-if-shmem_replace_page-updates-the-page.patch
writeback-avoid-use-after-free-after-removing-device.patch
mailmap-update-guilherme-g-piccolis-email-addresses.patch
vmcoreinfo-add-kallsyms_num_syms-symbol.patch
mm-re-allow-pinning-of-zero-pfns-again.patch

to the hotfixes queue.
