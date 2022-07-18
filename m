Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6621578E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiGRXPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiGRXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:15:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379811177
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:15:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bf9so21909032lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HE1FwD+lN8EId4JRcmxRzN5D4z0DEF/FKKUfYD2j4LU=;
        b=LfYnTGomRy0mIuYpeTaogh+8jet4b64mTTilWC1/+nP98lLhQqbJ6n382kgReMEoDH
         WGDH48In8zPhwAKVCph+TvSagiEd7iIQ5IchM54aMRwuju+MCBZsyb+NsYh3nR8ycBZd
         jNVUiXrJGaViaEJktW6vs8s22PYMG28TenrVv486mYDHgsDeTxeK45VpBGTJQgdw2eKH
         QTMtbGIfxx7g+ibA/ocd9JRwxlw1KngjbM5jQid7xcBS4qpO5hPn/yf/wBejbcd2Yji2
         EP1ak2pOKL1E0/XImoo6eVOzlGbCFwbWhDP0bXJrF7s4mx/UkH8dZuDJh6S08Ov7H4O9
         2x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HE1FwD+lN8EId4JRcmxRzN5D4z0DEF/FKKUfYD2j4LU=;
        b=i40GLvBJ/8ZsDaxfOgndnRSuCk6vZi0Z0f+4e3Uprzr3Ru7Kt/PC6a/3qtueDfmS5a
         02/MLmkdGZdv8R6j3/ZBWJX2Idd+ns+PPPjHxq2yy/waE8v5+U2K/8PcwxZrcyC0RSSD
         mdGCQIwd6iyylTQTBj0/vgXzWOsscUHqLWBCRzA7njdunWuh0YclJb31rAMqyoadH7E5
         hmQxbbqsZfsrJAkqoCaVWWj05vnuInZ4CUMbFW/vUYUqB5JGTW2H14AszTQYrXnHK1Hv
         6+7g2iv80wRS6iTCCcRhsVjgzREQKWW1ncmm4zoYSsosieZ4ngsl1yE8+bUrWx4oldH0
         WplA==
X-Gm-Message-State: AJIora/Qzf1/0ny1TdFa4q+RFG6AuU6ebN2fJG+ff/bFHbIhdqCK02Kg
        Qj7I6/Z3vgWy+dd2Zk9+dt3ZIA==
X-Google-Smtp-Source: AGRyM1uK4J89ps1im4BvW/EUBiHpmWPvWyOGFjewbSGsnwyFX0y/EZKtfhz97cRYx4yctS6D/Ew9yw==
X-Received: by 2002:a19:dc4d:0:b0:489:63cb:20c7 with SMTP id f13-20020a19dc4d000000b0048963cb20c7mr14857343lfj.101.1658186101548;
        Mon, 18 Jul 2022 16:15:01 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x28-20020ac2489c000000b00488ab8914b5sm2827797lfc.213.2022.07.18.16.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 16:15:01 -0700 (PDT)
Message-ID: <af496488-6761-d1a3-18c4-85bc63e37b9e@linaro.org>
Date:   Tue, 19 Jul 2022 02:15:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add sdm845-google-blueline (Pixel
 3)
Content-Language: en-GB
To:     Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Kalle Valo <kvalo@kernel.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>, Vinod Koul <vkoul@kernel.org>
References: <20220718213051.1475108-1-caleb@connolly.tech>
 <20220718213051.1475108-3-caleb@connolly.tech>
 <d8f24aca-2cdf-413f-2b30-ad41b81be1a5@linaro.org>
 <41a8cd51-f808-4fa2-b9b1-5c04c2aec7c0@connolly.tech>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <41a8cd51-f808-4fa2-b9b1-5c04c2aec7c0@connolly.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 01:54, Caleb Connolly wrote:
> 
> 
> On 18/07/2022 23:13, Dmitry Baryshkov wrote:
>> Any idea, what is the issue here? Do you have the datasheet for the panel?
> As Marijn just mentioned on IRC, the driver right now only calls
> drm_dsc_pps_payload_pack() but doesn't actually send it. I haven't
> investigated this myself but I'll look into it.
> 
> Unfortunately no datasheet afaik, they tend to be pretty elusive. The
> things I would do for a phone panel datasheet...

as a side note: I checked the dtbo.img. There are three different 
versions of the panel programming sequences in the included dtb files. 
So you might want to check for the difference with 
linux-mdss-dsi-panel-driver-generator.

-- 
With best wishes
Dmitry
