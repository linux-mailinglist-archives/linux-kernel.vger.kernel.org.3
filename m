Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53164D3D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiCIXac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCIXaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:30:30 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B794117C98;
        Wed,  9 Mar 2022 15:29:29 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5350E2C3;
        Wed,  9 Mar 2022 23:29:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5350E2C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646868569; bh=k7gfBbkZAxC7X7iQ0/bDTYZDI/K/n7o0f6AKCNs7sdY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Amq62uC381WEh8sxLagJfXh0nhfY2eleAMfm4m76jdCQWJyJg8OmkX8f4LKR5gDSn
         aCN58cCvzJBIP41i61IfEyCMRn82USr9xzvOAk0qaBsdlq9VHyJsdvZYRyZ8HhhmPv
         +tTDwSBeKB+l7YfgfoidWtXOONZW+yQ4Leya3us3SeZ/t+j8FxlZmJYy80b/MP+oqn
         uudmtuIHek5947KTmPUX5zIbMpBHVG17tgVSUFTyf+LGnDwcLCrok0GpBMrZrKMYiB
         blnBlU+EeKBhUOdad2s++pLs2pyjWENXsaevwBQPIpZM7Q14z1G9KTLpPrpwDdy4Ho
         pniYzcwRiIgSg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: describe how to apply incremental stable
 patches
In-Reply-To: <20220307063340.256671-1-bagasdotme@gmail.com>
References: <20220307063340.256671-1-bagasdotme@gmail.com>
Date:   Wed, 09 Mar 2022 16:29:28 -0700
Message-ID: <87mthy7lif.fsf@meer.lwn.net>
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

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The applying patches document
> (Documentation/process/applying-patches.rst) mentions incremental stable
> patches, but there is no example of how to apply them. Describe the
> process.
>
> While at it, remove note about incremental patches and move the external
> link of 5.x.y incremental patches to "Where can I download patches?"
> section.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/applying-patches.rst | 28 ++++++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)

I've applied this, thanks.  I do have to wonder, though, how useful this
information is anymore.  Does anybody actually apply kernel-patch files
this far into the Git era?

Thanks,

jon
