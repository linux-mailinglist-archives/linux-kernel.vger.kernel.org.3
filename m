Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687A5B205A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiIHOSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiIHORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:17:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468CD21D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:17:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q7so27992624lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8/WneAIH4doGZWwalQYiIRIPWbn6dY3tzQchBDy6uq8=;
        b=FW3NoVsk/D0Nf3JbkkTKy/wW5LGJUF6TucHDO5cDKLvBTnSC1Yi10PBSCfzXp5kIvj
         VF/j/gCFY5s6lhqw4xknnQn92Z74hzDmuxlxblmy8IQyrUbpvjuM/VCZsHFnEogQWFPQ
         h5yRCq3kYolxf8LMP759YSutYbxuix/6DjulZfkDB93YBSMqI3vg3S1QlTJtBEDW5Yh8
         Xcb+KZRu70DtccNSnYn57w5eCiCEXMsgze0Nc7XcF6e/8W2d9Z0FiSKY6vhE6XUqTits
         d1jQVqWO5WIwxAecj9clvgBRR6YS8BsnmRFEmFrfs1ALQC9Wdi/fs8MSC0eC9NE0tPvA
         D7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8/WneAIH4doGZWwalQYiIRIPWbn6dY3tzQchBDy6uq8=;
        b=xaf7y0QIkpPX01in5/22JjiSJmvruApztFIxXt4D/j1VruC86kmhpxfnrXerMLedrl
         YR0Ot2uavF7sz/DxnTGEbvZKNPG/sn6ZnSbXH/IHTXvWbdqCJtBkaP/J/M3sBzDl/Bft
         nD2/IOySW5iuZxRMUWYUwAOkcsyYctdr2OEJmtn9tvFYK8m8TRnVyAtj9fqbBWXFEmHu
         oPEvk5jheI/ELQyKkQkJ/0s6tCOCtO/Lz4xypp7+fiKyZ71IJBKs+IIlDqA3Y1BTMxHj
         orPbysvXMZQoma3TELljZQFdhgHJ38bRrb/QIeK0qr3H+qlfRCOTV0DTgef6S9LqfulT
         Stkg==
X-Gm-Message-State: ACgBeo2sMOZMJ42qyxp3nZ4b6A1WEVESZGUdcRi2W8MbYr7l3xbP+qYQ
        ZZ818LmHE57kh1FE04gtlL0AZg==
X-Google-Smtp-Source: AA6agR4mHUGqtjIx4fWu+AWyjmDlfv8bavpAUqYbTfxi3wJ8vaWjQj312qDOFEZGYwmEJx35Mt6jZQ==
X-Received: by 2002:a05:6512:2201:b0:492:f874:39fa with SMTP id h1-20020a056512220100b00492f87439famr2713913lfu.365.1662646670821;
        Thu, 08 Sep 2022 07:17:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k5-20020ac257c5000000b00492e98c27ebsm3049186lfo.91.2022.09.08.07.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:17:50 -0700 (PDT)
Message-ID: <83818ffc-bc38-0d3a-b225-d6671c6a1f3c@linaro.org>
Date:   Thu, 8 Sep 2022 16:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: iommu: mediatek: mt8195: Fix max
 interrupts
Content-Language: en-US
To:     matthias.bgg@kernel.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20220908141529.1478-1-matthias.bgg@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908141529.1478-1-matthias.bgg@kernel.org>
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

On 08/09/2022 16:15, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The mt8195-iommu-infra has five banks and one interrupt for each.
> Reflect that in the binding.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
