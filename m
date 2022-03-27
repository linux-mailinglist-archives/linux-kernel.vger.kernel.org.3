Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB204E8996
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiC0TOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiC0TOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:14:51 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D95F64;
        Sun, 27 Mar 2022 12:13:11 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id r204-20020a1c44d5000000b0038ccb70e239so2377092wma.3;
        Sun, 27 Mar 2022 12:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BVCp6R/bmWc9t+8wj8QpgDL3b81JxuDJTlmQAPj0K/4=;
        b=Bnw3T7PaJaawaBdz5q99m4NovV4hHXyvZq8l5esYkdYYt7wu66CICmy6bcZ6mS1CqI
         JCUdPnPYfIK9jVDsmRCdjSP/5T8PB7LayTaC8mbv09tUdHkGzp0v0qEGuUrmTAuROpHS
         oO0A8MunMNVcCfBEPOhsXi8Hv8JCCUK2QkUFTGodyAAkfIz1nUzVOQKAtghB3DlNspF2
         AWTfiYUvszT1Gg+KqOEu/ZYwW7gs4NoZo8VlMF2I/FATdLd5zdUQKOOL50u7weKgeN9w
         f4JcCR4z2ojBILIX2puPxS48UCXiqzX3xN9w0Jagjchz+dze2waBoif9D8jU7otxQUoK
         MmtA==
X-Gm-Message-State: AOAM530uOR6J6r+4G50vDLiIprDcHPVQ3TS78nTH6FMna0HAjjSvqseI
        dnq0iuMWZQpm5+0zuhN2xxQ=
X-Google-Smtp-Source: ABdhPJz1ThdgV5jL/JaZHXiJEoLzVhLa5Jqgvj4nb0etRFVRMMo0BZoSi/gykc/fAulQXVpWCAFEwg==
X-Received: by 2002:a05:600c:34c2:b0:38c:6cd5:4957 with SMTP id d2-20020a05600c34c200b0038c6cd54957mr20928965wmq.19.1648408389806;
        Sun, 27 Mar 2022 12:13:09 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm11047544wmq.42.2022.03.27.12.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:13:09 -0700 (PDT)
Message-ID: <2e00a51a-c408-d02a-e625-0fdcb6482b0f@kernel.org>
Date:   Sun, 27 Mar 2022 21:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 07/12] dt-bindings: imx: Add clock binding for
 i.MXRT1170
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
 <20220326144313.673549-8-Mr.Bossman075@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326144313.673549-8-Mr.Bossman075@gmail.com>
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
> Add the clock binding doc for i.MXRT1170.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  include/dt-bindings/clock/imxrt1170-clock.h | 282 ++++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h
> 
> diff --git a/include/dt-bindings/clock/imxrt1170-clock.h b/include/dt-bindings/clock/imxrt1170-clock.h
> new file mode 100644
> index 000000000000..6b94767c3a6e
> --- /dev/null
> +++ b/include/dt-bindings/clock/imxrt1170-clock.h
> @@ -0,0 +1,282 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*

The same license as bindings, unless you cannot.


Best regards,
Krzysztof
