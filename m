Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52AF4B52F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355056AbiBNOSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:18:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355050AbiBNOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:18:04 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBDD49274
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2IRrcNjbhFft6rdMCPj7kHywiR4ZE+zmLkUlD3JOZq8=; b=TsEx//Emm3JDTP/C5Aa0895S3r
        hkk9CLcVvYdn1S6rAzhbkB6yS1mNQdzJcQ0CexNcvuNNdM1MC2zoqPJnyxJxrK9fxPfyUlm/My/kE
        Tqr5Tk6uyLpJMyUaqYswtMFPxnaFrRn93Z+eQvjas4f9VrEt2BdBX05/cqAXETOTJnMAdMevVi+EP
        G9BD0AwsL1ZIziW1SZ8uWxf5n6hT4I84utdpd1nJpOpHvrlzq2FGUUvJoWJ5OCPSO48d9PBpYWhTg
        wXRXOGFwQmWES1SKuVr+03lO6FQlRAaGpvAXnOhxyg24cvGmwi160aayMdgM1/frI33QESyla/qEv
        9cEYwVuA==;
Received: from 201-27-34-205.dsl.telesp.net.br ([201.27.34.205] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nJcAs-0003zt-IC; Mon, 14 Feb 2022 15:17:55 +0100
Message-ID: <ae38ceb0-4af0-f010-5272-3bf1ca037bce@igalia.com>
Date:   Mon, 14 Feb 2022 11:17:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
References: <20220211215539.822466-1-gpiccoli@igalia.com>
 <YgoaNTnT9hc6PUjP@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YgoaNTnT9hc6PUjP@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 06:00, Baoquan He wrote:
> [...]
>> This patch changes that in 2 ways:
>                                ~~~ steps?
> 
> Otherwise, the whole looks straightforward, clear, thanks.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 

Thanks a lot Baoquan, just sent a V6 including your suggestion and your
Acked-by - I'm feeling we are close now...heheh
Cheers,


Guilherme
