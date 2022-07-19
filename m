Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00C8579780
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiGSKSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiGSKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:18:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3722A736
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:18:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o7so23946532lfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yhp40Fa8dIbWLUYQgUZLu34l1mYT1p2F4FG3i88o/a0=;
        b=YdB/5QY2IMSi4iu67sdHg01+fHyTTjIyNd++A0oIojzG3sOw+aBnKPPjGgWO3gaTEN
         E0VfXsbXzmmM4D3sY3iX+Ka7B85t/7bdOidi41PqOSY3LeCTV1ASF4GKkBLxE0v43QuS
         a3N+TYhsAA3gibWJPyG/WX+JpgH+2ef6K60J/Mil2twm8R/IrB/d3w+jyjIhdjbyw85p
         Vn/beV7b6XNf80Y8MU9L5TkeiByD7U3ICjNYiN+CGn4XQDItCIkRAoWw2y7oeMW/N/Fu
         bZPaoeENUcZxdcAuJSCeLi4uKX+3FKvAXItS/QSIX7S/4Y1HJy3n7F7LxUWumnVVSqr5
         veOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yhp40Fa8dIbWLUYQgUZLu34l1mYT1p2F4FG3i88o/a0=;
        b=Eq5RYBMs8nlhyD/CkFtsbT5mtKRv+t+IUu4XWkUzBW9sf9x/SPnFJ8Of7Zy+Tu2/rZ
         veKieVESlZDN/lDON4gtPurTol4yufmaJkCOK5Z6aJLwYWQkm9RHUfMfrwp0F1SwTc2H
         9OvddMOn+PdL6G07ceEL4nMDPcD2a2BrSYwIfI41wAPxGV3msB8Wdj+mTE8cMmeKIFrn
         CwBfnKqB7WmrC9EAbmZi6sahzFVa2JnB8FxyCTrSo3gbLTPGd676nD/p50yDG7oEmSIf
         BvwHMDaEDEgT6Kc1KJ96wPUw0o9WXAKYE+z7e2XPlFj4xjlzB+2TrugzdP3MY3neJARE
         TzZg==
X-Gm-Message-State: AJIora97hUdCpM/9EJgjyGsBbPh71ehStqFHKnGseyTM5cPdb8sRYkMR
        SG6UFuUiJXDzodLZwLv3pj9ghw==
X-Google-Smtp-Source: AGRyM1s8HgTuaZJ6SpD6cl0+QVA5btQeNUibFBZWLlyB0luN//n9+1IhA3B2PQI+96AApneuoLUUpw==
X-Received: by 2002:a05:6512:12c2:b0:489:c921:552e with SMTP id p2-20020a05651212c200b00489c921552emr18510784lfg.391.1658225927362;
        Tue, 19 Jul 2022 03:18:47 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e2c0a000000b0025d70efeaaasm2606935ljs.75.2022.07.19.03.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:18:46 -0700 (PDT)
Message-ID: <895e7df5-65e5-7b26-81d6-864e68957ab6@linaro.org>
Date:   Tue, 19 Jul 2022 12:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: Add device trees for MSC SM2S-IMX8PLUS SoM
 and carrier board
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220718152310.1937899-1-martyn.welch@collabora.com>
 <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
 <YtaEUvP4jpO5Dggg@gaggiata.pivistrello.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YtaEUvP4jpO5Dggg@gaggiata.pivistrello.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 12:15, Francesco Dolcini wrote:
> Hello Krzysztof,
> 
> On Tue, Jul 19, 2022 at 12:01:34PM +0200, Krzysztof Kozlowski wrote:
>> On 18/07/2022 17:23, Martyn Welch wrote:
>>> +	tca6424: gpio@22 {
>>> +		compatible = "ti,tca6424";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_tca6424>;
>>> +		reg = <0x22>;
>>
>> compatible, then reg, then all other properties. This applies everywhere.
> 
> Is this documented somewhere? It would be easier to enable new people to
> contribute, if it was.

Unfortunately it's not documented. It's a common practice - most
popular, but of course you will find other examples. There is reasoning
behind - compatible is the most important property. Reg is useful to
have at the top as it must match unit address.

> Anyway, I would add to this list status as last, when present, 

Yes, this as well in some trees is recommended/enforced although not
documented.

> and I do
> try to order alphabetically all the other properties.
Best regards,
Krzysztof
