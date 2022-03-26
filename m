Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA094E7FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiCZHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCZHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:44:16 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2001:41d0:d:357f:aaaa::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98D2BB03;
        Sat, 26 Mar 2022 00:42:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 279FD33E13;
        Sat, 26 Mar 2022 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648280558; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=GdswsmakIGiG00f5bOpw3wFaYlXB/0e6UaDzcr3aGeY=;
        b=NnewmZU6MUqVXZuiCiGX+6fi1CF7H3F2Ymci/0vR4FHIebuRQpXLn4ugT8Pjkb6a7jMeei
        AKF0sCpysLxTtoMyvadOdTPJuKB8OkBdICEbVESkNFnEnPe+pWVQe6L8FUT/zdhHE3H4OG
        /sGgxr7us4P0fUW/hDXAuaN1Tilbn9qlISHaahk7sWT21y+jtTsWmbVx14PJQCzSJ88c/0
        FhUZvVITSzeXmTzPm0ydy1YApSPWuCoD9goW6ofQCncGQkNC0FWW9r/nxX4IfwrauSKF+o
        xVZF9Dzlt93rDfJ40yyQsMdfPfduAyPgHAw19S7z8g7x37NQThJLchcQNXEq8w==
Message-ID: <b5205abb-745f-933e-bd36-53c8aa168f3f@lexina.in>
Date:   Sat, 26 Mar 2022 10:42:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/3] arm64: meson: update dts for JetHub devices
Content-Language: ru
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220325165501.81551-1-adeep@lexina.in>
 <394573e1-0786-75ef-65fa-4b75d57714f2@baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <394573e1-0786-75ef-65fa-4b75d57714f2@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



25.03.2022 20:34, Neil Armstrong wrote:
> Hi,
> 
> On 25/03/2022 17:54, Vyacheslav Bocharov wrote:
>> Update dts for JetHub H1:
>> - add bluetooth node for RTL8822CS uart port
>>
>> Update dts for JetHub D1:
>> - add ZigBee serial alias (ttyAML2) for backward compatibility
>> - update voltage regulators and SDIO config to match board's reference 
>> design
>>
>> Vyacheslav Bocharov (3):
>>    arm64: meson: add to dts for JetHub H1 bluetooth node
>>    arm64: meson: dts: update dts for JetHub D1
>>    arm64: meson: fix sdio in dts for JetHub D1
>>
>>   .../amlogic/meson-axg-jethome-jethub-j100.dts   | 17 +++++++++++++----
>>   .../meson-gxl-s905w-jethome-jethub-j80.dts      |  5 +++++
>>   2 files changed, 18 insertions(+), 4 deletions(-)
>>
> 
> Can you add Fixes: tag in all patches so they get backported ?
Bluetooth node update depends on commit 
b050c5bbbbccfb9e6cbf29c8ee7a41c1bba972bdf (Bluetooth: btrtl: Add support 
for RTL8822C hci_ver 0x08), which seems to appear only in 5.18
The rest are cosmetic changes, not affecting the functionality.
Thanks.

