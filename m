Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DD4B9483
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiBPX3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiBPX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:29:24 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB4715C9FA;
        Wed, 16 Feb 2022 15:29:11 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1487037D;
        Wed, 16 Feb 2022 23:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1487037D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645054151; bh=x0jr/JZmXqReG9uxmHayoCDQXBtMgWNxrKrxxmwZQW8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R1iSO/M776/7GQtJx/xIevc595pvzSxzaa1EntYMI0L0lw5SNWpFxkLGNbCArCEBK
         uWU3OcfwuiY51IKC2NYVP4GCpLFiNhrFS8TcA2JzO4B9kdiMZCGq5W02hy9EUsweD+
         SICN5fg2ZtyrZ9Rym04AqpdBj459Z6Zol4B9G3PAdxmbGT4FhyWM3NDuzv/Jy0d/Y2
         YSfe2ql14TI6DqlVtrwnzk6NHSTzUyrH5T+2+SnqHTdapKF736FQyWfDRrbDYJn28M
         E05r/5a+/OLC2ECXknFj0b61X5Ed4bBozJLNErt+/gsF2lkg795Yps92E++6YqvmAS
         gh6imBPKMa99A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/15] scripts: kernel-doc: Archive the pre-git museum
In-Reply-To: <20220104015946.529524-13-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-13-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:29:10 -0700
Message-ID: <87fsoi2xx5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> Jonathan Corbet suggested in a reply to my version 1, that these records
> can go, since that's what the git log is for. I don't agree.
>
> The log begins at 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2. That's from
> 2005. One of those entries is indeed logged, so kudos for having me check
> this. But not the older ones. Of course they can be found indirectly,
> but then...
>
> Why not just let them embellish the script tail?
>
> As you can see, they don't even require any formatting there.
>
> Are you sure you don't want them?

Do you really want this kind of stuff in the patch changelog for all
time?

Yes, I still believe that this information can go.  Why preserve a tiny
subset of a few small changes from over 20 years ago?  Just take it out,
please.=20

> * Transform documentation into POD (12/15)
> See step 1 for the series details.
>
> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)

Thanks,

jon
