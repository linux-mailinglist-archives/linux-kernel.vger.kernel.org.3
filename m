Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59D50677D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbiDSJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiDSJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:15:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1620BD9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:13:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 21so20465277edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rgi3jG3IzfFk/97rZZxdzXA8E6nwdIahpnGwkXRZ4y4=;
        b=R1TcrZ2RTC5pmzPgZI7aB8wTgTWhEWpZOOjfnnq7xYjPdQaybMCKhSvV5dDA8DI5h3
         rr0PlQR8qMWMMK1DRZ95cbEnBdxJjgkZUv0msmH2BKLYGc6w2r0NeM3jBKfdp52S9nCl
         A4rU1+4LhycdRF8KHn2KiqaczAUjM1Ptz3X9YqcG0lq5EHIs3NQDJqgaCRAHkHuzcV6U
         Tt43ayianfVHmEa5yFDIHrPCbHO20Ol3lC8XNBFWRQRQrpqUgJduL1mTS63tkg01Hqhf
         BiA3wPAJ3Bs6kVfPFDhz41/97+K9gufsiAAPXsxvsVSzQWK21dO3wtQ1aK/X3S1d9Etu
         LA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rgi3jG3IzfFk/97rZZxdzXA8E6nwdIahpnGwkXRZ4y4=;
        b=NXhPt6PUnNP7PA8Jx74s47CP9nvP5RGepk/DNJNrwLbRMWXVJxGHLD2IOwouwkf7/Q
         CGS+TvIqE8m+mjLL7xlmrFLu73RCSB9wPvCTSFvTOwFvE9QPbokXuGQTl9pPXFeKg85Q
         N9zyHrUul+xXP4fjgHTRQyngEwDINBMN+UbdMenDOW1IP9+cSaJKaIxwxS61r8tTxZFy
         7Ag6cJon00cKs0/WVkwte6XW3ETWrlfz7U7su8Fttzyy5kyWg78ZBPbjoMq+XShi+4ZW
         SmfGZnbhrwQ/HeQ9YlfSovMvDO/katRra1ROncM12YwwSuiujZxDbVy9eQpl8ZRwdfrl
         GaWQ==
X-Gm-Message-State: AOAM530A93TVMSZik9f8fsRwk1w4xVnoSjbMrIHuPSHRjDtXjX7L1j0d
        Im0H6v5tgsIxw6ccpn8QBntJmA==
X-Google-Smtp-Source: ABdhPJyuIVtA+uctlp9lLBFQpEOpgNfJfDW1L9ykM3qXhzLTfUxYzGOiHkJ2xPJAhqiqol9vRmoCgQ==
X-Received: by 2002:aa7:dc49:0:b0:41d:72e2:d34e with SMTP id g9-20020aa7dc49000000b0041d72e2d34emr16100008edu.385.1650359580300;
        Tue, 19 Apr 2022 02:13:00 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bm6-20020a170906c04600b006e89a5f5b8fsm5498890ejb.153.2022.04.19.02.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:12:59 -0700 (PDT)
Message-ID: <60955707-aabc-5313-aeb9-d65453538de0@linaro.org>
Date:   Tue, 19 Apr 2022 11:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
Content-Language: en-US
To:     Jun Li <jun.li@nxp.com>
Cc:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
 <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <3dafc432-849b-0a78-f3dd-954d88c74a61@linaro.org>
 <VI1PR04MB433336414971E5EB6F4BAA8389F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB433336414971E5EB6F4BAA8389F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 10:51, Jun Li wrote:
> My test config is making USB_ROLE_SWITCH=m, but PTN5150=y
> 
> So with below header file: 
> 
> #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
> void usb_role_switch_put(struct usb_role_switch *sw);
> #else
> static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
> #endif
> 
> Will have link error.

Yep, true. I cannot remember the solution for that... With the select
you cannot disable USB_ROLE_SWITCH. With "depends on X || depends on
!X", one still cannot disable USB_ROLE_SWITCH. However this is a common
problem and I am pretty sure people were working on this. :)

Best regards,
Krzysztof
