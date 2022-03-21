Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB674E2CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbiCUPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350569AbiCUPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:49:29 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139BA25F2;
        Mon, 21 Mar 2022 08:47:58 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id yy13so30737580ejb.2;
        Mon, 21 Mar 2022 08:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BjjQzcelBwwnS4d36yhGsVN+lSuVcK+I/7pFheIbDzM=;
        b=LRkhqifFKkt9kkr+q+ZsSbuS1435iuBwr2Bq7RbtCahgzSnR6smsG6Pco/xwz0PnIg
         SBGrtQ9dP5OcI/sDkZEic3IbRwkpmvxDZ9CMVP7MWfrUjQoaKJJ5G1LKTlGWZv2IPlGI
         Y8BktMqG9+MhH1HNBt3dZLa6ZlkV3FeCIuGf7ryTzmQV9Y93Y99nIWKv5InRuXRkr2S8
         ZdTwV4d4QgWtHTL8ue4tdox/WWb4+uqESAHqUux1v5nj7tOhOeSEwJF0X9p0fIJ6Nmy2
         IxYtOXpBQtZ4K436m8WUFJrFVH3XI8y6qdWvdRVpjuJwnJ7+g5rpcGq/V8q+YB+LzDZx
         IoWA==
X-Gm-Message-State: AOAM531bj90fpW/9Z0edgPu1An0fBVYfiOckfvSG1wUSQo+VW+OPIbHA
        7cJbTS2F6HGNenby2BRcCw0=
X-Google-Smtp-Source: ABdhPJzqCtE5fkFOXCFcxOIHdOKfzJMEG7hn6xXZViUU/Ej/rG/kJINxuxhg/ic7+tAuhF/oYAgKMg==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr20829508ejc.436.1647877676402;
        Mon, 21 Mar 2022 08:47:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm8259784edk.13.2022.03.21.08.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:47:55 -0700 (PDT)
Message-ID: <09b4b714-4fb5-f2af-5a88-b48cbff35b7d@kernel.org>
Date:   Mon, 21 Mar 2022 16:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] dt-bindings: update google,cros-ec-pwm documentation
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
 <20220321143222.2523373-4-fabiobaltieri@chromium.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321143222.2523373-4-fabiobaltieri@chromium.org>
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
> Update google,cros-ec-pwm node documentation to mention the
> google,use_pwm_type property.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> ---
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> index 4cfbffd8414a..2224e8e07029 100644
> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> @@ -19,6 +19,12 @@ description: |
>  properties:
>    compatible:
>      const: google,cros-ec-pwm
> +
> +  google,use_pwm_type:

Hyphens, not underscores.


Best regards,
Krzysztof
