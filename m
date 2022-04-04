Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F24F10D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353142AbiDDIYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbiDDIYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:24:31 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB33B3F5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:22:34 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aef69.dynamic.kabel-deutschland.de [95.90.239.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6CA6E61E6478B;
        Mon,  4 Apr 2022 10:22:32 +0200 (CEST)
Message-ID: <f52945c8-92c2-7065-bd22-cb18c05bd76e@molgen.mpg.de>
Date:   Mon, 4 Apr 2022 10:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        thomas.hellstrom@linux.intel.com,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christian,


Am 04.04.22 um 08:30 schrieb Christian König:

> those are two independent and already known problems.
> 
> The warning triggered from the sync_file is already fixed in 
> drm-misc-next-fixes, but so far I couldn't figure out why the games 
> suddenly doesn't work any more.
> 
> There is a bug report for that, but bisecting the changes didn't yielded 
> anything valuable so far.
> 
> So if you can come up with something that would be rather valuable.

It’d be great, if you (or somebody else) could provide the URL to that 
issue.


Kind regards,

Paul
