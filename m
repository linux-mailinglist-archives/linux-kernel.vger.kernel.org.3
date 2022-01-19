Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C203D493B45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354874AbiASNmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354866AbiASNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:42:43 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12CC06161C;
        Wed, 19 Jan 2022 05:42:42 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s30so9525872lfo.7;
        Wed, 19 Jan 2022 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RFoP38eLaOsvnxogD9Qkh5mjAkTPDMJZd+M3tQJRSyk=;
        b=GzXssFFl5DJZKrhIO2MxP1rd/eFsi+LQcnYJ82aSX9iEMUFj4/SpvuSKO9Wms0ggLc
         rHz33mnpoYtclqktD/qYbYfZKyOw67V2pIDLueGETdZrmzCVhyzWrENb6ydwGwOU5ALC
         lnDYruce/5VJe+HDkP0suNwiBfGj1EpCEARPabZf5eVRGpOZjhFVH01y+okYCBtiFwPx
         cxiKLTLCV1+J8X2qCCB+zVpUOsEYLvceTOosCI58TyoDp5n1jyPU79aYsflPuaQ4q51J
         le35K9dxFEzpL/PHhSOI0qNQQsQGTwQLX53ndw6mEEQ72K8n1fEKwmSpIoMW2idRzQu3
         Xb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RFoP38eLaOsvnxogD9Qkh5mjAkTPDMJZd+M3tQJRSyk=;
        b=BN4Eittt9q5hzHxYBxZGUw75aAoMEHqMnuKWu6N4ODeDEG2zCHaJXAPJubf2QGAknb
         dq5wbH4hUOpta1EOzA+sJzIR/1V7DD5uhVne1rITb/I+GAV00ubhxpMbeyDgeGr1e9N2
         UtL+QVvEoJRO7huu8P/xO/I07qDE+DgzoUuTuodZ+e60I7/4d5ysWPLcPA7PijzBRx8Z
         Y5yTd4Wxe3iJviaj8lgpRCKUKND2JFPmviwvRVMkbO2kDQjIqjJEB1ECoKpCHYeulTuu
         xaNxj5R29Oa+lXOwNQ0ArKTYPsrxCvUwpQRPexkbhWHgw6ovnzHYCFtummo5fjBAZcUY
         F5BQ==
X-Gm-Message-State: AOAM533e7ndONp2Si6eOHsjD2Fvl2kT4+WFhYRxaKlkFoPOlFREeFz7B
        6Ufq/yhphL7QXNMknjgUE+0=
X-Google-Smtp-Source: ABdhPJzL4vtMoSbuEEvBGCPN9LbOIJ97rDyX7FUAFKFHQqUi9ayqYxVQV2rUV1hRDk03Ww5qjxINsQ==
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr24947346lji.381.1642599761064;
        Wed, 19 Jan 2022 05:42:41 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id v4sm293193ljh.109.2022.01.19.05.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 05:42:40 -0800 (PST)
Message-ID: <e249668b-a847-f6c8-e90c-6a6c30c16311@gmail.com>
Date:   Wed, 19 Jan 2022 16:42:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
 <0b584dfd-04f6-d7f7-f08a-003b89e557f5@gmail.com>
 <b250e2f5-b095-3767-519d-40e42e0a832b@gmail.com>
 <89f20af4-de3a-01be-baff-014bcca9df82@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <89f20af4-de3a-01be-baff-014bcca9df82@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.01.2022 12:09, Ashish Mhetre пишет:
> 
> 
> On 1/12/2022 4:54 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 12.01.2022 14:22, Dmitry Osipenko пишет:
>>> 11.01.2022 21:45, Ashish Mhetre пишет:
>>>>   #define MC_INT_DECERR_ROUTE_SANITY                  BIT(20)
>>>>   #define MC_INT_WCAM_ERR                                     BIT(19)
>>>>   #define MC_INT_SCRUB_ECC_WR_ACK                             BIT(18)
>>>
>>> I don't see where these errors are handled in the code. Is documentation
>>> that explains these bits publicly available?
>>>
> MC_INT_DECERR_ROUTE_SANITY is supposed to be part a of Tegra194
> interrupts. I have missed adding it and will update in next version.
> MC_INT_WCAM_ERR is a MC channel error and is not applicable in upstream.
> I'll remove it.
> These bits are defined in same documentation where other errors are
> defined.

Is this documentation publicly available? I only have access to the
public TRM that can be downloaded from the NVIDIA website and there are
no register sets there for newer SoCs, AFAICS. If TRM was updated and
now contains registers, then I'll try to get the latest version.
