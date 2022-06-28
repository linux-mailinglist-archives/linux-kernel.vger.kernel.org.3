Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9455E4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346695AbiF1NgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346592AbiF1NgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:36:09 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44224F09;
        Tue, 28 Jun 2022 06:36:08 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id p9so7874111ilj.7;
        Tue, 28 Jun 2022 06:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljfrFcLSCQwuvYluVxziFP0rt3DXED+J1iuyt0fYGuY=;
        b=3zLsffXYoQkgYhpoUz7XmQhIj3o/EN35+IBqM9oRD0FyG0pYLbpAY4vqOL1qRXRu4P
         5o4Jmpxp4PuMPdy9AEnTNmeXXMkvhBD35cyGrEYgPOJbxzWJnDY25AWGkVhd3NktKCE4
         +vKqieyqLIW4BxPeGzQ1gXhzyCyCw3TeN9GC8AyQoG33vgq6fJ4Rgq8y8Gpp3f6a1Eax
         kPAbiEbsjuQOyhckXYxvUamJUsXrAk7LoExqo/uXHQ8sdLJOpcRbOe1ghTgN3ZD3vtn+
         //tvDaezmIcFwB860/wUQ70cwe3jPdv4PLznOEPGjE1NSMiOCc9P+D7PNE0voZZpYcPu
         KrzA==
X-Gm-Message-State: AJIora/6Az5xzdn0rhBc0RxZIJqu1ZQf5PxRVunpnUWbwoSAebhDonc1
        gK6RcA2tVbm/UN3UcrCVzA==
X-Google-Smtp-Source: AGRyM1tz7l70wGgbXl1juQ9asscmdPKCNmGgwRZqzsjZjzvBQK+ON1vZmV/hujutLLIezpH/spOGDw==
X-Received: by 2002:a05:6e02:180d:b0:2d9:26a6:d016 with SMTP id a13-20020a056e02180d00b002d926a6d016mr10482078ilv.170.1656423367965;
        Tue, 28 Jun 2022 06:36:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id bg13-20020a0566383c4d00b00339edc9d877sm1698361jab.120.2022.06.28.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:36:07 -0700 (PDT)
Received: (nullmailer pid 341603 invoked by uid 1000);
        Tue, 28 Jun 2022 13:36:05 -0000
Date:   Tue, 28 Jun 2022 07:36:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     devicetree@vger.kernel.org, michal.simek@xilinx.com,
        sivadur@xilinx.com, krzysztof.kozlowski+dt@linaro.org,
        git@xilinx.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, robh+dt@kernel.org,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH V5] dt-bindings: ata: ahci-ceva: convert to yaml
Message-ID: <20220628133605.GA341535-robh@kernel.org>
References: <20220620073717.3079-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620073717.3079-1-piyush.mehta@xilinx.com>
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

On Mon, 20 Jun 2022 13:07:17 +0530, Piyush Mehta wrote:
> Convert the ahci-ceva doc to yaml.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Corrected the patch --prefix V3 to V2.
> - Added Required properties.
> 
> Changes for V3:
> - Skip patch --prefix [PATCH V3] as already sent.
> 
> Changes for V4:
> - Addressed Rob review comments:-
>  - Update params description
>  - Removed description from common properties.
>  - Deleted deprecated property.
> - Warning generated from: 'make dtbs_check'
>  - Thanks Rob: We are aware of these warnings,
>    but they are unrelated to this patch.
> 
> Changes for V5:
> - Addressed Rob review comments:-
>  - Upadte the file name with ceva,ahci-1v84.yaml
>  - Fix dtbs_check warnings: added iommu and phy-name property.
> ---
>  .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
>  .../bindings/ata/ceva,ahci-1v84.yaml          | 189 ++++++++++++++++++
>  2 files changed, 189 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> 

Applied, thanks!
