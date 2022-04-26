Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C2510007
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351432AbiDZOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351560AbiDZOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:09:20 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04DA10CF;
        Tue, 26 Apr 2022 07:06:12 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso13128848otr.1;
        Tue, 26 Apr 2022 07:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dq4sezhtXvWjGkw6cGqtobAkYrF6Rziq0liMCjl9hY4=;
        b=PZbbBohbrq/JDTB7+C1NRLLOuGlZc+McLM/lO8FIinR61/zEP3eFfYDTHTsjupF+e8
         eVHzpmx0BFe3tOtsoQ1pxVlg1Gf6nRhEt20kWzQCpF0cL3LoaQC6FHPbPibMf2hGIFHz
         yw/hjwdfpijWgcSaGsKGXhpuQ5nOYNZQ5oIB/q5/MTT7AmZW+zqCilIJ5je+7gaRL4mm
         z/YNIsCaaf8KlT5lYgDF7sW7//A/zkoMh3LTYVTj5OdZztYiY2iAv/ba5ikc5s28QwlK
         4SXaw8H7XqngsrouCwealHy6XUHFm6bcmbiy6tO0KI93mo+SDPTNUtLgEDuGzBc0Onqe
         Ukww==
X-Gm-Message-State: AOAM533+s2Hd6qQvqzbiYopCBGugPLKiSApeC9Ds5pw6q5JaPOhIetJx
        eMnz142LBbF/vfff7eARfw==
X-Google-Smtp-Source: ABdhPJwuQX0Ade/O3VuDIyJktv/+LSYobOodBwi0egeYaqVmuGT2LJ039zBY7csrpgKSJa69CnyYzw==
X-Received: by 2002:a05:6830:304e:b0:5af:f66a:56ee with SMTP id p14-20020a056830304e00b005aff66a56eemr8623044otr.226.1650981971808;
        Tue, 26 Apr 2022 07:06:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m65-20020acabc44000000b002ed13d0fe6fsm4813724oif.23.2022.04.26.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:06:11 -0700 (PDT)
Received: (nullmailer pid 1894220 invoked by uid 1000);
        Tue, 26 Apr 2022 14:06:10 -0000
Date:   Tue, 26 Apr 2022 09:06:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-rtc@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] dt-bindings: Drop empty and unreferenced binding .txt
 files
Message-ID: <Ymf8UkekSzSIzuSp@robh.at.kernel.org>
References: <20220422191958.2589318-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191958.2589318-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 14:19:57 -0500, Rob Herring wrote:
> Drop a couple of old, empty .txt binding files which are no longer
> referenced.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 -
>  Documentation/devicetree/bindings/mtd/common.txt  | 1 -
>  Documentation/devicetree/bindings/rtc/rtc.txt     | 1 -
>  3 files changed, 3 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/eeprom/at24.txt
>  delete mode 100644 Documentation/devicetree/bindings/mtd/common.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc.txt
> 

Applied, thanks!
