Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BED5A65CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH3N7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiH3N5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:57:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F506352;
        Tue, 30 Aug 2022 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661867821;
        bh=EHevt7zWC6JO3ARZtbty/8S8Npfn4RsL6Nlqm8Ymweg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=R1TpPcg+5VGxpHJd5sf8stLZKnPWbLZnE8RoHvIn08qHbkWxh8O9zzwsQK2MIrgTf
         Dw/t/0jq+dK1OLgnsO1PkTopv66xtWQO40YFqCKBHmaI9RvkQ07y3+4sodQNeCKwML
         RqIPr3cc/f4vVpCY5tzwAMsCv9aJC3Z9ssjifzJc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.168] ([5.147.48.133]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1pWh8p0bDu-014jJ1; Tue, 30
 Aug 2022 15:57:01 +0200
Message-ID: <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
Date:   Tue, 30 Aug 2022 15:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
From:   jflf_kernel@gmx.com
In-Reply-To: <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FLyu7aM0okQ6rwOx9wRriOCGW6Xkv2orBrUuA6s2SZcZYLhEzJJ
 Y5xYn1nf0RuT15g/J+mcrbVw8NV+Y4Y+CH4FGkYpbf/X+y+29M6Z8AB9QtQNSAFPd40un9p
 DLm57PkFd6VQdu8WhshtM/6/6jwtBCWXtppNfCjfpA4PdvqH43xN/S0w2XyaBETlD53XZD/
 yB7Zp6egBTN/456B6Tf4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:adpJWW/Rk+8=:c2HNJVnB20hiGMhcSvur4X
 DZNqU7fRZTbT2R/0+hUTtpTLKwBoPhhZFTjhNJwUGnsMO2sDzBhvYztg+ftFWu2lkgF3HCNqk
 SfHQTS5DRFxpceOizfBVfCqrR08RL5f01RNQh0wSPrLhVeTymnNsImZUHHucRhHXjQvctMxYq
 oSsxtSxizTCzdOfioREcM6Gptw6Z0iJo/nR/NGMUlWgONynTQfCbmcQe//Y7Y/IyyFhBelfoh
 YR18CTfAq9LB5GmQyGB/nmMuMJfWRHfASuYhXwG6z0EpqnSsU6HucCCqwuCbay3Cjq4YEcJW/
 zwLBLi9xx4bJniXG7spgn0mnpEQHgPvXi3WVeEbEUjuTr0jKsLHh5IVXSRyuyBAreTJ4KTn3n
 jlIATPE/f1+3km/dqDRCCGnH3NXdhBr5F1DQeeTb0btCrz9XLTv476xK0lR5geTcGpnlKun/s
 F8/bcxVpPVwwlp+oxCXIzbkipZusKyDuLptXKeMeUNGpaFbB5XqReHeBI0FNBJ2DbW7d+th+6
 Pk/NtejYiNO9Owwxsbc9S3y57mUWXhS1aag9xM2QmwYEUA/8TFL+J/HdpGzSCZKPU2Lay8SXr
 EGlkmSWfxeErefJvdnE/LCaXYL+TZOU02crjS4sR8ZQxrQQ5z2ZHnLjX5LKdWreYYzb5DQyUL
 jfNjqWSlHsETcw/JUssIECVJwV81xmiuxRxPlDVPHlgNudpbdyD0to/iVbGSNNzEBS39DnZA9
 LSKCVNNElubpZA3Mpr0pGNzfMJz2M++lqMoBM6VHD6UvUKsanbS8O39UaPOkAUCMhQvMy0KDh
 OghY/9WV5cW70C8OWhadNzelU1g4VjFKUgdOvhp8dxAmND7D2Pu1sUFXUSXqAwjiyO6FRGaIH
 SIlPGwZ8V6uEg/BRMRv0SEkQ2bS3DS7GNK6VMNiWl/EfOqklO+EdOZyBZ1jtN6/h2keKax1Of
 6qBzzpd4wf7o7QZLURc0QbussIdps6Z28YO6UDaXEF4BsVL1VjSz3kLNpCKNl1avIL3nK8vXT
 IYV9r2z9yPZbKBrln+vCgLltjTE2d15KtWjM1U0nKq9yINL9mbmo/nTksHkwNJeamOU+yUWCs
 lzMRwd/CVKs+TAJkjcwDJfijsyuBHuRDFGMn4+lYxE6Ev0Ln9JCF1FNcg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2022 13.54, Oliver Neukum wrote:
> On 24.08.22 18:09, JFLF wrote:
>
>> By process of elimination the controllers themselves were identified as
>> the cause of the problem. Through trial and error the issue was solved
>> by using USB_QUIRK_RESET_RESUME for both chips.
>
> Hi,
>
>
> aside from the aspects of getting this properly signed off and merged,
> this opens up a question. What does resetting a hub do to its children?
> That is if the request to wake up comes from a child, do we
>
> a) lose state in the child?
> b) retain the knowledge which port requested the wakeup?
>
> How far has this patch been tested?
>
> 	Regards
> 		Oliver


Hi Oliver,

Partial answer for now: I have been using those quirks via the kernel comm=
and line for about a year now. I have been meaning to send in the patch lo=
ng ago, but kept forgetting about it.

I agree that USB_QUIRK_RESET_RESUME seems fishy with a hub. It's pretty mu=
ch the last quirk I tried, and the only one that worked. I can't say I und=
erstand what it does exactly. The hubs themselves don't seem to reset (or =
at least not fully), as there is no re-enumeration of existing children.

I have not experienced a single problem or side effect since using those q=
uirks. I use a mix of USB 2.0 and 3.0 devices, some bus- and some self-pow=
ered, some permanently connected (including ethernet and audio in the hub =
itself) and some not.

Thanks!
JF
