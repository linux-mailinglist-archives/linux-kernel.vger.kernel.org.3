Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5483B48D680
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiAMLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:12:40 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:42889 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiAMLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:12:39 -0500
Received: by mail-ed1-f48.google.com with SMTP id i5so21702926edf.9;
        Thu, 13 Jan 2022 03:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+I640+M7ZrIju3BDmTll+98qG/6MsN0P8dYMqkWxIVA=;
        b=6OTDxeG4ZiZXVAGIz2mruI61Ycb6IebAplVUDd834ScEBp6C7U1ZsFglQGjoTmMv0r
         iSLtjV/qHbszYaXYLqXsYfmysF19dcSb/G0hpY0LddJIyz/N2vtnYvSqQFmcFBOvLTFo
         jmkbjqQTfS9tjQjaJb6x5mGW8OErhFq8cr1UxnHPCsEkHkogtItTxmVOk4qxGwyVydD5
         OFwqbveCA3GP86y83pRQX987cAGV4KLIvatEn9OQv71+frc6wECGphneMDOC9vdElsc6
         hzlewbGxwLyYqObKADmYOb4UTu/9FRGv/Tg5hVe5JZ0zMuHiZ4RIFnpTx0B3ELpAVIyj
         YmfQ==
X-Gm-Message-State: AOAM533d277zclM5nJGqOubHtTC6DdC6anD/4yhxXqadAhqS3Sp7mfQb
        D6IgWofYKJoJK+y59t0lDuE=
X-Google-Smtp-Source: ABdhPJz2jyQ9iYcZAeaS/pWcrDxuda4YOQusK6OFqAKFAgoWpZR8W9h3cNgpKyQimCRjw6iha60Gng==
X-Received: by 2002:a17:906:6996:: with SMTP id i22mr3234069ejr.293.1642072358424;
        Thu, 13 Jan 2022 03:12:38 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id qk34sm758939ejc.143.2022.01.13.03.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 03:12:37 -0800 (PST)
Message-ID: <2cde3ff0-5180-7c1e-82fd-7b58e41d462a@kernel.org>
Date:   Thu, 13 Jan 2022 12:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Content-Language: en-US
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com>
 <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
 <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
 <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org>
 <CAOX-t57KZb0hNDuhPsabkmkf_qOOLqyH3yuvkHP6UNwhLodWDg@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAOX-t57KZb0hNDuhPsabkmkf_qOOLqyH3yuvkHP6UNwhLodWDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 22, 11:56, hammer hsieh wrote:
>> Could you explain me what posted write is and how does it not matter in
>> this case?
>>
> 
> Each UART ISC register contains

No, you still don't follow what I write. Use your favorite web search 
for "posted write" and/or consult with your HW team.

-- 
js
suse labs
