Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2484C4E897F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiC0TGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC0TGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:06:24 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CCBBCA3;
        Sun, 27 Mar 2022 12:04:44 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b19so17344746wrh.11;
        Sun, 27 Mar 2022 12:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8dxte/Nk3Xo80atGww0qKbqjPcx0rSBfv6e4dj7Bp+o=;
        b=fWx0MS91TNxrQkxiUxd4/zefgdxU4/jc42WYtU5o2FF/WtKTF7aaAJ6Y7ckF2GVLOS
         AgKKjhkRbvp2Bpn2aRSXOO0OePu7Z6D73GxYaG870VxBY8CdNZ2TaRBPnwMobYwOw6aW
         PRQTvuTmftdGsU/KsHMrOpI/xr9WtdlIh56Mz//YCqNlUZNpAecZxwYQ1soV4lkVQA0U
         90804+VbVMhPa/ZHxObzJ6D38hWwy/dnO3Ne/DcsnKAFqk3/nZJMaRxpcrx4+L7P5sXs
         otHMBRG8xSGax8YC+GUozQHZlt6vj5gQZvfYRQFYX7xGZYsYO2ZzxM9ti/+McvRSePbO
         WqTg==
X-Gm-Message-State: AOAM531Nfw00C1Zh87WnqiohbWIRPZctqPUdsCb/SNGPurhaliEuBwdr
        OP52Xpx13MqzU9uJS5Wzmbg=
X-Google-Smtp-Source: ABdhPJxgtelMWREwOcVfYU6jhvUzEq+0pS7TbK1Vm24wXlEwm6t6U8r8bXOGWGDUJ08t5C79ijV+mA==
X-Received: by 2002:a5d:6841:0:b0:205:9bc5:9470 with SMTP id o1-20020a5d6841000000b002059bc59470mr15195659wrw.15.1648407883095;
        Sun, 27 Mar 2022 12:04:43 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id 185-20020a1c19c2000000b0038a1d06e862sm14781875wmz.14.2022.03.27.12.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:04:42 -0700 (PDT)
Message-ID: <6264b6d2-63e1-db65-f201-41a34437c99e@kernel.org>
Date:   Sun, 27 Mar 2022 21:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 01/12] dt-bindings: arm: imx: Add i.MXRT compatible
 Documentation
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
 <20220326144313.673549-2-Mr.Bossman075@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-2-Mr.Bossman075@gmail.com>
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

On 26/03/2022 15:43, Jesse Taube wrote:
> Recently the imxrt1050 was added but the cpu compatible node wasn't
> added. Add both i.MXRT1170 and 1050 compatible to fsl.yaml

s/i.MXRT1170 and 1050 compatible/i.MXRT1170 and 1050 compatibles/

...and a full stop.

> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 0b595b26061f..59575053ff03 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -834,6 +834,18 @@ properties:
>            - const: toradex,colibri-imx8x
>            - const: fsl,imx8qxp
>  
> +      - description: i.MXRT1170 based Boards
> +        items:
> +          - enum:
> +              - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
> +          - const: fsl,imxrt1170
> +
> +      - description: i.MXRT1050 based Boards
> +        items:
> +          - enum:
> +              - fsl,imxrt1050-evk         # i.MXRT1050 EVK Board
> +          - const: fsl,imxrt1050

Order the entries alphabetically, so 1170 goes after 1050.

> +
>        - description:
>            Freescale Vybrid Platform Device Tree Bindings
>  


Best regards,
Krzysztof
