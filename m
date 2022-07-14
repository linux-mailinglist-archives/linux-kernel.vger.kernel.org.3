Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A04557524E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiGNP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiGNP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:58:24 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE7348C8F;
        Thu, 14 Jul 2022 08:58:23 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id u6so1761773iop.5;
        Thu, 14 Jul 2022 08:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=4KeB5GIua+/qOBBtlWxnIk1ZXlwEo8qb0N/qz5rZFdQ=;
        b=LBT81XxKzlU5ossPDapg9820x3sSnykhzkweQQCFjSDW7bBfd+lu+nVqQpetoetGyy
         fCJOoRTvKVFunyc16uP7BgUtJCw/0JR/QLPmHYnN/T7hvk4ftuX9/Re/j/iy8T4tzdHe
         +mw3ErLWPxyFGcA4ftL2xrXsRY/SyNAg89jywpo6z6zmQ/79y3pfoLV66aAgWmedeuNH
         17KQsFT67cFtVxYDsyx4SZwZ5T9fLEds+buObeP8GhpC3aM95bpwBMpd1waO81pM0j2s
         UhlziYJcCFkAORHFrOhSOq20AJnGy1WzlzOcLGnJ0+qdAw9JwctT9FDZvstoJeoohC1i
         RQFQ==
X-Gm-Message-State: AJIora+m4pyj/xBi4CSv4zPcwultaAKEX4WK5lZVInoFvkC9NOp759f9
        kzKz7o4QjluRujd9RquXdQ==
X-Google-Smtp-Source: AGRyM1tmAUmNBkIZ1jew6caxXU5A7OmSvloMuMkBFln0I8GB331iSsOsPhH/0Q135Z+FfY8+4xOOBw==
X-Received: by 2002:a05:6638:30b:b0:33f:8d28:4d85 with SMTP id w11-20020a056638030b00b0033f8d284d85mr3239612jap.13.1657814302466;
        Thu, 14 Jul 2022 08:58:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y2-20020a926402000000b002dc0ccc4cafsm754647ilb.49.2022.07.14.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:58:22 -0700 (PDT)
Received: (nullmailer pid 2440403 invoked by uid 1000);
        Thu, 14 Jul 2022 15:58:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, wbartczak@gmail.com
In-Reply-To: <20220714121215.22931-2-wbartczak@marvell.com>
References: <20220714121215.22931-1-wbartczak@marvell.com> <20220714121215.22931-2-wbartczak@marvell.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox : marvell,mbox: Add bindings
Date:   Thu, 14 Jul 2022 09:58:20 -0600
Message-Id: <1657814300.739064.2440402.nullmailer@robh.at.kernel.org>
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

On Thu, 14 Jul 2022 05:12:12 -0700, Wojciech Bartczak wrote:
> This patch adds device tree binding for Marvell Message Handling Unit
> (MHU) controller.
> 
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> ---
>  .../mailbox/marvell,mbox-mailbox.yaml         | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml: properties: 'mboxes' is a dependency of 'shmem'
	from schema $id: http://devicetree.org/meta-schemas/mailbox.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml: properties: 'mboxes' is a dependency of 'shmem'
	from schema $id: http://devicetree.org/meta-schemas/mailbox.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml: ignoring, error in schema: properties
Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.example.dtb:0:0: /example-0/soc@0/sram@36,0: failed to match any schema with compatible: ['cpc-shmem']
Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.example.dtb:0:0: /example-0/soc@0/sram@36,0/scp-shmame@0: failed to match any schema with compatible: ['cpc-shmem']
Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.example.dtb:0:0: /example-0/soc@0/mailbox@28,0: failed to match any schema with compatible: ['marvell,mbox']
Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.example.dtb:0:0: /example-1/soc@1/sram@36,0: failed to match any schema with compatible: ['cpc-shmem']
Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.example.dtb:0:0: /example-1/soc@1/sram@36,0/scp-shmame@1: failed to match any schema with compatible: ['cpc-shmem']
Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.example.dtb:0:0: /example-1/soc@1/mailbox@82c000000000: failed to match any schema with compatible: ['marvell,mbox']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

