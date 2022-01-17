Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE249091A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiAQM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:59:54 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33880 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiAQM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Eg4+CosmprUBdxkImyooL59klv9lZlKadW6+i0O7cP8=; b=sntxkZuvPeh6aFkf1a9ueaM5Ju
        3FwcaI0mWgaeqFQRJwR4etxyrW4UWuW5tLL/6YC2cwHiqjHZBB+zaZF4/9BYHlwHtHMf9cPhd4QjN
        IVfar5wwSIJTvaQOUNkTSOYTm71RjzulBlKh4dAtSByp2t6yop+nHmundgg8IbDC5epDiTv7p0lLD
        lETSa2rSK8F82qt+w+hWSCIsOHmVLITeHJR2qYfJlTQuJNi8ORH1sIXgJM9YhuhxKkv9c4VawqPv1
        asCoR5jHBMCLLqGPLpApoDBBya+E87A1rDm2QXMpdUj/vHHe1VdsLxaG6pJPAdQrqym1zXKwb+i64
        XQO8lJtg==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n9Rbv-0003zn-Gb; Mon, 17 Jan 2022 13:59:47 +0100
Message-ID: <7fd2b15c-0b62-2501-5078-0ee6046c8d04@igalia.com>
Date:   Mon, 17 Jan 2022 09:59:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <20220116131129.GD2388@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220116131129.GD2388@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2022 10:11, Baoquan He wrote:
> [...]
> This patch looks good to me, thx.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 

Thanks a lot Baoquan He !
