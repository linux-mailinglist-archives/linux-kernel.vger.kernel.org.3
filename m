Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DD54E29B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377334AbiFPNz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377273AbiFPNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:55:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685B4664C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:55:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so1297756pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p++bIs2HneM4Mmo2YjeBS7JYAqLzkFDGH55M3o+NIxg=;
        b=BehuJv74CLjkgQwQW2YTJI7GYHpWAyt46Adp9YWqP2Ino810KUqBU3m1LAkJP2RoeF
         +eA+u8d7kVSzDosz5vq7VxcNcZTX5YfEAdbw3WwaqZk6zp6IGjSa69Y0nIzpcs7oQ7T1
         5P9k5mgEtdwx7+92E2Hd+8E/s1CExYyHRLZ7rC2g7YdASXXLLCb/7P762HZgHrjLA75R
         xG5TtUiW3VtMrQd6uFAmQG8Y4p1sUGlhBWUz7hIEqmjYZkezA6cSjVo4NTIG9NzxS6uo
         9KvtSOoyXEs4n5UZOYuuYOrIE0Y0joFHJlTY2q8mQG0IgbCAF5+0MpkutS140mIBOqqJ
         kXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p++bIs2HneM4Mmo2YjeBS7JYAqLzkFDGH55M3o+NIxg=;
        b=QS1irzyeq4VXIP47yQonB+yG//tLdaM8WS9g5h+fqrXOOfFRw+J4a+VaOgJS6KY5Gv
         UzZLVIibzK3D372abxJDvDxcgQuolliXL4ttfFlwT0Zz9PKHW4Omccz3N5b0D7VLDMbf
         ZyPaX7HNPh4eQ1ueudKGFnv2BRtRdOC74OrTFNToxZcKuA8wBaQ6wl3L/Z6tsK8FiTzV
         QAzTLQeIxxKRV4nzp3avpnlAvFFvpk5WR+pHa/QYVnGslxmR6UZf0OkGWv5nMoi/QuB1
         pG1lisYK7jIluxsIYPstPMKgTJoZx6HizXBjj9YLl9cdPp1SLahL+kfWQmStCvADKMvT
         DyIA==
X-Gm-Message-State: AJIora/FUo6W0yDOZr3EavNJRKM8Qo0dzMO/qIhMfDqzEc2xqO3XZBwF
        d1IZfIHvv9xcvfoETD75B9ezBg==
X-Google-Smtp-Source: AGRyM1vXMhY+ZrUKaR7yePLi9tk4x6RLg+QaJ2jT5cqYNFanziG3iv5eJoN4umJFjqajEOEp+YtBpQ==
X-Received: by 2002:a63:356:0:b0:3fd:7477:63f0 with SMTP id 83-20020a630356000000b003fd747763f0mr4613366pgd.601.1655387752971;
        Thu, 16 Jun 2022 06:55:52 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a00198200b0051b9ecb53e6sm1773063pfl.105.2022.06.16.06.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:55:52 -0700 (PDT)
Message-ID: <ea767ff8-9fa0-7a2f-af52-e0d05adafb03@linaro.org>
Date:   Thu, 16 Jun 2022 06:55:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/4] dt-bindings: dsp: mediatek: Add mt8186 dsp
 document
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220616073042.13229-1-tinghan.shen@mediatek.com>
 <20220616073042.13229-4-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616073042.13229-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2022 00:30, Tinghan Shen wrote:
> This patch adds mt8186 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers, clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
