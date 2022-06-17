Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B454FD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiFQSuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFQSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:50:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D453DA48;
        Fri, 17 Jun 2022 11:50:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 14AC5380;
        Fri, 17 Jun 2022 18:50:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 14AC5380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1655491837; bh=nT1sOdmA4MiER3LLOjlrCtvG369t7lBTLCtmTFLx+XA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KkaVX+S+jDu6bQaR165EdvytYJFtnVRFfXHErphyg733QE1Oow5zJVQyZSCg1mJ1B
         ukNLXEfUKOB/6UV7yN9ap+oCHQln8/sBMs1B0D6biOvi1627EcYN9YdSpO8CLaXy1h
         onWthu64/1ipiocJfh6vJ0ejK6/fnZ+DlIvQlyjath1MH06rKgsIrD6tQMOLLoujwO
         J0N2Cwj6mzVq76VpL+mE+HH8OPcNxdcRav/nIYwzjukHKnWsOVw92QwBe4I1+9dUOy
         +ymDLe2WpK416SiVWZXwcrhqO/OMb+9GuaVc9v4QeZdoNY5P7M4vernE/SaXIeN7uy
         3MBnHAVk91JNw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        mario.limonciello@amd.com, linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: Add a blurb about using
 scripts/git-send-email.sh
In-Reply-To: <20220617183215.25917-2-mario.limonciello@amd.com>
References: <20220617183215.25917-1-mario.limonciello@amd.com>
 <20220617183215.25917-2-mario.limonciello@amd.com>
Date:   Fri, 17 Jun 2022 12:50:36 -0600
Message-ID: <87ilozp1j7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Limonciello <mario.limonciello@amd.com> writes:

> In the part of the documentation explaining about identifying maintainers
> mention the `scripts/git-send-email.sh` helper script.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/process/submitting-patches.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

So if you used this script to send this series, I can already see a
problem; I have a 2/2 patch without having seen the script that you are
talking about.  Bringing in maintainers partway through a patch series
like this is not the best way to go.

> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index a1cb6280fbcf..039deed14c49 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -225,7 +225,10 @@ Select the recipients for your patch
>  ------------------------------------
>  
>  You should always copy the appropriate subsystem maintainer(s) on any patch
> -to code that they maintain; look through the MAINTAINERS file and the
> +to code that they maintain. A helper script is available in
> +./scripts/git-send-email.sh that can be used with git-send-email to automatically
> +findd the appropriate recipients for a patch.

Please run a spelling checker on your documentation changes.

> +Alternatively you may look through the MAINTAINERS file manually and the
>  source code revision history to see who those maintainers are.  The
>  script scripts/get_maintainer.pl can be very useful at this step (pass paths to
>  your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
> -- 
> 2.25.1

Thanks,

jon
