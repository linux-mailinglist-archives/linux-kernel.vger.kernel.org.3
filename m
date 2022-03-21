Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170654E3197
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352786AbiCUUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbiCUUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:18:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292166ADA;
        Mon, 21 Mar 2022 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647893840;
        bh=gMZUlaRhHtOuNiUNkognlAAgZhxejeKPaZRmrnNBtrg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WSz/VADNqR/Ws7ZCPVXgwCO+aQxOimtHviOW/C+LYH79WhfM+vTD2jVYx+MhNz2GN
         NSaAo12Tez0NAcojb9yPR59hW3UU9/MQRTZLMUaclHnBPE2yuhUfF+jTc8+Jn3i213
         0/o2tXOuLNG0sBxhzibR8ja+hhc3d9p9WQndRjXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.171.242]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1oOdFO20aU-00sd2L; Mon, 21
 Mar 2022 21:17:20 +0100
Message-ID: <23093534-380c-5cd0-389f-0fb4206fe784@gmx.de>
Date:   Mon, 21 Mar 2022 21:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] parisc architecture updates for v5.18-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
References: <YjiyOIc71r53GME+@p100>
 <CAHk-=whnG8uJqNz83Fh=6je2u71syaenWEpDQCeHoPoxZyM5Dw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=whnG8uJqNz83Fh=6je2u71syaenWEpDQCeHoPoxZyM5Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sQcAdzhQcldnfYm/RRMbzGL21xJtg3hbgAy2o2X3WUhEACYJOxL
 14E1X8jx5d1LjLyLaQPG6rw8M+/XJ+H/19znQlulmYxpB4sp6TPURFENQxdua/RYSJFOPyA
 ca/PcrvNfQX6hMm//QFpja0hB84/8Df0qPc6x85RL278WjCZ/nL7BG1cnIHKZKHjUylxDJZ
 lPaIVubgYUr+ENpfaNHPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9eJGqUeUuI=:gtMS0hp48t86P/LBEG26tn
 txw5TbBmmjYkGWeT2d1CpEBgaSjbdLWfYSGLhIPdte6TLiYaJ+lPR+DCc7cmfklyQxnNje3cr
 sViH+nn0dC9zGfSBZhuc0FAQAENNJJm8J0LXwk3WCiGWI9QcIQbgnvWuEGTFVZtJZmkNCsK8+
 vQqveM3Wnl4ywKIqH/YN0HnpWVs2iiztgS4Lhm/IqXpgMl9X3YKVytNDyfLaBqx8EI1BmMuap
 wBX4RN1SR+Omo9e7tUyYs2JQMjP3uMGLOhtliWmOxKTXjTX6WbTVJ8+N0sW7oB4REcvBqDsYV
 H+bwKTjEk9Z5fE6ahdhGBBqeXp62j9WxFxYKn/VczhxncINAs8bruGCDVBqP8LLt03D3VNlPB
 HiIA1+T7FaX6WPfXCl1k3ZGYZ/cd7Fb23zK8nSN6PduYKwcBg0Li/33megx14ux2ZGv9gv5BO
 tUsZaXvDuPB3iVZiehAviF4I6Yv/vjwIwqRKUf26c+Cy9XYQRreDiqwtl3ipdg3yWwgkbXxpr
 b+BTN83uR+fdI9celYyb56gUBbe2B6e5eXDMu0+TxlfcALr4PZMJa14WL5yi5H01QGiYUzDJ6
 Jdg9KFa/o2Bzh8kR91Vwlol/K43PHBboxzFSKLMCGQGRh2sM0Bz+2lFuFoGlGyhE/bnx9ui5e
 o/oKWY2uqX214BD4EIgjX1jsAOtuxY/rN4kyu4kAyV8tmkSPqCDfZJVOeNVQJQWMOGihnqnI7
 cCmy//2bSrUQxHJoaYwlHak+R7nh1fkp6s2OZ1ULN60GMiPdHw2IdEwDk8IYrGnOKODiyJMdN
 LwdwXPD7uJW+wjknq5yiojqMg5cetjhQjWCbR/k7PqZW+Cy8tLfw4S6Wx0cKuRz63+P7r5BSr
 2fFXKoWcy301xjzFAoQkIm6B+i9bLqLHXdRHCPDv7XzeICZuI2EFbCO4/K4Ur3uy54CNcXqqe
 15j1qJ8RXYlHn5EXxD0PVIaTbmnn72S9E4XoayoR/+SW3tAGDYhHpnA5ttnEHT5ejNzAKzgUK
 Fe/Ild3ba0PH9awri8z50YzOeGR4UEDD3W+z8SZ4xnvDIkvC8OZFdQs7O7WEC1PxLxn8qwE03
 v+bNIXI/3o1gqk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 21:10, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 10:13 AM Helge Deller <deller@gmx.de> wrote:
>>
>> parisc architecture updates for kernel v5.18-rc1
>>
>> - add vDSO support (allows us to use read-only stacks)
> [...]
>
> I was all "WTF?".
>
> Then I checked the code.
>
> You mean non-executable, not read-only.

Hmpf, Yes :-)

> Fixed up in the merge message.

Thanks!

Helge
