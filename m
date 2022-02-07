Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3069A4ACBBA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbiBGV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBGV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:59:15 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6FC061355;
        Mon,  7 Feb 2022 13:59:14 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id s24so10916851oic.6;
        Mon, 07 Feb 2022 13:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1TgpekSKAIGefPlVKG3MJZI856wXlnKnhXOCP6G/TtM=;
        b=XKW7d1zTnTOmnVeglFAhgrNhVoNy5FQ8EymfsBor3CCo3lAMOZlJgNDKH7WA031ben
         BV51zBC8rWKLf7939v4oINfPMxHmG42q6aGv2BNkGt1lioUU27Ilu2kSPskzxeDgq3Tr
         nZVsy27T+QA1tuCkMpbxf7NEB5ZHISEOCiN73U9NAZvYh10b9VLmzdp8UHjcJN/IWuYG
         IUarIj7eIBPc3/OmtjOq775azOwumX+sbMF0jXPLaHVRy79ycYPZ7RtH1n4/g9ync0tk
         R5rArLnkSRC/k0YQbXOOe4/kASopqrY04j7Y9QuHbdZyrw2NIRJJK+W6RgIkKT6YYwFG
         6QlQ==
X-Gm-Message-State: AOAM5313LOcL7kMeEIWJwa6vhkY/xfJ8VQSqlsBT2uEig6of48Wqt8/f
        8fG0T1CvQtAGtUMX3UV0bE6+O22kXw==
X-Google-Smtp-Source: ABdhPJwI0ZpUsaKMxFb0aBSe8Sw2b4RWxRlQE2ac8fEAdS7NPC5z5RDDiyWlaa1rrV7BOte7aggdtw==
X-Received: by 2002:a05:6808:14c6:: with SMTP id f6mr453650oiw.0.1644271154024;
        Mon, 07 Feb 2022 13:59:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 127sm4703473oih.8.2022.02.07.13.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:59:12 -0800 (PST)
Received: (nullmailer pid 998749 invoked by uid 1000);
        Mon, 07 Feb 2022 21:59:11 -0000
Date:   Mon, 7 Feb 2022 15:59:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        th_chuang@richtek.com, cy_huang@richtek.com,
        gregkh@linuxfoundation.org, will_lin@richtek.com,
        linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: rt1719: Add binding for Richtek
 RT1719
Message-ID: <YgGWL+GZo2QRUMSv@robh.at.kernel.org>
References: <1644246970-18305-1-git-send-email-u0084500@gmail.com>
 <1644246970-18305-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644246970-18305-2-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022 23:16:09 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add binding for Richtek RT1719.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../devicetree/bindings/usb/richtek,rt1719.yaml    | 85 ++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
