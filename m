Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5434B4C02D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiBVUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiBVUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:08:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07035F4D0A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645560484;
        bh=9kjP8gHJ8zbxt0nrGOg7pzWmd2T/4X/XzJhvVHrw7mc=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=hs4treuNOBk2/uax7SAHqnzvl2x+IUERbnYioPc9ZnyoGJuvY+m3NC/XV6oq5ENq9
         6m+44chJxDbFsVKCUqP0Brmu6Yfw2AfAX6tVCk8Cu9ftGG2hywWdeCnUF/lMYHIGWj
         /OUGsa/9r98fV5Qoi8WXEAe0Cleh8eCuzoLyTTzM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.43.229] ([217.116.116.252]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1nYeh60P3s-00N6oZ; Tue, 22
 Feb 2022 21:08:04 +0100
Message-ID: <e4ab39cb-fbe7-1148-8d8a-5cd46866159f@gmx.net>
Date:   Tue, 22 Feb 2022 21:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     j-p-t@gmx.net
From:   JPT <j-p-t@gmx.net>
Subject: blocksize 4096 even for floppy and CDROM?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1sJtDLwGrzhoWmGyDwABVwneUGQiyEWTVI7sa6S9rcdRHz8Quyd
 sRirU7Z3bQzPkjarPm5baV6cNdvtj/HXLqZoYCBFG0iriMfCHq/h8FJKQK+caD9nZXIWftR
 6+JrBf3y6jo3i1X3vXYZXbUa4Hv+wDvU2qDSOVMA6yM0u4Bf+T4AdsHF/pUzfVhFqR7PTPZ
 M6EStHV1/zfYAE8KYF5Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JIqnRmLUlk=:R5CpZ51p84W0UXOkvOp3dJ
 eDz7DsvVMTzL10KqIMnCjnik6VBwiPLDMp3/S8nfzniPJifRI9I3r1CAQ/lqksicEa7CdM9e4
 VRJwwaXh3wx3TZuoSZeWzro1gZXKJK+OPo3yweX0VIuqBNdBkUFFTfOuVlLdEpAswuGKMgg/L
 +iFAC9fmE72USX5sDusyPHjBhNVcNC84ORTqJXTOBC4tnhZsAdA+4dTtAnG7n6YCInlRTyRhb
 z7zPDs5M6i74MD547AOlYoI83znfppgyc5AX9FK2K40s/7xGfvvsQpX2FQlDsFM7Z3qAGS4RP
 TMUUO5y9wRJEVgvgLE7ntOzlznHaiSvrsqsfbPQpd7isJuCPPx5pvDFZG2rmDQ4D1Tq58a9hK
 ZNQwBGhKn9+a1fl9Citfy8nWZ9Q3iSFAU+bogbeXgyyfuUM69F632gevw0/exHJdKiH4hPkeV
 BrXtwkv95CRsvI3fmEmTwrGhBPz95cf3lkHw1anWUJ4fiN7qZFLcatl7ALTIIkgnwdZQDZzxx
 7wDFRMvE+NGupdIZw5sYr2fPRZUTh2K2YmuAeVi0uqiacc3En+czbwENJuJXyrXEqOPaJ+DsP
 bWLMEPZ6syP5T0HM8CyO3L4VLlqE9wgWxpwY8kkxakUVo3nr2kNa5um1wjn6KLNvN0jy+K/Js
 x0eSPyQY7qdSUFuu2XU4dbQNOlyida2TkkquWBV45p1JGefWxkvM1Q4SXdIoe7PDvqQ950lZH
 wyw39SZb4lgM/2nNwEe0j1bOBjIyiBc1YlUP7FmlHBq7EhMtSgKOeRAM/IsTg/5glHAksUDrW
 Cc2RnF2yEmlET+qv5M7y4eIJVbKZGFPZKsgZPWp2yERjPJKGWSj80HZf488mEL0ZaXi0fF+No
 Lo59JpRaSghmUMdAWuUzgF3R+SqqK8wy5yt4b8MqjkDjLomcN5SIMBn85jolYLCW/EvFTMAGk
 QyrOYaYed77ko3kIE5T6OYYRJLx/t1iXCQwEmYEFwjbw/2NfH0ivfeGgXySGMTdYs4ienM/lQ
 MBRC5ZqYHsOT/8SK416K0MghKwxzHBNCaV9J0LCGG9XyEdsCdmcYbWUwIJPWCStW5oyHnZMil
 hk+ln1OpmgblCE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for bothering. I fear I need help by a block device pro ;)

I try to read several bad floppies and DVDs using safecopy.

I wonder why safecopy always says
Reported hw blocksize: 4096
Reported low level blocksize: 4096

even if the medium is floppy (512) or CDROM (2048)

is this a kernel issue always assuming min 4k block size?

Does anybody have an idea if there is a Unix out there that doesn't have
this limitation?

or which Linux version dropped support for smaller sectors?

Or is this simply safecopy's fault?


thank you very much for your help.

Jan
