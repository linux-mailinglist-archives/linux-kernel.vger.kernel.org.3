Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2247D3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbhLVOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhLVOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:36:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B42C061574;
        Wed, 22 Dec 2021 06:36:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q16so5333254wrg.7;
        Wed, 22 Dec 2021 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:cc:from
         :subject:content-transfer-encoding;
        bh=+3GdlkNFtphXM9+jbZr28VK+BqW1pmexR4dHqpidTUM=;
        b=m70JsyAC9ag04xzSZntp0nBHg3911N/bjISqCtGKsT444xZcRQ4lbpqPu8ZytwS9YW
         SXgb0qpl/Lqm5dFHbzAgkXJA7a1EbPmAYcurBp99MDMYnn2m2Z2PcIjQ3ZCas+UUMvKW
         bNi00Hcx24w1/03P482Y8np9mI8vR/k6YOvdVB7H/vKkpg8ebDN7PTFW95fq6TVGEYQm
         qb2eRBxdlRl+oxcnhRdYjxJoLIBFQMFtI32sHF4rb9nlikFTJAAZN6iX2uF3IiFbY4p+
         ftUIY6UiBT3HMkaX0EiWFjGzEUQD/5rjPbw7FVPjZTOK0Bjc5zbLz3oxHGE1vk+hyq72
         mbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:cc:from:subject:content-transfer-encoding;
        bh=+3GdlkNFtphXM9+jbZr28VK+BqW1pmexR4dHqpidTUM=;
        b=iU626B1iOaX0XUs232pPwn/8IlMTw6T5/R6J6DRlyxqFA6+ldSXdiI4DnxFV9U4dmL
         QQyEHFkhYYePb/X1fqR1Naqe8BUIUHD5N6B/LbtGnveNcTMmU2wG3/22GFxJRrhIDeZ9
         4ES17P4MUucFf6Dd4Fb+HUG0ykAmoRcK6xsWdcOZ/6K2+I7VPLiBSdOE4ubz5cOoUXCh
         I3VUhCXkMzHDNRdrMc//uCI3NzJMns/RilTVc6yhqlDjn1lVr2FI7KWxiVTlk9BSoVQ+
         aZswh2hDGGdJYs0HSobRyWcdJr54Qk4S+xz9CrVuM7hBQ6d8N5YaxhX72TmEoheymqBM
         aLjA==
X-Gm-Message-State: AOAM533xgpkqwwNk//QoQcNkHMw5tb+8SFDeib7bdTXBFhBlx0zS60wx
        vINBd87f1sRtIpUvWNcxo0+RsYbZ9W8odUbWtkSlnA==
X-Google-Smtp-Source: ABdhPJxACWzuou6187/C4WEJ5RESpXHpUy8LrxX+RXk3w/0SvBTHoVE46hocSH6yPsgYW1k61x+0Yw==
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr2308112wri.134.1640183774131;
        Wed, 22 Dec 2021 06:36:14 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id n7sm2080941wms.45.2021.12.22.06.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:36:13 -0800 (PST)
Message-ID: <f26b1e6f-f3fc-191b-e613-c0b5748e26ef@gmail.com>
Date:   Wed, 22 Dec 2021 14:36:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
To:     linux-alpha@vger.kernel.org
Content-Language: en-US
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: kernel oops when reading /proc/bus/pci/00/01.00 with odd size and odd
 alignment
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing the Alpha kernel with stress-ng procfs test I found that 
misaligned odd reads cause an oops. I was able to figure out a simple 
reproducer as follows:

dd seek=1 if=/proc/bus/pci/00/01.0 of=/dev/zero bs=5


[ 2013.722601] Unable to handle kernel paging request at virtual address 
0000000000000004
[ 2013.722601] dd(1195): Oops -1
[ 2013.722601] pc = [<0000000000000004>]  ra = [<fffffc00014fd634>]  ps 
= 0000    Tainted: G      D     E
[ 2013.722601] pc is at 0x4
[ 2013.722601] ra is at proc_bus_pci_read+0x244/0x3d0
[ 2013.722601] v0 = 0000000000000000  t0 = 0000000009080000  t1 = 
0000000000000000
[ 2013.722601] t2 = 0000000009080000  t3 = 0000000000000000  t4 = 
fffffc0006c43f08
[ 2013.722601] t5 = 0000000000000011  t6 = 0000000000000012  t7 = 
fffffc0006c40000
[ 2013.722601] s0 = fffffc0000967000  s1 = 0000000000000005  s2 = 
000000012002a005
[ 2013.722601] s3 = 000000012002a001  s4 = 0000000000000010  s5 = 
0000000000000000
[ 2013.722601] s6 = ffffffffdffd600f
[ 2013.722601] a0 = 0000000000000000  a1 = fffffd01fe000810  a2 = 
0000000000000010
[ 2013.722601] a3 = 0000000000000004  a4 = fffffc0006c43dd8  a5 = 
fffffc0003c05dd8
[ 2013.722601] t8 = 0000000000000001  t9 = 0000000000000001  t10= 
000000012002e058
[ 2013.722601] t11= 000000012002e058  pv = fffffc0001023650  at = 
0000000010a8b186
[ 2013.726508] gp = fffffc00025197f8  sp = 00000000d1f90b3a
[ 2013.726508] Trace:
[ 2013.726508] [<fffffc00012d39e8>] proc_reg_read+0xc8/0x140
[ 2013.727484] [<fffffc000120ed58>] vfs_read+0xd8/0x220
[ 2013.727484] [<fffffc000120ed14>] vfs_read+0x94/0x220
[ 2013.727484] [<fffffc00010110ec>] entMM+0x9c/0xc0
[ 2013.727484] [<fffffc000120f274>] ksys_read+0x84/0x130
[ 2013.728461] [<fffffc000101149c>] entSys+0xac/0xc0

[ 2013.728461] Code:
[ 2013.728461]  00000000
[ 2013.728461]  00063301
[ 2013.728461]  000012c8
[ 2013.729437]  00001111
[ 2013.729437]  0003fac6

Colin
