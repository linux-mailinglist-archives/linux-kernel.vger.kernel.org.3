Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5DB473B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhLNDhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLNDhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:37:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0023C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:37:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso15056981pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IP4nuXjL8uTtqvqJmO5l+VgMYJPLmImMRMKwBfOLCJs=;
        b=dYs4fsUc/ftGqhXsXLmmMPZQKS1qVnsCBazczVlKlS2mEa2kpWqnL1WMFDJBYxTHMS
         fCG+mhCtl/kkf88/iR5H36PTVwIAcN+QG2Xg/4Z1CGYMamydrsnWIVkzDidbXh5UV/2z
         WpeMQtyeBMrjXnm8NFMpLleHbDTrmoGpST1pRPYQOpb3ZbIklXGg6V/Fs/i99/hbh/Ca
         F7kG5YWZO+w3kS8vBh2s4/Gjrw/0SeQhTO8FbtFN84o3HLf6W0ApiD/4O0r5QowTjv1G
         XzNL5rhORolc1p539lJFNoEf+Phmo0ycqURbQy8zNlbBlPGjxp7thxH7U1p8TjkRmq4n
         clew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IP4nuXjL8uTtqvqJmO5l+VgMYJPLmImMRMKwBfOLCJs=;
        b=zkbbRuBWxPMByfBlhZZzdq/+qIe1kyl+/UJzCKr93u7IM6P9OSEvexlZp8XyoAoCSs
         3VHNhq7ctEA299+a31BLj757z8rUG6Fsch1L6Tt8SnKtXmeJgHn/MScsq3lZjJmWvKMV
         Tbw33NfU7998PHf3sVRgnZQceG1s2LGZJYVlxbJXAApcO+NbWgl0nMBkzf9VoDCI70ln
         vXCRLPKfPtgkgUyN9FvBUzrQacOVgs0359uIiAB61vybnFS8E4rJI4yXQu3I2dEm+uAA
         AnpNwli8q4iyv4fIpzqxQBqtuQ7lfqJGVGdrwNGtlN90wT60M52acccbOa5LemrC7bTq
         YiLQ==
X-Gm-Message-State: AOAM533OWy+EPZo9AEutP17Ou288Yv5vX4atNfOxEBaMLvfzq+d2D0Ch
        r5+DhaMNwtmHPn2h4+Gq5UI=
X-Google-Smtp-Source: ABdhPJyOXjepbtgN3txKAxlArBP0F+1RILwMvlbTzpk2gZ+lnyBNtrRK0MaC1+jlj3K6T4yfnkkL7g==
X-Received: by 2002:a17:90a:c08a:: with SMTP id o10mr2750396pjs.44.1639453055301;
        Mon, 13 Dec 2021 19:37:35 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id s28sm15333226pfg.147.2021.12.13.19.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 19:37:34 -0800 (PST)
Message-ID: <bbdcf6cf-8275-ef57-9307-fd7e2b456718@gmail.com>
Date:   Mon, 13 Dec 2021 19:37:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [GIT PULL 2/3] bcm2835-dt-fixes-2021-12-13
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211213123040.184359-1-nsaenzju@redhat.com>
 <20211213123040.184359-2-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211213123040.184359-2-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2021 4:30 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-fixes-2021-12-13
> 
> for you to fetch changes up to 6a56599b5a6b19adb21f8f0d9f2d33511426fb20:
> 
>    ARM: dts: gpio-ranges property is now required (2021-12-13 13:06:25 +0100)
> 
> ----------------------------------------------------------------
> A series of devicetree fixes aimed at the Raspberry Pi family of boards:
> 
> - Phil Elwell adds gpio-ranges to RPi's main GPIO/PINCTRL driver
> - Phil Elwell and Stefan Wahren correct RPi400's GPIO expander's
>    labels
> - Stefan Wahren drops fallback compatible from RPi2's vchiq devicetree
>    node
> 
> ----------------------------------------------------------------

Merged into devicetree/fixes and sent out, thanks!
-- 
Florian
