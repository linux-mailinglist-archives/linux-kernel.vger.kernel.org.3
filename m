Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302BB4F86D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbiDGSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiDGSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75838CD644
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1144B61874
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FABC385A4;
        Thu,  7 Apr 2022 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649354585;
        bh=+yMtJUm6feZXxZqTlDnWwouUGLx0qcjo0z4uDWA8UyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3uWEl+mmqyGILtDhV3tico+Pa5LYwylnlSPAYjjJAdreKmdVbxliuwon2JYO8BLh
         3LV8FKBQnHUQ0pAnYKdidtAXqJJ1yYdukD7TlZ6JCVPmr/WB3Kknp20uT/8G0WK+yz
         c8k0C+QUkNDWlI3Xu73w3pqcHCBWf7+6r9ja78Us8RMxRB5IalL5wBsgR8v3vEi7tC
         J0eSZI1/92t09vdy6pFLh3KkLvLxjK0OtJTZ6nAdG27hcW0GBtiN6rKpxhlhmC+ZCO
         L3hi1jIB5eMUs9Pv0VAqbSIytp62TIOvpm+JHLjwkNtVvgnmmanlGDOz4m+g3AGt2S
         ZvXRL23/W0Big==
Date:   Thu, 7 Apr 2022 11:03:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: add self as clang reviewer
Message-ID: <Yk8nV1kBngon+o6N@dev-arch.thelio-3990X>
References: <20220407175715.3378998-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407175715.3378998-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 01:57:15PM -0400, Tom Rix wrote:
> I have been helping with build breaks and
> other clang things and would like to help
> with the reviews.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks a lot Tom!

Acked-by: Nathan Chancellor <nathan@kernel.org>

I think we might need to CC Andrew Morton for this, as we do not
currently pick up patches ourselves.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ebfc93d8f0d..8da670067a34 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4797,6 +4797,7 @@ F:	.clang-format
>  CLANG/LLVM BUILD SUPPORT
>  M:	Nathan Chancellor <nathan@kernel.org>
>  M:	Nick Desaulniers <ndesaulniers@google.com>
> +R:	Tom Rix <trix@redhat.com>
>  L:	llvm@lists.linux.dev
>  S:	Supported
>  W:	https://clangbuiltlinux.github.io/
> -- 
> 2.27.0
> 
> 
