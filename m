Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85134F105C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377848AbiDDH5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDDH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:57:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA083B036
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:55:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j12so5522313wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=V1icDH0sG8OaWddIUXR6PcbcxrUYjjWFhQsbuUZTX+Y=;
        b=Tw3MAAUiANAe0uEFzb9++dTXFe+Do+SLBajZ6hO83yFusQhBI65DjNmkWxisuJVsq7
         BskJzvKZ6ilqg5Tx+ek6w+kGGyqgESx5t0vylEG4O26RLL+Sh4/hfoPfHMAN+84kEtAB
         xsRZ4gD92u+kqt0g+YqgoduJ2QK1Dwjs3o69vsHON3rG4VGlB1HiqckgEwY1EDy/0gAz
         HMj9gHaym1LVcuKaDQHAuajwh+aAu/mLPZFNm2bLGiL6TTmv0Sq/XLqYp9/IK1Nqg5U5
         sEaoLFHTYq8vaapdwyafR8d82vvfOg8b0XKOMDTT9L4Yy6Pgi/FwM7/kCUHkIXUi9WnR
         g3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=V1icDH0sG8OaWddIUXR6PcbcxrUYjjWFhQsbuUZTX+Y=;
        b=UCHLhF6NR6Qf+78XuWNJFhp27DhDjCsNyxiK2KSZBXADSpn7vqeSROVqw7Cr3xlYw+
         SRUxe4cvI40HCHKbXapBaE8SirRgeLburBQkbehshQmxuenUPHLoX9AWYMNRvpSnbo8w
         0RVT2vA3i+c1jE+mWtVgeVkmGksznp22TfIbVqRIde/00i4/47bJS2F6WWiUjY8SWnvv
         OYZ9R7m4wtNVCfNeg477K3BnipXkfsJR7sq+sZS01BdootmsktGcDCAnPnW7St6silLk
         4sG16sadbiGpgg0gBG2LNskV5pN6pcA68UWzUzCiqUz9UMslOvHYRwyhZ+Iyn/1oYEsJ
         jVmQ==
X-Gm-Message-State: AOAM532MAv4q1T6erdwqgfu8qUMgP+2nyWjPvTnoGUJknQm2Eds6CoR6
        koCoiTW/Hml0XWdGVbpQHP/Evg==
X-Google-Smtp-Source: ABdhPJzE06u080NnA8O5JfsK+lkEqlZu8kMMgM12b40vEOScHUzhelvnKIPUV/Rqm0YUmqJQpWpySg==
X-Received: by 2002:a05:6000:10d1:b0:206:f55:8433 with SMTP id b17-20020a05600010d100b002060f558433mr3650798wrx.486.1649058943917;
        Mon, 04 Apr 2022 00:55:43 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:1add:1b28:2457:eb46? ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id s17-20020adfdb11000000b001f02d5fea43sm8846643wri.98.2022.04.04.00.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 00:55:43 -0700 (PDT)
Message-ID: <e3089ece-6ff3-0f6b-71ee-8b59ffad6119@baylibre.com>
Date:   Mon, 4 Apr 2022 09:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] arm64: meson: update dts for JetHub devices
Content-Language: en-US
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220326075110.1462301-1-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220326075110.1462301-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 08:51, Vyacheslav Bocharov wrote:
> Update dts for JetHub H1:
> - add bluetooth node for RTL8822CS uart port
> 
> Update dts for JetHub D1:
> - add ZigBee serial alias (ttyAML2) for backward compatibility
> - update voltage regulators and SDIO config to match board's reference design
> - update max freq for WiFi SDIO
> 
> Vyacheslav Bocharov (4):
>    arm64: meson: add dts bluetooth node for JetHub H1
>    arm64: meson: dts: update serial alias in dts for JetHub D1
>    arm64: meson: update SDIO voltage in dts for JetHub D1
>    arm64: meson: update WiFi SDIO in dts for JetHub D1
> 
>   .../amlogic/meson-axg-jethome-jethub-j100.dts    | 16 ++++++++++++----
>   .../meson-gxl-s905w-jethome-jethub-j80.dts       |  6 ++++++
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 

For whole set:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
