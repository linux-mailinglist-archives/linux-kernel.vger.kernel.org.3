Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406849271D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiARNWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:22:54 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:50602 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbiARNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6iWnYS8XyWG1DmjmjynBSZoQD6FN7rBC0D+KrV9pXxs=; b=gqtGY+8TNLjzSStOy86qX5veBf
        1umoXON+XEO3cNpFPaODa8bGLsy1lffQqop0bM6TwtPyJMV7Sugdz1DFZnJmOdoCx8cxaZVjPXxpW
        2g7BZ844a00hvO5h8LJ+Mf8YpBnyYnRGJIWFFJVj0/VFflMgoz4/NhsC8Xufn1S2s9Ad81UBKk0Sc
        8cQwHgYhngAKne64ksCo7YmNWPcmBiTvvVJjXBI9XY68UG6dB5/nLeWVQJ8aGmll2Kmun4Tcb7Zhp
        79YLNcSH9Y5UWnLiyLciOs0mTC3Pouo9iwvEKxCZr+8/1fV//UosomEDbPNvruX3b6Sn9kiicfgF2
        FS1vOYUA==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n9oRO-000CJp-SN; Tue, 18 Jan 2022 14:22:27 +0100
Message-ID: <0651945b-ade2-c8b6-9963-df995049fcd6@igalia.com>
Date:   Tue, 18 Jan 2022 10:22:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Dave Young <dyoung@redhat.com>
Cc:     kexec@lists.infradead.org,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        bhe <bhe@redhat.com>, "Goyal, Vivek" <vgoyal@redhat.com>,
        stern@rowland.harvard.edu, akpm <akpm@linux-foundation.org>,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <16f01572-7d23-9455-ef52-67fc87f73730@igalia.com>
 <CALu+AoR+GrCpf0gqsx_XYETBGUAfRyP+SPNarK179hT7iQmCqQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CALu+AoR+GrCpf0gqsx_XYETBGUAfRyP+SPNarK179hT7iQmCqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 23:31, Dave Young wrote:
> [...]
> Hi Guilherme,  thank you for making it a formal patch!  Yes, it is a
> nice improvement.
> I'm sorry I did not get time to review the code,  I will leave it to
> other people to review :)

Hi Dave, no worries - thanks for your opinion, much appreciated!
Cheers,


Guilherme
