Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35A486AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbiAFUBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:01:48 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:40320 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiAFUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o8kRybl/YJgPm/1Ty3u9DM+5Rzg6IGnfZRnQegwM+t4=; b=gPQNFgKAS4rglFYgGNu7VAjybC
        2w+rucssHo907rCMWYFlfg8SsR1JzGhpQu2NFFiHmgEV5w7yK47x6cMxi4Pp4PEyoaIEmFCfvkE+/
        VfQralstZerzNmH5TlDrUg75Njo83K6XQhk6BDxPZKEL3Rbya+MsbBXHq8L+mfmQA4CcdnI3HCej8
        mM/uKwhd+s1hmwVltoHls3Dbu/GmpsnUX7jNKrsEHBrwwqlIGTLoQg6R5wobQKqNJ/RRFdtwhdW23
        JR0Fz5e1/rK3gvdUOcz5WXq7m3RSmhiDy6PkUlrdHhnxLbDqS/YpTMw2o+SwO0dZvQtGGIpbJahUT
        0M/iC3CA==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n5Yx7-0009bd-JD; Thu, 06 Jan 2022 21:01:37 +0100
Subject: Re: [PATCH] notifier/panic: Introduce panic_notifier_filter
To:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com
Cc:     linux-doc@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
References: <20220106162710.97544-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <1615e409-aa19-a798-03e6-d0abb111bd7d@igalia.com>
Date:   Thu, 6 Jan 2022 17:01:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106162710.97544-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 13:27, Guilherme G. Piccoli wrote:
> [...]

I'm sorry, I've made a mistake in the header file - just sent a V2.

Please *ignore* this version.
Apologies,


Guilherme
