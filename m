Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5850A7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391173AbiDUSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391211AbiDUSII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:08:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14A13DC4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:05:13 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1pk0-1njn2M0Qm0-002H3L; Thu, 21 Apr 2022 20:05:10 +0200
Message-ID: <7be89f17-8993-c0e9-3965-4ca5db3c4b57@i2se.com>
Date:   Thu, 21 Apr 2022 20:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build warning after merge of the pinctrl tree
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220421171116.6dbe87cb@canb.auug.org.au>
 <CACRpkdYW81iLveJoNu2RDEpySqRcXWqq4XGhGFMYdLvBzhRsUw@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CACRpkdYW81iLveJoNu2RDEpySqRcXWqq4XGhGFMYdLvBzhRsUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EVtiik8/dSmwP3H2lw0tuXN//9pN2Fsr+moOQlE9wMzlbK6EuzT
 9nf5OwVSCP1J8JA9lr/Rc0Ln8/3HFyIWJK3NooRSblS+uWSg8LQ/6N1hqvu34QkLEb2FFFf
 mGOhGK9Cwnt0nzJ8OAxXqpgAoBQ9g8GkdkgvBRy2xzYzf/gXYoPZIZFg3DHGkUTRUT/6yGJ
 bcWWcwhUydvEgi3qc3IQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fd9QVqU1P1I=:jGO4Bn+H2VFYkTGkuqNQN1
 Z5zrqQPDYRHvgi2bxghgnovyX1b3g3ucyVWKocGZePrtZmn7AwbyNCke/hMr/fXxlKhUjIi4N
 9KA/H9louOSJq4mu6F/9H0UqcS7v2Qla4ddSet63AY2DMnRSUXq5JK0blD2eFTgt+S9kOPgPM
 6bTXZ3dZhohdlBOuRBw6jCmM8TF1r8+Z2HytVbWgKd7XSaQjvq2+lw6A+Fhw2HzAl8jx1c4Ly
 sPU2iqI5J//0q/IhRiNXvLOVaqZKXKuBNSoO4HKV44S5G1gKWZVjDPJluviF2sd79/VLhYbnF
 rQNJ4f5xwYluM33PqJfnD4gqZJS85Moiw6zOM8tHsdg3Pocbp/Qf6gQFF1zenoKKvHml1Ilgr
 J4vIYBL+v3KTsuKQ+mlz6m4dGqMwEDzMW8v2vbn19FL6WICw2Wd6OfjRA2h72PYjFvtUhVlP8
 WI2pwxesu/87J9tk5QTFyxL/C4aH4W1O7yiCJcR4e76+9XZeNtb3m5IGj6NdOmdt1IRbfK2dO
 H0AwFbXd6XYd8LNyEA9VZ8BPMGWbEAXROIOgvcT8HhYiqo9XZDjihIszJWLkSGi+vnPQB0vVy
 pSw72ivtcLFJRJqyKSh2Hf/jipdBBdLEpRpPsKA5/Y5Qa2FM/uY0AwBpzTPXrjbUAS0+RoJTA
 kiIuJKtRFV/4WwwLV7F1K+HjgwyNH308lhrKNiFgiubXgeDUNGeTJEnEXdvsEdSXvLlpQ8NaD
 Dw/P28FdVjL9KMEp
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.22 um 16:12 schrieb Linus Walleij:
> On Thu, Apr 21, 2022 at 9:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> After merging the pinctrl tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> include/linux/gpio/driver.h:507: warning: Incorrect use of kernel-doc format:          * @of_gpio_ranges_fallback
>> include/linux/gpio/driver.h:518: warning: Function parameter or member 'of_gpio_ranges_fallback' not described in 'gpio_chip'
>>
>> Introduced by commit
>>
>>    a9491df0c4ae ("gpiolib: of: Introduce hook for missing gpio-ranges")
> Thanks, I just folded in a quick fix into the offending commit, a
> single missing colon.
Thanks
>
> Yours,
> Linus Walleij
