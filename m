Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC174BEB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiBUTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:08:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiBUTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:08:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718513F25
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:07:41 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qx21so35566128ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RB+KnGP4vjA0xEYG3QLBV10Oe0XhSXLPzGOpTKcC0fY=;
        b=K4a5HCHQ7nMPlxRuuLiM+TEcOdIH2u4Ivlw02dABkJWLEtElRDBMXHD3RESCh/OdSt
         Bnoei2Jrw75XrR4m2W+CgqK6BV9c1M7NKPCk3cC+SU8KngQv+S39l8TPMUqldOaPA+o4
         a0QngcOYe4VzptVwY6+Tg5WqerVbT/J1+zbAjdKb6t9L9CDz7igCjUh63mByyT6GTtIu
         ghiOzW0aS/tegRFhNpYMDDVDsvm3f8Ne3lyWnyBHru+O3Bza+d9+UsMi2poWspKQ/0Ry
         kkAcIGeJAHOQLpj+xH0iKjdgjOy+sGjnXs/2WxbCpPCApGSNdS9xSgI3lKqpbEpPtumI
         FhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RB+KnGP4vjA0xEYG3QLBV10Oe0XhSXLPzGOpTKcC0fY=;
        b=ILwju+K354GKHzfVxS5+qISxPS8OVy6LVr62EvO9C/LWo7w2/eAGgwxx8IkOuDxN3J
         eMzAlePEdk6UebyjuOqHKnEY3v1wflb7D9grw/JrwkpqZ2KztHILSOUdONR2mbWhbsZl
         E+nSR1EUNDXfy0aZ9Ts6CYY8DJI4ujmNpkA7ve3TVzIXt3bquGOrE7/THzRr8s2a/xU+
         4WKgHBzJHwHzzdn0tfBlc++WcZPaYVXIRcPEYFqNbhtuYTXTYIJdTcWCcyoUY1R2hsjN
         NWnoUck1vAcRRSWhkABzFK8t+1thWMF0eygs3kglSJzFZYL/7yIbJBAgMkPdsAR6dAWZ
         L3OA==
X-Gm-Message-State: AOAM531wz9Sly6P3VBqGOxFmZo++yVJFWhbR2KRsRIc1CAXbIzTDQLS+
        5ef2qwG2j/gMAH+nzNYJDIc=
X-Google-Smtp-Source: ABdhPJzsNn3FN3IHD5Uiz1ak9lTE+NTulWsnCooaEKsILTt0Ty1qKTletT1JXuKhptwRDKjeaguxzw==
X-Received: by 2002:a17:906:a384:b0:6ce:c3f4:c59a with SMTP id k4-20020a170906a38400b006cec3f4c59amr16279290ejz.580.1645470460317;
        Mon, 21 Feb 2022 11:07:40 -0800 (PST)
Received: from [192.168.0.253] (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id q5sm5357733ejc.115.2022.02.21.11.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 11:07:39 -0800 (PST)
Message-ID: <28f888c4-e77e-3b2d-a65f-9596ff70c519@gmail.com>
Date:   Mon, 21 Feb 2022 20:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] staging: r8188eu: remove 5 GHz channels from
 ch_freq_map
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-2-straube.linux@gmail.com> <YhPIVFmStJOMI0QZ@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YhPIVFmStJOMI0QZ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 18:13, Greg KH wrote:
> On Sun, Feb 20, 2022 at 04:48:45PM +0100, Michael Straube wrote:
>> This driver is for chips that operate only in the 2.4 GHz band.
> 
> How do we know that?
> 

The documentation that I've found for RTL8188EU and RTL8188ETV says
that both are 2.4 Ghz only chips.

Also the old rtl8188eu driver had a TODO item to remove code that is
only valid for 5 GHz.

So I thought this can be removed. Did I miss something?

regards,

Michael
