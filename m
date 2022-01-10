Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA00648992D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiAJNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiAJNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:03:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159AC0611FF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:01:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so1452508wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJEMyTSL01yzwyzBH1ogq1RDgA7lqAGH2WXcdzLGgjo=;
        b=KuZAXZ3ZWP8qIfuAbD36Zgtco5ENapO7WysQBN72KNU/8/BG1U2Mmkp7kz5JzXw1h4
         7kKeaj81XNLwaybFvBgCk5A+GEDd0y82Itp6RYah/xvFxMYrslBZELHGwM0KCFNCirpD
         Iq+xnMELOpHDfZRAVvgwfGfx2gNO+xj4F1XbF8c35iqvcR0SJneFup4QsrLRtvVFlLVX
         IYJd1HdGfEiARGg2FaMpI6mdfSMGXLkM+glHg5yo9LRltnZjvWkuqfAa5qSNlT3JnCe9
         7tm/sd75DC/QtPLNd+tfU/qdG6sfK1OKOacsct3GZoKSG5VEN0zQcSZK19O2PIin8nBi
         g4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VJEMyTSL01yzwyzBH1ogq1RDgA7lqAGH2WXcdzLGgjo=;
        b=sJz6r2Nis6elNkefsS5q6bjRVlM35CUejVXK4E778WI+to8RLoshfzAFaL1rEybmAb
         r9MtjYeha0dlktxWS9ZEL8shLt68FN3LktFuGHFPEWqLPnvSm60asU2gLofWzfIc11sw
         JO/NFcRYTIvRnxFl+71kMaTPDK4mYWwfnyJYmknLI9Y7w4V2h4m/RgqkSwL/woReTw9Z
         EQOreUi822fwcS1i55ZtA4r8/2DlABCOZB6dw5j4zygJ1qbKyX9AXpMC8wELiknc/mfC
         Lr1lw/QAIhcYo0icPExXbJ9gHNicEswjczEpS4Bu4GpFB1ERMJgWADew9Jiqmiq5KkDp
         UJwA==
X-Gm-Message-State: AOAM5319yYB2sCWNDVvu0jdMyrU1DpY/WCSPZRG1QCL96zaPvfF5pJMW
        S8aPvEjVRE59GbTStElrqgml23bE2bXXcg==
X-Google-Smtp-Source: ABdhPJxoccRH+KX27a/eLPTTXByrJgo/z+jQlyAzLsIRsJcCmZV3LChVjnKha1NAc/+h3HDFi05wHg==
X-Received: by 2002:a05:600c:21cf:: with SMTP id x15mr2545054wmj.8.1641819691598;
        Mon, 10 Jan 2022 05:01:31 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1? ([2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1])
        by smtp.gmail.com with ESMTPSA id k19sm6384673wmo.29.2022.01.10.05.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 05:01:31 -0800 (PST)
Subject: Re: [PATCH v3 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220107150512.614423-1-narmstrong@baylibre.com>
 <20220107150512.614423-3-narmstrong@baylibre.com>
 <CAFBinCC9J_w9JM-TmrXp7SXT27V7Ze37wrxHZZQ1==N4y2-0dg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3f7f1c95-8a16-cb74-3a99-3f67404424db@baylibre.com>
Date:   Mon, 10 Jan 2022 14:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCC9J_w9JM-TmrXp7SXT27V7Ze37wrxHZZQ1==N4y2-0dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/01/2022 23:09, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jan 7, 2022 at 4:06 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +#define HHI_MIPI_CNTL2 0x08
>> +#define                HHI_MIPI_CNTL2_DIF_TX_CTL1      GENMASK(31, 16)
>> +#define                HHI_MIPI_CNTL2_CH_EN            GENMASK(15, 11)
>> +#define                HHI_MIPI_CNTL2_DIF_TX_CTL0      GENMASK(10, 0)
>> +
>> +#define DSI_LANE_0                             BIT(4)
>> +#define DSI_LANE_1                             BIT(3)
>> +#define DSI_LANE_CLK                           BIT(2)
>> +#define DSI_LANE_2                             BIT(1)
>> +#define DSI_LANE_3                             BIT(0)
> At first I thought that these should be named
> HHI_MIPI_CNTL2_DSI_LANE_0 (and similar).
> But then I understood that they aren't bits directly in HHI_MIPI_CNTL2
> but they belong to HHI_MIPI_CNTL2_CH_EN.
> Have you considered naming them for example
> HHI_MIPI_CNTL2_CH_EN_DSI_LANE_0 to make this more clear?
> 
> [...]
>> +       if (IS_ERR(map)) {
>> +               dev_err(dev,
>> +                       "failed to get HHI regmap\n");
>> +               return PTR_ERR(map);
> I suggest using:
>   return dev_err_probe(dev, PTR_ERR(map), "failed to get HHI regmap\n");
> to simplify the code
> 
> [...]
>> +       if (IS_ERR(priv->phy)) {
>> +               ret = PTR_ERR(priv->phy);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "failed to create PHY\n");
>> +               return ret;
> and similar here:
>   return dev_err_probe(dev, PTR_ERR(priv->phy), "failed to create PHY\n");
> 
> [...]
>> +static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
>> +       {
>> +               .compatible = "amlogic,g12a-mipi-dphy-analog",
>> +       },
>> +       { },
> In the past I was suggested to use:
>   { /* sentinel */ }
> meaning: no trailing comma here so nobody can add entries after the
> sentinel by accident.
> I suggest doing the same here if you re-spin this series.

Yep, will do the changes,

Thanks,
Neil

> 
> 
> Thank you!
> Martin
> 

