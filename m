Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DF4D05AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiCGRtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244585AbiCGRtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:49:31 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053E939F5;
        Mon,  7 Mar 2022 09:48:31 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5F3EE2C3;
        Mon,  7 Mar 2022 17:48:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F3EE2C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646675311; bh=nG8bioloexPV0uQBiGpnPlCzaIq18VDDplzszFtnHoM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L2P4yjw65HHbc7Sfu8M1LYIkSQcFYO2v4eOEuciZ6Bp4xyVlnPZ18+h2rUiAz9ooK
         yu40hKVBvCreGdLiq3nXXKhY2zsDiBzWbPFrnhJOI5foe1488IN9vhgtEw5Wy1r6w+
         5QfFajlWnSXQeVJ/S20i6Eu3ZfXpSl4eUlXumGWmslgUszUpZ5pxosYehT1PvqB4CF
         LA4JYHLGmGfx20UvLX2ZAUqbrdsfhwppRoF8FNctBDOT/nBe+4CbNARHwARIGANbyd
         TsjlBDxtrsEv9Vhcr14zwYTX2RJY2dExmEoFRJ1aKitwZ3whXOnxO5biceaR/TXkme
         jYXXx1dkwGy9Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Clayton Whitelaw <cawhitelaw@google.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     rostedt@goodmis.org, Clayton Whitelaw <cawhitelaw@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/process: Replace broken link with snapshot
In-Reply-To: <20220307174301.1852106-1-cawhitelaw@google.com>
References: <20220307174301.1852106-1-cawhitelaw@google.com>
Date:   Mon, 07 Mar 2022 10:48:30 -0700
Message-ID: <87o82hd575.fsf@meer.lwn.net>
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

Clayton Whitelaw <cawhitelaw@google.com> writes:

> The link is for the reference article, "The perfect patch":
> https://www.ozlabs.org/~akpm/stuff/tpp.txt
>
> This link is down currently and apparently since at least 2022 Jan:
> https://web.archive.org/web/20220112192643/https://www.ozlabs.org/~akpm/stuff/tpp.txt
>
> Replace with most recent good snapshot, from 2021 Oct

We can do that, but first maybe we should ask Andrew (CC'd) whether he
has a copy up somewhere that we can link to?

Thanks,

jon
