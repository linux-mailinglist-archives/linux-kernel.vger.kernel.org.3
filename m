Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822215258E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359141AbiEMAMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiEMAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:12:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC652B23;
        Thu, 12 May 2022 17:12:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v4so8411554ljd.10;
        Thu, 12 May 2022 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ir54uCjbCQLor1M6H9orMXkqmrqN80NYNn3go1RhTOM=;
        b=XtxItwL/MbtRBi8arGgCgg6xnSUQwvfa+FCMjXXlHsf1jpy8PoD31EuU7yubvkMPCH
         Ev36d5pKXuEAv+WWb7KT7De48OkEk7F/PT9zANVNukfYwmWW2BB37PcDBu2hq7RiJzkS
         L6SlwIIPenBk64g+aPysOYm4yKmg5MgowJU+Gt/v4YRv0fMCxwwTM97LXyjXCnZ1pMkF
         hziixrVUrnmCLy2GisRmSaFl3x8QfkJxjnmAt5kFkCsLpjh8FBrClWpn0lwo0B0G9woz
         e5C8P/KksEm3BctSbXc3Cjak+BBsTTO/E/gvkqaddfy94ppNV2aYOeW0BxbCPu6ApXlT
         t8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ir54uCjbCQLor1M6H9orMXkqmrqN80NYNn3go1RhTOM=;
        b=4l95hGr4XAXGipttak5MUdmmlS0KMWrE6CsxNHC6NsGKSFSP3aIiW+BVexbc7LILC/
         ZLaxxOmFRaLW/ZCFjliaTHDaAZleGGl1Ljsk9gucL1wvQlBqQqLzJxXr/SvA2TLHSy5b
         jDCdCrkyYdFbJTWoMzBmBFgHMsBDcXUDWTwCMomsBxNxmvC7gdXVS2ZiMHPBApZ7p6Me
         Zkr+JTac2AXi+xN10VaTwpZW/NmfK0EuwLP8blqtWLHECSjGTdbmKhzck5+BB9RhHcbF
         W0TihS1oB3j2JUcrOg5iyDJyhP9PYheDNbyjad8XCEKH1seT5/NMS8jIgNyfZT2zwuCv
         bs6g==
X-Gm-Message-State: AOAM531SHDYkyzZWJ5EJ+tI8BhtWIBym1IMhB8K3pCCUMe04D07J/lI2
        bpw/4OI7/0Ud0G3oF1d9LXaXtY4TayI=
X-Google-Smtp-Source: ABdhPJwnJjevalcn/CPFFiAIV1hi8T8WOFBpbBWi8ZY0DivCkcNyGmUhqUjui8cBAjYbbPTIDWCIJg==
X-Received: by 2002:a05:651c:205e:b0:250:796a:e074 with SMTP id t30-20020a05651c205e00b00250796ae074mr1497943ljo.41.1652400764154;
        Thu, 12 May 2022 17:12:44 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id v4-20020a2e7a04000000b0024f3d1dae7esm172449ljc.6.2022.05.12.17.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 17:12:43 -0700 (PDT)
Message-ID: <6efaab50-12ef-3d37-3136-e3e00b47c613@gmail.com>
Date:   Fri, 13 May 2022 03:12:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220511094024.175994-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.05.2022 12:40, Shreeya Patel пишет:
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata, cleardata;
> +	u64 lux, div;
> +
> +	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
> +
> +	if (greendata < 0 || cleardata < 0)
> +		return -EINVAL;

-EIO should be more appropriate error code here
