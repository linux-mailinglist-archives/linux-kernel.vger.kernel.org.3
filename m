Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423405B1E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiIHNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiIHNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:14:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4E45F56
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:14:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q21so13428293lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=d6L8J87aB1v86b8RgudDsS+xKsHjOOrMMFG5XtkLsqo=;
        b=KHawKIkFgPkUxVPkrjS1pBxHZgetgHTNXzqxeOnAcSGLyIQMDySoPJY0z20Bkyivns
         RPFgcCuGjz4+xShlNPgjCl+R9EueMyB2ktLSK2dZpqECBuL0feaVHYpwNepFy7K7tYSu
         2KvMpZD6jpzhfIwYGIZKHCxFgYI5bGqvoTmZWHyH8sMHA5ne2vHmdeHMcUdzXfZxdrrB
         DrvjEFNw6NB0C4OcfJ7W298bdxJKmhSiODQpTt1GczHtkKhnZfrsDf26fCWUok8Y0zbT
         DyXGnZFjOllz5290Yz1gzA/LcwKkLPd4YWczB9p99j3HJhONBxS5BBuVJOE3kBfLtayx
         ge8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d6L8J87aB1v86b8RgudDsS+xKsHjOOrMMFG5XtkLsqo=;
        b=rMX5Nl/RYWfQfcW6HeEcbZUMYF0L9ClHR8zSNzuryNklBW9HGPmASeo3JtwaTojSe3
         0qwU7p8PPNJYONv22aMXxyzQX5izn1c4l6Buu1K+lXWV+DUsDmkXW9RQVVa8P9xlOdUt
         f1YarQdaZbi/aAYDpGxat+PcT3K3LMQvVuXKKoe9MYde8GpWLK11yuzotEEr6eD7QKIN
         JWxKsmVMKwul68/U8GBg+Q5JMW+c48PMPEBhBByIn0kY7gkMDaSwLM35GGloZQHOmqL3
         tqZDbPW6qKVnl/RHTJB2HF6JpiHkvT3VBhlxh0NMz3sHoHN0nT/+YsTEGV8GwyjDTmAh
         WuyQ==
X-Gm-Message-State: ACgBeo10ROzYCq8//ZGCg1YjxiR+GiVps/iX2ZiWjta3KiWf+UTVMVdO
        kSn9xkFx0tkyrz7eZp/bXvTWqA==
X-Google-Smtp-Source: AA6agR4avfuGtI4mV/LW9eH4t+t9Zcbij4SZp+wKUzY4VSoj42JgpHx8sPN67mwk8vwBWDoNPbikJg==
X-Received: by 2002:a05:6512:3f05:b0:497:9e06:255b with SMTP id y5-20020a0565123f0500b004979e06255bmr2549468lfa.175.1662642849511;
        Thu, 08 Sep 2022 06:14:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w22-20020a0565120b1600b004946d1f3cc4sm3028045lfu.164.2022.09.08.06.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:14:09 -0700 (PDT)
Message-ID: <cd896ff3-47b7-43eb-c821-8c5fb53c6ae6@linaro.org>
Date:   Thu, 8 Sep 2022 15:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 0/6] Add first version mt8188 vdosys0 driver
Content-Language: en-US
To:     "nathan.lu" <nathan.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com,
        lancelot.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220906084449.20124-1-nathan.lu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906084449.20124-1-nathan.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 10:44, nathan.lu wrote:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> This path is based on [1] and [2]
> [1] Add MediaTek SoC(vdosys1) support for mt8195
>     - https://patchwork.kernel.org/project/linux-mediatek/list/?series=658416
> [2] Add MediaTek SoC DRM (vdosys1) support for mt8195
>     - https://patchwork.kernel.org/project/linux-mediatek/list/?series=665269
> 

Can you stop ccing internal/fake/non-existing email addresses?

Your message couldn't be delivered to wsd_upstream@mediatek.com because
the remote server is misconfigured. See the technical details below for
more information.


Best regards,
Krzysztof
