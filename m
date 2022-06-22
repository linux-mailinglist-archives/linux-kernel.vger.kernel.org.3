Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC43554D69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358689AbiFVOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358681AbiFVOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:35:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDDD3BF8B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:35:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so12348973ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HivjPqY5IPVew4KDh5JXs42EJqg0Zja8oJPdWGPubQI=;
        b=s2FyGDQ8Tc33kJ135PIVk1gNLuVNCjiiGrAW5yin91Xw+BcqIDVA8NdwUuktAlsgws
         RwFI5qSlSO48nC9DshTuVS8YP1nJAzgkSAa3duuL+uXlh/xk24ZTQzRYk+et8wxeaGxx
         18IvazPkkrknb/34Ar6UazzVKdNqU98Qsce7lZNLcqeUlH1PGdxov1I59KOpdt/UpOLv
         rsWNJoKwVwwRcNwAvD/gQqDlKFEeZ6D6SUT71N0lYcpst9onimaHJruIlDCUdGoRj2xs
         G5GG1OiDBYBEqb1YvNgGiQLifzRPfuK5TY1nGNZ14CagV0fv3NBWzTsKOHo04b7gaw3+
         Rfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HivjPqY5IPVew4KDh5JXs42EJqg0Zja8oJPdWGPubQI=;
        b=IfW6nh7fkqrK1FKpL8+ReplKIx3ctp+iHoZa6GBq7GsTnDNyj8eMR8wq+zs5R763Ab
         sCDZ8IJ485bcIT2DpAKGYVW7OuAXtIvaOOydY+Ffgzren7P2eWSKYoGvGgRuZkKzjANf
         ASub2dOkxdF0PuXgWT45iIxGxPPF9+/xDzDvXBGcgpXclf+LKwKBT+p42SAGdgGyFUrs
         hTJhnZB0ksYS1RIipyhhCLB+9QgI6N7XYqu4F4t77amvpSLtTguJg/EzkFXAnyqxod4q
         CWasmn0sF8LiA9YB/GtWahipCS/CwrC5Qcx55SShXpeAE9fZO1SLpg0aFz+5MS8euXL/
         DHVw==
X-Gm-Message-State: AJIora+3gGtCg9HifnyZ+XvkAlvHiugxubbS8KctzqOCgDx63y7S8zCd
        lFDubdj9fn0Zbr0JrQFiDUNLSA==
X-Google-Smtp-Source: AGRyM1vpuXS252Vt2TCPoOf5IgGFENHWXoAL4VWnINzySUbFZ5zHejYqKkDpqUdKrVHzY0mavu5dcA==
X-Received: by 2002:a17:906:5d07:b0:722:e1e3:ab6b with SMTP id g7-20020a1709065d0700b00722e1e3ab6bmr3322620ejt.674.1655908517379;
        Wed, 22 Jun 2022 07:35:17 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402111700b0042dd792b3e8sm15275377edv.50.2022.06.22.07.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:35:16 -0700 (PDT)
Message-ID: <486c2e98-db05-de1e-122e-bda3f844e4ee@linaro.org>
Date:   Wed, 22 Jun 2022 16:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] ASoC: wcd9335: Use DT bindings instead of local DAI
 definitions
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622064758.40543-1-y.oudjana@protonmail.com>
 <20220622064758.40543-3-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622064758.40543-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 08:47, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Get DAI indices from DT bindings and remove the currently used
> local definitions.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
