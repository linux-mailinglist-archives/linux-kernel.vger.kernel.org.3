Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205D57F180
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiGWUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:47:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B71D0E0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:47:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p11so7793522lfu.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YMYNdsFRskYRkvEb/JM9UkC4CjAmNkgwoJhl3q9xdKU=;
        b=h8wBZt8JujREOhVhzTJLg6Wi3bx9fDhUOgc2Kl0nhO6xHDyrTNSPLCb8Ho0GYoL7Pr
         LsfI/CaPz0uyg4VcJbYQmc+L/MkY/ouI+kbJEDSlGPIkKr6fCpZqs0zTd9kCahH2Hk03
         CaOqTl6CXRdnflGFdVjyjKVEPG7H1U1S/y5zrNHnmAnMZdSiTc8e4JPo/NgDecZCJzIy
         yg3pg7LHBexXbdCNzudxlAjAiGeZLr27o6nB5YnbCO+wYejvIkbOP9q5BNAam42x7zk/
         DOciyd/TuvJeXlG3Ex4+Xjiso4gv/7IR676mfkGXHeN4RUGZ0DrAFYbU+9zfSuSthhjw
         aAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YMYNdsFRskYRkvEb/JM9UkC4CjAmNkgwoJhl3q9xdKU=;
        b=3pK02gCQ7os5iFUeUjbbeGjmQxTQSdjcobXgUFAyXQQRdqKpE+E/BnWbsN5mb0YD4j
         lZyv9ZFMDKnZquHZzMlOM6sjo9xDnzmIpw5hXW2cibzRKAhNxhPDY3XZo5Qi8BLj7IEv
         QXePUA0KPJZl7X0Pzs4Ad0lWb/a/mt6dw1NccMBzZ49TdiN8mfTV+VxcWJkyEIsmXTi2
         iRmjvn0cS/TYNHZ+uM3NK9oJezvNYgnUerNjbmQ7+vFxqQEqKB2OzETXa2ibeE29HXPe
         LM7Ha2aQYq/SYLPOWb/lO8xCoAX1B88GVHjvrQk+JhNfgTFlvoY7scq32we+GOZvsGKT
         J5Vw==
X-Gm-Message-State: AJIora/HVvACABfnLiwOzdw8MfBWwxxS+ceKLkbyVVa/EXIYx1RYX4cG
        JFofc++cAN/Di9aOj2qw5xz5Wg==
X-Google-Smtp-Source: AGRyM1vhGr/RB3Umpg87EaPMr8S/tV2PfMpFDPJFPWK3eNBrQtH8ZvijMs3raxhKb540/b1gKi9YsQ==
X-Received: by 2002:a05:6512:3d92:b0:487:5cea:a68b with SMTP id k18-20020a0565123d9200b004875ceaa68bmr2116366lfv.21.1658609241142;
        Sat, 23 Jul 2022 13:47:21 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id p18-20020ac24ed2000000b0047f6f8f20dcsm1832953lfr.28.2022.07.23.13.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:47:20 -0700 (PDT)
Message-ID: <6be14a28-a70c-e94a-f6b5-eb5251e14f56@linaro.org>
Date:   Sat, 23 Jul 2022 22:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 3/8] dt-bindings: soc: imx: add interconnect property
 for i.MX8MM vpu blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <20220722125730.3428017-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722125730.3428017-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 14:57, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MM VPU support NoC QoS setting, so add interconnect property
> for i.MX8MM VPU blk ctrl


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
