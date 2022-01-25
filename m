Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B446B49BF24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiAYWvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiAYWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:50:24 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D48C06175F;
        Tue, 25 Jan 2022 14:50:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id s6so19745638qvv.11;
        Tue, 25 Jan 2022 14:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=MRyo4b0CIjGUTTXoXk9MtlW6BaLnv9yE3LtTb5OwcVs=;
        b=OYZQQsV6WQK79JUg5fG+wh4gQTLA9/hdLuTH6VLPFb5W2MNAFhplA8Cz+FtlzEIYqw
         4Eclya+UfSXKATCT5ITJKovTwes6FdBrl+UU8JARvgxH/+DE9JTXRyg42hHL5NzkcEn5
         rwRzJDDESr2cT6xNh+IYrkW386JiHueFy3Tss7RwOgiNxgUMQz5Rj6vBFDweoSGUuFMa
         5ntLTTXyOVJlYoeQrQTGhlA/sDAE0WZqQMDHoq1HICzAGU0PVw0wQOm1fC0Aab2axdVf
         LT20yL1stwvnDGgsA6eQnlPvYny5ov+721Jc0zQvMJgWDHFrOYlg4p9Zo78s2WFN0Yxa
         QCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=MRyo4b0CIjGUTTXoXk9MtlW6BaLnv9yE3LtTb5OwcVs=;
        b=E0B48fI7LBiMh10P+toB/iqqv7GKf/FsU3HrlyCCZyUh7K7KOVhbRieZImIvVe6ZLS
         dNZtw0Oi1y8CzJXVUxaj+IobGqDT3ji6uarFF99eIMRM6jnnMdxO07JHQ0DtEthBMDA+
         nNtTE4ky+dEhAZ6SXpKYjxexXtbHk2Y7Py3iz7Y/O0ktcblY+1jzya3V3vKGzrRp3EHc
         ptA3bufU4pF5GMXCi4gelxO2LbR0/AV5hxz1p3L3uyhz6+SxcIOaKGhnGlZ2HfKWU9sn
         jGhqljryGDXE9Ysl9ye+/F/4Rie907IbAv64cc5GwdhXjvuXf/T3yb5yhkLChqYEe5Yr
         5YRw==
X-Gm-Message-State: AOAM5332vqkfGy2WpXLqC26Ehgi5cnpuArDHJQfBLldf5MQX3g2neZ1P
        vlhliY06U6S3j6DSoLbJ/mDl9dlXMa4=
X-Google-Smtp-Source: ABdhPJzluCa3czawjx4QlOjJOGVnXBoEAiK8VbFTScmM3nMvScxlMVAAWqgGoSNdbHQhbwWEwp0aHw==
X-Received: by 2002:ad4:5aab:: with SMTP id u11mr15031153qvg.42.1643151017412;
        Tue, 25 Jan 2022 14:50:17 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id r2sm5193133qtu.57.2022.01.25.14.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 14:50:16 -0800 (PST)
Message-ID: <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com>
Date:   Tue, 25 Jan 2022 17:50:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
In-Reply-To: <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 17:27, Paul Moore wrote:
> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
> <demiobenour@gmail.com> wrote:
>>
>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
>> always allows too.  Furthermore, a failed FIOCLEX could result in a file
>> descriptor being leaked to a process that should not have access to it.
>>
>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>> ---
>>  security/selinux/hooks.c | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> I'm not convinced that these two ioctls should be exempt from SELinux
> policy control, can you explain why allowing these ioctls with the
> file:ioctl permission is not sufficient for your use case?  Is it a
> matter of granularity?

FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
files.  If I want to allow them with SELinux policy, I have to grant
*:ioctl to all processes and use xperm rules to determine what ioctls
are actually allowed.  That is incompatible with existing policies and
needs frequent maintenance when new ioctls are added.

Furthermore, these ioctls do not allow one to do anything that cannot
already be done by fcntl(F_SETFD), and (unless I have missed something)
SELinux unconditionally allows that.  Therefore, blocking these ioctls
does not improve security, but does risk breaking userspace programs.
The risk is especially great because in the absence of SELinux, I
believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
a file descriptor can be leaked to a child process that should not have
access to it, but which SELinux allows access to.  Userspace
SELinux-naive sandboxes are one way this could happen.  Therefore,
blocking FIOCLEX may *create* a security issue, and it cannot solve one.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
