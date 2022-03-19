Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C74DE91C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbiCSPvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbiCSPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:51:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F012BF92;
        Sat, 19 Mar 2022 08:50:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so14768593ljr.9;
        Sat, 19 Mar 2022 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kVa5mxlIlsq5dXncE9W/OyQ3ulZn0gwZ8ABpkUdcWAs=;
        b=cMopkxMqHshhtt171SvmV5lYsL3VWPS3rQrEgW2+WbP7gBFdVDWJWCtgMkQvJG1L99
         rb1WNdJDvef3YDaCJpqfFXFBDIhLIXMOHGUm5N6R9au6cSjsRuKi2nTpdBqjW5ZOAJKC
         14kJa/OyBi9Ib7aCO9csNdbBm6eyMqgwnNPnIfcMEr4g45WqHxB98+LG6IE7Gq4pxLQD
         uKSzKHPKVM+Ss1yM6l00j6ZddIcGwn7T+AIA16HCzjI2R9Lej90T2/S4gBv9zJcaG7zP
         b1l8yTfnk+Jqb8eLcI5bZHqwB9D8Urc2QaE6gG2da9FlMQQFB6Vpp0njqtlAh5YMOaKs
         1C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kVa5mxlIlsq5dXncE9W/OyQ3ulZn0gwZ8ABpkUdcWAs=;
        b=FWMj1hbt3MyG4XO43sWuuR3PEfcirp/1zbZa1/AmMIx0ZM4VBAHmNM4l0zkr5cA6KT
         eAOakEFa/92UDNqyzIaVyQKP7r2mh2vwO9DhCd1ow6QUI6sikDLNI+zEoOQZFXLIvs9U
         Sb652e+fdL8mYCn1DqiF9/qdNiYhcZ7W8yITGnae7Jps5ejDx5N49IwqY3maaRhgUEpN
         2Mx8+xrUclC+iImkCuPJWZhS4sjAoVBHb7tTGjilI/tyzMdpT6dWdcLfryOVgN+aCJNM
         eyH/8yq9GubYahbzaSr7b4BfT5H6ZWwW+1fCV6vBhCrJNJzDi8suTVgpqLAgYBk3UCfs
         q9yQ==
X-Gm-Message-State: AOAM530EGd0Xj6NVxxGnE+QkTdrzcvlu+Aap7zjXWwejAi1gT/BC4/Pv
        tYAA5EdaW8qf04WJ0T30gWM=
X-Google-Smtp-Source: ABdhPJwOmeCO2tqkTX3F+ZJZWzu0JG3+2ifgDATcLgL6B8xf+45fOKRMGzevOF9aIO/2Uwj43cNlTw==
X-Received: by 2002:a2e:b55b:0:b0:247:e52e:75f3 with SMTP id a27-20020a2eb55b000000b00247e52e75f3mr9756005ljn.260.1647705026334;
        Sat, 19 Mar 2022 08:50:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id i2-20020a2e8082000000b002497e36acffsm45973ljg.78.2022.03.19.08.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 08:50:25 -0700 (PDT)
Message-ID: <fc8f35f8-ccc5-e847-e988-c4b882e53a44@gmail.com>
Date:   Sat, 19 Mar 2022 18:50:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220316092525.4554-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.03.2022 12:25, Ashish Mhetre пишет:
> +irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  {
>  	struct tegra_mc *mc = data;
>  	unsigned long status;
> +	bool mc_has_channels;
>  	unsigned int bit;
> +	int channel;

unsigned int

> +	mc_has_channels = mc->soc->num_channels && mc->soc->get_int_channel;
> +	if (mc_has_channels) {
> +		int err;
> +
> +		err = mc->soc->get_int_channel(mc, &channel);
> +		if (err < 0)
> +			return IRQ_NONE;
> +
> +		/* mask all interrupts to avoid flooding */
> +		status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
> +	} else {
> +		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
> +	}

So if mc_has_channels=false, while it should be true, then you're going
to handle interrupt incorrectly?
