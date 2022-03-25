Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFC4E7B45
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiCYTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCYTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:16:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882671D4C12;
        Fri, 25 Mar 2022 11:57:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so17196899ejb.0;
        Fri, 25 Mar 2022 11:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T3ZMNixaLJElkzcw1+eEB0m28rN9ABVv9LlORr52Gis=;
        b=PNMCGyzqdZkskLEoMdE9Gtua770PVsvcZuEPgyfaD2as7q6DITIzIfqsQJ1YxrtZkG
         CJvEf9K4Awr1A8bhyRAlYNNQYiBpcz0dM2pRqahByiv598O/i1W54oSs/EzHs/nyHEDR
         3BfMPU9AzsqkDaY8FWg1DsDVNCNK+LdBfsTASUGL+vPoJ/vQzfnXczfeBzZKnWI+/TA/
         doeehD0nCXCnkykiP/jO+wCTO7Ff+LawTP+Ov7sDaulmYYqj/4VOoczn8bmr3V9nkRRu
         4fv4/dYY6wOBgpEKVDQ+bpFVHMheYfL+IO3Dr4f6fNTFzjU72GyoAPx+vRA0HmT5ssPq
         u0Pw==
X-Gm-Message-State: AOAM531BnUsfvxTUNJp53tfZ0UH9C9ljjZj1wbGWVMuqLhtrrXJWPMPQ
        u82bPpBx+vHKQCL9WEUFYN6W8uYbAkal2A==
X-Google-Smtp-Source: ABdhPJxzhvYxQoq+OEFG3ywwQ643UpdmE/aW2fDwOBXfrMtLACv55jBSXSPboOkX/8x59n4J/6WaDQ==
X-Received: by 2002:a17:907:2dac:b0:6db:e1e8:c66f with SMTP id gt44-20020a1709072dac00b006dbe1e8c66fmr12992334ejc.382.1648230362374;
        Fri, 25 Mar 2022 10:46:02 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id bd12-20020a056402206c00b00418c9bf71cbsm3079365edb.68.2022.03.25.10.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:46:01 -0700 (PDT)
Message-ID: <5f864d33-3370-7a1b-d796-908ff49d3e3b@kernel.org>
Date:   Fri, 25 Mar 2022 18:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
References: <20220325171511.23493-1-granquet@baylibre.com>
 <20220325171511.23493-2-granquet@baylibre.com>
 <8baedbe6-eb60-02b4-a6b8-fe3abc566335@kernel.org>
 <CABnWg9s3vmpCFFai_BMjagqHehk2vbP0ST_tfWvOxmtubPm14g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CABnWg9s3vmpCFFai_BMjagqHehk2vbP0ST_tfWvOxmtubPm14g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 18:43, Guillaume Ranquet wrote:
> On Fri, 25 Mar 2022 18:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 25/03/2022 18:14, Guillaume Ranquet wrote:
>>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>>
>>> DP_INTF is similar to DPI but does not have the exact same feature set
>>> or register layouts.
>>>
>>> DP_INTF is the sink of the display pipeline that is connected to the
>>> DisplayPort controller and encoder unit. It takes the same clocks as
>>> DPI.
>>>
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> This is v1, how did you get Rob's review already?
>>
> 
> Because this is not v1... I'm not really good at this... 

Don't worry, I made many more mistakes...

> this is actually v9...
> I just didn't pay attention enough before sending the series.
> 
> What's the standard thing to do? resend with the proper versionning?

Yes, please resend as v1 with cover-letter containing changelog. Anyway
someone might scream that you spam his box (immediate resends are also
not welcomed), but what to do. :)


Best regards,
Krzysztof
