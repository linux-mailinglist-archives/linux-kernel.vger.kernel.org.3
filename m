Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DD54D3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350020AbiFOV2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiFOV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:28:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B8D56230
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1851EB8217C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90626C3411A;
        Wed, 15 Jun 2022 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655328515;
        bh=me6avMzN/vEfPB1Ni8q3RVyiMpw4zHRITuOz1TYb7s4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=acro0/PGFlAu9MrEgIqGZoYaVI4N0DrhNnIZi6Q9Reb3FUTDgyWnLnUF3hPNcYV0S
         /z4tV+CZLRE5CZxbDncmL2VPUaiSMfJjTioJddIwDwwTWHSePhTs4Zy88y1RsYE2Oh
         E2akBgiJeDJazma7e02RlOzl4la14d1iJw2wc9h8=
Date:   Wed, 15 Jun 2022 14:28:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-Id: <20220615142834.43a56b0a61e9a3b1ac5e8ae3@linux-foundation.org>
In-Reply-To: <16297304-82d9-f62b-b87f-cc8d8fde9bd4@redhat.com>
References: <20220610101258.75738-1-david@redhat.com>
        <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
        <20220614103842.af0c9a5434e3099cf9060cf5@linux-foundation.org>
        <YqlaE/LYHwB0gpaW@localhost.localdomain>
        <16297304-82d9-f62b-b87f-cc8d8fde9bd4@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 11:15:30 +0200 David Hildenbrand <david@redhat.com> wrote:

> @Andrew, would it make sense to update the git tree in the "MEMORY
> MANAGEMENT" section now that mm-stable etc. resides on git.kernel.org ?

Thanks, didn't know we had a MAINTAINERS entry ;)

From: Andrew Morton <akpm@linux-foundation.org>
Subject: MAINTAINERS: update tree references
Date: Wed Jun 15 02:22:44 PM PDT 2022

Describe the new kernel.org location of the MM trees.

Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 MAINTAINERS |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/MAINTAINERS~maintainers-update-tree-references
+++ a/MAINTAINERS
@@ -12846,9 +12846,8 @@ M:	Andrew Morton <akpm@linux-foundation.
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
-T:	quilt https://ozlabs.org/~akpm/mmotm/
-T:	quilt https://ozlabs.org/~akpm/mmots/
-T:	git git://github.com/hnaz/linux-mm.git
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	include/linux/gfp.h
 F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
_

