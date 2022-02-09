Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134FF4AFEBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiBIUzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:55:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiBIUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:55:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33C1DC043181;
        Wed,  9 Feb 2022 12:55:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6903ED1;
        Wed,  9 Feb 2022 12:55:39 -0800 (PST)
Received: from [192.168.0.5] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C50B3F73B;
        Wed,  9 Feb 2022 12:55:38 -0800 (PST)
Subject: Re: [PATCH] perf symbols: Remove demangle-rust files as superfluous
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220201185054.1041917-1-german.gomez@arm.com>
 <CANiq72nb_M3PJLG=mFfQVgAd4fbkL=OhGKS_uQHNf8Jbef3hag@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <4632061c-ec87-c4d2-3387-fcfdccf1da6e@arm.com>
Date:   Wed, 9 Feb 2022 20:54:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANiq72nb_M3PJLG=mFfQVgAd4fbkL=OhGKS_uQHNf8Jbef3hag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/02/2022 18:41, Miguel Ojeda wrote:
> On Fri, Feb 4, 2022 at 6:46 AM German Gomez <german.gomez@arm.com> wrote:
>> Demangling of Rust legacy symbols has been working through libbfd for
>> some time now, making these files no longer needed, so remove them.
> What about:
>
>     Link: https://github.com/rust-lang/rust/issues/60705
>     Suggested-by: Eduard-Mihai Burtescu <eddyb@lyken.rs>

Yes, I should've added these tags from the start. Sorry Eduard-Mihai.

Thanks,
German

>
> Maybe also reference commit cae15db74999 ("perf symbols: Add Rust demangling").
>
> Cheers,
> Miguel
