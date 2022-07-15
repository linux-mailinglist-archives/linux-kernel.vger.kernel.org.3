Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABCB5758F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiGOBEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiGOBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:04:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DE813E20;
        Thu, 14 Jul 2022 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kFjNGjBbXr9reYdlarR/vvGQT3nH9JjkdvdGWcF8lZg=; b=Bdb4uStXshxo6vG4HHpk9lkSPD
        iYnHWuW1/sfAa6CuDctsV0UnHcAaeKwYCjFybUfnWErC+XNEKIcWPhg+CS/agjH99LFYpon+IIELo
        U+0F1dH0ua36wRnEx4RuglwvvkZKs2SnUuulaVA1OdojHFXYnMTMvd5sr8rIFPYddb8FXvb8ZWftC
        SbP+N4DnUOWDUOTep23Ehr1P41doNUqWcaYEUntP6C6wSEvIPiBqPBq2hDthnoT+7CYSYvY9jfmyd
        DZQ+wnIIgzsH/kDAe+fYcdF3cBVz3J1zt5J8QMn7jn8n1yJRPGpSq/6TUFYhkrY/BPTJzA8Akkubj
        f/Jm/cOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oC9kQ-00C8Iz-JY;
        Fri, 15 Jul 2022 01:04:02 +0000
Date:   Fri, 15 Jul 2022 02:04:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <YtC9AgqezKXuUoy6@ZenIV>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
 <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk>
 <YtC6SUmyaCSKe2HX@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtC6SUmyaCSKe2HX@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:52:25AM +0100, Al Viro wrote:

> Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks like
> one of the commits in it got changed since then - the difference in
> __bio_iov_iter_get_pages() (unsigned int i initialization).
> 
> Sigh...  I'll rebase on top of that.

Rebased and pushed out (with copy_pipe_to_iter() fix folded in as well)
