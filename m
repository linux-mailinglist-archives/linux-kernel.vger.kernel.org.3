Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06A483E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiADIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiADIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:44:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0778C061761;
        Tue,  4 Jan 2022 00:44:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 7so19497420pgn.0;
        Tue, 04 Jan 2022 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BeIEpaxXkDsZZDPhXKeuVyakI2W4JViJaUyCleUCfBo=;
        b=lo3hgQ3A2Bwirm0k/qJMqPbh8QELH8Y+HKXp4KWsi/Gzh5Kol8/Tyk2y+Ao/9i3jf/
         eZp3ZX+rhA58fC6zZIgHjZuf59nhN/sJG36tetel3uILY0JiFW3OtmFoBmjXFMZWIR7m
         E2xt5nAHlxtqU6HuMFrBdfaI8onyGl7KPl+efL3lLZx3ZeB5DCaWqhgWxLn4Lo1HE1qQ
         YIB/5ce3aFfFlkuUuUASgiBja2Is8dn9jDLPD0IGuUMcMKyr8WmbcYjgGcn4hn1JQUEm
         PUQmr+k+F0CjcMnDGfts6eab/hCoXqWtWEvfZyWKma9aerU6zrReqWIEVv2/VvzbT+LF
         yunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BeIEpaxXkDsZZDPhXKeuVyakI2W4JViJaUyCleUCfBo=;
        b=xZ8QxsO//2bZR9WB12EzFSOCH2T2yLy/a/Pg+sy8rkwGUjRaDo1DVBf4DaxL38MtVq
         8+kIxlnK5UVGNo9FHI0vmb1P0IZRnJAJRr77Dp/uDOUhc/VTmDcPG1QU0zUF3gXq3FBz
         SkNXEko0Gy8H/3k3NfZYwqr0opH4tQt6L/6Ri85vFC08YPYOBZJcRKeD8o4hbCt4pKpf
         cne5dNuGkKLSDUt6/N7YIvOk+mShXJa9czvqznj7Ds9RI37sSr6jF9x9I112nKJxs19m
         zsZ7Sa2XNEJoyVVULtis5GClHT3l2LRCHC42IPVzTp0v/DPS9rZWtzqQSnfuP285mC/b
         +OYQ==
X-Gm-Message-State: AOAM532rWv3husHEw/Qx2ZL/Osc8ZMoqiWy2cocZxHqRAu3577rrEGQ7
        gaOu79tvOgVynIEZ61plUCP4L35Pm3k=
X-Google-Smtp-Source: ABdhPJw5ABLScth5egCh0GLbQjuEpzPDhyBtT9Dy3yYZnYfrgkUmt05W/Cg2wA9q2B77ChfcD2FM2Q==
X-Received: by 2002:a63:6542:: with SMTP id z63mr43964606pgb.429.1641285883344;
        Tue, 04 Jan 2022 00:44:43 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h7sm42234640pfc.152.2022.01.04.00.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 00:44:43 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
 <df9183cc-aecb-6b8d-0580-92c2a678d69f@gmail.com>
 <20220104075655.GA17315@lst.de>
 <931f9f77-e418-4359-65b1-cb7432e37a0f@gmail.com>
 <20220104081654.GA17682@lst.de>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <430a9e51-deb4-6f65-bbf9-846303890d45@gmail.com>
Date:   Tue, 4 Jan 2022 17:44:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104081654.GA17682@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 09:16:54 +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 05:07:20PM +0900, Akira Yokosawa wrote:
>>> Current linux-next.  But I've also seen it with mainline from a few days
>>> ago.
>>>
>>
>> Still can't reproduce with sphinx-build 4.3.2 on Debian bullseye.
>>
>> What version of Sphinx are you using?
> 
> The one that comes from Debian:
> 
> hch@brick:~/work/linux-next$ sphinx-build --version
> sphinx-build 3.4.3
> 

Ah, I'm not able to test distro Python packages at the moment.

At least I tried Sphinx 3.4.3 installed in a venv, but I could not
reproduce the error you encountered.

Hmm??

