Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CA47629D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhLOUH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:07:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225DDC061574;
        Wed, 15 Dec 2021 12:07:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i22so10360549wrb.13;
        Wed, 15 Dec 2021 12:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oTn6F/PIAxnH+UUMVbLCa+GN5bx695vAjTKoG7Ye+2E=;
        b=oMuBZtHIiqvQNXpXdmtvUQ8UMMr78otbfRGC/T5p0ykoai8NoJvMeesDuQc1wf9TGM
         OI70nVBFLs6kAfBpxH9pWTGppzcvJ4UgdWM9KZCJQpkmUm0VGcQ2y8EPpVPZEwKqnWgh
         09YCCrzEtBR84kMRniJJx5mP4rXXgniLElS8TfWB5btaZCZhs5wVu5FZIAAUnchXtv1z
         x1q9RX68uZTDVZvsiDOFoSkrBSzFL/7h9liRMgbWlUV2g2JkTF1FSgSn7mYXHyReXbNU
         hEp6S7iijVxWJDk8i61HnEaKmrDYqYNUKnC03LenwpRs03105N0fCLj7OkRxIeWemdEO
         BvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oTn6F/PIAxnH+UUMVbLCa+GN5bx695vAjTKoG7Ye+2E=;
        b=H470w64CMZoufPD+Jw7Nb5Nm+9Jo/D6UtReF0PlGnFP/ku496OoxlF6+uYbR9t25or
         myfJcALI4uKKTcDpZFvTl+58HFhEFPsNMihr2Swt/05JAPMs/5/3qhTKaSaXe2S7IoVq
         yIesBEN650fmArIe9x9nKNG0ypldLsV+gNg6vL95/VEVzcAtUGwuYikD2a7ldsLjTM5b
         ODeXKDo8ivO0sKoE67a+wbDNq1F8BYCt6OIydBhLkwkwUu0YmhahpjfoPnMokyaeMmyV
         jODsdH5MInaMRcA4GzVw5/dPkBA8JxPms1r1GKS1bN3bgQaLefi10wTtp81TmjehUrEB
         3Qhg==
X-Gm-Message-State: AOAM5319o3O0I7TqwDDfOASHEInP/pL6EV/BdXbO9Ld5iFJ3Z0wGpV+b
        4n2YDptYSfKoX5fJBTG6HVo=
X-Google-Smtp-Source: ABdhPJwVi4hkIGkh1pKRl5zQ8zACxwyQBSVxBuqIW0mpYf3U1qDV8ItlCRvWYLk6zKoTd5G//sk0qg==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr6084386wry.279.1639598843675;
        Wed, 15 Dec 2021 12:07:23 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
        by smtp.gmail.com with ESMTPSA id q14sm72140wro.58.2021.12.15.12.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 12:07:23 -0800 (PST)
Message-ID: <48fe0cfc-9bad-f20d-9b02-05ce3987e56d@gmail.com>
Date:   Wed, 15 Dec 2021 21:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v10 0/2] Mediatek MT7986 pinctrl support
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
References: <20211122123552.8218-1-sam.shih@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211122123552.8218-1-sam.shih@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2021 13:35, Sam Shih wrote:
> This patch series add pinctrl support for mediatek mt7986 SoC series.
> It is based on patch series "Add basic SoC support for mediatek mt7986"
> https://lore.kernel.org/all/20211122123222.8016-1-sam.shih@mediatek.com/
> 
> This patch series base on the following patches
> https://lore.kernel.org/all/20211022124036.5291-2-sam.shih@mediatek.com/
> https://lore.kernel.org/all/20211022124036.5291-3-sam.shih@mediatek.com/
> that have been applied to the pin control tree
> 

Whole series applied to v5.16-next/dts64

Thanks!

> ---
> v10: used mt7986b.dtsi to include mt7986a.dtsi to reduce duplicate dts nodes
> v9: added Acked-by and Reviewed-by tag
> v8: fixed uart node in yaml dts example
> v7: separate pinctrl part into a single patch series
> 
> According to the maintainer’s suggestion, this patch splits the previous
> thread into independent patch series.
> This patch include clock driver and device tree update
> 
> Original thread:
> https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/
> ---
> 
> Sam Shih (2):
>    arm64: dts: mediatek: add pinctrl support for mt7986a
>    arm64: dts: mediatek: add pinctrl support for mt7986b
> 
>   arch/arm64/boot/dts/mediatek/Makefile        |  1 +
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 20 ++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 21 ++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 29 ++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b.dtsi    | 12 ++++++++
>   5 files changed, 83 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986b.dtsi
> 
