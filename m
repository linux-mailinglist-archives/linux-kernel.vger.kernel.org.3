Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB094C8694
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiCAIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCAIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:34:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1174831212;
        Tue,  1 Mar 2022 00:33:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e10so1620153wro.13;
        Tue, 01 Mar 2022 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FrB0xiqh0R3+CodGDBFzoTSka3oB+8cQkeH+HR2pscY=;
        b=ZItHWuNisDbCn4VCnfN3PKVkjPdVF+MoXs5DozzoMvhf0aBhvosMiy0km1eXBhToT1
         /gqZUncEzz3+2DTwVKa0q/mmyxYDKZe6vXnFF3nsKB3kiCVqr+rosbRkcwwYFHh3M3ZO
         HX/Z4f94DWdBgpEK2BmHXDdDTXZtOgMKyaoY12Wss61GWovvyVUOZ8si/c13Fw37Exrm
         nTxnJ6Z8+a0eDuu6M9aoBhw8xwlFhVco65Rr3XzWuIS8ScASDU9FRtNMmbwH/e6+zFK5
         poNZRAsJfWPm046gB+BIDgJ939FLnBgl5lQ7R5A2qJMxs4IITyMfMHKYukPlWKC2yVSO
         bkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FrB0xiqh0R3+CodGDBFzoTSka3oB+8cQkeH+HR2pscY=;
        b=J9JEwu7Mu2j8d+jRA1zguSBphH+i/ncHjaa2MLJV0XpDWwWFLDI/ZM8ZnLdN/lwXCq
         JlYT8rZpiICeWaL53q+9/YbFK9KDRmAOC0cMpvfe4HeKv6mD5nRkawhyy96eSt/9YbRc
         jnh9qbs7VbXILRTt8FC5NxtDt3eltz0xzsDtKd9nP4u/bhY3vwQLc2zf9Hix4ZKMaIHL
         iA5f9qqJxxABeM8ny3zSW7b3v1jX7MDTmVs8IrIlFiguddI6Hu9NjjOiDVXpC3ZA8Hgt
         BX/9/1IumHEksA/3G3OlWEtICIRJwfGDlsOb4KakOP7s9zfZd2EfkLKwHYjkVAcR2RH4
         TlUQ==
X-Gm-Message-State: AOAM53081xjaxNc4O0b+WQiVolLzg0LdZ9xxk4eT7YXU2diN1i1WLYeC
        jcDoUvPm8yttNAYQ+TrdRlRLsF3xP6ApwQ==
X-Google-Smtp-Source: ABdhPJwbWC+RcE86K4AHZ/JXpplW/TP2HIkLpzmuGhlduFpPsZSLMAwwvijlKgZkmiRctKd58ozcKQ==
X-Received: by 2002:adf:9141:0:b0:1e3:1379:4cc6 with SMTP id j59-20020adf9141000000b001e313794cc6mr19398453wrj.249.1646123631557;
        Tue, 01 Mar 2022 00:33:51 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b00381753c67a8sm1919606wmq.26.2022.03.01.00.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:33:51 -0800 (PST)
Message-ID: <d229ad74-b530-af2b-2e01-a60e525186d4@gmail.com>
Date:   Tue, 1 Mar 2022 08:30:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v6 3/3] arm64: dts: mt8183: add jpeg enc node for mt8183
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
References: <20211206130425.184420-1-hsinyi@chromium.org>
 <20211206130425.184420-3-hsinyi@chromium.org>
 <aa54361f-6a8f-a616-640a-b9a098d82cba@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <aa54361f-6a8f-a616-640a-b9a098d82cba@collabora.com>
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



On 17/02/2022 10:41, AngeloGioacchino Del Regno wrote:
> Il 06/12/21 14:04, Hsin-Yi Wang ha scritto:
>> From: Maoguang Meng <maoguang.meng@mediatek.com>
>>
>> Add jpeg encoder device tree node.
>>
>> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Applied, thanks!
