Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEB149684A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiAUXiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:38:13 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41886 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAUXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:38:11 -0500
Received: by mail-ot1-f53.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso13688557otj.8;
        Fri, 21 Jan 2022 15:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e23Qd0fm0GuK2sIIse882pkUGPnMfjGNce/vSbHSQdE=;
        b=5nFe254LZWoEbmazFhf4uzxskoBhOix4Y2k2NRIYQd9htj3I8gCFAzBPM86KRcj/6R
         YIu2elxl3CxUhP1RNzlpTQApWVkAvA0aXjAPMOyV4u4/dabCa/7Jb+Cv5F/uPe7Z5uvs
         MSkh12NYn//ZX9c3NA7oqgyOkvT+++kHvK/1dvIy6ytq6xVREE+q8HceYialroWmk/qG
         hFy7577m5CXqkF3cksl01vaoKSCQRCFSQDxk6Sgu582WvwWzv4dZocyC+WZbMOhwmyIk
         MQMpZ/Lz6H9XK6Hm7FhtYZceRRQEUyD46m1/Kds7YGYnJRvjPfqLSuEx9ReDQ17Q6VWe
         GZzQ==
X-Gm-Message-State: AOAM531sr5OFOR772BzANm0LStXCbJTV71xiISp/zr9wMltdCnFagfsu
        /p+bP/vKO/FFDgXQFjVziQ==
X-Google-Smtp-Source: ABdhPJx8DELQ9xc5SKlrpkpLS4lSCx/gVdpoSqAojzwmxkwoW4TLkPA8rhSCwN3hTZgsaKBeYeeRDg==
X-Received: by 2002:a05:6830:1f56:: with SMTP id u22mr4325700oth.138.1642808291144;
        Fri, 21 Jan 2022 15:38:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f6sm1399162oos.7.2022.01.21.15.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:38:10 -0800 (PST)
Received: (nullmailer pid 1827883 invoked by uid 1000);
        Fri, 21 Jan 2022 23:38:09 -0000
Date:   Fri, 21 Jan 2022 17:38:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add compatible for
 Mediatek MT8186
Message-ID: <YetD4SehEDxLkrzH@robh.at.kernel.org>
References: <20220110084841.575-1-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110084841.575-1-guodong.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 16:48:40 +0800, Guodong Liu wrote:
> This commit adds dt-binding documentation of auxadc for Mediatek MT8186 SoC
> Platform.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
