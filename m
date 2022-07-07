Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3956A364
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiGGNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGGNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:22:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA5013D60;
        Thu,  7 Jul 2022 06:22:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t24so31127812lfr.4;
        Thu, 07 Jul 2022 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGx3WroSsu3NFcydbW98Okt5ftfv4JTgquEdA1fClxY=;
        b=DFkLGgnRVxLZISCjcbWYQhw6EmadHY8hPzmwZX3M/1QxQ3rmvA9K1FHR+tpG2ZfSY5
         ek76GH1xIAz1emj753ATo46VOs1ONBFcablBG6HMKrHigtB8kJ+fxDrO9GnqpctBlpVw
         yDXCzM+ND4CT792jU1C8YV6+K3ugW3iiiWKV3qCojVeGMPjA3loou9IWfb+9gpFhsdHr
         eyV2WzS1rx4/dgK8/e5uUb77rFJIDe7dDxcZZc5THJ+8Rc+N1w7cLmk4//pXuLpNjChy
         MMSCOT8KSaqIy+7TBUGcyxSPURxBDHdrIKLx3yET6/ZutXExttLDz3RN7tMh3RfbbkIS
         bx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGx3WroSsu3NFcydbW98Okt5ftfv4JTgquEdA1fClxY=;
        b=sza0Lg7VW+iS19hVBLRaMJD4oOcJRr+6UTctDX+3y2S2pNxypLP5A/7EKHRQImsDrV
         mrgFeF/oq2/kAJa0g+AeZoIIBECvUeeiLFXRyanoDdgwqurhFoRAZI858TqkWJ1Uxc0E
         Z67V9L3YvwFNA2/ZEz4c+9YvvHJyOob+t4758yAmPPRMpLO6UYwYNsENg0/nSDFSCkX5
         wYJ5BTnxOdJTS588hmQexeBqEYtzcLpCE9Kmhm02nDDCIl0QN2cXjU9U20q67N3I0AHd
         CujWfNU44nS9p952SSO/scPaJmMKxBdEGzP7jTyH/JF41LUdA0vAgWCQezJrquIgEuyy
         HGkQ==
X-Gm-Message-State: AJIora9Tgg+ZaniqHdtxe04Ddbj9CwrJ6ETtohnUQiwNrTrImSu3I9oq
        i2IhJdUiWw0oHKFksPbP8C8Y2XkGHit5Yg==
X-Google-Smtp-Source: AGRyM1uONBzgIxWVwqFTuuL9VxeGrfVkpmlIKP1L9gOJjXl9o3ejdup+BqRk+Z1WhEOp8MwIqibqxQ==
X-Received: by 2002:a05:6512:3b1e:b0:481:20ff:434a with SMTP id f30-20020a0565123b1e00b0048120ff434amr31566799lfv.111.1657200171737;
        Thu, 07 Jul 2022 06:22:51 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f5-20020a19ae05000000b004894b6df9e2sm9262lfc.114.2022.07.07.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:22:49 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:22:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v5 2/4] dt-bindings: spi: Add bindings for Intel Thunder
 Bay SoC
Message-ID: <20220707132245.5b4xzvh4dy4cgwgi@mobilestation>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-3-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706042039.5763-3-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:20:37PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add documentation for SPI controller in Intel Thunder Bay SoC.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d7e08b03e204..5ecd996ebf33 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -61,6 +61,8 @@ properties:
>            - const: snps,dw-apb-ssi
>        - description: Intel Keem Bay SPI Controller
>          const: intel,keembay-ssi
> +      - description: Intel Thunder Bay SPI Controller
> +        const: intel,thunderbay-ssi
>        - description: Baikal-T1 SPI Controller
>          const: baikal,bt1-ssi
>        - description: Baikal-T1 System Boot SPI Controller
> -- 
> 2.17.1
> 
