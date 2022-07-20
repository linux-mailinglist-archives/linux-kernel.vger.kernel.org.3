Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0857AFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiGTD7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbiGTD7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8B36D9DD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A049661367
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBF3C3411E;
        Wed, 20 Jul 2022 03:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658289581;
        bh=ZlN5ygnzX+V8vITCG0vZg1PUXUa1XbN4KWNFwvl2AJQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HMAHh6bCRysCeS/bvOC1qSjfRVWW3VJCmqdUp4Vbofh/Po4TvIgXKyn04MvXsGWMF
         MTJsoPeqiV+HnnoP5sWdWVObw1AK282UsjtXUdys+5Vl29oaxMLQcELjM/BZEn4cAJ
         kKflda+G7KPzmN5IJ/jDLajDzReEp+LE4CoY5gyWqhhfGYdqbE0m8Et7bH82U9Z3Ax
         zb4NlTu7qmZqwgrfqq/iX/EPrb3WJBkDenM2KKP6kTkDgTLdWi4MY3lwRXf61H7Fs+
         ziO7Q2I1bEzaZHxCwEMGeQ+/sSZ8T7yDQ/xE7mgRtCCTrc13RCtQwe8vY7WUFXKgIK
         DCwbv3NCyKsJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8F71C5C0812; Tue, 19 Jul 2022 20:59:40 -0700 (PDT)
Date:   Tue, 19 Jul 2022 20:59:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH nolibc v1] selftests/nolibc: Avoid generated files being
 committed
Message-ID: <20220720035940.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220720033745.GC3106@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720033745.GC3106@1wt.eu>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:37:45AM +0200, Willy Tarreau wrote:
> From: "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>
> 
> After running the nolibc tests, the "git status" is not clean because
> the generated files are not ignored. Create a `.gitignore` inside the
> selftests/nolibc directory to ignore them.
> 
> Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Cc: Fernanda Ma'rouf <fernandafmr2@gmail.com>
> Signed-off-by: Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
> 
> Paul,
> 
> Fernanda sent me this which I think is a desirable cleanup to the
> series I sent you. If you're fine with adding it on top of what you
> already have, that's great. Otherwise I can queue it here for next
> time, but this should improve the user's experience.

I queued it on top of the others.  ;-)

							Thanx, Paul

> Thanks,
> Willy
> 
> --
>  tools/testing/selftests/nolibc/.gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 tools/testing/selftests/nolibc/.gitignore
> 
> diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
> new file mode 100644
> index 000000000000..4696df589d68
> --- /dev/null
> +++ b/tools/testing/selftests/nolibc/.gitignore
> @@ -0,0 +1,4 @@
> +/initramfs/
> +/nolibc-test
> +/run.out
> +/sysroot/
> 
> base-commit: 1e93ece89dd1c6217b92ef6fc100df9ba202c30c
