Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC24DBA70
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiCPV7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbiCPV7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:59:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D717E3E;
        Wed, 16 Mar 2022 14:58:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 018072CD;
        Wed, 16 Mar 2022 21:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 018072CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647467908; bh=mkEu1wloGTkm0xeCjB+YLUuIuUcxOva+qbVOTd2bpF0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mOAmTmWkyrimqb3IewjMj4VU6pEAU+P6v6BLdUgvZQ6sgE7KR4wIludswKJ6erqWr
         54+RDW02ZuDJvjKxfSec4BFmLerifdIXBooPSM114KOSpQhlJbIHre9ctqkGmlkzEz
         8oHtAlO2OzUCq7v18QH3Cnl2QzmeaCggcbF5aqs+dD0a8Jk5mA1ZnPILd6mGljNlzL
         LIzMLVvZMsbA5aNmnrSA/8c8eSM0OWRM9FTIQSU1dz4FyifPhNQyJAWfbX3zVjT5iE
         KcThg0Thdv4UyCCY/9c45M2j09yCi9vlmsEsOTRUIQiFPuoSvUS8g/WuCiOl9iR8hP
         +gIilHaNs7mPA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mike Rapport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/kernel-parameters: update description of mem=
In-Reply-To: <20220310082736.1346366-1-rppt@kernel.org>
References: <20220310082736.1346366-1-rppt@kernel.org>
Date:   Wed, 16 Mar 2022 15:58:27 -0600
Message-ID: <877d8tsgos.fsf@meer.lwn.net>
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

Mike Rapoport <rppt@kernel.org> writes:

> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The existing description of mem= does not cover all the cases and
> differences between how architectures treat it.
>
> Extend the description to match the code.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> v2: https://lore.kernel.org/all/20220309172258.1183796-1-rppt@kernel.org
> * move Hexagon description to make it better visible
>
> v1: https://lore.kernel.org/all/20220309122446.1118738-1-rppt@kernel.org
> * drop clumsy and redundant paragraph about Hexagon
>  .../admin-guide/kernel-parameters.txt          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

jon
