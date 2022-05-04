Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B737751AEEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356626AbiEDUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiEDUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:25:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E75488A1;
        Wed,  4 May 2022 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rLx+c7VTqOEfz7fcI/lgHktEMgXhYRDtYOiELRvMPrc=; b=LlrQjoofxxS7kPCi/rC2//Wwok
        Mb3oXzepzm1cWSQGZ444BCN1+dO/xftv7/5Z7Z27TmUORRD3gwB2sK4aoRXoJvbcROBnMZf9Rkjz7
        FZ8t0ZEcP88eJ9MRJduocKOqSKYwT+i24NlHtWcfHvmAjDKgJBh/Qn2D8REn0NnFD4nArtfamhETt
        h8ITkBdmGl0/2bLuOcSz4yxzrmkCIQqUpDUc5U91wcD5MnLsGFustS1cp3KsoKgSvyS9LWCGbo4kM
        fbtG2Qj2Hi9qE8VpkLSTPb4hHt5BM9Q8GtwZF+70Nhdh1X6nFqnhyvMA4hPYf5ZHvVLftlkY0yQWk
        neJ1s9MQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmLVe-00CWlB-An; Wed, 04 May 2022 20:22:06 +0000
Date:   Wed, 4 May 2022 13:22:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] module: trivial cleanups for symbol search
Message-ID: <YnLgbjFdFke9Jzzv@bombadil.infradead.org>
References: <20220504194245.1088063-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504194245.1088063-1-masahiroy@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:42:42AM +0900, Masahiro Yamada wrote:
> 
> Masahiro Yamada (3):
>   module: do not pass opaque pointer for symbol search
>   module: do not binary-search in __ksymtab_gpl if fsa->gplok is false
>   module: merge check_exported_symbol() into
>     find_exported_symbol_in_section()
> 
>  kernel/module.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)

Thanks! The droid you are looking for however has morphed quite a bit,
any chance you can rebase onto modules-next [0] and resend a v2?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
