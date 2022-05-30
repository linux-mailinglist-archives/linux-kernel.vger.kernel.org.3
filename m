Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFA538461
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiE3PDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbiE3PBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:01:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C528707
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653919315;
        bh=zatsFWFK/7ooruflXicselSccOEIPQKYqYurBMy9Dj4=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=Hb4sQoc3Xk4+DKXnih+ns24QsfyiWn+1/TnGPCFHcv2v94ilwNbjojVNCWdDHMEta
         D2UmlBXM6z8VKKv1ADl4kJPupKYj9zV4Cr1zyo7+jerLxlbnOUnNUUdF+RrP1KoNbW
         JsVJLYdC1NrpCiuRL+jhK6XUc8az8xdpLBb3Uxns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([77.8.130.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1oKOQE04IE-00XaBQ for
 <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 15:49:20 +0200
Message-ID: <3d3f6547-11f3-6faa-4d4d-792a5c5d39ac@gmx.de>
Date:   Mon, 30 May 2022 15:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: 5.18.1 has thousands of similar lines in dmesg with
 CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
Content-Language: en-US
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
In-Reply-To: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l3hWpDIwWPUR/LqQN4BaWroCaLNdaMz4du0txXGiGCvE4eyQ+Lz
 io8SODLfJrh0vOrnoqdNIhdPKq8GkZUw8NhcvFPca0BcKOk1Qoavr9qZ4JZalfCpbTYoapS
 Wfk8PTxMMeZJzlLAQCa/RSzgOPrWJxtgNqmYjYGMo3lVHgNpK1xLgCs57okJzWdmD7FXE2u
 So2Xzwaf1gLB5vcVWRa2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rtGMMNCcPq4=:DrDrv29XyAUWVk0aGiAAKZ
 lPsR/4EoljpwfsMMMAeH50hX63OhKMCs//i7BYmmjkM4fN/CEtThc+WiX8w2gb4bCYkhGDhCI
 jgeCxQYdMRPTGveHEG9MiJORAW6AaKaRjk+IR7xrcMgaANCG87Ynbg+CmddtSC4wlf2xNWHMo
 6sK5HBTqyvYeUPzFX5V9J5Zt+NY1BgeI3V5HKlZB2x+0E9CTUea0Zv46/pM5Rf0zPB+8RxMxA
 /PmEVNcbCgj081G6fp8E5bFEo5xN6tqqtwofD7Ykpo4UyRiUPdLept3m5g0qnEW3vsJNoZu8x
 sSziRo+FWMTPBIzW6Vjnyr6ZcvvT8NXuQnYVbgkiFw934WI5jP7SMWPHVgu+Xa04zBobhN6G1
 z5NVRp9cduykteEHPOxvv3dvJv5LmAanSCJJOldCV8+PLSumosEu11ztDkwHhdPz2NYyJ8qK7
 fv/0NKzyWMr+sKopMqZeVNNn9FPK3uhREhCAfRKCY68Na63PZ17H702O9EYK09UBsOqnnSpdS
 nHRBB2FtWrZxOytDjoJ7rjI5MpAOhwFYcCdfXmBDJF4ZA++8knHitvHoqHW53U6n9cZLUZ3z3
 Kl45SU06Zl0CyoUzlpE++YKgVgS8jeFJYYNpCuYAUlljawCsn1vtzksFo1JWguWhepsZMJh5M
 r0HWtlA2jYhNJs+iPEv7JHyrwK0Fo7qVsCzq++aDSwbygdGm6w65tR7y59Fwc9YKhTLxvQCB2
 7/NR5mG1mJPHfeWSXS3fEHglvYOkzM9jMKUHMYJ5cdNaHK5bKiaJkF5HaQCQ2hwvloGJ6MoGx
 LLv0WqtxAdN0C4GsewJxUN2jwTQJdJMe7Gqy7MIktQfJG/k1I/48aiapTamXC1R5a601HMXWB
 GRsV6Td+sjC0iE2NlCaHaRDpQj3/A2okdJ/NSUcd1WIWITZiU/E/CEYEnx9irXPLGdHHf2VzS
 pgMwGC2Sg4jtGbsZBjahvZ5UaBBA1lUIBGa86E7QDW/jKhw7n9oMPDNWzU/QEWN/j9N+3rj6f
 2Bu9STp/2njpqQ6BZ8xSSfJAonfvj9/CRMfpSeLTS9CmauSIuT+R4NlSL1TKC3dVWoj+JznR8
 RCZsWCmoiSMX97sEzjS+keN5TBfU5T9L95GKW/sX6Wc4lgUJ4cmTMkdMA==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 11:24, Toralf F=C3=B6rster wrote:
> This deletes the early boot messages in dmesg:
>

Well,

changing CONFIG_LOG_BUF_SHIFT=3D18 to CONFIG_LOG_BUF_SHIFT=3D20 helps, but
nevertheless:

  $ grep get_random_u dmesg-5.18.1 | wc
    5541   38787  440908

For 5.15.44 there's no similar effect in dmesg after upgrading the kernel.

=2D-
Toralf
