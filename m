Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347614AB03B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiBFPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbiBFPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:33:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AAEC043186;
        Sun,  6 Feb 2022 07:33:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a28so22289222lfl.7;
        Sun, 06 Feb 2022 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6F01PnczbrUYfTRctqtn61JQbTq7gsQBhYH7gPh6Rpo=;
        b=kSWtgXpR8vcXGYds9wDRllqdjzlAnXUh4PDUmL+UWIlg6z0kzaOOorC9iX553e7Dsd
         M3YhK93xouyhYzgvbPrS8uzEUUKyQw+YXwA5aZww3GsGKmthBYRu208JMhR+DnQRGXbI
         0vEAMVjf+XpYhNfvg7KzgyuHueqFXBUsi+pHPC0wCQWs/b2NSMgn4TvBLk7BzeATu/bl
         fGD8gGIbHwzHN7aVxxf3TV9StuO+/vlbDSdZL/QgETHOFXZmfoshf96QAvsfxiTOh8sb
         Oxiox2/1PwHMOURbYWT2ILD9HIs2ViUq6PkbcDJy0NMswk3yoxOx0IpU2TyBzBlsWo6a
         YUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6F01PnczbrUYfTRctqtn61JQbTq7gsQBhYH7gPh6Rpo=;
        b=SgUlFaF8fNyBNbun8LI2/Ic3s9a4ItuxhjRetTiDUUWJX8CBrMlAisXLdkR+2x1hNI
         P2j4G/7RikaCWriHnZy4Krb+yismYpdlGiBKlVWtwej+lMlYT+PxCB+Agv2D3Mts4XPY
         cfF3Q4ZEkclBYydZrW8va33bN6ClfTruArH4E0qYnIPh4l4SDfoVbsB2w6l14+3HkTG7
         XrB4OqQ4O0Deqi6DC53tXknA0kF22bNeI/L1gDoqwTIuzmxpQNcj4s8c+fFwOKnfMBID
         xq078IwgPU6tazrm1BRDoX33KJ4LQ/E1k67ZzJR10hD2lPODjJ7ywYf9MTDVh+ctEm02
         /MSA==
X-Gm-Message-State: AOAM533xARUrjorZhMHtpWDjH95t9xO59SKQjfxpGf8ec3uB3ajtS2IB
        OUt5AhPueuLJfHwOVuAbWGQ=
X-Google-Smtp-Source: ABdhPJxCjyU/CqNALMre+lFkD8yQrWpNqHsWCnQTBUMmfiwVTrlMrXGbM0uI+i7NE4vJHyK/z9hPxg==
X-Received: by 2002:a05:6512:128f:: with SMTP id u15mr5740844lfs.359.1644161604464;
        Sun, 06 Feb 2022 07:33:24 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id q10sm1130758lfn.296.2022.02.06.07.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 07:33:24 -0800 (PST)
Message-ID: <685aa09e-fa57-e082-a0e3-d385292101e6@gmail.com>
Date:   Sun, 6 Feb 2022 18:33:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 6/8] dt-bindings: memory: lpddr3: deprecate passing
 timings frequency as unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
 <20220206135807.211767-7-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220206135807.211767-7-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2022 16:58, Krzysztof Kozlowski пишет:
> The timings node maximum frequency was passed as an unit address, which
> is actually a workaround.  Such workaround and unit address are not
> needed at all, because the device memory node (parent) can contain
> multiple timing nodes without unit addresses but with suffix used for
> nodenames, e.g. timings-1.
> 
> LPDDR2 bindings already use such version, so unify the LPDDR3 with them.
> 
> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../ddr/jedec,lpddr3-timings.yaml                | 16 ++++++++++------
>  .../memory-controllers/ddr/jedec,lpddr3.yaml     | 12 +++++-------
>  2 files changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

