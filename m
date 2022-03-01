Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65C4C8F90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiCAQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiCAQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:02:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBAA146A;
        Tue,  1 Mar 2022 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=qm5dRt7Gv4aZmweadp/wzo25KjVUcXv8NB7v3UutMTM=; b=1814yqXWXWPNT5Q0nL4NdOCsiQ
        mxFREAXuA62BlyPV9R6t5SGOIaheXozWprFqVyBlipNT7IC2x9hQvaaDcRdfmbsfHzj5eoHQVx9pV
        0gk/IYVY/V2XugPGQxACJVu4tTGsvFhVLBAXNOwwNjiEmpdQUAM7SDm6jFpdK+AsAh5CQ4O1AjrAL
        ReNRmbXUtWj4uFalvaLSbLGhHz1DKjo/F9fvXe2B7g/3nSDa+K/hRvit9AnGXNjwbNzv4r1/2yZL5
        4RO9oTMigDahqAXRI/KtW7sxuQvsmeLa8DYRvjx0gnhK+6BLmGqiB0RwGeqGmNtFIINTgdSZLOlw6
        ixTeZD3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP4wF-00HSkf-KG; Tue, 01 Mar 2022 16:01:23 +0000
Date:   Tue, 1 Mar 2022 08:01:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v9 00/14] module: core code clean up
Message-ID: <Yh5DU6n7oCRTfbtG@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
 <2e2860d7-23e8-63f3-f7d3-bce0aa57a3d0@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e2860d7-23e8-63f3-f7d3-bce0aa57a3d0@csgroup.eu>
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

On Tue, Mar 01, 2022 at 07:44:26AM +0000, Christophe Leroy wrote:
> 
> 
> Le 01/03/2022 à 01:21, Luis Chamberlain a écrit :
> > 
> > We should run kmod tests as well.
> > 
> 
> I tried to build kmod tests, but I get a crazy result:
> 
> 
> $ ./configure --host=ppc-linux --prefix=/usr/local
> 
> $ make
> 
> $ cd testsuite
> 
> $ make
> 
> $ file test-list
> test-list: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 
> (SYSV), dynamically linked, interpreter /lib/ld.so.1, for GNU/Linux 
> 3.2.0, with debug_info, not stripped
> 
> $ file module-playground/mod-loop-a.ko
> module-playground/mod-loop-a.ko: ELF 64-bit LSB relocatable, x86-64, 
> version 1 (SYSV), 
> BuildID[sha1]=d46956a4fd36d8d3467806c31831c81217a573f5, with debug_info, 
> not stripped
> 
> 
> 
> How do I get it to crossbuild proper PowerPC module ?

Lucas?

  Luis
