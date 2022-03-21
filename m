Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE524E2CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbiCUPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbiCUPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:48:22 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F660AB7;
        Mon, 21 Mar 2022 08:46:52 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id bg10so30702374ejb.4;
        Mon, 21 Mar 2022 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gZCh1iB4XHHU1h7mdXi3Ca3bYSPa4vUssLjec7XO48A=;
        b=4uEYDfqv1sneF0WbtT1rA8h/hK1+8cbaUZn/o+5aSKfYAQHBazjAWZCKHb6vyP81l2
         OzHDpuOGI53yEYWzdkqk1xR5e6xoWvort+gtx+c5ANL8rirVrSNScDp0Dhwpn36GUtxG
         OQMFxTHV7MblseTp485rutoJIC+pssIS4fHkAKKixynfvMvevBVOyZWMjBgLqElmSjTg
         wZEbAx2VwayrT9s9iGxJXmMH9T4hxgSl4kUKjmNuhP354ctlTgv4PAUSCoVyh226V++f
         ICp+/o/nIT3oSCyp4IOzgI2itaZE+kKrEckPQRjtxexBgYUBsJGw0U8HKF7wuuEwC5C4
         PFqQ==
X-Gm-Message-State: AOAM53192nVn80GPM5BLzHP4vWVWIf2xZEVmlAAV7HJJ5pI5gia0mUMm
        v/Dyf6W/VwzX1wVkmyOnJmOmz1mBIEk=
X-Google-Smtp-Source: ABdhPJzgzGN3zjVLHzh64VLoEtnosD8ElRHmrTzYKpnrQezbHsIkRV5Uk8Ejf0hdwVkYSVGZweSluA==
X-Received: by 2002:a17:907:724d:b0:6df:ff4c:8941 with SMTP id ds13-20020a170907724d00b006dfff4c8941mr6699161ejc.10.1647877610712;
        Mon, 21 Mar 2022 08:46:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id hb6-20020a170907160600b006dff6a979fdsm2269933ejc.51.2022.03.21.08.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:46:50 -0700 (PDT)
Message-ID: <2942ea7a-3e23-7df1-daff-c266a82682fb@kernel.org>
Date:   Mon, 21 Mar 2022 16:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: add mfd/cros_ec definitions
Content-Language: en-US
To:     Fabio Baltieri <fabiobaltieri@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
 <20220321143222.2523373-2-fabiobaltieri@chromium.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321143222.2523373-2-fabiobaltieri@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 15:32, Fabio Baltieri wrote:
> Add a dt-bindings include file for cros_ec devicetree definition, define
> a pair of special purpose PWM channels in it.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>  include/dt-bindings/mfd/cros_ec.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/cros_ec.h
> 
> diff --git a/include/dt-bindings/mfd/cros_ec.h b/include/dt-bindings/mfd/cros_ec.h
> new file mode 100644
> index 000000000000..e02414eae622
> --- /dev/null
> +++ b/include/dt-bindings/mfd/cros_ec.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Same license as for bindings (GPL-2.0-only OR BSD-2-Clause), unless you
cannot (is it a derivative work?).


Best regards,
Krzysztof
