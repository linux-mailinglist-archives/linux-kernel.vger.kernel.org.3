Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3A565C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiGDQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiGDQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:36:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BCCB855;
        Mon,  4 Jul 2022 09:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5616B8114B;
        Mon,  4 Jul 2022 16:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE3C341C7;
        Mon,  4 Jul 2022 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656952558;
        bh=Q75PA0ihcw46MgoO9hImbq+mkmb2piBNBaKYd9Ickvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCovc5Tl9Gq95vZXfSSS721zmw/zWudHGrzFbrlPERyfkGAp/vwVjKs1mWWLOCHi4
         azZqhsX07iBDIMQa/5sI01vU9fnCaWDCK3tkqmHL6nW9y8FqHpRhWfed9HXmPn5BOZ
         yN26k2UMSyQ9R5XdazlOwRNPKRWqGGUlffrdkVCH4ge2VADRKg5XHP7i5RXqe+vGi9
         DIdvcaXON9c7coN4foGEMAsbJLhGLh9m4RqZqVnBrKrKhFauumG6d9cAX4+fGfgACA
         qWFYfiMIBXaISBIFUcSyKWAMfG8aab9PwLZSyArSAL/+92RjEGr3DDInKSpoHq9fG8
         Iy2wzuYzSfzGw==
From:   SeongJae Park <sj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     SeongJae Park <sjpark@amazon.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [sj:damon/next 17/20] htmldocs: Documentation/admin-guide/mm/damon/guide.rst:173: WARNING: unknown document: /vm/damon/api
Date:   Mon,  4 Jul 2022 16:35:55 +0000
Message-Id: <20220704163555.87880-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202207032102.FQn5Ryi7-lkp@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 21:15:46 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/=
> next
> head:   54aa71ecf6cac755c491a1992d83437cd2240311
> commit: e381a2734cd4250c0e3ab5f46cecc86ec67edb57 [17/20] Docs/DAMON: Add mo=
> re docs -next doc
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/admin-guide/mm/damon/guide.rst:173: WARNING: unknown docum=
> ent: /vm/damon/api
> 
> vim +173 Documentation/admin-guide/mm/damon/guide.rst
> 
>    172
>  > 173  If you are a kernel space programmer, writing kernel space DAMON applications
>    174  using the API (refer to the :doc:`/vm/damon/api` for more detail) would be an
>    175  option.
>    176
>    177

Thank you for finding this issue!  I fixed this with below change.

    diff --git a/Documentation/admin-guide/mm/damon/guide.rst b/Documentation/admin-guide/mm/damon/guide.rst
    index a014cb99a116..e1eb92c61499 100644
    --- a/Documentation/admin-guide/mm/damon/guide.rst
    +++ b/Documentation/admin-guide/mm/damon/guide.rst
    @@ -171,7 +171,7 @@ applies complex optimizations itself.  Using this, you can make more creative
     and wise optimizations.
    
     If you are a kernel space programmer, writing kernel space DAMON applications
    -using the API (refer to the :doc:`/vm/damon/api` for more detail) would be an
    +using the API (refer to the :doc:`/mm/damon/api` for more detail) would be an
     option.

Please note that the issue is made by a commit that only for DAMON hacking
tree, not for the mainline or other trees.  So the patch wouldn't be submitted
to other mailing lists.


Thanks,
SJ

> 
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
