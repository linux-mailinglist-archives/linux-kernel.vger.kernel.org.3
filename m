Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B8483645
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiACRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiACRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:39:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E89C061761;
        Mon,  3 Jan 2022 09:39:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n16so25348704plc.2;
        Mon, 03 Jan 2022 09:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LhrfJNdIiSCtMsFYAlLLJE0sYGELSM2UzBcm11PRSn4=;
        b=B7C+onQVE1jGMZzeEpLnB5U+LQ6mFcJPlq3GjByJCEFk/Uu35N4rpujOJcFVxq0x9B
         4+qBdSbhWEMtLgISBzgK0l1wE9jlp0Q+g/fsI7r1oYVy0zbnUoYR3nTjfn9nmCZsiZsI
         Y4E/TdWE70WRBnmsSAHsBSnSvLHg+hy+avQ+PfU4P3Mb/9HaZCdtynk0WSnu1myc0FDs
         KNRfe530KFQ3VA3dlHKqy/64T0i9Cevkuua+FKo0slhdqIEK4tj7gv/+xWGUQVJrM0Js
         SqoekeV8uPnpZDMkE3e+cThrU6FwCvE2IKCAhhFqXdsmebSjz4Q0oRfZfVOSFLvuh86s
         Hu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LhrfJNdIiSCtMsFYAlLLJE0sYGELSM2UzBcm11PRSn4=;
        b=t1upvOyWYrEvdNj7zBh02xR+MX83vR/hb+H51czr/a79zWUm6DQSOE8IJ0gYmpFwZf
         WMkdyu2Ryo/53h+AN1yTqYpfNSD0ngmdZBuY6yQwRzZPgvywko/57XaOrYK6IicIaIPR
         S79MMtPuj+4AqTsFwIAzAC2UI0GUwmEQM9MRYyefJH4hZFLSc3+bD+G0FQJE6qD1ymk6
         GNwUzTplKE3GJW7MWLf445qGL/qe7nUs+zbgc93cmM/+kBqgwfxLus8g0Y7MEdFXfwyE
         QJ6sM0kGz31HKUQtWye0V6ARDxNslOxhOqyHDCsef6Rp7UoDvV304mDsxZNfiS9c1z9t
         1Xow==
X-Gm-Message-State: AOAM530jeW4naWexQO+D58F7mFuQadxBxa5dBR9sB3RPnp5J7/kMWG5B
        HUQSg89hOCztARP8tWKYP5M=
X-Google-Smtp-Source: ABdhPJyjuqmW6v6SbOHXmNlfvLcy2CNx1UyOV3rphN8rrDR7MeK1soK1lU4BgLU8d/y/OOAqrgaxMg==
X-Received: by 2002:a17:90b:4ac5:: with SMTP id mh5mr56397951pjb.2.1641231572260;
        Mon, 03 Jan 2022 09:39:32 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id c17sm40337300pfc.163.2022.01.03.09.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 09:39:31 -0800 (PST)
Message-ID: <5369c742-5e41-b9dc-915c-e5f71618df63@gmail.com>
Date:   Mon, 3 Jan 2022 09:39:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] MAINTAINERS: update gpio-brcmstb maintainers
Content-Language: en-US
To:     Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Doug Berger <opendmb@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220102020811.8013-1-gregory.0xf0@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220102020811.8013-1-gregory.0xf0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/1/2022 6:08 PM, Gregory Fong wrote:
> Add Doug and Florian as maintainers for gpio-brcmstb, and remove myself.
> 
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

A bit late since the patch has already been applied, thanks Gregory!
-- 
Florian
