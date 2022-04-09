Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB6B4FA6D9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbiDIKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiDIKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:47:59 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Apr 2022 03:45:50 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5954E205CB;
        Sat,  9 Apr 2022 03:45:48 -0700 (PDT)
Message-ID: <ba60121a-a120-b717-6a2f-7883685d17e6@manjaro.org>
Date:   Sat, 9 Apr 2022 12:40:08 +0200
MIME-Version: 1.0
Subject: Re: Aw: Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Content-Language: da-DK
To:     Frank Wunderlich <frank-w@public-files.de>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220409075147.136187-1-linux@fw-web.de>
 <trinity-71c38625-1a00-47d7-8e23-4f33f25a997a-1649499268581@3c-app-gmx-bap35>
 <9183927.T7Z3S40VBb@phil>
 <trinity-8384790e-d2aa-4041-b4e9-aba1130d8577-1649500371045@3c-app-gmx-bap35>
From:   Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <trinity-8384790e-d2aa-4041-b4e9-aba1130d8577-1649500371045@3c-app-gmx-bap35>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 09.04.2022 kl. 12.32 skrev Frank Wunderlich:
>> Gesendet: Samstag, 09. April 2022 um 12:23 Uhr
>> Von: "Heiko Stuebner" <heiko@sntech.de>
>
>> ok, so do you want to send a v2 including that change?
>> Alternatively I can also add this change when applying.
> imho the best way will be that peter includes my patch in his
>
> "arm64: dts: rockchip: add rk356x dwc3 usb3 nodes"
>
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220408151237.3165046-4-pgwipeout@gmail.com/
>
> i just posted the fix for those who want to test his series on 5.18 including himself.
So the issue is only with usb 3 ports, not usb 2 ports?
>
> but of course if this is not the right way, i post a v2.
>
>> Also for educational purposes, the format for referencing a commit
>> you're fixing would be
>>
>> Fixes: 33fb697ec7e5 ("usb: dwc3: Get clocks individually")
>> Signed-off-by: ....
> as the patch not really broke current mainline state, i thought Fixes-tag is not right.
> Imho only the rk356x-usb-patch is not compatible with 5.18 due to this change, but this is not applied yet.
>
> regards Frank
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
