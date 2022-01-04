Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1128D48497A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiADUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiADUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:52:56 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C9EC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:52:56 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h15so49131029ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hQXt2kCpfG17wQ1j0L2RQe+/2vBRsqY/bfs0/xljrmk=;
        b=Sl6kYQCb3QpKqVRvV+KqRiCE6mav78rEOgyuwrXmG0oiUQKGAudDcsSOVFG172QqKl
         lsyMpFUhe750++f0TIjr8WLhKNIwA55tclWp1quOopzdmbV1mZ9mFZaXiIGJaBooFt84
         YfT+wTiBvMjjxhs5SCX1VFbTct2ID3Jzhkd1PwGwGZ9S9fC2Bo+/QROM6dQClKSs1lW0
         JGTsphOv1SZWSXCADf5NrWYYv+n8rJ3IpDbvvXCmgNdg10ixNAwAXZww7Clw1D5/KS20
         Yt/ogRKlgnah9D/cpkkGxp9/ClIXSAFnsbdNiWoBBObKBHndH1kDZBovDxtrNcR+WIW7
         dz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hQXt2kCpfG17wQ1j0L2RQe+/2vBRsqY/bfs0/xljrmk=;
        b=n1ZgpM2KB56jQ+X8a1PZ6BYhtw3W3cL1P381yR0CubHv52WwJH8rDQdsgm9BX6DvNO
         UuniFpG1h8YzP9Vt2z0us+vTbrueyR8+7TPIz79206f7K05vJk2Fo9HRCL+BUcdPaCr+
         K/B/BCKWnY6VyxUugC3DBl/Tfs05uEyXSv2EIv+UgOkbk0saPw/Xd9nr7pwpBNZigJn1
         4KVOgbIXZcK22ghlKSuzy1RhvOY1c+AOtOjKJ0jCAhNzokO4AwZoktc7O+e+Ri0EN3T9
         Xc2HpxyyW3M5TXszMc3kJB9Oq4zqTGrS8CWtwh2wXtneP+o6+e2uitsngwN9tgC3NBoO
         GL6g==
X-Gm-Message-State: AOAM531fz3Dip7Be/7G8ibX6QKX838DLxSDGMc4A8kh2LSGNs9kWnuRj
        2qIJ8B7GybVQ+M6vHdYiD/U=
X-Google-Smtp-Source: ABdhPJyQK7kBxykRgNtvFA6LuKt3Snmy/xF5WKSxPxjbxF5RTO+yMs1pT9KzaOvYRnmX1y1aOn55UQ==
X-Received: by 2002:a05:651c:10a6:: with SMTP id k6mr40926577ljn.194.1641329574663;
        Tue, 04 Jan 2022 12:52:54 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.38])
        by smtp.gmail.com with ESMTPSA id c4sm4015245lfm.160.2022.01.04.12.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:52:54 -0800 (PST)
Message-ID: <f93b7f73-ce0f-2f95-d775-5d644c05ca21@gmail.com>
Date:   Tue, 4 Jan 2022 23:52:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 5/5] staging: r8188eu: turbo scan is always off for
 r8188eu
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220102175932.89127-1-martin@kaiser.cx>
 <20220102175932.89127-6-martin@kaiser.cx>
 <6d33d346-b797-aeb3-8b1b-64332e05fb87@gmail.com>
 <YdSzNFZ+DXX6gemR@martin-debian-1.paytec.ch>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YdSzNFZ+DXX6gemR@martin-debian-1.paytec.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 23:51, Martin Kaiser wrote:
> Hi Pavel,
> 
> Thus wrote Pavel Skripkin (paskripkin@gmail.com):
> 
>> It's a bit unrelated to the patch, but I found it while reviewing this. It's
>> in the same function rtl8188e_PHY_RF6052SetCckTxPower():
> 
>> 89: 	u32 TxAGC[2] = {0, 0};
>> ...
>> 92	u8 *ptr;
>> ...
>> 129	for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
>> 130		ptr = (u8 *)(&TxAGC[idx1]);
>> 131		for (idx2 = 0; idx2 < 4; idx2++) {
>> 132			if (*ptr > RF6052_MAX_TX_PWR)
>> 133				*ptr = RF6052_MAX_TX_PWR;
>> 134			ptr++;
>> 135		}
>> 136	}
> 
> 
>> What is going on here? Code just checks and writes to random place on stack
>> outside TxAGC array? I might be missing something, but it looks wrong...
> 
> TxAGC is two 32-bit values, i.e. 2 x 4 Bytes. The outer loop selects a
> 32-bit array entry, the inner loop iterates over each byte of this entry
> and checks that it is <= RF6052_MAX_TX_PWR. I don't think this writes past
> the end of the TxAGC[] array.
> 

Oh.... I should have go to sleep earlier that evening, sorry. I've 
missed, that this array is u32, but not u8.

Sorry for that noise :(




With regards,
Pavel Skripkin
