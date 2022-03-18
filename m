Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A224DDA93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiCRNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiCRNbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:31:39 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A22E1C3496;
        Fri, 18 Mar 2022 06:30:19 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p15so3381360lfk.8;
        Fri, 18 Mar 2022 06:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vq9qQSRELzxWkIVj+hUn/M+Bp2lpfseu1iZAEoXNp4A=;
        b=GmUxunETtSe0nzMn6wg1Dkh1EgQTI9QoP+c2+ltEPvL+M55FXyrhQnYBXrx+OQldod
         CqR0gyddT1Hlm3FVmvBFuS2QziKWIEK1ue+NsLzygCJBCbXp8ol+PewrxvOPiz4R74l3
         bX+jrOT4UC/4zxsPWaTnTbuZ2JnS7dsaDTybTU5v9sOMajD8FA+TYtIUN4rEJrnKfBV9
         7KAY+GohG4b/zQc191VmgHAockR6mbSMncj/wBjT0KW9AU/TDSZR+vbqrvlzE5p6KJ5J
         8mdsblVqCAlqR3suRFYGd3H2YUc4M1D8q2+CtLOS+IqtkyWAF4p8QNizroHDFYvr6fDD
         Zi1Q==
X-Gm-Message-State: AOAM5320zsqmy6Lc9rbGDIrXxwHjizTxTN1dq+oSrQBoTolvHD61gcWI
        d+bd2drPaFxYEYY8RB4yy5Q=
X-Google-Smtp-Source: ABdhPJyYBFJsAEi9Ox3ftSywWBGbh5eMDlIwP/i63FzaSWzPLrE9zOrSgh9JWeoOZQHa1ow2OL1Tcg==
X-Received: by 2002:a05:6512:689:b0:448:baa7:154e with SMTP id t9-20020a056512068900b00448baa7154emr5791258lfe.230.1647610217735;
        Fri, 18 Mar 2022 06:30:17 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id h14-20020a05651c158e00b00247fda7844dsm954009ljq.90.2022.03.18.06.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:30:16 -0700 (PDT)
Message-ID: <9e82c55a-51cb-1c1d-8314-cef75797f1ae@kernel.org>
Date:   Fri, 18 Mar 2022 14:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND v7 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220317101215.24985-1-axe.yang@mediatek.com>
 <20220317101215.24985-2-axe.yang@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220317101215.24985-2-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 11:12, Axe Yang wrote:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
