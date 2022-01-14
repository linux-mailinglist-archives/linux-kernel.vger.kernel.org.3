Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27A48EA31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiANM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiANM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:56:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46BBC061574;
        Fri, 14 Jan 2022 04:56:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q8so15417056wra.12;
        Fri, 14 Jan 2022 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d3ibwPAPVt4HA/SbrQ1xEvUJPH+rbcSyYMnJxKURgvY=;
        b=fb5npDbIVbXCAmGa3aSg1k8zmuohBbb7KypbIegherNH93fveoZq8HcfrgdsuNvXz8
         CDw9aC3OJl/FCnBGvwgMykySe9jqF3hjX6uVUTPOGTork74gr4LptbeOXg08D4FANiN4
         m8uPEJXzq0ezfHyXFI8iPMWd6idfe7hf+JY5QpD66LC7d0MXsfE9Ghd81R/poIn9XgZa
         aZ+6o7lhptWt3VmwrOFdjmES0DdKYFnKYEFl7Y2Pbve5Qp/2x9SlYO4Y1AM7Ejq6Mgvg
         hzG7CLkkWKgGMP6j+arp8RUt0N9V2cVDdsz3waJaB/vNQgiuNQ/ZWDdROzQuPi0Ykuxa
         0+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d3ibwPAPVt4HA/SbrQ1xEvUJPH+rbcSyYMnJxKURgvY=;
        b=B4qwT0JApZS/1hhtfGUGbKf5jMf2sIi1SxsGflGuswSBRRsB8cHHOYMjCSKONLMNkQ
         vET3ZENKOfQMoPt3u/wur7/vzYorC3Z0sWVv+VWAbvbKkLXRtyC0Vwxk08gGw+cWMzPK
         uHJLM12w+nVFoCld0to6+Mo8HA8kUtyxZ489IK4vGMkYyumu+/9VtUWmjL4G9c0Fdr0M
         8TfL1JeKOcuf4vKE7ZAInw1S/hsEHkQ19RW0Y0CsvYm2hQ4oYBVJkxiVjCIQ74IvxlIx
         fc4COnHoVwrKVaIfleLPtvX/eMh7TdYMJLWEIIw50dyjwrkm+L7up/BYmS8MVtn8A8AD
         ob8w==
X-Gm-Message-State: AOAM532Vs2cn5DyJfG0xqztQnVGpaIWvefjvha8oV8dd+EO9cqDEw5cv
        XvUM+I/mU+CU/fkokBoMiec=
X-Google-Smtp-Source: ABdhPJxo8QEjs5Q0X+ZWAwcHSYac8AQTrcqIp/pFDeME41NkNSzQHoy2PCkOg4lwKdONf8ZqSIFXjA==
X-Received: by 2002:a5d:6dd1:: with SMTP id d17mr8741857wrz.520.1642164973553;
        Fri, 14 Jan 2022 04:56:13 -0800 (PST)
Received: from [192.168.0.22] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id g15sm5358083wrm.2.2022.01.14.04.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 04:56:13 -0800 (PST)
Message-ID: <68895a40-559b-13ce-d433-f9b32c648323@gmail.com>
Date:   Fri, 14 Jan 2022 13:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, YC Hung <yc.hung@mediatek.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        cezary.rojewski@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com
References: <20220106064847.15588-1-yc.hung@mediatek.com>
 <Yd4yNkeGlzdULNlv@robh.at.kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <Yd4yNkeGlzdULNlv@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2022 02:43, Rob Herring wrote:
> On Thu, 06 Jan 2022 14:48:48 +0800, YC Hung wrote:
>> From: "YC Hung" <yc.hung@mediatek.com>
>>
>> This patch adds mt8195 dsp document. The dsp is used for Sound Open
>> Firmware driver node. It includes registers,  clocks, memory regions,
>> and mailbox for dsp.
>>
>> Signed-off-by: yc.hung <yc.hung@mediatek.com>
>> ---
>> Changes since v3:
>>    Fix patch v3 error : v3 only provide difference between v3 and v2.
>>
>> Changes since v2:
>>    Remove useless watchdog interrupt.
>>    Add commit message more detail description.
>>
>> Changes since v1:
>>    Rename yaml file name as mediatek,mt8195-dsp.yaml
>>    Refine descriptions for mailbox, memory-region and drop unused labels
>>    in examples.
>> ---
>>   .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 105 ++++++++++++++++++
>>   1 file changed, 105 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Rob, it seems we don't have a maintainer for this bindings. Shall I as MediaTek 
SoC maintainer take them through my branch?

Regards,
Matthias
