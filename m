Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73F348A770
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347264AbiAKFrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiAKFrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:47:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 21:47:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso3020923pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/UDeNAZjWQ1ctWLyCgiJTKVeKvyo0lX+xCq2mIIe1AQ=;
        b=fcYWemOatxdiYk5VflmA3ktfbvLM7ASQay6Xa23DGH8a8KQhGMkkD5GPhokkSLuyqs
         5nZ/QtWBbEJydgeB8fsnukSV25a7ki9YKWJj9VJc2Q7THMmy7JHagAAdCreE1ke7yIx5
         XoE8TtlhJZDa0PvWGt9tROnFai7W2RZr1MK7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UDeNAZjWQ1ctWLyCgiJTKVeKvyo0lX+xCq2mIIe1AQ=;
        b=BRBtV4oVGUG2ysFq7czO1Q4PYW5/SLn9MSl46VgaFI3eIjwrIvF3w9B6EW86G9aqaW
         wqBkQF75d4XQ4DIIPHXUDmQBRhqU0+M3YJYdD1BNIs+RbVV60p6g3glj5MxJU4hs9kKv
         kvfJ4wYt+SUK9KVQSI5Xn6jLofviZVgPafgMRFU4Kuc5E1EWz0PT0/nnVdWUxcHtWfKe
         nTTD1UT5uTo/FGiVc0StTjTcfswXfbaK1QaK9t99i7p34J27T7vJELpT7mBdhyhkCzHE
         UNowrED+qb4wbtgtHm7vWQfpcJQjoCFONu6dfWKxti3Ii0SNuNxR4/O0PXZd+sNsU9ur
         MgsA==
X-Gm-Message-State: AOAM53098i+VrDIN886si0VSdvJE4WpPRor8TLQRpNOjty4Pu1YqPsIs
        q9LFBMP/ikFJY9UclMu+qAPIqw==
X-Google-Smtp-Source: ABdhPJwSptZ7aTtWktm6lgA2BPeRZrJpBKobUrT3JnrVp6Lql+PSiN5jzf+PsWD02OMFI9fnQy7F3A==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr603667pgn.384.1641880060753;
        Mon, 10 Jan 2022 21:47:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3a8c:e3c9:306f:7ca0])
        by smtp.gmail.com with ESMTPSA id p10sm4447906pfo.95.2022.01.10.21.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 21:47:40 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:47:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] checkpatch: require Fixes tag for fixup patches
Message-ID: <Yd0Z+MoYHExGaKCL@google.com>
References: <20211130111503.2930770-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130111503.2930770-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/30 20:15), Sergey Senozhatsky wrote:
> 
> Require "Fixes: hash" tag in those patches that appear to be
> fixing some particular commit.

Gentle ping.

> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index df8b23dc1eb0..4e97d0f6b995 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2493,6 +2493,9 @@ sub process {
>  	my $commit_log_has_diff = 0;
>  	my $reported_maintainer_file = 0;
>  	my $non_utf8_charset = 0;
> +	my $fixes_id = 0;
> +	my $fixes_description = 0;
> +	my $fixes_tag = 0;
>  
>  	my $last_blank_line = 0;
>  	my $last_coalesced_string_linenr = -1;
> @@ -3076,6 +3079,11 @@ sub process {
>  			}
>  		}
>  
> +# Check for Fixes tag
> +		if ($in_commit_log && $line =~ /\b[Ff]ixes:\s*[0-9a-f]{12,40}/) {
> +			$fixes_tag = 1;
> +		}
> +
>  # Check for git id commit length and improperly formed commit descriptions
>  		if ($in_commit_log && !$commit_log_possible_stack_dump &&
>  		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
> @@ -3128,6 +3136,11 @@ sub process {
>  			($id, $description) = git_commit_info($orig_commit,
>  							      $id, $orig_desc);
>  
> +			if (defined($id)) {
> +				$fixes_id = $id;
> +				$fixes_description = $description;
> +			}
> +
>  			if (defined($id) &&
>  			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
>  				ERROR("GIT_COMMIT_ID",
> @@ -7326,6 +7339,12 @@ sub process {
>  		}
>  	}
>  
> +	if ($is_patch && $has_commit_log && $fixes_id && !$fixes_tag) {
> +		ERROR("GIT_COMMIT_ID",
> +		      "Please add 'Fixes: $fixes_id (\"$fixes_description\")'\n", );
> +		$fixes_id = 0;
> +	}
> +
>  	print report_dump();
>  	if ($summary && !($clean == 1 && $quiet == 1)) {
>  		print "$filename " if ($summary_file);
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 
