Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD65A86BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiHaT24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiHaT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:28:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01576E68FD;
        Wed, 31 Aug 2022 12:28:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso158737wmb.2;
        Wed, 31 Aug 2022 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xEkvTPxCYEtbgyuc7AbrC31XxwpwG8/Jsc4DJQ0nSZc=;
        b=l+SYHrC0WOx05Lw+vAl31uevKBK60EfzJn925WLGi1a9q6NUzLy5TZJfJGCnY8iR2M
         GZ7kf128ka27jrSwY1C+G2Hvia5CWcprJ2giqVxC3V2+Tio6nDSxKw+6zB5VCF5QPpML
         h2GckzEO+aGEWQHHqrai4cod9XE/PRBdt+HGMDjgcRv4XnHyjAGSVErhV0L75kiuOTx/
         mehc+Wv//EQEdW+LZEOdPFlasR3Raxygvx3+e3ei4DCNNluMFWGjSViEgYKX4XtGmnJa
         OH9+mfBe3lNoP5FBOvOM4c2O1deTFaI5vW8F7uYbNGg4tMyYvJSh0CJvsMZfBEB+aUpU
         T/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xEkvTPxCYEtbgyuc7AbrC31XxwpwG8/Jsc4DJQ0nSZc=;
        b=nnH5lh9g/WqgNn+rmM3PwjRPPN8jcTN9G+KCTKz8dMJl0184I9yAH7aNp95lBKw0HA
         4jaEJtxRiB2p3qQLSRMtIeNPxA3Afj3tN30XvCBE2gqjD5UO2wuzyw8QwLxj+nsoDs4I
         QEUw8gDAPNhjJZK5CM73d++pYxQJS9JEPrnOBJ2ap3CtLh+u91ffNu8apf+lRmPwzHRK
         ge0pmC4m2qZkkEd7CQQVxB5eQLEoTM0QyB5l2rWGUGc+0538UW+nRGeVmaCGKciQQ4IK
         qtS4indwCLgzl288BGPK343OeMRJGx3oCQWLCWgWV+RxZF4XiubKD4YuOb4eHWf5ceiT
         OsTA==
X-Gm-Message-State: ACgBeo0/DCOjR67Xa6LNmBf4N+fyV042pXA//UuyPDCbOKYNjl9z6lHs
        s5kFQFnQZPOT3NGdDMJQDzU=
X-Google-Smtp-Source: AA6agR57+4W6XctCTACADhF7v56bAvACdqKSkgF5zPBGOHbQHeodwXcH0QJKrJxOT94Yf1jS+D2Obw==
X-Received: by 2002:a1c:7916:0:b0:3a6:3540:5b3c with SMTP id l22-20020a1c7916000000b003a635405b3cmr2855528wme.178.1661974128760;
        Wed, 31 Aug 2022 12:28:48 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f6-20020a7bc8c6000000b003a35ec4bf4fsm2928680wml.20.2022.08.31.12.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 12:28:47 -0700 (PDT)
Message-ID: <afb33bb9-206e-fe7c-7c6e-b42d87e79dc2@gmail.com>
Date:   Wed, 31 Aug 2022 21:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 0/2] Add mt8186 mutex support for mdp3
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220831172151.10215-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220831172151.10215-1-allen-kh.cheng@mediatek.com>
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

Series applied, thanks!

On 31/08/2022 19:21, Allen-KH Cheng wrote:
> This series are based on matthias.bgg/linux.git, for-next and provide
> mt8186 mutex support for Media Data Path 3 (MDP3).
> 
> As discussed, we add data field (mt8186_mdp_mutex_driver_data) for
> mt8186 mdp3 mutex support instead of adding mutex_table_mod into mt8186
> disp mutex data.
> 
> changes since v2:
>   - rebase to matthias.bgg/linux.git
>   - add C-d-b, R-b and A-b tags
> 
> changes since v1:
>   - add mt8186_mdp_mutex_table_mod
>   - add mt8186_mdp_mutex_driver_data for mt8186-mdp3-mutex
> 
> Allen-KH Cheng (2):
>    dt-bindings: soc: mediatek: Add mdp3 mutex support for mt8186
>    soc: mediatek: mutex: Add mt8186 mutex mod settings for mdp3
> 
>   .../bindings/soc/mediatek/mediatek,mutex.yaml |  1 +
>   drivers/soc/mediatek/mtk-mutex.c              | 28 +++++++++++++++++++
>   include/linux/soc/mediatek/mtk-mutex.h        |  2 ++
>   3 files changed, 31 insertions(+)
> 
