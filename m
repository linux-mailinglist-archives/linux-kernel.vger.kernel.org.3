Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6924E7C35
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCZAET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCZADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:03:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984AA58E74;
        Fri, 25 Mar 2022 17:02:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B3CB740;
        Sat, 26 Mar 2022 00:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B3CB740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648252930; bh=cUM0bA6twXDq+rLcbYqfzIlfhUvjvLtmgZEyHL8oBlI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kbw/RodfhLjNlgWGazhjMkzxiNUUD/f5JK8pu41IDDOrqD+AUHU9lR4QwZvFi/zqy
         vI/G8Gww56Hs9cWcfOBeQDazJ7+9XoimECCTVGLfl+ESqRyzx74XeyU/KmJ3Dt3uC/
         Wksqv/2G0BmR/UX8jZUxgFgP+ncUj+5ZcyXN9LhLpnIBUXbMIJ4uXwthrWi/WqgZLd
         TZ8pjvLSak6k8tXVwrjEKJKT7X6dif72hzsA+IhtJeatPWp7XqVBMDESXjEGkxe+QW
         Cf1vj196xU4Fw5XEdMPYCY6YibgaErv2x8tAAc9qf9olCBuGlD71KFvsIKYVxeiL4o
         HLezU6G/2L85A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] scripts/get_feat.pl: allow output the parsed
 file names
In-Reply-To: <20220326003050.50750c75@coco.lan>
References: <cover.1648216561.git.mchehab@kernel.org>
 <a924b46a80d750d808c28a27adffaa5d5a983e5c.1648216561.git.mchehab@kernel.org>
 <874k3lg7r3.fsf@meer.lwn.net> <20220326002109.2cda0402@coco.lan>
 <20220326003050.50750c75@coco.lan>
Date:   Fri, 25 Mar 2022 18:02:09 -0600
Message-ID: <874k3ld1j2.fsf@meer.lwn.net>
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

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> Btw, maybe we could replace them tree with a Sphinx comment, like:
>
> get_feat.pl:
> 	.. FILE <file_name>
> kernel-doc:
> 	.. LINE <line_number>
> get_abi.pl:
> 	.. FILE_LINE <file_name>:<line_number>
>
> (or something similar)
>
> Just let me know what you prefer and I can take care of the needed
> changes on this patch and, if it is the case, writing the extra patches
> in order to use the same model on kernel-doc and get_abi.pl.

If it were just me, I'd just put "FILE <name>" or something simple.

I don't really have a strong opinion on the matter though; it's not like
people have to actually look at these things.  I was mostly curious as
to why you'd done it that way.  I can take the original patches or any
of the variants above; just let me know which you like best and we'll
get this done.

Thanks,

jon
