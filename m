Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B73585706
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiG2W7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiG2W7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:59:20 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C190868A1;
        Fri, 29 Jul 2022 15:59:19 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id j20so1643908ila.6;
        Fri, 29 Jul 2022 15:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qtHVxHIf1ranp5UWH3YvWfj77wihU7UmTQjplZtOLAo=;
        b=ExMdEO/yc7Q2jjfpUl3Q4BfFMVmdYwbM3yk31ciKSoUvPV9+x3REuNM+o3tCEm/lFK
         RgqgB08Q06ubYiOlAwOvm5p6POz0aNlrsbehGyOoYs/h+wNcYfuvKA04EgW8HVEl1EXf
         RCxl4rWs1oRA48rrgoM7xiCadBmMRFdPYmASBqFkUz2tt6hR9P5vKdrTHtoNm/Tk8iWp
         QGN+YrYVuqbFLmlK0qnhE6l5JDYcJlX4ytnI0UdWjZzSljetmssLPgPcdXadDqmRVOkj
         Suboj2dhQwBA0KlcOKXIyiR2sDzRXLKBuEAWtbZVxKkmNRVRguFUNPChyvr3HXYYRMLy
         O4zg==
X-Gm-Message-State: AJIora9nT66XRht9PzkX7IHlRQqL/Wl/9QGAN/gXwMjfSflbLMmn6dLj
        yqrLL8/wtKjWgceXWUJ4/w==
X-Google-Smtp-Source: AGRyM1uImBYJJceitPtvDPkne05B/TOaHpSUK/ydXKTmD9uWheT6PiMogps3kBxE+zuC91ugtcAjAQ==
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id m3-20020a056e021c2300b002dce4978b12mr2184159ilh.151.1659135558409;
        Fri, 29 Jul 2022 15:59:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f5-20020a056638168500b0033f5e8dab90sm2262072jat.143.2022.07.29.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:59:17 -0700 (PDT)
Received: (nullmailer pid 96409 invoked by uid 1000);
        Fri, 29 Jul 2022 22:59:15 -0000
Date:   Fri, 29 Jul 2022 16:59:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <20220729225915.GA96357-robh@kernel.org>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729063208.16799-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 14:31:54 +0800, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
>  .../power/mediatek,power-controller.yaml      |  2 +-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
