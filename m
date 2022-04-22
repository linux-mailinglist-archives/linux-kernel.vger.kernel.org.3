Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71450C39C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiDVWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiDVWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:15:19 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34418EA24;
        Fri, 22 Apr 2022 14:05:30 -0700 (PDT)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 906AAC26D9;
        Fri, 22 Apr 2022 19:38:45 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1B567C0004;
        Fri, 22 Apr 2022 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650656245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfEQnMLQBp5gcbCjnS1m2KT836fiq6O/cfzcdERxXCI=;
        b=j5G6WCpisDyJMaBpdGq55laQYL2EYP0G8+ANfLVS7NbBP95B21QouzhNo7XBFTikfKY9G7
        pG5U9eT+63blfEGRcBnxyDC49YB76QFwN013Lt36pxExh2ArQGEKKUAxGgh4S5/b5uSn4T
        Ni1kN/GIjW44LAlb3UaSN/T2cBZe20+S7bJD7ePfvcYk+7r5gyM2WkL1UDZGzXR0MxXdbX
        6131WBe9v+3LMj6Z7TTzQvXKYbcTRuQrlAnVJv7aY9advLLz69eZsri4By7UxlXW4IOvia
        62rV3xCO013hZLwwY9lhuJE5ovFI5RRxOuQVhY29287MMh0fmfMI36ce/4BkuA==
Date:   Fri, 22 Apr 2022 21:37:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop empty and unreferenced binding .txt
 files
Message-ID: <YmMD84TNCqhkH+Hw@mail.local>
References: <20220422191958.2589318-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191958.2589318-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 14:19:57-0500, Rob Herring wrote:
> Drop a couple of old, empty .txt binding files which are no longer
> referenced.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 -
>  Documentation/devicetree/bindings/mtd/common.txt  | 1 -
>  Documentation/devicetree/bindings/rtc/rtc.txt     | 1 -
>  3 files changed, 3 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/eeprom/at24.txt
>  delete mode 100644 Documentation/devicetree/bindings/mtd/common.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> deleted file mode 100644
> index c94acbb8cb0c..000000000000
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -This file has been moved to at24.yaml.
> diff --git a/Documentation/devicetree/bindings/mtd/common.txt b/Documentation/devicetree/bindings/mtd/common.txt
> deleted file mode 100644
> index ae16f9ea8606..000000000000
> --- a/Documentation/devicetree/bindings/mtd/common.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -This file has been moved to mtd.yaml.
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> deleted file mode 100644
> index b8d36fce5e2d..000000000000
> --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -This file has been moved to rtc.yaml.
> -- 
> 2.32.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
