Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328384F6852
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiDFRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbiDFRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:47:57 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C45181D9C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:23:29 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 890A43F756;
        Wed,  6 Apr 2022 18:23:27 +0200 (CEST)
Date:   Wed, 6 Apr 2022 18:23:26 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: novatek,nt36672a: add
 backlight property
Message-ID: <20220406162326.eptnln622w65juts@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Joel Selvaraj <jo@jsfamily.in>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
References: <20220401001810.81507-1-jo@jsfamily.in>
 <BY5PR02MB70090BB5D8C7D655BEE0642FD9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB70090BB5D8C7D655BEE0642FD9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-01 05:48:09, Joel Selvaraj wrote:
> Add backlight property and update example to include it.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  .../devicetree/bindings/display/panel/novatek,nt36672a.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> index 563766d283f6..41ee3157a1cd 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> @@ -46,6 +46,7 @@ properties:
>  
>    reg: true
>    port: true
> +  backlight: true
>  
>  required:
>    - compatible
> @@ -73,6 +74,7 @@ examples:
>              vddpos-supply = <&lab>;
>              vddneg-supply = <&ibb>;
>  
> +            backlight = <&pmi8998_wled>;
>              reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
>  
>              port {
> -- 
> 2.35.1
> 
