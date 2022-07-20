Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E657BF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiGTVTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:19:17 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F123152;
        Wed, 20 Jul 2022 14:19:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 92EEE2B0;
        Wed, 20 Jul 2022 21:19:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 92EEE2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658351956; bh=LmYxArYWHdnbHw4VAuZTMP618eo0OL5FzSkSWrD2b5s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HmFCJj51JstREUz496rEFb3/DD56IGLqL09z0tnz3sxistfCGysh+D5p48DLBC8Pi
         F3dPfdFzyvcalVpO2xsuGRX0ZTzOpDQnXRXdSxFCh6X6ysGSDigdChQR9qRT3Yilo/
         j+liXDsOyRZq3WzCUeRhUj2VOEg6R2RNfPK0LtdaWoAXVIB7ICVU7kSgPfCLZxbxTk
         zHhLsk+KGobcsPEhDNzSK/l3g5gz+wduVCni+dyhi//7E8PHxAEOx/oKhRpRHOej6Q
         KDhk/R0KY9hgiqvl3du9TtOCecNDcFlLTz7miWy9gxUMOQghNpydmb8yRiP4V4UOFs
         hzn2r/5MbNVEg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sotir Danailov <sndanailov@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, rdunlap@infradead.org,
        Sotir Danailov <sndanailov@gmail.com>
Subject: Re: [PATCH v3] Documentation: process: Update email client
 instructions for Thunderbird
In-Reply-To: <20220715211307.9358-1-sndanailov@gmail.com>
References: <20220715211307.9358-1-sndanailov@gmail.com>
Date:   Wed, 20 Jul 2022 15:19:15 -0600
Message-ID: <878rono52k.fsf@meer.lwn.net>
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

Sotir Danailov <sndanailov@gmail.com> writes:

> The instructions don't match with the current Thunderbird interface.
> Clarification on using external extensions.
> New information on how to avoid writing HTML emails.
> Tell user to restart Thunderbird after modifications.
>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
> ---
> Changelog since v2:
>  - tell user to restart Thunderbird after modifications
>  - unnecessary comment on older versions for "External Editor"
>
> Changelog since v1:
>  - better external extensions explanation
>  - information on avoiding HTML emails
>
> v2: https://lore.kernel.org/linux-doc/20220714131152.12709-1-sndanailov@gmail.com/
> v1: https://lore.kernel.org/linux-doc/20220713225037.1201-1-sndanailov@gmail.com/
>
>  Documentation/process/email-clients.rst | 69 +++++++++++++++++--------
>  1 file changed, 47 insertions(+), 22 deletions(-)

Applied, thanks.

jon
