Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA5583F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiG1NFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbiG1NFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:05:35 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776252DEB;
        Thu, 28 Jul 2022 06:05:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5A0BF6E2;
        Thu, 28 Jul 2022 13:05:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A0BF6E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1659013533; bh=Rn0/Mu+SAV+BNOe5JrY+OgsjZ+DlbTUQOY3Wh6DCw/k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m96c49tz3s79D6TTEd1k8GPvfm82e0IJVCx5NOOZMZU6J7Own9cLUVHxdRak8M9DO
         CH32YY5xjA+LWRctPVF5Esm+z6iKfpguO+jq+9iyx+EKhqjAvbZdhNR0Fn0XYk0QW9
         17sgW+HmEzs2kIPs6KwpvMrlhxpuM79G0nERz+2sLTXGTf+BaRslO+68jzF/h6/FwX
         MQkMWGK1DS1SAzg3k7y3W/PQUSTRenCH3dwHnC+wL4k3vs8Px6sBYKLxnyP8o4yrAm
         AMexj741a1aD2Pc589uhExlMa0J+GeZaeiS1d8k+dF0oRFtL8oTNLG+g9DebTkQOSu
         2UelDwQnk6vhA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Nicholas Piggin <npiggin@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] Documentation: use different label names for each
 arch's elf_hwcaps.rst
In-Reply-To: <20220728033332.27836-3-bagasdotme@gmail.com>
References: <20220727220050.549db613@canb.auug.org.au>
 <20220728033332.27836-3-bagasdotme@gmail.com>
Date:   Thu, 28 Jul 2022 07:05:32 -0600
Message-ID: <87y1wdcrqb.fsf@meer.lwn.net>
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

> Sphinx reported duplicate label warning:
>
> WARNING: duplicate label elf_hwcaps_index, other instance in Documentation/arm64/elf_hwcaps.rst
>
> The warning is caused by elf_hwcaps_index label name is already used for
> arm64 documentation, whileas powerpc use the same name.
>
> Disambiguate the label name for each architecture's documentation. While
> at it, also adjust original reference in translated documentation.
>
> Link: https://lore.kernel.org/linuxppc-dev/20220727220050.549db613@canb.auug.org.au/
> Fixes: 3df1ff42e69e91 ("powerpc: add documentation for HWCAPs")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/arm64/elf_hwcaps.rst                    | 2 +-
>  Documentation/powerpc/elf_hwcaps.rst                  | 2 +-
>  Documentation/translations/zh_CN/arm64/elf_hwcaps.rst | 2 +-
>  Documentation/translations/zh_TW/arm64/elf_hwcaps.rst | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

A better solution in cases like this is to just delete the label
entirely.  I'm not quite sure how we got started with this habit of
adding unneeded labels, but they just clutter up the text - and, as
we've seen, add warnings.

These labels aren't needed for anything, so I'd just take them out.

Thanks,

jon
