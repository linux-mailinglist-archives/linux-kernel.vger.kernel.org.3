Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3D4B5859
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356981AbiBNRTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:19:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbiBNRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:19:35 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D3652C0;
        Mon, 14 Feb 2022 09:19:27 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m22so11142968pfk.6;
        Mon, 14 Feb 2022 09:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UlEoY4gUMCf+dGZF5OFEMsNszRaKi2NA9sVTb7hg2Q0=;
        b=Ae4U2rn/YgQgOSiyBw4kGAmri+C7D120xX2o4jTRqLmVZIwA9orrp82PFXVyOLe88t
         5T5LS8Yywqq1yrpCVB7G4GG5FYZQUDJDm53OLiwGHyGy8+PzEh/ltOv9sdjQsLOQ37BW
         K9jUAGGyAGbO8m/d9ADpTfTiEDDicGmysucCnySqoNkUDMyL2sf0KwApIjlpCOBKh7LG
         PwLn7yzu096BJFsZbMkywa8qC5bLUChdLXtHANsVKuws7eixe2FC3CD/XVIIbRv0GFH4
         8aL24++hGBw17OPlB9PFW8aJifALKZ5y0EbTPSEC7kOrBTt+Y+9DY5uTdqXJzHsuvFjt
         Fi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UlEoY4gUMCf+dGZF5OFEMsNszRaKi2NA9sVTb7hg2Q0=;
        b=ujxL7PDUeMS+CbmkzEbRrgiPOJHDngy+tn08wI7KiLUWNMYQrel1E4tam2WgnvaOV0
         mOL9x7ofM576JGrsg3Cb1zqMJLD+TbcvgFZNA8eCgulH/6829BvzYG+2VsbyLD9aSz8S
         cODmEEU2xbDJIyQYIkYIYiyNcsuhcjOYenOWIpVt/sTjRzYGR4y3RvWzQdJXtfXlmDld
         Et/pAgT0hncGatSUQEGQUp0+p0Wo3rFZVSSxFU+mRgc6Zfo0G0raAFoipeEDIzr7No90
         s0Np3fXvbEDXGgA/i6vrTOijYp0/2gHkEU1b/3xf7YOzt27+igpmv3wBFpShSaPwiIya
         uLQw==
X-Gm-Message-State: AOAM530c9f9JldGzpav6VBo7qaEQ+PKe+pLJTMpCKLoI5djAMZsoU7Ud
        jcgxz+CsTX8xl78MajnPSL0=
X-Google-Smtp-Source: ABdhPJzbAW43zE1Qfnv6bnjeH7rBFCX7yXcNUn2pVO8yLoL7oe86rRsSHL23eDM2HIDNmODSHPh2sQ==
X-Received: by 2002:a63:2a51:: with SMTP id q78mr4148pgq.239.1644859166687;
        Mon, 14 Feb 2022 09:19:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bd34sm5276481pfb.73.2022.02.14.09.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:19:26 -0800 (PST)
Subject: Re: [PATCH 10/15] dt-bindings: pwm: brcm,bcm7038: do not require
 pwm-cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
 <20220214081605.161394-10-krzysztof.kozlowski@canonical.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a8d3ea6e-c9f8-e5e4-7cbd-71e0c814db0a@gmail.com>
Date:   Mon, 14 Feb 2022 09:19:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220214081605.161394-10-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 12:16 AM, Krzysztof Kozlowski wrote:
> pwm-cells are already required by pwm.yaml schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
