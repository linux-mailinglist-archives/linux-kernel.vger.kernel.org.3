Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE2512CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiD1HfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244304AbiD1HfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:35:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8095737B1;
        Thu, 28 Apr 2022 00:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B513B82BA4;
        Thu, 28 Apr 2022 07:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD42C385A9;
        Thu, 28 Apr 2022 07:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651131123;
        bh=XLtOpv4/Sq+8xO6mEwHDHtd/e3eoMaYDFgGPCnxXZik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ptaDwG49gImhjARf3ApqvC9GLBPNvMKTtXJchzByR5gtugmQ5RtaG4+wkY9yjZqmV
         s2F3r1z1whNISkFKnuVd8YnRSaeSzUHgvrUwMX+yu/hJHLgMO2cbaLjZK/w0RpbAFU
         WweJ4L1so4Oyvir2A3uD0QxM1K3/1vWyCwG2L3I6qq4UDUkevb/25RtG6YEtNO6GGG
         fNhnSO2hTvHHD8b1J3oFbTamiZfDcg3zPMWFtP1nRALhJQgeGspI45PnFtyuxPBxDI
         /h3wVQ4d9AoUhhLsIGEwY18GQJsMBqe+h09sh/XNssXX6a+LQ08VaUhePQE9PIGgt6
         5nssVoPHASBYQ==
Message-ID: <fa113ba0-1221-de93-a18f-e4e942cdb261@kernel.org>
Date:   Thu, 28 Apr 2022 09:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
 <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
 <20220428012941.GF145620@ubuntu>
 <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
 <20220428063634.GF151827@ubuntu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220428063634.GF151827@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 08:36, Jung Daehwan wrote:
>>
>> Since you called everything here as "exynos" it is specific to one
>> hardware and not-reusable on anything else. How can then you use some
>> other compatible? It would be a misuse of Devicetree bindings.
>>
> 
> I got it. Let me add them. Is it still necessary if it is only used by
> other module on runtime as I said above?

Except what Greg wrote, if by "other module" you mean out-of-tree, then
the patchset will not be accepted as it is unusable for Linux users.
Basically it would be a dead code in Linux kernel.

Best regards,
Krzysztof
