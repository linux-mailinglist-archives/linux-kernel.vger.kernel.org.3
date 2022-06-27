Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0800955C2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiF0ILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiF0ILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:11:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1576172
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:11:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c13so11775040eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h3Mdp7WZpjNWUbLLF/KYYtNmAa+cGw6y3XcuLyzAU8g=;
        b=q5zVoP5clcIVDrY6ERK2vmP9OZfarqRkGci7A4OY51STVO6GItSzvcoNw2yUOg1pzf
         uWCwOYwOpqK2kdRRsLnqGOj1sRNqw86F532Mk6NKDwsmyjKnbAteN8GFce0kuHx8nTZS
         +O1deikonijJCWXPURdyN9w2XbTMjfe/Z6Q198aSE/8tPdNYVo8ZJqXmPwWbDdgZavZ4
         RF2/XAmi7XGqB675rtl3JAO8nbKSfvE/1dXXCCw3zpnwuk+FfgHgn67sRzv+vcoDzzr+
         u4Gy5tGwrAZi1vRxNkeGBHnVLXrSXLYI6DBsUIyR4pKuJTJOJ6LD9V6NkO94CFludcuA
         aSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h3Mdp7WZpjNWUbLLF/KYYtNmAa+cGw6y3XcuLyzAU8g=;
        b=WfCS2inrTwtM/wm2VC+ZmqxWGfgI9LTjHLL1mdIDM8II2C8bn9sfOAK5x6CGXIB5Re
         CioOfNxvsdMtVCJw0HwIseOZ/MQECStwm+qXg8L4uixsb8UmWxpZdTw/XRRnX2q9JW2s
         YQMH5O2PGP9CX6PsqKr3p0ICy9GUxu8iMX/3l+dCwM7B+w8zX6Zph6TnLm+XHGvEWLqu
         Cnjt4G+T/6qQKldNszp16EdD+gXbGS51WgTtklarZg/9qCkihg+Aeg6HX8MCtCCp9VvU
         gU6SOaT+n/QCb4qyr1lxH4uGO5blnf3Pznim28iQxcSBWIOYbZnxoVx/zK0bvUPu1TkW
         x2IA==
X-Gm-Message-State: AJIora/MzwEAVRWCp68oMRmgNN1FEM151Vgv9chMds9sEh2vK5UVkH/y
        mYzygISOt4vGZX+KektZyJrqrw==
X-Google-Smtp-Source: AGRyM1sktl7RIZL1/G0JBzWDl6xiJ0SUDo+RA0dlLEqNiPs2faaTLxqZ1tas7kNDD7zvUSp224wxPw==
X-Received: by 2002:a05:6402:5306:b0:437:8bbd:b313 with SMTP id eo6-20020a056402530600b004378bbdb313mr6563242edb.123.1656317503401;
        Mon, 27 Jun 2022 01:11:43 -0700 (PDT)
Received: from [192.168.0.246] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709060f5200b006fe9e717143sm4726972ejj.94.2022.06.27.01.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:11:42 -0700 (PDT)
Message-ID: <e1156747-e7ea-c35e-b24e-61f9318bf45f@linaro.org>
Date:   Mon, 27 Jun 2022 10:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        cw00.choi@samsung.com, krzk+dt@kernel.org, robh+dt@kernel.org,
        kyungmin.park@samsung.com
Cc:     khilman@kernel.org, djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220607140556.6278-1-johnson.wang@mediatek.com>
 <20220607140556.6278-2-johnson.wang@mediatek.com>
 <4e452af8-e96d-fb06-7800-707f3bf75155@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e452af8-e96d-fb06-7800-707f3bf75155@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 12:43, AngeloGioacchino Del Regno wrote:
> Il 07/06/22 16:05, Johnson Wang ha scritto:
>> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
>>
>> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Acked-by: Georgi Djakov <djakov@kernel.org>
>> ---
>>   .../bindings/interconnect/mediatek,cci.yaml   | 141 ++++++++++++++++++
> 
> Uhm, I've just noticed that this is being put in the bindings/interconnect folder.
> The mediatek,cci is *not* an interconnect driver, but a devfreq one and is not
> using any ICC APIs.
> 
> Shouldn't this go to bindings/devfreq/ instead?!

No, devfreq is not a hardware subsystem.

Best regards,
Krzysztof
