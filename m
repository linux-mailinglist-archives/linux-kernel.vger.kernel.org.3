Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17458550CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiFSTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiFSTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:10:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A25F72
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=svs5G5U9ZLanKZIE8i/7zmItG6MWpJd6KG5Sk+MzSnk=; b=LezKtrHb5jAt2iZ2TKSHG6o7fE
        BApIEjUdMAzqi/sjiPruo/A4wqLkCSA2C/PAKtuZv7JuFkxZZ+WYzRSUTGOBwJOVCdd0Da9ywtZot
        yrRaWzRw3L2yHLJ36HJtvCFT/psKGd+G0OLhlcVjQwVjMJDSlNWtgp2zbmPJP5ZRVVaksjQX+8gDN
        4azjBYJF9wI5VBRO0yjd4kgBkZlmk4Sod2ig3WZ7P89CbpV4zVKv28MJDxArIhyeYZ0FbT4yhmnKR
        IjHobQJ1pKtP3YQJ2sY2X0gC3HlvH3bIW6Hx3ijF9dJKeakE7RvStEpAWbaWv+aP152DYN/pp/NEW
        9kdqoEOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o30J9-004Yhk-TP; Sun, 19 Jun 2022 19:10:04 +0000
Date:   Sun, 19 Jun 2022 20:10:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:for-next 3/81] mm/huge_memory.c:2380:21:
 warning: incompatible pointer to integer conversion assigning to 'unsigned
 long' from 'void *'
Message-ID: <Yq90i/eTPYuGkpDS@casper.infradead.org>
References: <202206200151.WMsNVIYY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206200151.WMsNVIYY-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:21:01AM +0800, kernel test robot wrote:
> commit: ddf632ba3fd866d92f0ec9343984c6b2c18a788c [3/81] mm: Clear page->private when splitting or migrating a page

thanks; obvious fix pushed.
