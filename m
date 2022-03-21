Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE83F4E305A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352376AbiCUTBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352369AbiCUTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:01:06 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A8369DC;
        Mon, 21 Mar 2022 11:59:41 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so20349241oou.4;
        Mon, 21 Mar 2022 11:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73x0qYLjzeZuIXhmRDyrl6vRXlCeCtzIqpI54Vo0sbs=;
        b=Z4opopJdHO8BBGlxj7/Rt4wnorD28BWZVwsCzDUYegcMa4iTEzK4dg+YWmtfANmk7x
         oEBP35hNE7sW1rCvdOZ83+/RxRuPMT4uS+Dpc0+Bu8AFITxJO/86PIMcrwuxtsEkdK5K
         mHpxxkiaY5s3RmsriaW0CSIiHjdt+btsjoPTN+AD2N3ldxkUDf+HsDJ+ZGOC2KgKngYj
         BIyeNDId22qE7vymgP5v530xXy/WXLHAzgHG7NlJT4/nZOlMJZFy4wOdJCB51V1eFUd2
         RFpl9YsGt30N5ahpJZG37QVpY/ELACYlxMAItH3VnG4FJ1mM8+USAGDLe4qdm3nzcnkS
         ct4Q==
X-Gm-Message-State: AOAM532GB9zRUntj3fq33LrE24Le1oW7k8kgWT1hgZVgU3LnrvFRJ4EY
        mrUn47Fmjf8M04ZjmMe3Wg==
X-Google-Smtp-Source: ABdhPJxgbEazPHPMPO+95ThHUNIOg+ZQxsJywLAxuuMJFl05QUPRZcDGfwRfTM8eyqoNlvbTIxgU2w==
X-Received: by 2002:a05:6870:462a:b0:dd:f4f7:24be with SMTP id z42-20020a056870462a00b000ddf4f724bemr236406oao.39.1647889180650;
        Mon, 21 Mar 2022 11:59:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 69-20020a9d0bcb000000b005af83322c6asm7581938oth.12.2022.03.21.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:59:39 -0700 (PDT)
Received: (nullmailer pid 368895 invoked by uid 1000);
        Mon, 21 Mar 2022 18:59:38 -0000
Date:   Mon, 21 Mar 2022 13:59:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/5 v2] dt-bindings: gnss: Add two more chips
Message-ID: <YjjLGgjlw7zAJt9K@robh.at.kernel.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317225844.1262643-4-linus.walleij@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:43PM +0100, Linus Walleij wrote:
> The CSR GSD4t is a CSR product using the SiRFstarIV core, and
> the CSR CSRG05TA03-ICJE-R is a CSR product using the SiRFstarV
> core.
> 
> These chips have a SRESETN line that can be pulled low to hard
> reset the chip and in some designs this is connected to a GPIO,
> so add this as an optional property.
> 
> Update the example with a reset line so users see that it need
> to be tagged as active low.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add maxItems: 1 to the reset-gpios
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

