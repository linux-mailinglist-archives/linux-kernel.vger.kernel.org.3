Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FC53CCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343616AbiFCQI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiFCQIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:08:55 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD80248E0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DnXGC9zGk6AHc3dQ89SCaTJ6SAAcYXn6TdgTRzNMnTA=; b=aR1yHJl82/rGjfq4KPHKC15bfD
        9Nt2NWPj066c+3Fo1v4xn/5Co1dYLFz3QjMyoXj7dOC1jDV8i4PeZ9PMpd1iyxzrbXX78oNFvma7O
        EUHASTKFbAYc0rJlzmzNLNXfOzpga3Znx2Qi7gPQv5Za5Uvw1N+PXzqWAxKvWyyObvy6qbLCOZ+xh
        gtDfJIeUZx9htDrHIJ7hNojiWIomUSVBqIbW62pUsVTbD1S06xZ1kR4Q9g8ecYz+QvYjXHLvsW9+0
        ZtYI6M8U0qG2NQiZIt8wWBJ0C8/QmshEoKLDy7icPAwbS094ROAOQ7WYC14tDucMRDyxm32EKzNu2
        cOgRFERA==;
Received: from [177.83.209.223] (helo=[192.168.0.110])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nx9qU-009U3C-5E; Fri, 03 Jun 2022 18:08:18 +0200
Message-ID: <11da326a-1cb8-46f5-d084-ae543e872ea6@igalia.com>
Date:   Fri, 3 Jun 2022 13:07:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/3] x86/crash: Fix double NMI shootdown bug
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20220518001647.1291448-1-seanjc@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220518001647.1291448-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean / Thomas, was this merged anywhere? I just checked and seems it
didn't reach mainline...patch 01 is especially relevant, IMHO.

Thanks in advance,


Guilherme
