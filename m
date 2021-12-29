Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66800481589
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhL2REX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbhL2REW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:04:22 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D81C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:04:22 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u22so36658676lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fTrzUJWfhUIkdckLSHMnURIWay1hQkAnOl+6SgL3Qxw=;
        b=iL/eGYu1HjMm8BVvLrWVPKGJwWFEI9BJY8jfbW9O4spm7Y+Rb/nqCE818TUR22pidR
         BTR1QIRah9M8TayWD+Zza7+7pWMSikKh/UxZFvJ8uTqLYCLG7sG2obWMSjN4lzN4KSDq
         JMj4yi+WDUakiXsQfNOA2tjQDQvFGwqUL5N+IvGS+FXtxvM061MQwqPDKLdLtE3mKIGq
         rglor7Q/lh6D9GPYcYyaY6l0JUF869EmDEX4rtGmMbBhCCX/hgNFO/OnZV1Hf4QZeED1
         VApBUUYZ0ZiMXzAGIn1cz8mIO29J6fEWmAGW9jkaRCaqdriZLZCdqt4mUvmLNwo6Zt1W
         qd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fTrzUJWfhUIkdckLSHMnURIWay1hQkAnOl+6SgL3Qxw=;
        b=4sPnhrils7UoshU9S0Y8fodbyndupQ9u0v/WDHDUpVnCqpudd4P6mcILjG/OH1lj8x
         LgqhV9ZSFoZvbTIIwf7tcL+ogN/uf16jMrRODkFfl2ShUATkNuUEWDGQBKsuryilm2A5
         RSWflxKIqAsSlScKhz71OZOjDA637PjgNFknVkyi/6MDGWrwTmKMkNcdewp94vCZWmZe
         y1CT17sVK+Ew4u4dEWy0WMuy2Ix9svgMXQRak8FUZ6jf7oerPFvybkEaQ8HgVP+/zYfY
         1egqaZStEKdiqL2cyt0zBMYUav7YNlNuGcSd8pGvHPnBxP79QtJUmaIg/fupQg+oIOlp
         WFkw==
X-Gm-Message-State: AOAM530miBD1nEQE9HybDKpEcqfIel2PiVc6VJ1AcDkBqXXeLbWue5W1
        K1CvTvT7od7ixqWUAecOB7oWZ/ilvKm0OpZCfy8=
X-Google-Smtp-Source: ABdhPJy9XbWrnBPDstakJxVDB050NScEATy/Wshvr7LpHN1RnyZTAAmnTgZ+Ok5FsU0wgvur/5ydjw==
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr20600989ljj.164.1640797459871;
        Wed, 29 Dec 2021 09:04:19 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id b26sm2120463lfo.6.2021.12.29.09.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 09:04:19 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <87626d61-ada0-c220-bea5-5330f5256629@cogentembedded.com>
Date:   Wed, 29 Dec 2021 20:04:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thank you for looking at this.

>> +				port@1 {
>> +					reg = <1>;
>> +					lvds0_out: endpoint {
>>   					};
> 
> Endpoints must have a remote-endpoint property. Let's drop the endpoint
> here and keep the port only, the endpoint can be declared in board
> files.
> 
> If you're fine with this change I can make it when applying the patch.

This empty endpoint is currently defined in dtsi files for other r-car gen3 SoCs.  Goal here is to 
define lvds0_out label that is then used in extension board dtsi files to link to the port.

In this patch I just used the same approach as in files laying nearby.

If this approach is not appropriate, then perhaps need to fix it in files for all SoCs, to make it 
possible for extension board dtsi to be compatible with all of them.

Nikita
