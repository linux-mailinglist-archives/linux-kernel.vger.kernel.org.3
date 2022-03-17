Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20324DC80E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiCQN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiCQN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:59:10 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5A1DEC1A;
        Thu, 17 Mar 2022 06:57:52 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so3245492wmf.0;
        Thu, 17 Mar 2022 06:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxzfqzF9DUDWUAdXbkQl96dvUawwfyjYl3PBDi2W2sU=;
        b=QG/p5YA5f8ewtIbEJlELmgp9J7rADLS8j0XmeE241UeM3DWbqZF3E4gDN+gvI0H5EI
         zn5WtmM4DLXh4+VKjQhQ9fcpr/ZYWbRha8mVgH+6M5ceAev7/89rMR3kCMJwppLXXd5p
         Bi2ZFHHlpC4XtqaFSjb5Ksu7RvAI+uuPFU+emXvuYBE781Qf43ZB34iA5t5bymOmpaWI
         Vea4F/BA8yah5TAPYjzS1lrxc2Eai/T7iLzoejsqc0syx1vSjG61ukAIMT4QT6gp1AFE
         8rFM+ehajjZzqpXrwh/G1D+YjaULX3FSrnxtcBghxF6hw3gvCA2+g1k3za1KWMpASCXb
         kZxw==
X-Gm-Message-State: AOAM533AE13otzMyRQQ89seeNf3lhTTlILyPb7+X8MVRpIBxKjuAEn6P
        10lhsvOzfgYWBNk8PQ09li5xnlGKjbY=
X-Google-Smtp-Source: ABdhPJxxIf/mU2jqy/1NcnS05LTtUL/fITE7auGEjuzFTa5v2l9Oy+4Dijc5WoQ0bWflwi36K8yX0w==
X-Received: by 2002:a1c:7303:0:b0:37c:9270:2ff4 with SMTP id d3-20020a1c7303000000b0037c92702ff4mr4030655wmb.99.1647525470536;
        Thu, 17 Mar 2022 06:57:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p125-20020a1c2983000000b00389cc36a3bfsm7884258wmp.6.2022.03.17.06.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 06:57:49 -0700 (PDT)
Message-ID: <39debba5-3536-2423-5ac6-9fd66836d736@kernel.org>
Date:   Thu, 17 Mar 2022 14:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add bindings doc for Sunplus SoC
 SP7021 PWM Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
 <1647237097-29172-2-git-send-email-hammerh0314@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1647237097-29172-2-git-send-email-hammerh0314@gmail.com>
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

On 14/03/2022 06:51, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC SP7021 PWM Driver
> 
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v3:
>  - Addressed all comments from Krzysztof Kozlowski.
> 
>  .../bindings/pwm/sunplus,sp7021-pwm.yaml           | 42 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
