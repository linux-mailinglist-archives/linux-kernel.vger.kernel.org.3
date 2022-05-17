Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAE52AACB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352219AbiEQS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352204AbiEQS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:28:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45451E54;
        Tue, 17 May 2022 11:28:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd25so17129edb.3;
        Tue, 17 May 2022 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmWMl24PLrdkb0RO6o7DaiaR1+eajCYcl4bE91rBER4=;
        b=BH2Gw1ZQRnCcAtEp+ZPEzVyf5wjZWSj5fjQ1Vq3RhoPk0DOqRJt2w+cPkyeSkSalx9
         mt8Lzg4S/9XBiV9znMETiSfuALWo+dfQTpw0vNxjEvZD9/LocM9XvEekNwRKS2sxAeAi
         f5K5tuY2ucqtrR2cmQQ/u6RWsPSz4fAubURY/X2cTNIkGeeBWfFe5C4AufaqzcMvGthX
         lwAezuCox7s6Pd2pKt9rRJhEwmZo9s0pNOv3e/LarYjJgYhwCXhvSPuFeOLO9bSwDND3
         WT2CTcvFaX/MUcB1+MqxWQEr3tk1KXsEQ54Bl/oZXyyKqG3J7OEpUCn9HGtLEP2N5lF0
         o/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmWMl24PLrdkb0RO6o7DaiaR1+eajCYcl4bE91rBER4=;
        b=WIclwk705eRYx5mHw5b1NjY0E2cjoou6DpNkQ0PdMa2Oyd0jCePfm572fN9Sp42RbZ
         IhJ4vwtRT9ZzWqhzyk9O668JgjxdUG8+6J2g4uWB5EeVI2UIY3Fnoj04gT/CizrMN5F+
         3S+kInmOC30audkVMTBg/EHoxdFiPylRJQuUbCSRit9bhEFnDhSijE7Z5DieLtCT38xE
         3Kv/gWYaItq3fV5Gc5jzSJptvcnYF71h21Tw9EhLgzuh/acWyW+Hap33w+cyJPNfjDRX
         ZC3jvAk7eRY6XlpWjSx+Rl6+XVegnWH7oyAFc3o4NZUlr92BOilehgb9w1YSwixKb5lg
         7seQ==
X-Gm-Message-State: AOAM530Ai5POFH0fTBxMhcfum7LocGNSNIMrNunp7dp3WA/ydQc/3Ias
        YX+dWyz78r1Haf5HFdI5zHHZHfrSEtEgg5yDx4f9RHkkY5Q=
X-Google-Smtp-Source: ABdhPJy/uQrZWWIHO1CiHlPJevmtZBD+fUUpD/hDsMEIyLpgfqpzgyjpxRHV89afcJi4KPUeKwNo77D8FaDcclPUlK0=
X-Received: by 2002:a05:6402:3585:b0:427:ccd4:bec3 with SMTP id
 y5-20020a056402358500b00427ccd4bec3mr20764880edc.2.1652812099078; Tue, 17 May
 2022 11:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-12-max.oss.09@gmail.com>
In-Reply-To: <20220516115846.58328-12-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 May 2022 15:28:10 -0300
Message-ID: <CAOMZO5BtQtX2873RQJ6hB0rAZThJ82mf4gTm9JboAkMrwq+f6g@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Mon, May 16, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:

> +       ov5640_csi_cam: ov5640_mipi@3c {
> +               compatible = "ovti,ov5640";

Does it make sense to describe the ov5640 camera in the Apalis SoM dtsi?

The camera is not populated in the SoM. What if the customer baseboard
uses a different camera?

The same applies to the adv720 description.
