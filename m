Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7C4F133A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356949AbiDDKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbiDDKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:41:48 -0400
Received: from mx.msync.work (mx.msync.work [51.91.38.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C13CA76;
        Mon,  4 Apr 2022 03:39:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4965C3964D;
        Mon,  4 Apr 2022 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1649068790; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=K8y6f0ZyIOvwaXnDqPqMX/eCkxRTN6+lglp1GjSsoF0=;
        b=WbQ5fDISwpYYjCwTRN06a2PF9QC4E6eLyo2UaFMa1S3Rz8yBnghyulWkLF9hlcaPXLyG6U
        jYEJAVSgXcUx7gh6m+zS0IN3Djz/fVBzj5JHvNY0FfhbP5iq8vj5nNNQK/zhZFYrenOjlj
        FdeUu70vEO3hGdGidGVvRRtvXl9M423wkhaDE8wFc5fKIMjonbdN7FHDvPt5GxyVN8Qr3h
        eQqJnj49aH06xMEfPrWieUC5oaN0G+QBMpnfFtO9k0dLlkQyDOnlvxe1ViSuCeT6FyeL27
        eZ6o1NUdebQJt5Jj0+dm7Sz4cV2DVzbjUlDuZKYbp9vpU5YWQ2YXfvd3L9Wpeg==
Subject: Re: [PATCH v2 0/4] arm64: meson: update dts for JetHub devices
To:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220326075110.1462301-1-adeep@lexina.in>
 <164905930207.1797085.9678466232916244683.b4-ty@baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <d53b8c6f-6bc2-5445-c426-5409d324fac1@lexina.in>
Date:   Mon, 4 Apr 2022 13:39:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <164905930207.1797085.9678466232916244683.b4-ty@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.04.2022 11:01, Neil Armstrong wrote:
> Hi,
> 
> On Sat, 26 Mar 2022 10:51:06 +0300, Vyacheslav Bocharov wrote:
>> Update dts for JetHub H1:
>> - add bluetooth node for RTL8822CS uart port
>>
>> Update dts for JetHub D1:
>> - add ZigBee serial alias (ttyAML2) for backward compatibility
>> - update voltage regulators and SDIO config to match board's reference design
>> - update max freq for WiFi SDIO
>>
>> [...]
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

Thanks.

> 
> [1/4] arm64: meson: add dts bluetooth node for JetHub H1
>        https://git.kernel.org/amlogic/c/2bda08dfc501967a7a7bd6f77f04afef14dc7271
> [2/4] arm64: meson: dts: update serial alias in dts for JetHub D1
>        https://git.kernel.org/amlogic/c/cf94e26508ad411c2a618b00dfaae515affd0ca7
> [3/4] arm64: meson: update SDIO voltage in dts for JetHub D1
>        https://git.kernel.org/amlogic/c/81bbd2bd24a9ebac3871b293060df50445458c79
> [4/4] arm64: meson: update WiFi SDIO in dts for JetHub D1
>        https://git.kernel.org/amlogic/c/87a87657249316616138c103c2bdb7525c34d987
> 

