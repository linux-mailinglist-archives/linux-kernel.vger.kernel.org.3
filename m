Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171FD5387F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbiE3T7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiE3T7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:59:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D2495DE7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653940770;
        bh=5TwtwPfhsvml68xLy5JQtlXviR05dNFzye7zbu6eEM4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ilpcgn+cYEnuQA8sw0KmUdpuBpC7FlslZl9YmfG5dJbR61lJ4Ap7/4czetAcJusyO
         TNAvC0HntdXTC1B8NlIQcOU8DuEnyp56Pv9pDWcH5jYdcSDm99SK2ozQXGYbGTmw+Z
         QbYflFUOOxQu9OFBidOkG7Q4Ev+rhmSAKAtqB3zc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([77.8.130.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1nXxBB2Tsp-00lEi3; Mon, 30
 May 2022 21:59:30 +0200
Message-ID: <871e5d4b-609b-ba52-43c5-2e9c0d0a4cce@gmx.de>
Date:   Mon, 30 May 2022 21:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: 5.18.1 has thousands of similar lines in dmesg with
 CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
 <YpUfNc9XcdA5KqJ4@zx2c4.com>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <YpUfNc9XcdA5KqJ4@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DVrAeEIfQSKSrk2CaYUyYwe2ZqEmqIZQTL3saTXWrqvF7C3lrXT
 whG793SfXVaq8a2km9YlDY+xm7IFTEmR8luvnmtR0Ix2SAqkWtsBs+D0yXqAEin+eikaHDD
 MqodMvS57irGVdPaJzCjO1RV1vTovGswBXGRiQmnL5+PkDKOJqJYJ4dTrPULPU7Qt2/gfba
 SojhrNE1chE01JlvDbHNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HWkCeZr532k=:0YOt8W3R/6cfTAsFfseXna
 I24zDOIgmJ1kugdtVt9RVR1jOaM/r8/f8AGotKzkQeZV92B6rplCz6wWRbWqjgkQbeWEeqVzk
 kBSHasH2wEhFeGUazQli9Nzdx5GJzuFfWCVX/7OVytzkrKQYMZFAG+KZXCaAFxoxkoeEL4p3e
 qTXTKSxuWVVf7ACwLZxApSZA4x3s6n540NZB+pn3ltZBT9NmrGtkLJ0YQxRDIhaDKU+p6r35D
 bpMi5WTcFOaurinmRSSl3lskI1CRsUuEZ3ADY1pEc4nDnNRZ3bPBIH3IL5H5+bnNLaXaXu4oY
 Rm23RuGN3SL8Aznd4z3GBb5gj5LxzIIpE6Uc6/ek8hRMmGkrMvl5sLxjf2SdDnKNN99EKcVC6
 lHC4/79DCUPp5j2xQ8G7g5b2p4bI2Uc0A3IP/3YLUAZWBLtgu+pON4GJ9GnhLM/MA3oRgyTZ/
 6REGFylDUkqy4rfpgAcYpo27e8nx1IP5HKGCEf+hhRX41SQakI+PYt/ODcqD2kZ82qYd4WJ2g
 Kg7ODo6pWdjCewJXDEgz/alukNfpwPljurgumgKcwJRIJzZ2mFUpGT09fEE2X49vBt8D1Qo0O
 YPrw7NUaVCZjj+EPbXHwJ70IA/6CZSoL7ucvL3QXwHL1ixAaZUrEhsgQ1upsTnKx8gW4TKTi9
 FP35vquYrgFWtPB8/e8fudYB++hCmMSwz11ntUCubldjBnlO7OMDwqNu+Oa3Sq28HyMkdWFSP
 mDK/jwG3MRYOA2k0qfrWWYrX8rwIGHfNIA1/fCuiBuTex1dSmkzmpU5Ok2tUtl5YGSL9uM6zo
 k1oReqhRwRcQgpzorTgnjE/dkFhHm1AdckCaPQ5/2mTcUFW9fPkSxRlxNtITjlWMCyX6Ba+NG
 ao53x6BXklzQINJgpu7psOYdGdaNpH1AvipLbVy/h2q0UIwugmqCaCDc1yAYIKbkIafr3ng38
 pZGOh16o5FRsBe3bQx8gXyuTYFKYreqJI+9JI5HkrYxhuoZkukTvUDeF/lL+pU6sc0YmDG4Am
 eSQfpBcgFKL+KxZb/xIgWE2eypv/Zr3A7v5JVo2dB7GVc7LCD3LGv2AF/YsmlRTuj4IykHEWN
 qH/VFv3MR2pjYgxaAjyBpgdPoGR55BclY5BST0ViTNO3QrgSKcL2myPKw==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 21:47, Jason A. Donenfeld wrote:
> This was simplified here:
>
>      https://lore.kernel.org/lkml/20220509172426.612649-1-Jason@zx2c4.co=
m/
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dcc1e127bfa95b5fb2f9307e7168bf8b2b45b4c5e

Ah ok, understood the rationale behind that.
Thx.

=2D-
Toralf
