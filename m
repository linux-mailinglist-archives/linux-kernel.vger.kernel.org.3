Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE474F80FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiDGNwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiDGNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:52:34 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E41EBAD6;
        Thu,  7 Apr 2022 06:50:31 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so454514otr.2;
        Thu, 07 Apr 2022 06:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DxCif+I+h3qUJ8PQJ1TMI3wZ+FQkVzQw6LHqikw6lm0=;
        b=jA2zm6SPqlXPyXM3r9bOc33nbcUT1FoYbtTM8m3hcm1IWYKb39on5Pt0dznRSpOYod
         0ybbjdcaEAgN9rKWe2rE0f/1cb4kxLgRe7Gxp47h/1bCsS5rOmWHypbDUStwej2dpmXA
         AEgYeD9Zd3vAg/PTRIdKa97S8OY9MFvSh8OMHcxcd+72hXHfi/QN7+WULYtmL/NzRzDJ
         wORdvWfrYmnsj9FWe7eS00k8C5syWtew3yMEWdDtMCh8a8rCllTgCfJlbO8f4b2G+Iqy
         4Dc6kYZCxfGpliBniY9YHqLuxKuSKWqqHmeG2uA0YI0dOu2ZiCAIHTXPRKu9Er+MeMj8
         7n0w==
X-Gm-Message-State: AOAM530vk7CePAF/Qra2wilx350LJIGqPimj37H15nrUARelWOevoLKg
        poCzKTydPh+FmosQvolrSQ==
X-Google-Smtp-Source: ABdhPJz7AbEDxicrWgNX9xYJXUZeZZWDvsq5xGhm1fr6P71xE5bIBsFHeBa6kF9+Ki73uORHgipl2Q==
X-Received: by 2002:a05:6830:4126:b0:5c9:2a3e:be43 with SMTP id w38-20020a056830412600b005c92a3ebe43mr4755801ott.143.1649339430608;
        Thu, 07 Apr 2022 06:50:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u16-20020a056808151000b002f734da0881sm7885466oiw.57.2022.04.07.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 06:50:29 -0700 (PDT)
Received: (nullmailer pid 795408 invoked by uid 1000);
        Thu, 07 Apr 2022 13:50:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mikhail Zhilkin <csharper2005@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Karim <Karimdplay@gmail.com>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20220406195946.2019-1-csharper2005@gmail.com>
References: <20220406195557.1956-1-csharper2005@gmail.com> <20220406195946.2019-1-csharper2005@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for Sercomm parser
Date:   Thu, 07 Apr 2022 08:50:27 -0500
Message-Id: <1649339427.653492.795407.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2022 19:59:46 +0000, Mikhail Zhilkin wrote:
> Add YAML binding for Sercomm partition parser.
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  .../mtd/partitions/sercomm,sc-partitions.yaml | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.example.dts:21.13-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

