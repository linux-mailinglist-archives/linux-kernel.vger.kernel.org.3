Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029555D98F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiF1GxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiF1Gw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C527177
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 273A3B818E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4FCC3411D;
        Tue, 28 Jun 2022 06:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656399174;
        bh=8BdKnYm+8/G8IpAtA8VZn+iUBFg8g3/Pte7FOTwoErQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ee+IzWmTw3EvQOwZn1SgNNcNNp3j65bZaHIKLzc5KazvB+Man4H/1KmitXuRAs3o0
         rSErC7oRdVVEFYEG+JoLJiNkjpfHmtFHf+sqbCuX3cbihPa7Lo0WA8fDhx3C+Su65B
         qcOeXTSicUGAvxiGXAHCTEqmHvXHRjg12FtzwLfu1NRC2M3RGaDzCDYWp8oO1tC87c
         Kl2PI9uj7l1ltGKRYJJn/mieMYxWs9Udstb7YRjcjtOLaCqY/EYTIWymS8B+WPq+9i
         P3p19sekQ2HfbvI1kSUmlLC7h1ZMJSQ84NC5AyPdkSrnIm0KHc1oxQ3Zkfl/JgGgkW
         T0+a6N4nvhvXg==
Message-ID: <75ae8819-a02e-420a-fe29-33ed280104c5@kernel.org>
Date:   Tue, 28 Jun 2022 08:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAH2r5ms_jsG7KpPzYyF3jnW+O3c191fR-nY+GT51hDa6b4tb3g@mail.gmail.com>
 <81ecf8cfb0e0e0338b60c64251d9e1d3@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <81ecf8cfb0e0e0338b60c64251d9e1d3@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 18:33, Michael Walle wrote:
> Am 2022-06-26 22:59, schrieb Steve French:
>>> Mails to Charles get an auto reply, that he is no longer working at
>>> Eff'Innov technologies. Drop the entry and mark the driver as 
>>> orphaned.
>>
>> The Documentation file for this driver
>> (Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml) lists a
>> second maintainer:
>>       Krzysztof Kozlowski <krzk@kernel.org>
>>
>> Should the maintainer entry for this driver in the MAINTAINERS file be
>> changed to him?

Please keep the discussion as response to original patch, not some
trimmed/changed address lists.

> 
> I'm not sure, Krzysztof is the overall maintainer of the NFC subsystem.
> Krzysztof?

No, don't add me. That does not make sense.

> 
> In any case, the state should be changed from Supported to either
> Maintained or Orphan.
> 
> But I guess, Charles non-functional email should also be removed from 
> the
> device tree binding.

Yeah, you missed his other email...

Best regards,
Krzysztof
