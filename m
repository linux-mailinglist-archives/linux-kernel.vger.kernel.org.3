Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748AB5378AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiE3JZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiE3JZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:25:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E374DDE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653902695;
        bh=22e6SOPmbTshzeVoCu7Bt2tE4v5zu11GrsZPZuWfYPs=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=TmRdCRjDiVU9mRm6GGDIKu4qg6vZHkGcCjOkFui8qGNqb1fOOrDrmEnKMrCCsk5Hc
         F/jLLH7UMz+oCSEyOmmN6QOfNiPHRLwwrkd1wibk3X0CZJmbSQKmlYs2zAXIiMwdpN
         usHksg6FVu1giRC4HKRYZLP7Gr7n9DyYudGVhEwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([77.8.130.55]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1nZpXK2owD-00vgKu for
 <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:24:55 +0200
Message-ID: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
Date:   Mon, 30 May 2022 11:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: 5.18.1 has thousands of similar lines in dmesg with
 CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SF9SMdHwEG3FQBuy6I258cqP2nEPJHgOkvsFwSBLLGAXN4H2s1v
 tiYaZfrJk9nd82wqUV/GxdQnWvluLNcPE3zILGOVq8dcAW0+mT7+45WbsieqdGtlsqV3jkp
 ckAwPwBXWsf2rVXJxPTQmypjYwkWvGkNCcpoZ6YtAzyOZRdpUfBJROMzKwElk0aqZF3Uf9O
 jZ96RNDgzHxVfu2gx8sfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1F8ls2CZLc0=:S2/K2N2BMNnVq1F4eg/sBt
 zQMaUGB8/nXxg94oObRSAOABfB2dXr0BwTSuGS4nVD1AI5SmmZqoYizx4Kde4ckTXoKgmX2Oh
 VFliib6Jq4YUVI9AN0/YvRETgTCEkbB2j3GCcuGxtTI2Z3sfJoLie3B2IrZmP/gJF3aPCkIjt
 mT/ZFbaAtjp5HqqjWBUf2xqmdJDuTtgYhGeiLpxzMgYtkyQWrjlQGX73VXlp09s0XwSrFxSC2
 gduTgsgqSi1QHVW60JylYpA2bzfvu5F/2Ln4bk3OWnIEa8edW1oRi/A10HI/G0NjwDps74D7k
 fm7EQl47x5d5ELIxrnEgviTvOsLrvNuq64eCgu+cbywiASbLDjJtQ1jfGkmoU7Kp8ba6LHmig
 Tnhl8G6D0ilAEDilL3j3fhDnEKAjQG6k5Zm1exNvlMWIS8DrfV+GaUnawvE2BkaRLdZIwaCte
 mwXu/VBmtjioW78MhMH5d1xleNM/190WebGQPzvRIU/fJmB4MDxVuZOGMU6zdSUND8xhGaWYC
 K3zUCggaefnW5SdyF7YAqYvwpei0BLV7sCoBAElLqHLBnZw+K6Q53+SunFa5sqrwTVIjfjsE3
 qbfmpsSIL4r6+NypSa2DW5DD7GMmm8bZSgxo5ravfS40ujp320UWFm+Hgj0xgqPoQi7g0eSFC
 51I+Gm/9CNpzBVaCGqSxsXRn7VTyNXX3U0JZoPZpp0BjmzSswgChhY39WtNj4t9Rl/W52wdtD
 /awhmwjT5A2Qe6ln0XvlmHbGSo5wP7oPcfbvRg9xc63lAdEEgmoPmS8aXldoL17wS6FlawcU1
 MRO7hG4KAPkz1YtGBpgN9dIoU3akReeVuHcu/20fwzKCSc51VOQ/RvlqZ9KMqf+9d2ge61y8j
 maiwyKAI4abxQJ62c6gBpHL+sulcJ3zKDUKXv8Csi+pK+vncMJY6oFuxzkZ3YRBxLtACyUX76
 F0qwwFjg0NYgA9RRsd9OeCrPX/hhzpPe5OdQYtj5Oku3YpLVvz6fGFeKW/IBxcVNDIF4Q3U2I
 4GIaMsnSxiZVCChZX/N8/721R0dkAEe8vH3Frxlf9b+zc81Pf7R2oyz83dHJslp/xNtTLuypT
 7kj3O+xIVExdfbUeDfMKhQeHBx5q5teVj5sPecGLIcisIXeT87sMcP6Iw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This deletes the early boot messages in dmesg:

/var/log # head dmesg
[    3.114274] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114286] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114291] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114297] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114304] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114315] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114323] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114329] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114333] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0
[    3.114345] random: get_random_u32 called from
allocate_slab+0x144/0x480 with crng_init=3D0

5.18.0 was fine

=2D-
Toralf
