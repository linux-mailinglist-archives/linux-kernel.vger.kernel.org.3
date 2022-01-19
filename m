Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7909E494151
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiASTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:52:02 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33872 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiASTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hULID9ARBzCzTKyApZceV6aQZfeqhuzP2G3GKg8FSE0=; b=KBhy/k9jKn0BooVDBBznx+z53o
        LjUyQdT/9Bm1XE5L2mMYp2oChGCc05Ptm7TjNl9O+ZSGML03SitoV6kpSXVZ82oUJWEwnDwvSXH1J
        68Fb9Cp8Y1mbkqdAa1poso0ar7LUbwS4Zrj9kSR4p7iLSc5b89JLhHzSMWUKWy6uKp3vfj+aeoEhn
        VStZPDUvO2KGAHvHry+TMJ+3j4VjOnIXzyKFtt5HPYmF5SYWt/rQkcEJU7oc+WIfkOv1CKyu1S55+
        tz4nUbZ1TKjssn7kgdmfa/+n4h0QGRpf8UO+XQJ7yM5Tdesp/+FIoRDQMuK7r8zbpvzInt6rknz7H
        UZ6L9Blg==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nAGzo-0006fQ-3K; Wed, 19 Jan 2022 20:51:52 +0100
Message-ID: <b10749a2-d5e9-389d-921a-467cf1860075@igalia.com>
Date:   Wed, 19 Jan 2022 16:51:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <YehanMqSvL81DLqg@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YehanMqSvL81DLqg@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr, thanks again for the thorough review! I will implement all your
suggestions and submit a V4, all makes sense to me =)

Cheers,


Guilherme


