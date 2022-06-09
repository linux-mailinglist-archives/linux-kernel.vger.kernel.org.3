Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A8545563
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiFIUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbiFIUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:13:42 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D416C0CE;
        Thu,  9 Jun 2022 13:13:39 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id 19so3977203iou.12;
        Thu, 09 Jun 2022 13:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6l9l9kPqwl3IQE/Cf0+fYtyhOgx4JcYqWXsF7+CMNJk=;
        b=dpT1ne9LU+jiCMQgr2yFjTN1NTf3AXfdT6C1y0wtImAcVPpWeqZWr0vKlE9fTBj6w6
         PIYmh5wXeXb8MjOOAV61FZLkKh1wPBdng2D1syLGG0Xc5Fjw49Jd3fMt1/YMTp4hsOSC
         aOx1fFLm53JiSW36Hna6QKYVbHiiXRVpfd5j3PLkJTAJQDSmZbWcXnRZqs6Hxo7PdMKn
         bEfaiCBDVk1qWmfXZj2pWKclsIxFRtg1fMWm3+c1EZluyaFFN2nJgKSi6+EqQgqxrAfW
         /0M+tA2RSEBzF2k0JnFkywkmih+pIpL+DTubStjYNAkVCA2oZ2FbmApKa3QVlgIvCsZN
         Tk5w==
X-Gm-Message-State: AOAM530taDR4I4EDhKXTUexrgWAZCmTXn/mvYqRpWe+uoyZf9Rs5fBOL
        592rBMyR8uW4IqMan3EJiNowPGrUsg==
X-Google-Smtp-Source: ABdhPJwzRhZ2lulsjWqbpQE+uzTRV4T5c7iS8UU0OeRQQMuSib7TYQtQGw968hJHxu7B08fpJiWo7g==
X-Received: by 2002:a6b:d612:0:b0:664:c158:da22 with SMTP id w18-20020a6bd612000000b00664c158da22mr18993120ioa.143.1654805619014;
        Thu, 09 Jun 2022 13:13:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r21-20020a02b115000000b0033197f42be0sm6335915jah.157.2022.06.09.13.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:13:38 -0700 (PDT)
Received: (nullmailer pid 27164 invoked by uid 1000);
        Thu, 09 Jun 2022 20:13:37 -0000
Date:   Thu, 9 Jun 2022 14:13:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        ldewangan@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, skomatineni@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        ashishsingha@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 3/3] spi: dt-bindings: Add compatible for Tegra241 QSPI
Message-ID: <20220609201337.GA27067-robh@kernel.org>
References: <20220607114659.54314-1-kyarlagadda@nvidia.com>
 <20220607114659.54314-4-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607114659.54314-4-kyarlagadda@nvidia.com>
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

On Tue, 07 Jun 2022 17:16:59 +0530, Krishna Yarlagadda wrote:
> Add new compatible for Tegra241 QSPI controller which has
> multiple chip select lines.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
