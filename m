Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09D058D8F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbiHIMzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiHIMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:55:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AEE13D04;
        Tue,  9 Aug 2022 05:55:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB09637F;
        Tue,  9 Aug 2022 12:55:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB09637F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660049701; bh=zJzaVstWdqCzZEUwLBmwdRMqEN2u+PciwoZk6yl1nKw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i2EWFk+48wT2XX0jL3ONglkhqo+M/dVpLV/Ujw/LBa6SZj6+EA142sO96UKzFaY/m
         DiAhsmnfrpdvJn7jR1BsenPVzm25X4I3OzwGTs7yLMMuOGfzEUkO0JrO2/aEAeveKr
         ajcshfzk3Bs9CwJbAUQZ8Jy50sF1PO0VjqnNl5an70aMfl4bKh4ug1PbJyMG43QXhd
         OcHibaU4Z65pjgdNe6+vXNELsiwTgXdDeKxe9jC3yDYYFScDiB7ZbaqEnwGyFJAQog
         PvCbD1nQjib+UDSkrPjI6i5Noqj3ooH2/Q0HndPz1JLYeTzJVmT8BTHBVLrKzNlI7X
         W2CoSIRyWCgpA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] Documentation: stable: Document alternative for
 referring upstream commit hash
In-Reply-To: <20220809045543.2049293-1-carnil@debian.org>
References: <20220809045543.2049293-1-carnil@debian.org>
Date:   Tue, 09 Aug 2022 06:54:59 -0600
Message-ID: <8735e5a864.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salvatore Bonaccorso <carnil@debian.org> writes:

> Additionally to the "commit <sha1> upstream." variant, "[ Upstream
> commit <sha1> ]" is used as well as alternative to refer to the upstream
> commit hash.
>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  Documentation/process/stable-kernel-rules.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

So this is a nit but...

> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index c61865e91f52..2fd8aa593a28 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -97,6 +97,12 @@ text, like this:
>  
>      commit <sha1> upstream.
>  
> +or alternatively:
> +
> +.. code-block:: none
> +
> +    [ Upstream commit <sha1> ]

Can this just be:

  or alternatively::

    [ Upstream commit <sha1> ]

That extra RST markup just clutters things without any advantage.

Thanks,

jon
