Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66F4BF178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiBVFkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:40:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBVFkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:40:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2468199ED6;
        Mon, 21 Feb 2022 21:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1CqAnBEZ2ZFy8fjm8dn38B5C3yzCvm6JIWsbFX3lVDg=; b=J2bA+qoyp9LSvEiGOnvz3PDj9O
        w0XW4l97M2o24neAIEFvi1h7B7wJIUU77UZlIktnm8Vf8L7E9QsRdYFVMB0jf3qn9c01xaD9zq1mf
        kLEqoCWoib3jlpdZdrfe5tVP1csZKOfMrr7ZDfnldA/WFCkvfs10lz+sqLWQFLiIB/yeE4Ok5n5IV
        6mAsGThkox34CXg2iTHN8aBebZFpt++GB7NLu5cWKycWTS+LVlmped9Ez8bB+FxOr7kDom045OWkt
        mU7pbH39SULs953022HHHEs8IXFT7gE9KGA/Il77r6Jv1dv2dkqgddA/TRcSEuZdMTZ2YOz62pZ6P
        Ex1MN79Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMNtc-00BrhZ-3a; Tue, 22 Feb 2022 05:39:32 +0000
Message-ID: <0285efc4-3983-56fa-6b4e-a0b17bdd841a@infradead.org>
Date:   Mon, 21 Feb 2022 21:39:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Content-Language: en-US
To:     =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 2/18/22 10:16, Tomasz Warniełło wrote:
> This series transforms the free-form general comments - mainly the usage
> instructions and the meta information - into the standard Perl
> documentation format. Some of the original text is reduced out. And some
> is simply dropped.
> 
> The transformation includes language, paragraphing and editorial
> corrections.
> 
> The only change in the script execution flow is the replacement of the
> 'usage' function with the native standard Perl 'pod2usage'.
> 
> The to-do suggestion to write POD found in the script is ancient, thus
> I can't address its author with a "Suggested-by" tag.
> 
> This version follows the advice received on v3, except I'm leaving
> the old copyrights untouched.
> 
> The process consists of 14 steps.
> 
> Patches beginning with no 3 are disfunctional until no 9 has been
> applied.
> 
> 1) Add the basic POD sections
> 2) Relink argument parsing error handling to pod2usage
> 
> The following subseries is disfunctional before its last part.
> 
> 3) Translate the DESCRIPTION section
> 4) Translate the "Output format selection" subsection of OPTIONS
> 5) Translate the "Output format selection modifier" subsection of OPTIONS
> 6) Translate the "Output selection" subsection of OPTIONS
> 7) Translate the "Output selection modifiers" subsection of OPTIONS
> 8) Translate the "Other parameters" subsection of OPTIONS
> 9) Replace the usage function
>     
> Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -help
> parameters are handled by POD now.
>     
> 10) Drop obsolete comments
> 11) Refresh the copyright lines
> 
> Let's see what's wrong this time.

This patch series looks good to me.
I'll do some testing with it now.

thanks.

> Tomasz Warniełło (11):
>   scripts: kernel-doc: Add the basic POD sections
>   scripts: kernel-doc: Relink argument parsing error handling to
>     pod2usage
>   scripts: kernel-doc: Translate the DESCRIPTION section
>   scripts: kernel-doc: Translate the "Output format selection"
>     subsection of OPTIONS
>   scripts: kernel-doc: Translate the "Output format selection modifier"
>     subsection of OPTIONS
>   scripts: kernel-doc: Translate the "Output selection" subsection of
>     OPTIONS
>   scripts: kernel-doc: Translate the "Output selection modifiers"
>     subsection of OPTIONS
>   scripts: kernel-doc: Translate the "Other parameters" subsection of
>     OPTIONS
>   scripts: kernel-doc: Replace the usage function
>   scripts: kernel-doc: Drop obsolete comments
>   scripts: kernel-doc: Refresh the copyright lines
> 
>  scripts/kernel-doc | 347 +++++++++++++++++++++------------------------
>  1 file changed, 159 insertions(+), 188 deletions(-)
> 
> 
> base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26

-- 
~Randy
