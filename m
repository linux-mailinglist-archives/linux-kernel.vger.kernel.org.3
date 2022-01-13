Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAD48D2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiAMHZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:25:53 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41864 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAMHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:25:52 -0500
Received: by mail-ed1-f50.google.com with SMTP id t24so19643656edi.8;
        Wed, 12 Jan 2022 23:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=str16FI/F5xFD0n2C9n5hc+OZX67vqcPfd5sJFbgdGI=;
        b=5mJpsgnVihoftp+cmLaknRVDMvmgfZzzwzLaW2wip55WaMQDgAEBcUIVVXvWza9BNw
         BVuUiIuEbSil3hyvCxeilbYW4q4oz7xHiMI2SY5sHVFiBRiSAXLN6NDDmbdAZcwpBprV
         UuZDQ3qENg/UGwT/VGcoUsvGSwQQeMaCdjHrEQdMIKkEI/J9sg/nXmyZjcGT1SzBavg6
         l/DCicg642Gc0TL6ZDaTMpyRJqRFLQCo3wTv/L919off2sy0f71JyQikOWO1x+hUAH6c
         mxOkxoiSZwowmq5Kgxd2BcFKlPDC6mg+3T3CFSPDFVCJC/GFF0SN+JjTLxgBizo0s2a3
         u/0Q==
X-Gm-Message-State: AOAM533/chsynU8Py8TWH5LFbeY7UkxfyYl60jTN8iycykxxCrfYcku8
        nN9bzAr+ns1Cx0y6MiXOcHA=
X-Google-Smtp-Source: ABdhPJxKV6lDv8a8uMbMek/SWb8lQRWHNN5x+2X9xP0AmxTdpAmdqC2KIsyXwzOuWYYYr1gfrpB/MQ==
X-Received: by 2002:aa7:dbc2:: with SMTP id v2mr3053045edt.59.1642058750696;
        Wed, 12 Jan 2022 23:25:50 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g2sm587549ejt.43.2022.01.12.23.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 23:25:50 -0800 (PST)
Message-ID: <efce614d-c8e6-bb06-e3c1-cb67b26bbc6a@kernel.org>
Date:   Thu, 13 Jan 2022 08:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V5 2/5] tty: serial: meson: Move request the register
 region.
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110104214.25321-1-yu.tu@amlogic.com>
 <20220110104214.25321-3-yu.tu@amlogic.com>
 <01066e66-5d97-ab40-b4a6-99e962b47073@kernel.org>
 <cad33ab0-26d3-5b78-3bcf-62217aa70871@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <cad33ab0-26d3-5b78-3bcf-62217aa70871@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 01. 22, 3:48, Yu Tu wrote:
>> And no, do not resend a new version in the next few days. Having v5 in 
>> 20 days is a bit too much. Give maintainers and reviewers some more 
>> space to express themselves.
> I am so sorry if PATCH is sent too frequently, which has disturbed you.
> How often should I send it? Or under what circumstances can I send the 
> next version?

~ one week after the last reply to your previous patchset is about fine. 
You could see that people were still responding to v4 while v5 was 
already on the list.

thanks,
-- 
js
