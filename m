Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0085961BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiHPSBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiHPSAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:00:15 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57712832EF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:00:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z20so11302001ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jb2YCmtzStrf7oPaQDp5CORzVrMt6QsLXaku2/2alHw=;
        b=TXGV7d4y/nyORgZvCClAmPDsHxHFE+Iw8br/AFi3XE91TMuUOyIfAsfhM61WMj9Qa1
         I5zjtH0mBDtQeb0BVqCUdQ7o1uVZ61a8PvW+pTtTWMKTAq70/VliLez+g6a49Z40Hq5S
         kHoJ/f5XsvRKX1z98aaH8gGCQhyOw9hlnxJc0AQcGq5msKiUqW88Vs0QebsvNrke0gzY
         m6zIWXZ6M1XPkk5XX71u7GBk7S2r6jmzLfdHPg2OTulpRufdap6UqtSWZuWnCO+pCYQa
         kJ+wFqoefxVAXXGZyeMJZ3BCJIlpXrnKtbRUqGx7vZbdWnH9UsB48TfbcnbIidY7GduP
         /E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jb2YCmtzStrf7oPaQDp5CORzVrMt6QsLXaku2/2alHw=;
        b=3d9bCjh8kRTtzGsG15pqF4HISn8u0E/+dWcoxh5gwJOmVyDhrOm0LRYof/n182nz0s
         4b59CQdk/SEwUodqvR0JvODbgXbI3YNCq0uakL3DhuDgBT5Px8Xb9/+AWcEbSsT0LEW4
         1GyIAfInl3TFKABebZhL2rMLvK9sMi5KJZNQUo1h0ddJIRlmaKahb3evuhI4kVJ63XGM
         KQ+Kdhf/8PyH9Vzf2PWtbTkRvQPzZU3yzn0ryCJSpu9iXKWfEC3wHElc62P6/0bDOEK2
         v8aBJTmkQdNhbXy0NqmMWr2VPm3eGIY6b49trOYgHNZcBJfquNkvGLAmeUMwWEn1Xt8W
         GkYg==
X-Gm-Message-State: ACgBeo2RPBmG93uTg7S6YhMiEIcwvMIifleouTJUesTbZIOFx/+zqEju
        k3jkqav5crOfV4AwbCU5AMGFTg==
X-Google-Smtp-Source: AA6agR49/8LpwUjHkR0YA8dRHfC2fMxyKVR0zEGU/v61rAa06vW2HgPTJv99wXh3/r33rKkoJL73Iw==
X-Received: by 2002:a05:651c:2003:b0:25e:5c53:8915 with SMTP id s3-20020a05651c200300b0025e5c538915mr7330297ljo.88.1660672808624;
        Tue, 16 Aug 2022 11:00:08 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:633f:dc22:d8ba:e2cf? (d15l5445-7tvqvr3c58-4.rev.dnainternet.fi. [2001:14bb:ae:539c:633f:dc22:d8ba:e2cf])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c010900b0025e2c6b15e6sm1870773ljb.72.2022.08.16.11.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 11:00:07 -0700 (PDT)
Message-ID: <3f755d24-969b-1804-7979-880a9fe10cba@linaro.org>
Date:   Tue, 16 Aug 2022 21:00:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 02/14] drm/qaic: Add uapi and core driver file
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, airlied@linux.ie,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     quic_carlv@quicinc.com, quic_ajitpals@quicinc.com,
        quic_pkanojiy@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
 <1660588956-24027-3-git-send-email-quic_jhugo@quicinc.com>
 <10ad6023-703d-65cf-6b00-2caa658c49e9@linaro.org>
 <e9786447-edd4-90e0-25a9-b35e96adbfc2@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e9786447-edd4-90e0-25a9-b35e96adbfc2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 20:47, Jeffrey Hugo wrote:
