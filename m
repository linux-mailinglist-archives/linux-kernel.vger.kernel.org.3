Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95A580505
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiGYUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGYUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:07:44 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D3CE3B;
        Mon, 25 Jul 2022 13:07:42 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v130so9586240oie.13;
        Mon, 25 Jul 2022 13:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4GWuWpoAhrVCWo1uur9iksaj/fTVZRC6odEtZowuyck=;
        b=mHCRsQazEFxw5eYNf5UcFCOZ+DRL3i1xsFteXXnmqEUEXeAka0hmBKyT625N2pCRh3
         rhZMG/D34A/SiNdZvp82e5odiMBS+gD9D7i82LF0mDELiX9bCxGWlZy5+S6wJOvMopoG
         Aga2+LHPEn3AF+9ytsHZVuPA2TJpq1T2VA9CzLZ0tMXQFyrOD6P3SBpoGCDlYZSVPmFr
         W+OBRTej4VR2lL1EqAtv6ynnBC06rxWHdTpzgmK3ueSFlSRh2hydYuUAL06TOvx6xjDW
         iVWbrcF70RASqRt/qSMaPY4tCJwaaHkhTFhizXSGX6HpUE35TkPkLKlDAgWxBOnEwLga
         b0wg==
X-Gm-Message-State: AJIora+H2TealB+0aqg2sHOZuoaeoA3lulxl/hIcjH2BkwgDIPshcoKy
        cwfB+5fPu6h7fqLzU7hyGg==
X-Google-Smtp-Source: AGRyM1s9bFZXSzKFUySKHhgElYf8SWow+HiRmq7/Fd7H0J6JmYb+GfEYGWIS4ue0TpRPUdBZYB81vw==
X-Received: by 2002:a05:6808:209d:b0:33a:8b99:f7a3 with SMTP id s29-20020a056808209d00b0033a8b99f7a3mr6336587oiw.119.1658779662190;
        Mon, 25 Jul 2022 13:07:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o31-20020a056870911f00b0010c7487aa73sm6473352oae.50.2022.07.25.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:07:41 -0700 (PDT)
Received: (nullmailer pid 2625395 invoked by uid 1000);
        Mon, 25 Jul 2022 20:07:40 -0000
Date:   Mon, 25 Jul 2022 14:07:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, aisheng.dong@nxp.com, festevam@gmail.com,
        ping.bai@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
Message-ID: <20220725200740.GA2610621-robh@kernel.org>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 05:43:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There are many warnings when do dtbs_check: fsl,pins are too long,
> so add minItems to address that.

A single cell is not valid though, right?

This particular property is problematic because each entry depending 
on the platform has different number of cells (5, 6, etc.). A single 
cell (minItems: 1) is not valid though, right?

There's a fix in dtschema min branch which should fix the warnings. 
Unfortunately, it just strips any bounds checking.

Rob
