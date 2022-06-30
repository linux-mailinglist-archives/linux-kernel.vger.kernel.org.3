Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2DC5621F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiF3SYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiF3SYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:24:32 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97541300;
        Thu, 30 Jun 2022 11:24:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B8AA94B7;
        Thu, 30 Jun 2022 18:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B8AA94B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656613471; bh=p/sWzyhrbkyk3TRdT7vX/Awfp+eVJD1AxPUZppQmEIM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P1PHD5SLDmyl1ngcjr+v51mhMSfhc5mMQHhOHvrzgdih/mj8ibjeYtWYu+eGqLIK/
         PUD8Dm/OlwfONr2fz/d1nghdnDE3LlBdtsN52huJcCxSYLf49JJAt3puGi2cWKt36N
         OXSqY7tXtOlnCsEkC909W4qXpf1snhEHgT0k9IdAAc62hYB3fYFodRuZ197M7IoOq9
         OaDa/zAJFE9DiBymksvAsfhPPlwR3YPYrmnevfjx0tlGO2RDQ54SYAdpbBaQvrcnJw
         4C4ljxx0zWlif5My3+RcAU0CfDobO21BpG+ldNhGUMExMJYKs0KisuDU/rcnCRibpv
         SPRboqbnKM7cg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] docs/doc-guide: Mention make variable SPHINXDIRS
In-Reply-To: <50d6f0bc-030d-9529-0665-e2b3e7c792d8@gmail.com>
References: <50d6f0bc-030d-9529-0665-e2b3e7c792d8@gmail.com>
Date:   Thu, 30 Jun 2022 12:24:31 -0600
Message-ID: <87czeqnh5s.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> SPHINXDIRS is useful when you want to test build only those
> documents affected by your changes.
>
> Mention it in the "Sphinx Build" section.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> v1 -> v2:
>   - Added command example (Jon)
>
> v1: https://lore.kernel.org/r/ff89c064-e24a-0f2f-fc03-b029e5d04338@gmail.com/
> --
>  Documentation/doc-guide/sphinx.rst | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

jon
