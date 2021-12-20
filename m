Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4247B12A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbhLTQg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhLTQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:36:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:36:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bt1so22909845lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c+N78WDl9K0dF3N13dZEbhlEbhbeqqk4HFIa/BtOnu0=;
        b=hPpZMPbJhP6wtRXH+sEm9QWUCYxPnrFRTQcnYsTof1GrKcDJ/5aPwWJ9oIw0x2tJad
         9Z4KPc7xyAJDJlM3kWYdAn/1pXbTOJ1fgxaEh/Gy2SFs39jjD898NSMPov2mqEQ+Lqiz
         h05Y1zENSsYKOvgG2Cu9dSZ27h4Y90ll+IKly76v4N93/kPpK2HwwOTD4CSMP6Jqnfv5
         Dq7tAtX7yTMQBsCRgylHGvLtJi2BgYqahfPeufB3gOkImcgRMzR3TENnCBH75DV5zTKX
         ahxK1x3Itn3g7On44owcV+7wrujuEaraexf231EtucyEvQcXLvvYO3wVKIcbIXtfL8Fn
         IBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c+N78WDl9K0dF3N13dZEbhlEbhbeqqk4HFIa/BtOnu0=;
        b=hgTVi4cXAlmPgIPbTVvCRr291mM9icGIPeiNMxpnTZLwMwnrKpY6zVkTqIr61SGHgY
         n6uQwK1/wnzhyyLp9t6Z4EPCb1md0QYDCE1GIUzKxjP8GaFl3IWG1RzAuf0qtG0+MCOn
         j0wT60IrVSN/+PesvGKnCYTvPGS5j2EkXaFWMvs6sxDVLtIk1HlaONfJsQQi4j7vUV0s
         w7LzyYMoSn5+RaSRUs/5nfKOUJk9dRvG+J7HApmTrYPg1x7qrWHCr7jCwrXir1bziFi9
         PkAbOYn5OVzz7WbWNqwQ35LwZIvqA9tf2OHoZE+FojXCas0fkYaEP7wcEyGml1yYwkBN
         vc4w==
X-Gm-Message-State: AOAM5337TzLTnlCLIJZQNW8nKVNhYtK6ialspWMyrIV6cjWb5bz3rdem
        TdXF7IMH5wFG29Sk7Kcv8cQCnLMMPoA=
X-Google-Smtp-Source: ABdhPJyFahvsEgzpy32B8BlbvcAWxb2T1XTVc1eB2QbgI9VFCP7zqP7whp3C7iKFTs0eJil9f610Tg==
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr17164895lfe.473.1640018214973;
        Mon, 20 Dec 2021 08:36:54 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id br37sm927701lfb.99.2021.12.20.08.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:36:54 -0800 (PST)
Subject: Re: Aw: [PATCH v3] mfd: rk808: add reboot support to rk808.c
To:     Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211220144654.926112-1-pgwipeout@gmail.com>
 <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b0d0e2ff-4282-f104-b8f5-554b059200c9@gmail.com>
Date:   Mon, 20 Dec 2021 19:36:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2021 19:33, Frank Wunderlich пишет:
> Hi
> 
>> Gesendet: Montag, 20. Dezember 2021 um 15:46 Uhr
>> Von: "Peter Geis" <pgwipeout@gmail.com>
>> @@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client *client)
>>  	if (pm_power_off == rk808_pm_power_off)
>>  		pm_power_off = NULL;
>>
>> +	if (of_property_read_bool(np, "rockchip,system-power-controller"))
>> +		unregister_restart_handler(&rk808_restart_handler);
>> +
>>  	return 0;
>>  }
> 
> this change misses a declaration
> 
> struct device_node *np = client->dev.of_node;

Good catch, technically the whole of_property_read_bool() could be
dropped from rk808_remove() since unregister_restart_handler() survives
if handler wasn't registered.
