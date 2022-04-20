Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61005084F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354994AbiDTJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiDTJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:31:34 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984910FFE;
        Wed, 20 Apr 2022 02:28:49 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 37543378;
        Wed, 20 Apr 2022 09:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 37543378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650446929; bh=7zWBHxG4jtYQ6dRdLjEtUynzfmSn2eD+L9NJ3pIQ9f4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dTOci+dItv/WxYIM0Rm3HzqrE5q6VaShut5P4VmbSWQW9ZWxBCAqOSYHI96hTNGnF
         fJ8WM1QfEhRJGblf4ibaKxvQQeEW0QnT6ybiHIjR6kKjqA3bnffk2uVhhAIyoEgg2z
         w4J/6zSYx+JC75V3vQwTO90Py3YMZU/01apW3qAKxV1YtRjPY1HvmqIdoGT3K8whei
         aFyo95yYWlajVnehwA8+tpQqQabM4hst42+FzUlcGnMuJyciayl0cxhQnK0OFnbgp3
         SBbhgs+WbiQYaHXdW/MPr2D2M4dBiWUZiVMqBBrfMV8LXrQRM0kdgb6SVMUhG79vMb
         0XNuShs1S6jrA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] Documentation: siphash: formatting fixes
In-Reply-To: <20220417075057.127865-1-bagasdotme@gmail.com>
References: <20220417075057.127865-1-bagasdotme@gmail.com>
Date:   Wed, 20 Apr 2022 03:28:44 -0600
Message-ID: <87bkww3xyr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Formatting fixes for Documentation/security/siphash.rst. The shortlog
> should be self-explanatory. Resend of [1].
>
> [1]: https://lore.kernel.org/linux-doc/20220329042952.10100-1-bagasdotme@gmail.com/
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: linux-kernel@vger.kernel.org
>
> Bagas Sanjaya (2):
>   Documentation: siphash: convert danger note to warning for HalfSipHash
>   Documentation: siphash: enclose HalfSipHash usage example in the
>     literal block
>
>  Documentation/security/siphash.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied, thanks.

jon
