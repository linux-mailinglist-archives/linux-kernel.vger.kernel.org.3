Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F76473B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhLNDiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhLNDix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:38:53 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:38:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so16144398pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 19:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P/BUX+Y9nC7B6aKulzNhO8FuVXdrMr2Yn3t9WCC93Bg=;
        b=pns6Pb2fLGXltZ/26mjArO3E3emkL8IJm985LxGeHafczufRl41fsIwH+HQ3pxfYE7
         Dcfo3oNtM8epPrtjZBg4j3zECMG/URtfWEdsxLzF8ju1xdPRPqhNnkToNvaGaq+wrb/D
         6XMZpnAv+FrPCvfNJGPkRsYGn0qRbf2Jp/TgTN2nzJ9aGAozvrXu/2rTJS36XgkzTgAz
         jieyK+TwcCUQXNhINkCceZmYgQ/ePT6HxLI23UbEEN18ZLI+BNwWvhiXdJ11YazvK2yT
         LTRud+K9/R1PeAarr3+l10Ia35WwD54RRXURNIEus6p+Vj8QQTq6NMwkcSd6KTHva5I1
         ubJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P/BUX+Y9nC7B6aKulzNhO8FuVXdrMr2Yn3t9WCC93Bg=;
        b=szV1E5bL/IOdTWWde0EQXCoYVZinDp0W04Klfl1DcsuigsQ3Q1saLB2gzkMMtXCymo
         +SJ/MP+oPl0/maX8ic42dsHWP84N/i6qyHCuaT2ZxQSHeYW4zapPLrbeVIgZGQ3qbwQY
         nUCSHwVvOGealEMf9vvURkeW42EPpUp2+ix8t2pSchowyTL6x34BHNIAM8o4iD/ZJRUK
         s3TU7gGmjZ1645i8gD/3gGkay3qVLzf1rfB8OquMZC8KNL4cUQKd9c8iMqIojBYNZpX7
         eEW878pbsdRROLlUWOvUoex4KQk8Exw2z7xvsa7NjZG/RRONkyhRjs26iXgNsj9Y993s
         NUhw==
X-Gm-Message-State: AOAM533YFwhmOT+Y2PBVkC+dYWbkXmyIftduSoPKB0sGudoCsg+kFoF4
        Bkr6Pyoij8OTg1P6JCqDw2U=
X-Google-Smtp-Source: ABdhPJyMCHtb5ok+qMsl/ISWomYHJmOz/EXbrl08JCq7AAnDXwSvABhDOkpmbPrtcuPRNHY5laI8EQ==
X-Received: by 2002:a17:903:2292:b0:141:e76d:1b16 with SMTP id b18-20020a170903229200b00141e76d1b16mr2523999plh.21.1639453132433;
        Mon, 13 Dec 2021 19:38:52 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n16sm536390pja.46.2021.12.13.19.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 19:38:52 -0800 (PST)
Message-ID: <bc9a960f-7577-c3cd-a58f-91c165f3e06c@gmail.com>
Date:   Mon, 13 Dec 2021 19:38:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [GIT PULL 3/3] bcm2835-bindings-2021-12-13
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211213123040.184359-1-nsaenzju@redhat.com>
 <20211213123040.184359-3-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211213123040.184359-3-nsaenzju@redhat.com>
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
>    https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-bindings-2021-12-13
> 
> for you to fetch changes up to 4e5be177f6d2545dd639f41138af3b138470c61d:
> 
>    dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema (2021-12-13 13:10:11 +0100)
> 
> ----------------------------------------------------------------
> Stefan Wahren converts VCHIQ's bindings to YAML format.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks!
-- 
Florian