>>> +static int qaic_pci_probe(struct pci_dev *pdev,
>>> +			  const struct pci_device_id *id)
>>> +{
>>> +	int ret;
>>> +	int i;
>>> +	int mhi_irq;
>>> +	struct qaic_device *qdev;
>>> +
>>> +	qdev = kzalloc(sizeof(*qdev), GFP_KERNEL);
>>> +	if (!qdev) {
>>
>> return -ENOMEM;
> 
> So, no centralized exit per the coding style?  Ok.

Centralized exit except for cases where it is simply return.

> 
>>
>>> +		ret = -ENOMEM;
>>> +		goto qdev_fail;
>>> +	}
>>> +
>>> +	if (id->device == PCI_DEV_AIC100) {
>>> +		qdev->num_dbc = 16;
>>> +		qdev->dbc = kcalloc(qdev->num_dbc, sizeof(*qdev->dbc),
>>> +				    GFP_KERNEL);
>>
>> Why not devm?
> 
> We were having issues with devm and the PCI stuff.  Looking at this 
> again, I think we can apply that here.
> 
>>
>>> +		if (!qdev->dbc) {
>>> +			ret = -ENOMEM;
>>> +			goto device_id_fail;
>>> +		}
>>> +	} else {
>>> +		pci_dbg(pdev, "%s: No matching device found for device id %d\n",
>>> +			__func__, id->device);
>>
>> How this can happen?
> 
> Badly functioning hardware.  That hardware has been removed from 
> circulation.  Given that this is an init path and not performance 
> critical, having this handle the scenario in a sane way instead of 
> having the driver blow up in a weird way much later on makes me feel better.

How badly functioning hardware can bind and then report some different
ID? If it reports different ID, it cannot bind...

(...)

>>> +static int __init qaic_init(void)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (datapath_polling) {
>>> +		poll_datapath = true;
>>> +		pr_info("qaic: driver initializing in datapath polling mode\n");
>>
>> No pr() in normal path of init/exit.
> 
> This is not the normal path.  datapath_polling is a module parameter. 
> This is something the user can enable, and so it would be good to have 
> the user informed that the option took effect.

No, not really. User always can check via sysfs and there is no point in
polluting dmesg on module load. It might be printed (if someone has such
modprobe setting) on every system, even without the actual device.

> 
>>
>>> +	}
>>> +
>>> +	qaic_logging_register();
>>> +
>>> +	ret = mhi_driver_register(&qaic_mhi_driver);
>>> +	if (ret) {
>>> +		pr_debug("qaic: mhi_driver_register failed %d\n", ret);
>>> +		goto free_class;
>>> +	}
>>> +
>>> +	ret = pci_register_driver(&qaic_pci_driver);
>>> +
>>
>> No need for such blank lines.
> 
> Agreed.
> 
>>
>>> +	if (ret) {
>>> +		pr_debug("qaic: pci_register_driver failed %d\n", ret);
>>> +		goto free_mhi;
>>> +	}
>>> +
>>> +	qaic_telemetry_register();
>>> +	qaic_ras_register();
>>> +	qaic_ssr_register();
>>> +	goto out;
>>
>> return 0.
> 
> Ok.
> 
>>
>>> +
>>> +free_mhi:
>>> +	mhi_driver_unregister(&qaic_mhi_driver);
>>> +free_class:
>>> +out:
>>> +	if (ret)
>>> +		qaic_logging_unregister();
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static void __exit qaic_exit(void)
>>> +{
>>> +	pr_debug("qaic: exit\n");
>>
>> No pr() in normal path of init/exit.
> 
> Sure.
> 
>>
>>> +	link_up = true;
>>
>> This is confusing...
> 
> Will add a comment.  This ties into MHI, and how it can tear down in two 
> different ways, usually based on the link state.

Shouldn't this be link_up=false?

> 
> In this case, we are doing a clean tear down where the link is still up, 
> and so we should have MHI do the extra tear down that leaves the device 
> in a good state, in the event the driver gets added again.
> 
>>



Best regards,
Krzysztof
