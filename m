Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F8468C64
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhLER0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhLER0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:26:45 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2CC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:23:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so19677945lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uFaSJUqtbkqjrLraqOpRDFxq6XMUSg8P8xGe/5qj4Qo=;
        b=HInyItokzsY7cg2aHn34yO6zRn2JEmzNtqBKaIsLft3KGMWo9a5OSO+s6QBchmq3Dn
         9vfXtyAWv38GdlYpxxdZnNzEMDqARNMnvaZjfmH4roXxc2xmHXFWgOamd0tnnIQJd93x
         iSiug7s0CrpRwDES4pJ06D93u1JJqp8FFggbGkuF+/BPN5gIY2wxKafWsvE5hWx5PIUa
         DGHEyXLtFAS/MdMDC7iWCGLfloI/69oBopyUIjc6RbPYJK0TK3ul0eKQsx+pBy1ZEtsi
         ByE4KfIb/R5HPmaL87daZTeSFkyqy+SL9XjX/cky5acrFb6j+74owgfUEZ5LY84/+EUk
         AE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uFaSJUqtbkqjrLraqOpRDFxq6XMUSg8P8xGe/5qj4Qo=;
        b=yNWR9+2/ZoDx8ungCOuRfc0ED3FG5ujyOEKte61togs1kX1yyXVUSquhfK4bUSGMkr
         WsFNPO0zBrkZMRqfxcxf+f8yomhTCBatPsJFuRvIUKgmYR5nA9Y4IVFBokRjDj1NjYGm
         A+cSllxsnwF19v0uIn4MzTUVuYodSPjSQgSoYw10WZAWD6BjQxffi6eEBjzbMzbKW+aR
         41NHoK/bZa6OKMyFJOj63FJcym2zoqmXThsU1JjlQ7PjT2+5FMrds1AynHklkWezInQY
         MAwUuldn4M8F9bage65yP9iKbTIWSdQ/uuTPEpOIRrhrtKiakFqcpyrFEKTDrVvhTD1n
         dExA==
X-Gm-Message-State: AOAM533pmrlfrPL5THMzBTYaH5y5zgM8xYj9SU7xtK+VA46JMz5joXrH
        1xLnH9gIk4fQO532lugwZoU=
X-Google-Smtp-Source: ABdhPJy/vmMTG7ZhLJA8zWPlGnpmlOtIczIOY6wOIvh4/R3cFSFlimwjHYDCtL1GBBd3rJUYlZp9dA==
X-Received: by 2002:a05:6512:150c:: with SMTP id bq12mr30946752lfb.687.1638724996270;
        Sun, 05 Dec 2021 09:23:16 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id u7sm1144780ljh.49.2021.12.05.09.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 09:23:15 -0800 (PST)
Message-ID: <51a14a4a-8385-b155-a16f-b4cc8b0096c7@gmail.com>
Date:   Sun, 5 Dec 2021 20:23:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 12/12] staging: r8188eu: hal_data_sz is set but never used
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211205135919.30460-1-straube.linux@gmail.com>
 <20211205135919.30460-13-straube.linux@gmail.com>
 <197e167b-2225-3593-dab3-4f1f61331de9@gmail.com>
 <b3886219-9a24-c119-fe10-12e5e7c6b139@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <b3886219-9a24-c119-fe10-12e5e7c6b139@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/21 18:22, Michael Straube wrote:
>> Not related to your patch, but not returning an error from this function 
>>   looks very dangerous to me.
>> 
>> adapt->HalData is used in GET_HAL_DATA() macro all across the driver 
>> code and nobody checks if it valid or not. If allocation fails here, 
>> than we will likely hit GPF while accessing hal_data fields.
>> 
>> Maybe we can embed struct hal_data_8188e instead of storing a pointer to 
>> it?
> 
> Rethinking my prevoius answer, embedding struct hal_data_8188e is the
> better solution I think.
> 

I also think so. At least, it looks like this is very core structure and 
embedding it into struct adapter sounds more reasonable.

Also, it is one step further to make struct adapter more consistent. For 
now it looks confusing: some of privs are pointers and others are not:

struct adapter {
...
	struct dvobj_priv *dvobj;
	struct	mlme_priv mlmepriv;
	struct	mlme_ext_priv mlmeextpriv;
	struct	cmd_priv	cmdpriv;
	struct	evt_priv	evtpriv;
	struct	io_priv	iopriv;
	struct	xmit_priv	xmitpriv;
	struct	recv_priv	recvpriv;
	struct	sta_priv	stapriv;
	struct	security_priv	securitypriv;
	struct	registry_priv	registrypriv;
	struct	pwrctrl_priv	pwrctrlpriv;
	struct	eeprom_priv eeprompriv;
	struct	led_priv	ledpriv;
	struct	hostapd_priv	*phostapdpriv;
	struct wifidirect_info	wdinfo;

	void *HalData;

...

and even why Haldata is void *, but not struct hal_data_8188e * :)


so many questions and so few answers....



With regards,
Pavel Skripkin
