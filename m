Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBAC598A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiHRRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbiHRRSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:18:04 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E56CE4AA;
        Thu, 18 Aug 2022 10:14:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D75CC4E5;
        Thu, 18 Aug 2022 17:14:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D75CC4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660842896; bh=vz4tknliPzmjSgyqWLAMoebgxNp6CQ3X1EAaFT00qbE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W3zo6+MV8r16bPNzSHfAWWQdBIq3+IbtdBgYH5UCPhY+NldadBlsRLIKNm+vXRRk2
         wVxxd/q+Cj9R0Nj/GF+6go/KIg4UvA5mC08TtnbgKTrcdAseTazA96YHzttQj9RgAx
         PAdkd/SkUkeJdj2NCwrBHJ8UkWOjQ88Ak7voz81DlmL+vgu3DDgmZBeFnf73HiQjvd
         L3/K590LaPHJWycQUhzs4/xxfb3zejkArZb7riqjM1FpMeswbzxuQxCKQ2LVw/Kx3i
         3fdScgSCZi6YnkY/7PnZwS79afGvRYazQFYAFNIjdaBJXpyWbLWCdd/w54DkzkqKuT
         Q8bDHNssEj5mQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Update the maintainer PGP guide
In-Reply-To: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
References: <20220727-docs-pgp-guide-v2-0-e3e6954affb6@linuxfoundation.org>
Date:   Thu, 18 Aug 2022 11:14:55 -0600
Message-ID: <871qtdcw34.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> This series updates the guide to match terminology used in the upstream
> "protecting code integrity" guide and brings the documentation in line
> with the latest developments in the GnuPG world:
>
> - uses "Certify key" instead of "master key" terms to remove common
>   confusion that the "Certify key" is somehow able to restore lost
>   private subkeys
> - removes keyserver instructions because keyservers have largely gone
>   semi-extinct due to GDPR enforcement and just general neglect
> - adds a link to the kernel.org PGP keyring documentation
> - updates information about ECC curve support among the devices the
>   guide talks about (Yubikeys are able to use ED25519 curves with the
>   latest firmware updates)
> - adds a section on using PGP-signed patches with b4 and patatt
>
> Link: https://github.com/lfit/itpol/blob/master/protecting-code-integrity.md
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>
> ---
> Changes in v2:
> - Rebase on v5.19.
> - Small wording changes based on feedback.
> - Link to v1: https://lore.kernel.org/r/20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org

I've applied the set, thanks.

jon
