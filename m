Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4C5A5240
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiH2QxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiH2Qw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:52:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D9844F9;
        Mon, 29 Aug 2022 09:52:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5FB2A4B7;
        Mon, 29 Aug 2022 16:52:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5FB2A4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661791973; bh=xTH9KyS5LJBn19Dets90OIhRtmg7YbU8Y/2aZtbm8u4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RHj/C1dJui91Js0c61jNGOINfXlFVoEJB885XYZQZYsjuvTnN3jLSzoPRfiwLY624
         XAFuu52tnFwkhnoUgN1A5B0jqbJyL7lY8aA6JCbkIBVXBeu1SYLPE/jvHho0CBj3zY
         Qf+Kz0U51pxUgcMQAPpYarcr3OsuFb7loIvwip6JH6qN5btZTXKB6wULOJzNsREi5K
         m636ReQmXekiZIx9hMPa1MktqYMqDGiinm4Bjgd4HZ/zSacRcujhDbGQ/SvhLQ/XW+
         JdoaVf4tATOtqzuJKhMLdBmyPjM0iLxJs9SFXugnc7/aYbEyU1x6QZW2nuqiRYb/Nb
         t+Z1f9tzIyF4g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 0/2] docs: conf.py: Reduce texlive dependency
In-Reply-To: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
Date:   Mon, 29 Aug 2022 10:52:52 -0600
Message-ID: <87ilmbouu3.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi,
>
> This is v3 which addresses Jon's comments to v2 [1], but slightly
> different ways from Jon's suggestions.
>
> Changes since v2 [1]:
>  - Drop Patch 3/3, which is in docs-fixes now.
>  - Patch 1/2:
>      o Simplify find_command() by using shutil.which(). For guessing
>        available commands, it should be good enough.
>      o Mention find_command() in the changelog.
>  - Patch 2/2:
>      o Instead of silently ignoring unknown setting of SPHINX_IMGMATH,
>        print a warning msg.
>
> Acked-bys from Mauro are kept, as I assume these changes wouldn't
> affect the purpose of each patch.
>
> Changes since v1 [2]:
>  - Patch 2/3: Rename LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro).
>  - For the series: Acked-bys from Mauro.

Set applied, thanks.  I did make one change to patch 1, see my reply
there.

jon
