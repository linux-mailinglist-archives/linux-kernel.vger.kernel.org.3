Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718C14E8137
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiCZN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiCZN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E857A9BD;
        Sat, 26 Mar 2022 06:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1271B60E93;
        Sat, 26 Mar 2022 13:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36476C340EE;
        Sat, 26 Mar 2022 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648302972;
        bh=epRNsHHCOQUrGWlx+/P8FKFWDZQ+vOazJEHJU5kW44U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xbm3Gar8CrbVaQCKHxVrdEMK85rISLwByrpt3pWMi/AEEAmuhP9UPeNtYYHDGVjYl
         Sfa+1Cn8l1jTKD9/LxQm4CQjnVq96V+R1N0GjcMV4WMl2R7WifdQZORvFQDE5mRSRJ
         xpqqLLu1SyUkrCxKfYbWRh9SlGkeyH5+IuPUcWYWNaTI0LCBXRVzlDzdPmPHiMbeOt
         /I4QmyNIAtPsdOBemHIJW/IgR4g1Db9bgDY4aXizfZbzfRNJIEtaCDN20TGYOFA2ie
         KQsUOMGnKSpP+JO17hxQtmFuilemPCYjxshL3SzimV+ytumYYmLeh6wPs0czVWomw/
         +HcKF4Kcw2FfQ==
Date:   Sat, 26 Mar 2022 14:56:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation: kernel-doc: Promote "Writing
 kernel-doc comments" to page title
Message-ID: <20220326145332.0698a849@coco.lan>
In-Reply-To: <20220326123337.642536-2-bagasdotme@gmail.com>
References: <20220326123337.642536-1-bagasdotme@gmail.com>
        <20220326123337.642536-2-bagasdotme@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 26 Mar 2022 19:33:37 +0700
Bagas Sanjaya <bagasdotme@gmail.com> escreveu:

> Promote the first heading from chapter heading to page title. While at
> it, fix heading inconsistencies by promoting the appropriate headings.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/doc-guide/kernel-doc.rst | 29 +++++++++++++-------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index 79aaa55d6bcf2b..ea41e05d0e8903 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -1,3 +1,4 @@
> +===========================
>  Writing kernel-doc comments
>  ===========================
>  
> @@ -31,7 +32,7 @@ kernel source code layout. This is lower priority and at the discretion
>  of the maintainer of that kernel source file.
>  
>  How to format kernel-doc comments
> ----------------------------------
> +=================================

Hmm... I can't really see any differences... What this patch seems to be
doing is to just change the markups for each level.

See, on Sphinx, the first markup (whatever it is) is level 1, level 2
the second different markup and so on.

So, before this patch, kernel-doc.rst had:

	level 1: Writing kernel-doc comments
	=====================================

	level 2: How to format kernel-doc comments
	------------------------------------------

	level 3: Function parameters
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~

And after it, it will have:

	====================================
	level 1: Writing kernel-doc comments
	====================================

	level 2: How to format kernel-doc comments
	==========================================

	level 3: Function parameters
	----------------------------

No semantic changes at all.

The only (eventual) value of a change like that would be to make the
levels more uniform, but IMO, it is not worth to apply a change like
that, as:

	1. There are a lot other documents that don't use the more commonly
	   used level standard;

	2. Making all .rst files to use the same definitions is hard;

	3. Even if we place everything using identical markups for every
	   level, as new stuff gets added, different (still valid)
	   markups could be used on newer documents.

Regards,
Mauro


>  
>  The opening comment mark ``/**`` is used for kernel-doc comments. The
>  ``kernel-doc`` tool will extract comments marked this way. The rest of
> @@ -56,7 +57,7 @@ requested to perform extra gcc checks::
>  	make W=n
>  
>  Function documentation
> -----------------------
> +======================
>  
>  The general format of a function and function-like macro kernel-doc comment is::
>  
> @@ -88,7 +89,7 @@ ends with an argument description, a blank comment line, or the end of the
>  comment block.
>  
>  Function parameters
> -~~~~~~~~~~~~~~~~~~~
> +-------------------
>  
>  Each function argument should be described in order, immediately following
>  the short function description.  Do not leave a blank line between the
> @@ -116,7 +117,7 @@ be written in kernel-doc notation as::
>        * @...: description
>  
>  Function context
> -~~~~~~~~~~~~~~~~
> +----------------
>  
>  The context in which a function can be called should be described in a
>  section named ``Context``. This should include whether the function
> @@ -134,7 +135,7 @@ Examples::
>    * Context: Interrupt context.
>  
>  Return values
> -~~~~~~~~~~~~~
> +-------------
>  
>  The return value, if any, should be described in a dedicated section
>  named ``Return``.
> @@ -166,7 +167,7 @@ named ``Return``.
>       effect.
>  
>  Structure, union, and enumeration documentation
> ------------------------------------------------
> +===============================================
>  
>  The general format of a struct, union, and enum kernel-doc comment is::
>  
> @@ -189,7 +190,7 @@ lines, and ends with a member description, a blank comment line, or the
>  end of the comment block.
>  
>  Members
> -~~~~~~~
> +-------
>  
>  Members of structs, unions and enums should be documented the same way
>  as function parameters; they immediately succeed the short description
> @@ -223,7 +224,7 @@ Example::
>    };
>  
>  Nested structs/unions
> -~~~~~~~~~~~~~~~~~~~~~
> +---------------------
>  
>  It is possible to document nested structs and unions, like::
>  
> @@ -274,7 +275,7 @@ It is possible to document nested structs and unions, like::
>        should be documented as ``@bar:``
>  
>  In-line member documentation comments
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +-------------------------------------
>  
>  The structure members may also be documented in-line within the definition.
>  There are two styles, single-line comments where both the opening ``/**`` and
> @@ -311,7 +312,7 @@ on a line of their own, like all other kernel-doc comments::
>    };
>  
>  Typedef documentation
> ----------------------
> +=====================
>  
>  The general format of a typedef kernel-doc comment is::
>  
> @@ -336,7 +337,7 @@ Typedefs with function prototypes can also be documented::
>     typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
>  
>  Highlights and cross-references
> --------------------------------
> +===============================
>  
>  The following special patterns are recognized in the kernel-doc comment
>  descriptive text and converted to proper reStructuredText markup and `Sphinx C
> @@ -385,7 +386,7 @@ Domain`_ references.
>    instead. This is mostly for legacy comments.
>  
>  Cross-referencing from reStructuredText
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +=======================================
>  
>  No additional syntax is needed to cross-reference the functions and types
>  defined in the kernel-doc comments from reStructuredText documents.
> @@ -408,7 +409,7 @@ through the following syntax::
>  For further details, please refer to the `Sphinx C Domain`_ documentation.
>  
>  Overview documentation comments
> --------------------------------
> +===============================
>  
>  To facilitate having source code and comments close together, you can include
>  kernel-doc documentation blocks that are free-form comments instead of being
> @@ -524,7 +525,7 @@ source.
>  .. _kernel_doc:
>  
>  How to use kernel-doc to generate man pages
> --------------------------------------------
> +===========================================
>  
>  If you just want to use kernel-doc to generate man pages you can do this
>  from the kernel git tree::



Thanks,
Mauro
