Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D2575047
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbiGNOE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiGNOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:04:09 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1538B4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:02:55 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id p81so1469897iod.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RsxRFWookUjb9M1eoVrfmNO791X9QhGp0s9BwKoLC08=;
        b=ej3N6eT3QVNMmGegVhaeKFGN6mELTqticRKN4eLFLE9bcVwRDxLGWwqWeBGIDLdOn5
         cZzP+NkjAnhn5wgDAhZibQVmkBx1gDQwMgg0G+OsHggEJxv1vK5gXFdXtq5o74T9TnRI
         8QNl35TLO67FH8WP9v/VvrkmugXrWVeOYpI1Jnn4+CYRAGRgsnLeCRIDqrcGjPBR4uFH
         7FNIQFix6Bv6d/G2Q4Y/xhwgqwWxIN0RKfQ/I9BFHfiB7mL9IObVoBMBLyIZT7rHg7fJ
         zjVFQ2xmAOzPrGaCiXIzzDZWFg5KJyL+7bf0wq40v7FwwgPgY47Pp7NePt6yPlVocb0Q
         pJ5A==
X-Gm-Message-State: AJIora/mYlGeNe/KMkDKg4I1tGRs45h/b0gQ2jj9HLvCd3nQg/T2ZdXx
        mRhiDGJQm1IHr4A+hidmYIrmdw7ynQ==
X-Google-Smtp-Source: AGRyM1smf1WAcR8IN4kePXM6pm0T9Cswdl5y1ddZqV+QgMkBJy49JHaZ8hMNP6HJrz1kWeEf0xSUpA==
X-Received: by 2002:a02:a88d:0:b0:33f:15e5:7fdc with SMTP id l13-20020a02a88d000000b0033f15e57fdcmr5083451jam.271.1657807374840;
        Thu, 14 Jul 2022 07:02:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p13-20020a02c80d000000b00339e2f0a9bfsm755174jao.13.2022.07.14.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:02:54 -0700 (PDT)
Received: (nullmailer pid 2233203 invoked by uid 1000);
        Thu, 14 Jul 2022 14:02:53 -0000
Date:   Thu, 14 Jul 2022 08:02:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <20220714140253.GA2229197-robh@kernel.org>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707081826.953449-3-Naresh.Solanki@9elements.com>
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

On Thu, Jul 07, 2022 at 10:18:24AM +0200, Naresh Solanki wrote:
> Add a devicetree binding for the 9elements,output-supply driver.
> Example is also provided.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../regulator/9elements,output-supply.yaml    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml

Now failing in linux-next. Please send an incremental patch to fix (and 
test it yourself):

/builds/robherring/linux-dt/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml: required:2: '.*-supply$' does not match '^([a-zA-Z#][a-zA-Z0-9,+\\-._@]{0,63}|\\$nodename)$'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
./Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/regulator/9elements,output-supply.yaml#

