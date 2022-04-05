Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C604F4A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454233AbiDEWiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457471AbiDEQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1A3BA47;
        Tue,  5 Apr 2022 08:50:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35:2589:2a93:190d:b787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1B761608;
        Tue,  5 Apr 2022 15:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1B761608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649173820; bh=7+lervbpy6gXxeBrivEVunvIrUU2KhGTP2hBrxL/QTA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pCL0S9JpbndAJVkCNAkIKwDxISi6nnxklloexQ6eeoGjdVbCYbUcS2nMV1GpRvtu6
         9NQ0lkceS1cH5tCqvEs/MOTgPSGrtE/fhm9G/sdeNbUoH6dv+wSeuUolH/qe3QCeZc
         BGUIdIJR1dCJDXfeI3ecF9FM4J1yizFYN59Iixc4w6h1r6XGEoaCDoRx6+2dgdtpr4
         HSyGRMADKpho8RVLVzR71/bG5fT0y0P0QzF/IUdgqI0K153OheSBzrRR0wL0+8ZYtI
         5LUw4JAVkkPjZs7rzKwZfgjh2zF0RYX3KTXhpc/6XrHLGjD/uwVbPUBWuG0WyoOPJl
         5XRazNzgYMahA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        dlatypov@google.com, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Subject: Re: [PATCH v3 1/2] Documentation: dev-tools: Add a section for
 static analysis tools
In-Reply-To: <YkWaL26K7UjKB0sa@marsc.168.1.7>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
 <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
 <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
 <YkWaL26K7UjKB0sa@marsc.168.1.7>
Date:   Tue, 05 Apr 2022 09:50:19 -0600
Message-ID: <87y20jedhg.fsf@meer.lwn.net>
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

Marcelo Schmitt <marcelo.schmitt1@gmail.com> writes:

> On 03/31, Dongliang Mu wrote:

>> Should we include static analysis tools based on LLVM? For example,
>> Clang static analysis.
>
> I think that would be a good addition. I haven't checked out Clang tools
> though, so it would take me a bit more time to write something about that.

That seems like a good topic for a future patch.  Meanwhile I've applied
this series, thanks.

jon
