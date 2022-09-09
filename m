Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B545B2BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIIBov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIIBos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:44:48 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5FD18E0C;
        Thu,  8 Sep 2022 18:44:34 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11eab59db71so331713fac.11;
        Thu, 08 Sep 2022 18:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FAY07Cuqp3oSJ8w7oZhWrcAHyCe/nG2er3bhN/HbsFQ=;
        b=4xebnvYBEJQHGdvK7Jmf6+ilnDYAnIBs56bLhu0hiooYAgrpAfpPyZ9Lek5fwHs2KD
         1gp7EEDcjrUp8EIl1VzARnZD2kbD5a6WtNaupFhZDM7hIB7ouS70r6086/0PIkEXfKhT
         e4B/1LS5q4W4EctQdniTkxLf7Y3CTSGWYD39rsfIhknjdfUHBkEk/7R5EJXoxkk1glBP
         QIqGdKt2LOETYTBQrF0TdcxoYpBlAV6Y79awQW51HFFDpA9APYAbboquNKWDoPH4A7XD
         /5eYSeGyNTfDWgkpR2KHpcFnP8OIJ70ay0VnIpqBQCtJgTfzZZX04ixczsf13Q3WWmT9
         M3UQ==
X-Gm-Message-State: ACgBeo1AN/5CTP7A0qGEnCStwf5FFdW4VFmfP2c9StDKTFhcT05xSX5E
        5pCyAFDnWp+FQfvl2Tr2wA==
X-Google-Smtp-Source: AA6agR6bmNOSz9JmTrN/yOhgvThK0Ksd1oD+MCm8XzQDgO/uwL9qDfW8aQWRxQ4yJuVDElS9frmTvQ==
X-Received: by 2002:a05:6870:d114:b0:127:611d:dcb9 with SMTP id e20-20020a056870d11400b00127611ddcb9mr3554432oac.286.1662687873739;
        Thu, 08 Sep 2022 18:44:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808208400b00344851ea0ddsm87683oiw.56.2022.09.08.18.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 18:44:33 -0700 (PDT)
Received: (nullmailer pid 3746913 invoked by uid 1000);
        Fri, 09 Sep 2022 01:44:32 -0000
Date:   Thu, 8 Sep 2022 20:44:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
Message-ID: <20220909014432.GA3745895-robh@kernel.org>
References: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:52:03AM +0000, Yunlong Jia wrote:
> Add an elan touch screen chip eth3915n.
> This chip requires more delay time than the eth3500.
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>

Author and Sob emails need to match.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> index a9b53c2e6f0ab..d28625372f5ac 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - elan,ektf3624
>        - elan,ekth3500
> +      - elan,ekth3915
>  
>    reg:
>      maxItems: 1
> -- 
> 2.17.1
> 
> 
