Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE54F0859
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355487AbiDCH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbiDCHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:55:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA013D33
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:54:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c7so10147871wrd.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hcg+mFW30TpS9ncd0QGFAXAUah810Bk4ErrwSl9XyqI=;
        b=K880O8XxgSHTelqrRmX8SMOKPgP8wUaymPxJDrjQIfgI6E4bJCemXnyxi4JX+Pkpsx
         Cakyoq/kvNcpGuTnD9zKFpvZ4ze370N0TbiyKkyr/MzNxVNlWcOw2MlWUa2MxEAmAC2o
         mGCVDzM4bSXBn7w3hC9kwzhG+uzKlrbJJv24DTKtky61FLOOJGJcynsPxrNaV+nZOvXD
         2qrGF37Cs+3M1A9FkjU15n3JrNFSh9gyYn75etdlQ+rDKABimXzPurIPjWNwNh9QgGNf
         sgNFhUmUdB2SgkCKq6ySPKMB2NkjBcsy8dbfTaUX52w/v/9TlhO1oc45Rg+rDXsvweY+
         Ux3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hcg+mFW30TpS9ncd0QGFAXAUah810Bk4ErrwSl9XyqI=;
        b=zRdFnmcoOrzJfDbcAgSp1k8HyNaGB9jzzm4azqcUicoKlGhXzT1E2sydkf/f4BMI22
         4vcmS+EbuH4sDmxQug4YTohYDBCIv55xS4bAyPYf+HRGx/9U0izkU6z70pQN1Nu9MHPl
         aQhh3zsnYHoGvBu1hp4U71sDlXg/PfBorHTWMAKWnFDJ42YB9H+8pQ1gpKvTLvFy/gGw
         Vog72alVC7eu7VraRe4QORCwHNxaqbtNMvB8tfk9p6ogK1oKe21QzRctruAi+MusnF8k
         Aep3LIUgzUjgwodtYQ/+HjYKK8gnnlrPlDYZdVV347w2HWvm6o9BjcDbomKhy/r3SH0i
         7jxg==
X-Gm-Message-State: AOAM53203QcgUHWzB5slNhSmz56wK8MeF45/3ozji40EhIdwFT2Yb+xr
        hSZWHXdpxv/wdAekI4YDQK55OA==
X-Google-Smtp-Source: ABdhPJzzv+kEom3eImDklP+9lgt/iyEES94WNz/z5HnICtbB/q1/k3LL/Mf65ZUrpXs81k3wfQOQiQ==
X-Received: by 2002:adf:f442:0:b0:203:e0ef:32c9 with SMTP id f2-20020adff442000000b00203e0ef32c9mr13484943wrp.53.1648972441113;
        Sun, 03 Apr 2022 00:54:01 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm2687763wmp.14.2022.04.03.00.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 00:54:00 -0700 (PDT)
Message-ID: <943dd39c-f92e-0323-c263-65b8a03124fc@linaro.org>
Date:   Sun, 3 Apr 2022 09:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] ARM: dts: BCM5301X: Fix compatible strings for
 BCM53012 and BCM53016 SoC
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20220402204622.3360-1-arinc.unal@arinc9.com>
 <20220402204622.3360-3-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402204622.3360-3-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 22:46, Arınç ÜNAL wrote:
> Fix compatible strings for devicetrees using the BCM53012 and BCM53016 SoC.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  arch/arm/boot/dts/bcm53016-meraki-mr32.dts | 2 +-
>  arch/arm/boot/dts/bcm953012er.dts          | 2 +-
>  arch/arm/boot/dts/bcm953012hr.dts          | 2 +-
>  arch/arm/boot/dts/bcm953012k.dts           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
