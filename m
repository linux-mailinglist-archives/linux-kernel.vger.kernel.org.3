Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CC4774CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhLPOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbhLPOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:40:08 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CCC061574;
        Thu, 16 Dec 2021 06:40:08 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso29285753otf.0;
        Thu, 16 Dec 2021 06:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NklVkMmLqh9pa2V9PgmyGfRV62W/v92ZEZUhrUpcYQA=;
        b=CloXF/1UMUEh5xKisMeJH99O/He8Bqcw25CZ/RdpQsy5ys9bW/7wZfA+K8l4Q7CQyu
         Phl/B3VLSKa0kufet3d/korG8kV8z4KoXushEB4pnypCsNoAxnBXa60NFVs0ErNWFspJ
         lGbWfN4SbCNzlqwkKeh1AWUq3ItIZm/2AX5eY77fwHMcdGpmm6ASKyUB/yKchHR8TnSa
         G2EGatLX691TmlOuav3EA5zA3Y+l5qYWeI5wiyPr4LYiXe8T6zWF8qC7d2EQaYXQ2nU7
         ECW4pFofXdpZowGY7Lk/kQzMjw3QbAoMFCSu97Uo1yP5or7gf7diWBp+clw3FmqJqYs6
         TUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NklVkMmLqh9pa2V9PgmyGfRV62W/v92ZEZUhrUpcYQA=;
        b=YMeEdwQ5ufhG8CsphncqppRXn8qEOxdODRVRpifU3fcAbu6GFm+4XDV16AYZaZQ7iO
         up8KwxFIbgk+9ygF1Ou0Wz8CgjSKfQqo0Yu5HpoYHOmiobnIIP+CA9G2VxWMp/VxiDN5
         35PPxYD/YJLj/xnT6NaG5wI/pcY5bdvwYmCcJjieW+PjKPNXLuHAiXg+N1eHyHZDo2wJ
         AfVqdHdQlmWexXGSfPfePnvWeQOM2Z4BL+41ZMsRKEUqhIbLb+swsmbY0UPX+6IIi9oX
         K+8IZhos+Ziw+PSnvKyjOOb1wvddXw3Xff9b0NKPIxnUgAd4pKSx31BKSY5edW6GyDo9
         iliA==
X-Gm-Message-State: AOAM533W/RdTkB/rBGbMIkvBrBm3CqblruAZds1+EG8TgdnYAitSonpn
        0FbH2dswgvyI90DgPoHeFXlergouStU=
X-Google-Smtp-Source: ABdhPJyNtWKN3fFxP0LIffnKUpM1K+x9sQlg0mZFsc9i5GWliBsnkLCrASJT7vOIfS6eaeCzl+c0AA==
X-Received: by 2002:a05:6830:441f:: with SMTP id q31mr12812561otv.164.1639665607301;
        Thu, 16 Dec 2021 06:40:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2sm1046567oor.18.2021.12.16.06.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:40:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Arseny Demidov <a.demidov@yadro.com>,
        Arseny Demidov <arsdemal@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211215113023.2945-1-a.demidov@yadro.com>
 <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
 <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net>
 <c1d036c0cfa14fbb9c289f792780f003@yadro.com>
 <20211215162753.GB2906031@roeck-us.net>
 <CAHp75Vc646YB0FeYZrFYKHkzCQUt9Nu0bmaGO_1-5mxpQgGtLg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <76b93d2e-15d2-6969-6411-7839691b8dca@roeck-us.net>
Date:   Thu, 16 Dec 2021 06:40:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc646YB0FeYZrFYKHkzCQUt9Nu0bmaGO_1-5mxpQgGtLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 6:26 AM, Andy Shevchenko wrote:
> On Wed, Dec 15, 2021 at 11:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Dec 15, 2021 at 12:36:32PM +0000, Arseny Demidov wrote:
> 
>> Please add that information to the commit description. Also,
>> please copy Rahul Tanwar <rahul.tanwar@linux.intel.com> and
>> Andy Shevchenko <andriy.shevchenko@intel.com> on your patch.
> 
> I see how my name appeared here:)
> Okay, I have no access to the datasheet, I believe Rahul is the best
> person here to answer this question.
> 

You reviewed the original patch, so I thought it would be appropriate
to copy you on this patch.

Guenter
