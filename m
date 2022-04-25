Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191D50E7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiDYSUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiDYSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:20:26 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204383B28B;
        Mon, 25 Apr 2022 11:17:22 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id z8so18032318oix.3;
        Mon, 25 Apr 2022 11:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zK0XbZYFHIbn4YEvbtlTS5+ILlqbhfjpcFXsN6SS8C4=;
        b=qghc5s1fMzwhPD2eX+cGr5ndUY5qbRTOgqxpsYHPMIRdH4ZAgf9b4IKEFC0zA1j9+m
         FfJVMlv7l+KAmqrG/xPqsELWKetCDXIqYIbw89+mkdfyAX4TIvC0W/IoYIZSSp8E9g5k
         62EvjUp21N7zF3gkCdntzkBAm5ArUqrDbJ/dB/vd9V+NKIOt4xW0GJ8XWMPm17m7vD6D
         NFbPuE4dbV+UWGgUCLtyAF2OJ++cRiHbK1PgyRQFUINCuP/zZUh1oH6kxeJ2BXX0ktq/
         DlaAbuJMkjCES7QDdMlKUTnMLXdgI9IzsZ+SK4PSTuXlRvh2qNtZUGROBQnZZ2+x8sbj
         Cfyw==
X-Gm-Message-State: AOAM532+Wnotiw99BN/Ga4voHDHoBwKIOfDzt2AgsNhlUwgi7VPYddPy
        etQNplQ62izPgE26ac6rbg==
X-Google-Smtp-Source: ABdhPJwpGMq3v6GY16e0pPz8kVCaVX6IjaGt3PcOCofp6hpO6qfoizLRg+SlvikHqN4Fd6Xv7H84Iw==
X-Received: by 2002:a05:6808:302c:b0:2f9:41e0:26e6 with SMTP id ay44-20020a056808302c00b002f941e026e6mr8502192oib.151.1650910641329;
        Mon, 25 Apr 2022 11:17:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ed22-20020a056870b79600b000da32eab691sm3492657oab.23.2022.04.25.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:17:20 -0700 (PDT)
Received: (nullmailer pid 4186706 invoked by uid 1000);
        Mon, 25 Apr 2022 18:17:19 -0000
Date:   Mon, 25 Apr 2022 13:17:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/5] dt-bindings: mfd: Add bindings for Silicon Mitus
 SM5703 MFD
Message-ID: <Ymblr1TdU/LZWXKM@robh.at.kernel.org>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-4-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423085319.483524-4-markuss.broks@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:53:16AM +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for the Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/mfd/siliconmitus,sm5703.yaml     | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
