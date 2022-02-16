Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5D4B946B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiBPXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:19:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiBPXTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:19:36 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE11202042;
        Wed, 16 Feb 2022 15:19:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1E04784;
        Wed, 16 Feb 2022 23:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1E04784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645053563; bh=BjKzwzpyuKoxSEDcgkMpjZ1v/Lq8KvjA6wMXrC7GhMM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EKL4AvNNtt0JPzvPTyQ8I7ip0ygYXvddaeagyIOApTULhDGLRwNXXhDueRmJBZZjv
         FMxSHsajFIgSqeb87PF/udf/LaYBu/iZybmdD//0+lHglcT7gfuz/dH9k/AP5TNb2k
         k12veBMsi1etrdnkj/+yfaVA+M7vSRbJqwtG7XE3pIGB65Ysf99hGP+CRVskPuerua
         8yZ7WkWHlGK2CaKgZdqJ3iq6kzpbKOwjxIr4ztE09eIStQSQp/LQKeegfgrRBTG78V
         Sa3IEBizbBQ24Jd9n2ORVkSVB6f+M/+w/UX82dF9mKEnxzfk8WXV9C18MqmaPTjrsi
         FAYgnbm+oq7sA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/15] scripts: kernel-doc: Add the SYNOPSIS section
In-Reply-To: <20220104015946.529524-3-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-3-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:19:22 -0700
Message-ID: <87sfsi2ydh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> Rst-only options are grouped around rst, the rest is arranged
> as in the OPTIONS susections (yet to be translated into POD,
> check at the end of the series).

Again: *what* does *this* patch do, and *why*?  The above isn't be all
that illuminating to most readers.

> * Transform documentation into POD (2/15)
> See step 1 for the series details.

Don't put this kind of stuff into your changelogs, please.

> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Thanks,

jon
