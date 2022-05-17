Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3282752A018
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiEQLKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbiEQLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:10:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB64611A02;
        Tue, 17 May 2022 04:10:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AB0C91F43AE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652785809;
        bh=qf8uzbZ1EqZKktmG/w8A35nbIzmMTkGNdHNjUDAKrE0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YSEpN29NXtz9y0X68InodlahgVwMXAbQqp76hpOV6ZqVaCMcmQ604Hsdc+EMgGSWp
         iHP21VfOdjsMU1q4z3olc5ksKIpVDuSNx5b9aEEkn+xSaDc1zsEJl8U+RYi2zn9jpe
         byljfm3THQOEyYqu66vH85Ci4JOmATN1oJW7XYCJHYhoshg/JkrBjoXEyLcWFdkxXX
         5dR6aWBFVpXtDo80jDCg5oYpCI1Er0M31yjCljsEj17+xl84lwResrSPnngcH1cR3f
         HaQGPDaasbSn3GpwwWP6Tsl/H+vf1lvUEF2O2fuHLT+AHtofAujWeTA5b7lMIk/kOh
         DIboZigcnu4hQ==
Message-ID: <0ab46d63-3b3a-c847-df21-40efbeb01486@collabora.com>
Date:   Tue, 17 May 2022 13:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     martin.botka@somainline.org, linux-mediatek@lists.infradead.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        paul.bouchara@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        will@kernel.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com, ~postmarketos/upstreaming@lists.sr.ht,
        joro@8bytes.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, marijn.suijten@somainline.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
 <20220516160307.GA2732645-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220516160307.GA2732645-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/22 18:03, Rob Herring ha scritto:
> On Fri, 13 May 2022 17:14:10 +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/iommu/mediatek,iommu.yaml        |  3 +
>>   include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>


Hello Rob,

I'm sad to say that, but I have to send a new version of this patch even though
you have acked it already... and I will have to drop your ack, as the changes to
the yaml patch will be a bit different, as we're adding support for a phandle
to mediatek,infracfg after some discussion about it on patch 2/2 of this series.

The mediatek,infracfg phandle addition will come as a different series, and this
patch (on v2) will add a conditional for:

   - if:

       properties:

         compatible:

           contains:

             enum:

               - mediatek,mt6795-m4u

     then:

       required:

         - mediatek,infracfg

Sorry about wasting your time on this v1.

Regards,
Angelo
