Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0095AB9B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiIBU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiIBU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:57:25 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A7FE056;
        Fri,  2 Sep 2022 13:57:23 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11f0fa892aeso7698172fac.7;
        Fri, 02 Sep 2022 13:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I+lC4NQ49td+wOEGEF4piSWmC1XVXG5X9v8OoGEXnEc=;
        b=SfZgvWmHViK2Ah27phxEjpTcP03JL/PREPua+4pT7kuMnZpdwgvsnCQhr11SHO4iCr
         GdhJ+BZv8iRLh1pE+FEa6zoAGHLGK3Obuw4vCs5QRCcTYc0xPW8SKr8zdzBZAm4XgVDy
         1CG/V+cdlbrpCwQ/wu5MA2/fol7OCWreCHB+LvCeXeWGC1YyAt/uGdEkF309jlGpbJSh
         DxRW8kshSVR8Pd10CChTtaxOcg6Q0E35NwX2wYaA7cos6wvJfT+/V+94vqokf4C1hWnS
         spLSrqh6uscDN3OxsNKkb6KE18L3M+JayzyEEHuMXCixjUENRT9QPivc/KgxCh+fJn4o
         C+iQ==
X-Gm-Message-State: ACgBeo0R7md5QwBryiWFInWfFhs/xSGbAkEluibE2LeAN04d4z56qugO
        auQu1qxZmxZEf5/XR/6ESw==
X-Google-Smtp-Source: AA6agR5d5j0pkbv0nxtD/hPNiE/gPngtHQGC+s7pMW3tCkdsuyrQn7YSNLZa/7xnsqCPbtwfrW4dNQ==
X-Received: by 2002:a05:6808:1482:b0:343:6755:a7df with SMTP id e2-20020a056808148200b003436755a7dfmr2789386oiw.288.1662152242608;
        Fri, 02 Sep 2022 13:57:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a54468d000000b00344f28a7a4csm1400698oic.22.2022.09.02.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:57:22 -0700 (PDT)
Received: (nullmailer pid 401958 invoked by uid 1000);
        Fri, 02 Sep 2022 20:57:21 -0000
Date:   Fri, 2 Sep 2022 15:57:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/8] dt-bindings: soc: imx: add binding for i.MX93
 syscon
Message-ID: <20220902205721.GA399775-robh@kernel.org>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
 <20220831141418.38532-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831141418.38532-2-peng.fan@oss.nxp.com>
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

On Wed, Aug 31, 2022 at 10:14:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add binding doc for i.MX93 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix

Is this complete or you expect to add to it? If complete, just add the 
compatible strings to syscon.yaml. If not complete, why not?

Rob
