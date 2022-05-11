Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68513523C09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbiEKRzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiEKRzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:55:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F474231C8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4jwM5L3zKIPu85/e5wVXWEuEngueu1nP+mnBsxsDvuk=; b=Ow19ahrcTFf8cNcG3HOK+trhHk
        Cc/3i8jaNCcXp5bWQ4GN9V/XDZAtGRV4Mnj5WSyOGjDVOcex75CaKyy7z03vqymZa23HfJ6CtMLyk
        1QvJFJAoyJOcQoUkkVinEXsBYQxfAPqs401AYzcGUU+xvNUDo2KWrs3Hv4mmU01keZBzXmTdmRQhN
        uvrIOpzo6ZPBavFPxigITxc/hukh6/ykw0ZCIwqkWQ9UFX3lVjaGcL115P+ydbzQapIkBlJvZI+G3
        Xic3RD5XTUr0bdG/8oKUGFjwRhlY96imnspvElaoNaWbjfMI38i0QmjeeANPOWj38iNQPhMHxJt5j
        oIwwSqzQ==;
Received: from [189.38.168.23] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1noqYC-000BXd-TX; Wed, 11 May 2022 19:55:05 +0200
Message-ID: <b8022e35-57ee-91c2-d5cc-dc124e1ce6dc@igalia.com>
Date:   Wed, 11 May 2022 14:54:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] futex: Remove a PREEMPT_RT_FULL reference.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <YnvWUvq1vpqCfCU7@linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <YnvWUvq1vpqCfCU7@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 12:29 de 11/05/22, Sebastian Andrzej Siewior escreveu:
> Earlier the PREEMPT_RT patch had a PREEMPT_RT_FULL and PREEMPT_RT_BASE
> Kconfig option. The latter was a subset the functionality that was
> enabled with PREEMPT_RT_FULL and was mainly useful for debugging.
> 
> During the merging efforts the two Kconfig options were abandoned in the
> v5.4.3-rt1 release and since then there is only PREEMPT_RT which enables
> the full features set (as PREEMPT_RT_FULL did in earlier releases).
> 
> Replace the PREEMPT_RT_FULL reference with PREEMPT_RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>
