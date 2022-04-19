Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5950668E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiDSINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiDSIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:12:58 -0400
X-Greylist: delayed 1696 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 01:10:16 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270DDF82;
        Tue, 19 Apr 2022 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9qfOo1FOODXMcgRdw2ZARNk7YVVQEHz8SOv8rQTaLoA=; b=X2GPqOmJxqY6DAgWW5I24FKKxA
        9FS+xd33q5yCd1Go2L75/ZTQ1sPucX9A2LApeUCxsCsV3pQ0SM+g2nhKjek2kmwrAZbZvYBitGEW8
        RXfHkKyxVE4ZWlzyW6QZjhQpRjqqRnkr+3pfx68JtHm/goTEpIPsPvsHJxoS6osuKxqG6OKVBRxmn
        hizF/+03PXnEmqVk4EoFerdxuBzswE7m9vKf/Xrkkcv7EakYMKlxuVyIAm1nlUj5GZh+4QVUleCMO
        x0jdzJBHWen2/i4qEVq6ScpZVeI/K4nBiGEG5Cye7rZAWgvLDCGEkqDvFtV5SAHM5SjAcd16I3W4f
        c9W8DYYg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1ngiUl-000EbL-BN; Tue, 19 Apr 2022 09:41:55 +0200
Received: from [2001:a61:2a5d:d701:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ngiUk-000KyO-Us; Tue, 19 Apr 2022 09:41:54 +0200
Message-ID: <4a940702-8a34-c163-2e5a-8dfd835e56d0@metafoo.de>
Date:   Tue, 19 Apr 2022 09:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [v4 10/14] iio: document "serial_number" sysfs attribute
Content-Language: en-US
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-11-andrea.merello@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220415130005.85879-11-andrea.merello@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26516/Mon Apr 18 10:21:52 2022)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 15:00, Andrea Merello wrote:
> From: Andrea Merello <andrea.merello@iit.it>
>
> This patch adds ABI documentation for the new "serial_number" sysfs
> attribute. The first user is the bno055 IIO driver.
>
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2a6954ea1c71..3be613f64843 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2048,3 +2048,10 @@ Contact:	linux-iio@vger.kernel.org
>   Description:
>   		Raw (unscaled) euler angles readings. Units after
>   		application of scale are deg.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/serial_number

Can we make this `serialnumber`? IIO uses underscores to separate 
different parts of the name and to a machine (e.g. libiio) serial_number 
looks like a channel called serial with an attribute called number.


> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		An example format is 16-bytes, 2-digits-per-byte, HEX-string
> +		representing the sensor unique ID number.


