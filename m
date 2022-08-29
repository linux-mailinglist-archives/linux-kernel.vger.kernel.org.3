Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD765A4817
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiH2LFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiH2LE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:04:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EE6567C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:03:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b5so9693004wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CpaB3ddJEDe584NFMiOKZhHWMRiirLWO36hNiUSRyEA=;
        b=MtFVRnlqvFCDp/2JPEM0WuYX9z4sAWXEySwkIEslskyWcWEwk7GwF7mPD8fnNCuka5
         iZsdTIYsIIz0dJ8SR8H3+W0Q6U7aWML84pUi/t1/GkczgGtm/ASEyvZ2GqlwN6IemqCg
         MEjwVu9pVjKpjdvaJBfkTI7vFEwtZe2OI9fpO0fPVHxlBbX6Ddw149ocyNxFAAYF+FEz
         PBuog2YOfo9a95u4PxujzJ1yrwRpOqEXasge7p1iHCzFhINUeq8JLdF9iyBrK5/GboTo
         +tKXTmep6l6NiakYLuT6k6P7ypdoPHTjvVyi6ADq0r6CGPvaUmuemFRpTkivQXXe2ksn
         M2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CpaB3ddJEDe584NFMiOKZhHWMRiirLWO36hNiUSRyEA=;
        b=N5TC2PbKwvaUiDWdhQbE2zqR8ZMlSXy7B8vdTw/nS0dRdi/82f3VoiiFAVpUkHdRNt
         x3V1hCtI4N9qBXgmyiaIVIqcZAbuS7SExpx1P80E/pbr7JrkZNZQrrChk+9V4cDaEhVc
         4SKfDoz/LWf0pBe++jW/3f+Xdhn1ESzuA4+bTM9vMzIo36+4W/48jTKHEczHJTIOh22r
         6vKyxyTjD6FCnDU5t6Bc63gs+hVhLpmGYuwhJQS1hYVoHH4jICOiACU7BPZeAFWrcXJY
         g9d9Dx+GefTaz+33l1fkdplud4cupWk6bnkdZJOFqpDaLoEkdOhTgrW1ZaZYttjuSq2z
         4Ekg==
X-Gm-Message-State: ACgBeo1c1TTNqwbct4KBQWHCnMpjgtrxk0IEMoEenUJc30XxDIaLzozX
        wM9NMvLDnOqwCXgSWoqdwgA=
X-Google-Smtp-Source: AA6agR6JDbKTJ7JqVUrNRRhnLjrcMSZrxoyQmDSWVWy3eJl6CWzFTpZag8RsDca0Ng4LaNIvdXqZhA==
X-Received: by 2002:a05:6000:2cc:b0:225:6e25:a9f4 with SMTP id o12-20020a05600002cc00b002256e25a9f4mr6255619wry.330.1661770973922;
        Mon, 29 Aug 2022 04:02:53 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0021f15514e7fsm8078909wrc.0.2022.08.29.04.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:02:52 -0700 (PDT)
Message-ID: <2629f8ed-9ca5-3b37-3025-85262e5fe848@gmail.com>
Date:   Mon, 29 Aug 2022 13:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 6/6] soc: mediatek: mtk-svs: Use bitfield access macros
 where possible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-7-angelogioacchino.delregno@collabora.com>
 <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
 <5ef83611-1649-c86b-abd8-dff617993580@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <5ef83611-1649-c86b-abd8-dff617993580@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On 29/08/2022 11:33, AngeloGioacchino Del Regno wrote:
> Il 25/08/22 15:29, Matthias Brugger ha scritto:
>>
>>
>> On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
>>> In order to enhance readability and safety during registers setup
>>> and value retrieval, redefine a few register related macros and
>>> convert all open-coded instances of bitfield setting/retrieval
>>> to use the FIELD_PREP() and FIELD_GET() macros.
>>> While at it, some macros were renamed to further enhance readability.
>>>
>>> This commit brings no functional changes.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>
>> Does not apply, would you mind to resend together with 1/6? Thanks!
>>
> 
> Hey Matthias,
> 
> thanks for picking the ones that applied cleanly in the meanwhile.
> 
> I'll rebase this and 1/6 as soon as I can!
> 

Nicolas did it already and both of them should be part of Linux next. Let me 
know if there is anything missing.

Regards,
Matthias
