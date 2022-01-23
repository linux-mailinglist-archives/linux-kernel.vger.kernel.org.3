Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9B497192
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiAWNB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 08:01:29 -0500
Received: from mail.nearlyone.de ([46.163.114.145]:51494 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiAWNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:01:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B3E25CF96;
        Sun, 23 Jan 2022 14:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1642942886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=U3cKLFg7NF1MN2kUPqUTqLe2gaAwY57VRnajnPlcKHI=;
        b=AVLwJK3j/JPgSBnKyzbhtxGgRCybdbNKVWMTcujRY1WpCkSgRN4p0NbKLyeqWl+1Zqpof7
        +gxEge767ytmXGDczYc9Z7tUX9MC3M7/gjVbyV0Me8eew8gnxagc/cwJ/NU1B5H0np5S/S
        J817yOxFnaFG5spagKan+T4UZPvga1a/LVg+ixze58ppARDHLRGHAyb9TQoN85oXcOQXs1
        Bukv0e/4fJTmhSLrnl57ZhaPe/OMOH34D9t8F/Wbdb1VNeFG+oKXAY0L8Fv7GG9V4x53sb
        pW8U2QCiEltvI3RQ1hOiQakd9PeYvX2GD2TCBb7QE5STn6vdRrBDTUUstSo59A==
Message-ID: <b5d08049-0e02-9085-a52e-da31b17e4806@monom.org>
Date:   Sun, 23 Jan 2022 14:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [ANNOUNCE] 4.4.299-rt230
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
References: <164232885429.16727.14256146043064078052@beryllium.lan>
 <YeU9ahVNB8aLHoBl@linutronix.de> <20220117100247.yftwn4k4dmvneisg@carbon.lan>
From:   Daniel Wagner <wagi@monom.org>
In-Reply-To: <20220117100247.yftwn4k4dmvneisg@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.22 11:02, Daniel Wagner wrote:
> On Mon, Jan 17, 2022 at 10:56:58AM +0100, Sebastian Andrzej Siewior wrote:
>> The uploads still stuck? You want me to ping?
> 
> Yep, still not working. I think my last email never reached the right
> inbox. It might be due some DKIM problems on my side. I'll try again
> with my work email. Thanks for reminding me.

I have access again. Uploaded all previous releases including this one.

BTW, there will be on be one final release end of this month. Pavel, 
after this release you can take it over for CIP.

Thanks,
Daniel
