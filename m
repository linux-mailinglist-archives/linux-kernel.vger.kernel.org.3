Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8654614A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348437AbiFJJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348738AbiFJJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:13:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796AD2EE10D;
        Fri, 10 Jun 2022 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654852283; x=1686388283;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3P92TjbxgWWzR31wO/9qZunS2kkje5uPblM6lB8tw0A=;
  b=Pu5K8oppfXrSX7Dv7zuk/6/hXCEpjmTVOfvYD5gUG0kDFvudrPhRZqcN
   CMbZVhbxDT7Kxt+B6lnwO/TWCrEem9OH4eYDzkBD8NIuiAuUTc3FK18t6
   M7pFUDPskzpEk2+M4rjuBmE4k2IXEqBEVpYOvSnnlczDPsGS8A7SH6WEQ
   Dr3iVODVQ3bhi1PkxNo4g8troKvk8OMulkGEAmZtVn/m0ZraOesk8STJP
   oUSF0FHxAkgde6G7WBGTAGxsRAxdRbVjqlasvY1uszNJlsfbsxBe3/P1Y
   2RKM7j4DQawkZZ9kBeJTcTaU/dwowGStZedTUq2gBn49gpPBZmYQUrUjn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="258004016"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="258004016"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 02:11:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="586110091"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost) ([10.252.58.80])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 02:11:18 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [RFC PATCH 3/5] docs/doc-guide: Update guidelines for title
 adornments
In-Reply-To: <732154bc-aa35-2326-2b64-87b6c4dd02e7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
 <732154bc-aa35-2326-2b64-87b6c4dd02e7@gmail.com>
Date:   Fri, 10 Jun 2022 12:11:15 +0300
Message-ID: <871qvw2898.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jun 2022, Akira Yokosawa <akiyks@gmail.com> wrote:
> Existing guidelines predate the sub-directory wise document
> management.
>
> Update the guidelines to reflect the current state of affairs.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/doc-guide/sphinx.rst | 66 +++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index efcccab68286..f257c4785607 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -202,34 +202,72 @@ Here are some specific guidelines for the kernel documentation:
>  * Also update the content, not just the formatting, when converting
>    documentation.
>  
> -* Please stick to this order of heading adornments:
> +* Please stick to this relative order of section title adornments:
>  
> -  1. ``=`` with overline for document title::
> +  1. ``=`` with overline for 1st level titles::
>  
> -       ==============
> -       Document title
> -       ==============
> +       ===============
> +       1st level title
> +       ===============
>  
> -  2. ``=`` for chapters::
> +  2. ``=`` for 2nd level titles::
>  
> -       Chapters
> -       ========
> +       2nd level title
> +       ===============
>  
> -  3. ``-`` for sections::
> +  3. ``-`` for 3rd level titles::
>  
> -       Section
> -       -------
> +       3rd level title
> +       ---------------
>  
> -  4. ``~`` for subsections::
> +  4. ``~`` for 4th level titles::
>  
> -       Subsection
> -       ~~~~~~~~~~
> +       4th level title
> +       ~~~~~~~~~~~~~~~
>  
>    Although RST doesn't mandate a specific order ("Rather than imposing a fixed
>    number and order of section title adornment styles, the order enforced will be
>    the order as encountered."), having the higher levels the same overall makes
>    it easier to follow the documents.
>  
> +  .. note::
> +    - It is not easy to tell the levels (chapter, section, etc.) of title
> +      adornments in a particular .rst file.  A title that appears first in
> +      a .rst file can be at any level of document, chapter, section, or
> +      subsection (or deeper) depending on the file's inclusion depth.
> +
> +    - The RST language does not have an explicit means to specify a "document
> +      title".  Quote from the RST documentation\ [#rstdoc]_ with minor edit:
> +
> +	*Specifically, there is no way to indicate a document title and
> +	subtitle explicitly in reStructuredText.  Instead, a lone top-level
> +	section title can be treated as the document title.*
> +
> +      In the kernel documentation processing, the first title in a top-level
> +      ``index.rst`` can be considered the document title.  In HTML, as each
> +      .html output has its source .rst file, the title which happens to come
> +      first is used as the title of the resulting HTML page.
> +      Alternatively, it is possible to specify a page title by using the
> +      directive "title".\ [#rstdirtitle]_
> +
> +    - There may be a 2nd or 3rd level adornment at the first title in a .rst
> +      file.  This usage is often seen in .rst files that are derived and
> +      split from a larger .rst file.  It is sufficient if relative order is
> +      preserved.
> +
> +    .. [#rstdoc] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#document
> +    .. [#rstdirtitle] https://docutils.sourceforge.io/docs/ref/rst/directives.html#metadata-document-title
> +
> +  .. warning::
> +    For existing documents, manually updating title adornments just to meet
> +    these guidelines is not recommended.  Such changes can be error-prone and
> +    may break section hierarchy without being caught by reviewers.  They may
> +    be justified if done in conjunction with a section reorganization or
> +    similar.
> +
> +    It would be appreciated if adjustment of those adornments could be
> +    automated in some way.
> +

When I wrote the original guidelines, it was my subjective decision to
steer towards using the same title adornment styles and ordering across
the kernel documentation. I intentionally left out all the
reStructuredText details about this, because the definitive
documentation is the reStructuredText documentation we can refer to.

While the "Nth level title" is a more precise description, I'm not sure
it's actually helpful without describing how these levels should map to
kernel documentation structure. (Not saying the original did that
either, but then there wasn't much structure to speak of.)

Improving the documentation on documentation is great, but I think it's
a bad sign when length of the notes and warnings on something far exceed
the length of the thing being documented. The bulk of the text should be
helpful enough for people to DTRT, while leaving out exhaustive
descriptions of all the details that should just be references to
reStructuredText documentation.


BR,
Jani.




>  * For inserting fixed width text blocks (for code examples, use case
>    examples, etc.), use ``::`` for anything that doesn't really benefit
>    from syntax highlighting, especially short snippets. Use

-- 
Jani Nikula, Intel Open Source Graphics Center
