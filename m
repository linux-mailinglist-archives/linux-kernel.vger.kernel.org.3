Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637605387E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbiE3TxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiE3TxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:53:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E664BE0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:52:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653940374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjvtLPobMoxb22eHrXBm3piK1Mr5ZJ9PX82I/93Pzeo=;
        b=2egWa9b0OdSGOB8ngmox+P2RgzYZ60gDTlm9bZJnWT6zFyQFNXm537A/CK0MtVyQF2CxBN
        DydUK/eXn8BCCRRbwnycWROwnOL9D1J16dTa+J1W1XfhS8zfQGNh0pR5940Db+G4bl4GhV
        XV2JDxZukZ3U6Qe4Qftk4QbhwvTgoaCa02tCuRn+vkJJ1VsPgKj3MIZJ6P4D5oza6F5/7y
        1lHOtDa7+6fncnrPAecZC8fvAoHr/2xxkTYm0tV6oaCgo1a7JZ75+KcM5t+IHakq/ZU4kY
        fjXB4FLTfcjVrvwHSBTYzqz28qUkrGZfFrrx66N1PP9rd/cKjsXkcs2iuTimSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653940374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjvtLPobMoxb22eHrXBm3piK1Mr5ZJ9PX82I/93Pzeo=;
        b=AVzP3zVMjutvKAWFDIxCj19DsWelsmim17vBR2nwGv4zMEbYLtimDTSyUuhrk8xcbfAEAd
        fR8bll2ht7z6OYAg==
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 5.18.1 has thousands of similar lines in dmesg with
 CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
In-Reply-To: <3d3f6547-11f3-6faa-4d4d-792a5c5d39ac@gmx.de>
References: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
 <3d3f6547-11f3-6faa-4d4d-792a5c5d39ac@gmx.de>
Date:   Mon, 30 May 2022 21:58:53 +0206
Message-ID: <87tu963ii2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-30, Toralf F=C3=B6rster <toralf.foerster@gmx.de> wrote:
> On 5/30/22 11:24, Toralf F=C3=B6rster wrote:
>> This deletes the early boot messages in dmesg:
>
> changing CONFIG_LOG_BUF_SHIFT=3D18 to CONFIG_LOG_BUF_SHIFT=3D20 helps, but
> nevertheless:

FWIW, you can also use the boot argument "log_buf_len" to dynamically
allocate the dmesg buffer at boot.

For example: log_buf_len=3D16M

This is usually more convenient than reconfiguring/rebuilding your
kernel.

John Ogness
