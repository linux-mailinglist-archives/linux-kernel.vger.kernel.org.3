Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2B5387F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiE3T70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiE3T7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:59:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A9F95DD6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653940750;
        bh=HPzVzmx2L+F8MCbfaEMAdaGEbPebAHvXwVZeg4C/7Xs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=d1CBzBDEAjGh16QBvB45wIACDuADv7EXUB7lzjVI9PUjinUyM9I+Nj1TcZNHEh2/N
         hiuktM6nYpz35pgy8Eszr6/HIASW+zxgdrZUM6UKgK9azhhEaKCXMFm1kKJJ9mqQQN
         OdJk0v1HyKgjUEc9dYVC6UvVOLWPQbQCRQMjXJ1A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([77.8.130.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1nxySs0Qhs-002HzC; Mon, 30
 May 2022 21:59:10 +0200
Message-ID: <3506d671-bbf0-a0b1-d460-11a8e0365cc8@gmx.de>
Date:   Mon, 30 May 2022 21:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: 5.18.1 has thousands of similar lines in dmesg with
 CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <83b4b916-1334-e3b0-cb1e-6cd12ae0ddff@gmx.de>
 <3d3f6547-11f3-6faa-4d4d-792a5c5d39ac@gmx.de>
 <87tu963ii2.fsf@jogness.linutronix.de>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <87tu963ii2.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Ss+LsBt9lc0kWuQA5HFGQw2e7CAF5TFEequqIra7gr/ZvvXB0u
 eB59LMFIogM09KC+zARB3Fa8XqType5CG9KOaAyKHTixATJmTQtZgxaeje8hT7gxAvAO/Rk
 ZApmjO8jMV2OjxP+l/hiu9b2TD9csniWBMeWhr7vGa+RJtFeJZdsuVayz6lq8ShJDWwapBB
 odRPyGf8Dhl70RIsq34hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tNyUvHez18k=:wow87LLIUESt/bB2Q0q8CP
 ktM0ZAKy9UHw1Q+O473G9nr0qZU2+ciXPtwYlTqFGNuFbTdQCx5NyrfFh6hdC6vHlX7NHzMmZ
 fdQ7jaaJjge0maHzlSL0jWuskcf207uMuyp8OsqNHvuPaMv/42BcHcVBM+P+kFfx9Ob/ph6A7
 2y4Ng11I+fcWd8HQaSV3iUNIUH7XFkmYrMXmeOMxQBWyu3yGhVO7C94EbQ4Bkcq6l7BUsHRb8
 kNFDbunPgIrvyj0wrxKDTtp/SuNLMTfCjUDAnvn7XFzaoUDAyZ/L5eMw2oaeGll9wjZ+f1LcW
 6ulnPEn98LahPV2uc2nEn27tUr1d96y67FP+UBrK6Swh5KKn+tvLeo+K+nl/zVIaR4QmEqBU3
 v/i2oW9+T1vXByCUhQL37V6Olp9q5PAr120ozVLoEuE6R/rk+ZT7zl5JKQi0Zp3RZvG1p8eB8
 GfDoazAIkQPFhhlsti/rXfCDHsqPxZljGx5SGICTfyDsZT4SNQMAoxmO08XLrBW7yqUnwwTjl
 4lG9PSFwwSPvOJJsG1BMDqjUpXvjz/R3vZSsqCo3a5XovtckexHedsI3yrbch0G2XhEICstE6
 uj7LH7/778L4fdyD3rCf17eIlLc0FYZpdKvNLx9QT6jZkCyj1A0Tp/B97Ag3a9f+Oksg11ZQ5
 t7THTnXVbhAxkc9ricaG8izZpppA4mu3F27wD6ZdvBl6J7dcKKSaD4cKkHKqXy8MWwW42793R
 FOEcINPSx5th+6Z+sFyOFawud6nVI+bUs7IylDkeiLuBYM3bXXBnJHZ359k2v853wtT/3aH1i
 TAbYQiQPjVmD2mYnLnjjT/55cxlVUXCx1zyl+dGZUYHQJJdqLF7t+6u/FpMIUT4ck6xRzDMMM
 ZxiNWDn9QeNH5TnfyZtsSVNzGJyexJQwtpzUfZzfZyNweHTP1XM8c1thteWj1F99OkmSgiNTi
 bBVaimGAwA6hvhZ/TLLzuo+Vgg7Gy+bUN0+MB7VUWErd+d6/5bETs6JZ2wJPVljtTbt+uWIir
 /RDLZ8ADJ2HWF4t2rhRWmrda4G5IjHsHpNg4umDbMDOf53JwlEFIfHXzkZxL/hYjswnTQnQbu
 l4/dGFzhSJOURyJdMpsJJL7+NwmN9DRCM/aZTkvJoL5GLU6fWu5o+Ip2w==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/22 21:52, John Ogness wrote:
> FWIW, you can also use the boot argument "log_buf_len" to dynamically
> allocate the dmesg buffer at boot.
indeed.
Thx.

=2D-
Toralf
