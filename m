Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F084C4E25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiBYS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiBYS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:57:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1E1E1111
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:56:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0F20B83302
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B43C340E7;
        Fri, 25 Feb 2022 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645815391;
        bh=5mFg1geK3/HpS6b4jbVxVyn7sGWeVlBfS0uJ3vxTLPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j6nHidPSurApkrvwM5GPgOG7CsQ8u18KemJYtHn3HjFXS1np8mUcx0zI744hfeOey
         ROb5f4lWlKqY9JZytGTUOFkVnHAhm61LLUoTJi4pIw2tWvYNYh+TTjM6OXdar3IRr3
         1rNxy+M7Eu9E3N3Ci3+Pz3I1SZmTNiPEdojg/rvz6+YjtpVz14SlT9BFO3IWAetSh+
         fUyu+2DAipF402RXJoZATPyKLMvWFvpTjfH2zhyEc0bxuY7w40O4pxr5gow/V+GgoS
         zwIP2ynaQjajD6beApp+vzzM8QMkIDW7LjNxrcKkUF99AEhWZa7TPSNBM1HWjsxwzz
         CnWHmZEEONvSg==
Date:   Fri, 25 Feb 2022 19:56:26 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] scripts: get_abi.pl: Fix typo in help message
Message-ID: <20220225195626.71a4f810@coco.lan>
In-Reply-To: <1ff3605db3dead41bbde33fbbff6754900eceead.1645789205.git.michal.simek@xilinx.com>
References: <1ff3605db3dead41bbde33fbbff6754900eceead.1645789205.git.michal.simek@xilinx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Feb 2022 12:40:08 +0100
Michal Simek <michal.simek@xilinx.com> escreveu:

> Fix misspelled word in the script. (s/COMAND/COMMAND/).
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
>  scripts/get_abi.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> index 6212f58b69c6..1068cd0e3e90 100755
> --- a/scripts/get_abi.pl
> +++ b/scripts/get_abi.pl
> @@ -987,7 +987,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
>  B<abi_book.pl> [--debug <level>] [--enable-lineno] [--man] [--help]
>  	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
>  	       [--search-string <regex>]
> -	       <COMAND> [<ARGUMENT>]
> +	       <COMMAND> [<ARGUMENT>]
>  
>  Where B<COMMAND> can be:
>  



Thanks,
Mauro
