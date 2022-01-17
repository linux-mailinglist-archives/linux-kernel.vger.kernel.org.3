Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732449108A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiAQTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiAQTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:03:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD42C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:03:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o15so61196311lfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to;
        bh=diQLW7TXTCFX4JE+KanS662NxmpjJMEIjMvzHGVF+dY=;
        b=PvnCl/KD8Wi+yUNyPZjqzV9nTvT4sa8xg+O9YSGbvRtjbrlBxLhW4+aY199JHJyH8S
         RpO18Dw/uZu6e0+QxXaD/+CpY8OL0xZmmXFgphcOGiXsDSInzHAFBdBFLe40LsWbOtB8
         PHS/AeQgRZXg7xq/JrIFAe2o8Gj3dNOGaFqOEcsyo7Q4axxcRBt7+ICkzUC4tJ25XjWq
         ybnicnvM2C5rtnJ9dSGJY9hGJ0v/BcUZHi/g6RjlX3znKaT9sqPIxBv7BMtzrpWQvCcX
         9KOG/RraBmt4B2qlu+La+m5JCfIZy2U4WkpzCwSrmMK89vd/oQc7M7Ofmj4Tdm2Vp+eV
         b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to;
        bh=diQLW7TXTCFX4JE+KanS662NxmpjJMEIjMvzHGVF+dY=;
        b=KL9/J1HZvaY3OcRVgp+ftg4gm+g3AtbpX035+MUyICnqS/J2uR9VwMv3D34bS6JEqp
         6wPFKvf8CB45cOp/OiXzOR5UDAACsZP4tQl5eD46gyXyWZLgOAZv2iVRXLrnuDuCeDvk
         oubz7joqSi9szfCmLt6suBwUOUeFpg9vvB4Xkom88UlPWPxssj8wDGtsQj/0Xlnqr51B
         jg+IiQG7r9bnq1BeiG5205KL+1I1M2lWXTUrY4XqqYHiymD9A/jmXXkVyl3TN3W7GZ9y
         +qyTW7u58qM5bnFdGwjEADHO8j4ITk7p5zPkC43HKemldy4wF91RVDgukvLBNcaKbaHa
         P8CQ==
X-Gm-Message-State: AOAM533da4cS8mw1z9jBz/HnKs/ycEfFngOC6Sw/mcEaZruHuRTUf3Yi
        IFhfUmouqkbT/5GwbSaBVeI=
X-Google-Smtp-Source: ABdhPJx5Pm6pUZrf/3LMmVmO/F6TPFh9YJEtetOGvqoOya+PjyY0E3OistJqkcWG00jVLPAl4oUTjg==
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr8712821ljq.200.1642446196063;
        Mon, 17 Jan 2022 11:03:16 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id bq30sm1463545lfb.222.2022.01.17.11.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 11:03:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------hH4tojY0MpBCRE8WyCF2GwLt"
Message-ID: <860dfdad-d7db-9c27-adfe-02a3b2e02d0b@gmail.com>
Date:   Mon, 17 Jan 2022 22:03:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [syzbot] kernel BUG in ntfs_read_inode_mount
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+3c765c5248797356edaa@syzkaller.appspotmail.com>,
        anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
References: <000000000000739eb405d5c458dc@google.com>
 <38455f10-6cac-4eda-3e7a-3744fb377870@gmail.com>
In-Reply-To: <38455f10-6cac-4eda-3e7a-3744fb377870@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------hH4tojY0MpBCRE8WyCF2GwLt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/22 22:02, Pavel Skripkin wrote:
> On 1/17/22 13:09, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    d0a231f01e5b Merge tag 'pci-v5.17-changes' of git://git.ke..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11f83837b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=986ed422f1741853
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3c765c5248797356edaa
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
> 
> Sad :(
> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3c765c5248797356edaa@syzkaller.appspotmail.com
>> 
> 
> __ntfs_malloc() calls BUG_ON() in case of requested size is equal to
> zero. Seems like syzbot has once again crafted malicious fs image that
> has attr_list_size == 0
> 
> Just for thoughts
> 
> 

Clicked 'Send' button too early, sorry

With regards,
Pavel Skripkin


--------------hH4tojY0MpBCRE8WyCF2GwLt
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL250ZnMvaW5vZGUuYyBiL2ZzL250ZnMvaW5vZGUuYwppbmRleCBm
NWMwNThiMzE5MmMuLmE5M2ZjM2RiZDRmZCAxMDA2NDQKLS0tIGEvZnMvbnRmcy9pbm9kZS5j
CisrKyBiL2ZzL250ZnMvaW5vZGUuYwpAQCAtMTg4MSw2ICsxODgxLDkgQEAgaW50IG50ZnNf
cmVhZF9pbm9kZV9tb3VudChzdHJ1Y3QgaW5vZGUgKnZpKQogCQl9CiAJCS8qIE5vdyBhbGxv
Y2F0ZSBtZW1vcnkgZm9yIHRoZSBhdHRyaWJ1dGUgbGlzdC4gKi8KIAkJbmktPmF0dHJfbGlz
dF9zaXplID0gKHUzMiludGZzX2F0dHJfc2l6ZShhKTsKKwkJaWYgKG5pLT5hdHRyX2xpc3Rf
c2l6ZSA9PSAwKQorCQkJZ290byBwdXRfZXJyX291dDsKKwogCQluaS0+YXR0cl9saXN0ID0g
bnRmc19tYWxsb2Nfbm9mcyhuaS0+YXR0cl9saXN0X3NpemUpOwogCQlpZiAoIW5pLT5hdHRy
X2xpc3QpIHsKIAkJCW50ZnNfZXJyb3Ioc2IsICJOb3QgZW5vdWdoIG1lbW9yeSB0byBhbGxv
Y2F0ZSBidWZmZXIgIgo=

--------------hH4tojY0MpBCRE8WyCF2GwLt--
