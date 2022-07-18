Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8339A5781F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiGRMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiGRMPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:15:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7F255B8;
        Mon, 18 Jul 2022 05:14:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 19so13360753ljz.4;
        Mon, 18 Jul 2022 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zzP5O2UmgIk3Drx0H4MSnDfz0Rp3ps9TJkdV4JO2R7A=;
        b=k5lJvTj75rH5lRKTzC/JAHyfjGsr14xTRDcoHCgEcTV4AQGrX8eFw3FOfF4xGf2PUz
         GCADOTVObBuWMnlgaXeaVF1dqwMtGESu3hTv+M26TO+9cIS1lyu4M0odsGdKQlD9+7ut
         gFQBBFbdwPYVbn/gjSujfZBM2f728agNEQfl3mKPtWp10sm8buT9AlXG29ggOL7hHi3h
         C4EH0rGOBQr4N4G61LEJyTy1OyypnaLIDQxSvRda9A1IAx5tAx41Hi5M2T/W08OROahM
         OGN+4/hy7EKVlrVJi4A2SjLF9pVebYJR30ltq5FPKlIsFy9cCcr0CnsDyAwm3KL8OqpO
         SfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zzP5O2UmgIk3Drx0H4MSnDfz0Rp3ps9TJkdV4JO2R7A=;
        b=bQfGiFs1B4ZRgzHFx5J/mBUG8FzA74tJZqM8jIdJ7rl0TRt85h2VGqQLgLf+smhI6G
         32HSH/jYeeFAjtjHxmCVd30NtWkkO04CLf5xfRZ5fkN69FVE2n6AXLvT4sEV8IhQvlLx
         4BxaCo/z7NPiu22CaedpoSap24+7AuO50ba5Khs5/7iZ0OHDNBZURN78xsHxq9v8Shij
         LzE1dRxD0OwuDJZZGsYe+LVjvGZO5deTPF0Tl9sDxCp8Nc8sC4VVhLS5bBYvyWu0i8Ur
         Qjqm5F0livCIbEpyw0Dr8mkRuXWytA9YVIrVMWeP+xBeHfD3DmeoGHBHRS7h4gQdglLq
         kcJw==
X-Gm-Message-State: AJIora8rWXUelBsFjF7TF+dFOn2vVP468dOj/wiU9k+mWsDohRD8X7NA
        5g8L1Pw6srh5yEnwW33Nxbd+Cp3Ef0LnYgwN8jAdNA==
X-Google-Smtp-Source: AGRyM1ufnTrLK16zGnHGSVDYgn6Qdqwl+qyM635WSkuiGCCWe3WaxlO6iYTzbk1LrpRwb59JMef4hg==
X-Received: by 2002:a2e:6819:0:b0:25d:63ec:7954 with SMTP id c25-20020a2e6819000000b0025d63ec7954mr12048608lja.389.1658146491305;
        Mon, 18 Jul 2022 05:14:51 -0700 (PDT)
Received: from [192.168.0.251] (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id c1-20020a05651200c100b0047f9dca3708sm2572788lfp.51.2022.07.18.05.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:14:50 -0700 (PDT)
Message-ID: <48656998-7b7e-29ac-3f94-c05dc705c166@gmail.com>
Date:   Mon, 18 Jul 2022 15:14:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
 <20220717213432.134486-2-matti.lehtimaki@gmail.com>
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <20220717213432.134486-2-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.7.2022 0.34, Matti Lehtimäki wrote:
> The PM8226 provides 8 GPIOs. Add a node to support them.
> 
> Signed-off-by: Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>

I will fix the UTF-8 issue in the Signed-off-by lines in all of the 
patches in v2.

-Matti
