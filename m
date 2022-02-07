Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7494F4ACAA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiBGUrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiBGUok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:44:40 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66862C0401E4;
        Mon,  7 Feb 2022 12:44:37 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id v67so18355671oie.9;
        Mon, 07 Feb 2022 12:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25o5fEbKKcJzCYVxzyDmg4WVA8H2QgFhoj5UAD125bY=;
        b=CfzGb0cuc3b91swojYfC89PQQZcMo4GSH4TsNSdr27ZCw7eeBF5yd6Ra7qUXxDexBh
         ve4ImpL/aVznmWclabQPgVNbZo83fY/D4m93FCE7AgG0wmC/f8UR/cima9lRmVGbb/5p
         f3WEEsajH7s06ufu7NTLT+ceFOoxsdnVcZB7PnryoPpF8D3p13INneDU3OSRlInjy3DT
         gD7Vm7EJpsCn/Jbpb1kKkHTVm22Way9SwabsvVfnfG9oMIhue6isq5Q5ni3LoygxU3Iw
         fqKtiBnJsL/ecLOc3S5GTGFWhsrcjttyCL6eed3xUZGXeSKKvcuBuQr6qtXeHNf5lF9S
         wFlA==
X-Gm-Message-State: AOAM532qFJl5UBT/v2TmAqBv6X4SlvlZah124QO+SfpcGwXBvOo0zsGf
        TNMV+6/mAaeWc9cxK20fAw==
X-Google-Smtp-Source: ABdhPJwg99eaeCun36HwI4ITFM8x+iu5bk4427O5oWJn4TSawH3xmz43w0LTJB6I+fs+IJ0UGN2YXA==
X-Received: by 2002:a05:6808:11c6:: with SMTP id p6mr362172oiv.208.1644266676647;
        Mon, 07 Feb 2022 12:44:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b8sm4434395otk.36.2022.02.07.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:44:35 -0800 (PST)
Received: (nullmailer pid 886052 invoked by uid 1000);
        Mon, 07 Feb 2022 20:44:35 -0000
Date:   Mon, 7 Feb 2022 14:44:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     srini@kernel.org, linux-kernel@vger.kernel.org,
        ekangupt@qti.qualcomm.com, Jeya R <jeyr@codeaurora.org>,
        bjorn.andersson@linaro.org, bkumar@qti.qualcomm.com,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 04/12] dt-bindings: misc: add property to support
 non-secure DSP
Message-ID: <YgGEs1iigfMvxtT8@robh.at.kernel.org>
References: <20220126135304.16340-1-srinivas.kandagatla@linaro.org>
 <20220126135304.16340-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-5-srinivas.kandagatla@linaro.org>
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

On Wed, 26 Jan 2022 13:52:56 +0000, Srinivas Kandagatla wrote:
> From: Jeya R <jeyr@codeaurora.org>
> 
> Add property to set DSP domain as non-secure.
> 
> ADSP/MDSP/SDSP are by default secured, where as CDSP can be either be
> secured/unsecured.
> non-secured Compute DSP would allow users to load unsigned process
> and run hexagon instructions, but limiting access to secured hardware
> within the DSP.
> 
> Based on this flag device nodes for secured and unsecured are created.
> 
> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
