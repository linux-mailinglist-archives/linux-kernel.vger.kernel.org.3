Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AA56ACC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiGGUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiGGUd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:33:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF5120BD3;
        Thu,  7 Jul 2022 13:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B5DB80522;
        Thu,  7 Jul 2022 20:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389B0C3411E;
        Thu,  7 Jul 2022 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657226034;
        bh=gOQJhMxW8xSp1tMqkz/KWBJO7/GEhU5fryrg90lTNZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ny2VmlxA3OodgBB940SLJA2KJbVmTCud9NBjyF1w1cJPXq6sEc02RCD+AntYeMZgm
         Jj5eHybbSzU5JEtY9DN7/LI/f1/mlpseh7waplaUusDvK5PmxWDdcsTXoI4kRNPQgq
         bGTwBJuC0xE6AJJzlPKUIhQeHGilWLuAHCZOqRooczD8MO16DiumnvtpqaPP2qHOm0
         6LLUron71i+8sKTJLCANV5ZVaa5UZIgweKKIzWFQuhUtAxzB4gkGf0IOxsFjKKcV8q
         EHVUZ/aNTyzuIPL9YHl8gVYvxqjix0y9AzX+LLSIiqNxm2aGC83JpYA3EcZEE8Q+uo
         +I8LPFSUa/Mnw==
Date:   Thu, 7 Jul 2022 21:33:47 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        ksummit@lists.linux.dev
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
Message-ID: <20220707213347.1b5c2334@sal.lan>
In-Reply-To: <a5544eb7-6044-0b84-cf1c-17ca849c641e@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
        <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
        <a5544eb7-6044-0b84-cf1c-17ca849c641e@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 6 Jul 2022 23:31:09 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [CC: update address of ksummit]
> 
> On Tue, 5 Jul 2022 13:15:57 +0900, Akira Yokosawa wrote:
> > Hi Mauro,  
> [...]
> > 
> > Fedora, RHEL/CentOS, and openSUSE Leap provide helpful packages
> > for installing math expression support.
> > 
> >     Fedora 36               python3-sphinx-latex (python3-sphinx depends on this)
> >     RHEL 9/CentOS stream 9  ditto
> >     openSUSE Leap 15.4      python3-Sphinx_4_2_0-latex
> >                                 (python3-Sphinx_4_2_0 depends on this) or
> >                             python3-Sphinx-latex
> >                                 (python3-Sphinx depends on this, version: 2.3.1)  
> 
> These packages are supposed to cover LaTeX packages necessary
> for building LaTeX sources the version of Sphinx generates.
> 
> HOWEVER, in my test of openSUSE Leap 15.4, pythno3-Sphinx-4_2_0-latex
> does not cover texlive-tex-gyre, which is required since Sphinx 4.0.0.
> 
> Changelog of Sphinx 4.0.0 [1] says:
> 
> > Dependencies
> >
> > 4.0.0b1
> >
> > [...]
> >   * LaTeX: add tex-gyre font dependency  
> 
> [1]: https://www.sphinx-doc.org/en/master/changes.html#release-4-0-0-released-may-09-2021
> 
> I'm thinking of opening a ticket at openSUSE's bugzilla.
> 
> Fedora 36's python3-sphinx-latex (for Sphinx 4.4.0) has
> texlive-collection-fontsrecommended and covers texlive-tex-gyre naturally.
> 

Yeah, I remember the script started using some meta-packages for LaTeX.
This had to change a couple of times because distros that have dozens of
packages for it were not installing everything on their meta packages.
So, the packages install but they don't run as they depend on other
non-installed packages.

That's basically why I added a list of *.sty inside the script and started
using kpsewhich to double-check if all dependencies are there.

Regards,
Mauro

