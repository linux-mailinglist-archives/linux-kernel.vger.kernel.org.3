Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81707481DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhL3PNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhL3PNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:13:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE2C061574;
        Thu, 30 Dec 2021 07:13:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso13478988wme.1;
        Thu, 30 Dec 2021 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BrOBt56bIUGwhax4+hkiSfB9eBwZpxmU8jWPncxv4xY=;
        b=mdcO0u7q512tAOfsTZd7cVP+9FoqU2UTTHPO+Yo/IGSV0jpo3V6ocoJcpfqVC+FqVq
         Y/R2IMnisigM9OZSRq5m8cMI7UyxCzpEuwJlZjzD5I47qKBijMd0cTgW8YdmGvwqGIgG
         LwR00rdl+w0+6VoEoFxks9NrghoH8gzJl2c9Dh3417RDCUfH9BARG/IJnJfzaTAntEg/
         CYUuZhMWbhoQqgpxKCsVWyAdkttIQD7uzWMV74baJmOu3o7+kEPwlbuTYOZNTQcs/XG3
         ICfmjodf46LaSnfOU3e9lZLYnTXzYhDprLDPs755K6R3tRfUNrteJoBN+1Tea/4Qukih
         upXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BrOBt56bIUGwhax4+hkiSfB9eBwZpxmU8jWPncxv4xY=;
        b=tsQ47yVVoRPoGF44vIIAr0q2FRgdCOWQ9LY8wnIOfFcT5AfQ3QR4qyVrRNHjy76s59
         8YOoiU57MXOh5JubV4o7JhsZBnnLkpZUG3kJ/gVFgL59NQgKTLZp7dAg2OFiIQfmJyw2
         VqUYzc++V+DQqKjNVRbVPsLiMQgzMZiMrklMOftN+rhXZGYQGLNMswXQwYtIYUSEeD+1
         aW/+WPcVsu0H0AMrLNhzAB1tOlpAW2X0fpO8/R1dF6Rl9JpA8HIbK1L0+pbESmhzlrOl
         JygDhNd+2tzpm/QqakARpwMgda+dW9lENOAX8ndfke5yTHLunxHoXCjuq+JZqYfFUMUZ
         P8vg==
X-Gm-Message-State: AOAM533ILkJTFWHgOK1OaVUKCqzbbMPkXt1vvz8G7cjPrbVyZ1JwORC9
        o8jYQ2R8NNSASH/X6RrDGvg=
X-Google-Smtp-Source: ABdhPJz6Ivr54shp46pcRY+QQqmJl5qUd/LY3TzF+V+pjZDP3U8afmIJ+avvhxp005UdEO/5axkTJw==
X-Received: by 2002:a1c:20c2:: with SMTP id g185mr26301905wmg.115.1640877192898;
        Thu, 30 Dec 2021 07:13:12 -0800 (PST)
Received: from [192.168.1.145] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id bg19sm2589127wmb.47.2021.12.30.07.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 07:13:12 -0800 (PST)
Message-ID: <fff75b65-51ab-cafd-a55f-137c0b7c2dc6@gmail.com>
Date:   Thu, 30 Dec 2021 16:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v20 0/7] soc: mediatek: SVS: introduce MTK SVS engine
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20210721070904.15636-1-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210721070904.15636-1-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 21/07/2021 09:08, Roger Lu wrote:
> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
> 3. SVS dts refers to reset controller [4] to help reset SVS HW.
> 
> #mt8183 SVS related patches
> [1] https://patchwork.kernel.org/patch/11193513/
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20201013102358.22588-2-michael.kao@mediatek.com/
> [3] https://patchwork.kernel.org/project/linux-mediatek/patch/20200306041345.259332-3-drinkcat@chromium.org/
> 

Comments made in v16 actually also hold for v20, so please take them into account :)

Regards,
Matthias
