Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9844DB779
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbiCPRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbiCPRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:40:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0D2BF59
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsLzpovWL3qpyj8PodkSfoW+Ylj76HOoManReo80w4c=; b=acgk7Ks9sbb3gy7n5YIa/AYSez
        FxaOYOdkfHJ7kNHTcld3iUzmJPWG22BfbcFQpbDAlNuZOL8YkOguyRFswUXQo6XCQwNkcE3yAvrtk
        Mq5hOj/evSGVCaQmqOxnjNFSB07VqPytT7ULWfIrUm5T85BDI3pHCcDxBWWoyC+RDODKCB279rdLt
        9Dw65/wnV5bCUWjS1AkxbYFOYuznmcbXWnIcXCxqYsmCZCjK91dQCApOmwSsRG+BSTa/d8xyCQRk8
        BYthB/buYvQ/Ea/w4wkU9re/zNYI1jVEJkb+jDfGeyEj2WjowzP9uKS3BYlE7hLPEYa0BhH1nBQV5
        LAbvlBng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUXba-006DEi-Vu; Wed, 16 Mar 2022 17:38:39 +0000
Date:   Wed, 16 Mar 2022 17:38:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:for-next 174/179] fs/nilfs2/inode.c:232
 nilfs_dirty_folio() error: uninitialized symbol 'nr_dirty'.
Message-ID: <YjIgnsi4+GLFduA8@casper.infradead.org>
References: <202203162210.u0O3mmI4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203162210.u0O3mmI4-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:08:09PM +0300, Dan Carpenter wrote:
> New smatch warnings:
> fs/nilfs2/inode.c:232 nilfs_dirty_folio() error: uninitialized symbol 'nr_dirty'.

Thanks, pushed out a fix.
