Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5051248F045
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbiANTDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:03:53 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:45092 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiANTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W+XptwIguqwX48rrzq3SFWHF+TQlvjolWXmK4otHBz0=; b=haJga+YKBxAhppXillf5hNwxs8
        Ut3rq/k8VrsPHdCmUD/5dDLcj6C+HeiLc5k94BgFIvSS0jco6/5yPyFHlxwTbKqFdJB0fuwkUGHt/
        9yVIA7tSBNyvclp1qMSJGPhRxwSGGmKaQw3t84niAGBSN+7zHN8T1GB2cAsRDTCqiXNJeepeJO1he
        h7j3dfNFSWjXHmmeIvyRmShB0hoXTfZUxOuQG7gp3IHuL4NpFzi3c1pL3jNB6x9vaMpHyp6gqfOPv
        Z/IxeXOCYnJx8vEHxJ9Lhb5DEX7w1HXavFM2xYeP466Atdys536xs2J+COtMFnbeWENuXMRZ+VMEL
        rfp2q/5A==;
Received: from [177.215.76.11] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n8RrQ-0004w9-En; Fri, 14 Jan 2022 20:03:40 +0100
Message-ID: <16f01572-7d23-9455-ef52-67fc87f73730@igalia.com>
Date:   Fri, 14 Jan 2022 16:03:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com
Cc:     linux-doc@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net
References: <20220108153451.195121-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220108153451.195121-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks, sorry for the ping.
But is there any extra reviews? All comments are much appreciated!

Dave, what do you think about the patch? I remember we talked about it
in [0], seems you considered that a good idea right?

Thanks in advance,


Guilherme


[0]
https://lore.kernel.org/lkml/Yckaz79zg5HdEgcH@dhcp-128-65.nay.redhat.com/
