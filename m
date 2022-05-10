Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7652266C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiEJVmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiEJVmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCA25B3FA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D06C6617B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B9BC385CE;
        Tue, 10 May 2022 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652218925;
        bh=pAys4d063qaBAGhMCRKfoAhiN+/cEyV1YYd7Xm6LrIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Ru53wdxdahdjTg7F4tdR+QbS7I5o+c+3uUjg23QPPglvwxDhZK3Qbf9JSykfsJHq
         BClutq2zq86c2Z/eg5vRkB6i2pv499z+LXErJ+AJkBTwWBlJEFP3KxEZ79bjZO6WlK
         5f567i+q9kW3d4UW8En1PsaMEWi90A3uAJzakS44=
Date:   Tue, 10 May 2022 14:42:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [akpm-mm:mm-unstable 175/431] mm/madvise.c:632:36: error:
 implicit declaration of function 'is_swapin_error_entry'
Message-Id: <20220510144204.ba2856587aca43d7fa23ed45@linux-foundation.org>
In-Reply-To: <202205110409.O9A7aFSX-lkp@intel.com>
References: <202205110409.O9A7aFSX-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 04:42:45 +0800 kernel test robot <lkp@intel.com> wrote:

> Note: the akpm-mm/mm-unstable HEAD 584a50635cc1deee2eeab5a17dfdcf9db7add21b builds fine.
>       It only hurts bisectability.

Well drat.  8296b60c4ec is in mm-stable and addressing this would
require a rebase.
