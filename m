Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D085489B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiAJOwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:52:44 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiAJOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:52:44 -0500
Received: from [192.168.100.1] ([82.142.23.158]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MeToK-1mWmP81TXQ-00aRXa; Mon, 10 Jan 2022 15:52:34 +0100
Message-ID: <1f913c8f-45fd-32fe-d456-ba4d1920efdf@vivier.eu>
Date:   Mon, 10 Jan 2022 15:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: fr
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220110084239.1597511-1-laurent@vivier.eu>
 <20220110084239.1597511-2-laurent@vivier.eu>
 <CAMuHMdWtEZ3WqFw0ihSAAcTP76TdR+jtqjkX+=UwOi+=04xOWQ@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 1/2] m68k: add asm/config.h
In-Reply-To: <CAMuHMdWtEZ3WqFw0ihSAAcTP76TdR+jtqjkX+=UwOi+=04xOWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pwxq2Gx2x8vc53pmPfpEgSzldrEnE5D0fyO+eWrLhdfIug4ipJS
 GkxsEeGQ6/RCfRgpKLlLaJPgQd0WqSF9Py52Q+4u3pl1rWs/yJWIuy4sKCUOYqOVp3eXuZ5
 jF5anYDTsuIeqsU2+oK4n1brmy081jA59uAdavLED6IU1/H2EOfR6odHtijGTKOJbMec9JQ
 jqxaCfgZGHjIFNd/Cxcww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/cSx/aWVMQ=:Zg+EmJdOn+s2t88DIxvWo/
 oZggx5Bu91er/IA3Hd/1oZGy+6xEhN4Ogc6PE/tGCMpUfyIOFlOhUVbbsvVlZ4aJ87VZGxnV3
 k9jqr9BuF3BzwN8ErrWcGLBOaAIbo0Odpc4uGKLtRm2mHHkjzvyC/qlb8qYZ9NHzBGWnmtKdH
 VON4p80B6+4FWt8eUfaXSvDp3xLkNym9yPegZLAfx0sLqnFN4vWtzKaPwWGu5eWLnp+RN+Bjm
 GzgFXK1Z7d+kGG7R0MJ+nbsaMdizl+qMCC17Ek7AElVFBbJ2snKQn3M00n7PIKuUELJ4xlc00
 NpHrnNEg1JgykqxPlWbOEK+SGqpNV7IPZoZ8cxOLBiGHJMyNDIke5tMuUbe9AcsRNzmEDYnJj
 SYUGl9fkksZCmmlGAnBGT0XM7GQcbveIt8Z1kcrXhar7nvj6gusosdmjVmXRuesx2SxsB04YV
 7tDHO1vUJCybJolx8QmSVRXZ6YiRl5yEbd3h50acIC/9XeW6cjeYr1nI0mqgrZ9HOZvQio5ck
 p5DWKuYIOc5oPMQjFO9DjHU1Uhd/I0NI4Q0D85N3l9n5w/kvpOdjBQmPV3hfUHcwKLAdhJwfb
 icB3MJ4piMa62OnHOKCfVW3pT/s/cRjLECsZISCScdIIU0i3IfNqKnDjwNhjObFbx7dqY1IyK
 MKdz1A6Pyel/5Ffq/jYjAgzQksOHOTCNDtzemJudW9TQ4lghShefnOlP3hDZFYFQPXcU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/01/2022 à 15:21, Geert Uytterhoeven a écrit :
> Hi Laurent,
> 
> On Mon, Jan 10, 2022 at 9:42 AM Laurent Vivier <laurent@vivier.eu> wrote:
>> To avoid 'warning: no previous prototype for' error, declare all
>> the parse_bootinfo and config functions prototypes into asm/config.h
>> and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/arch/m68k/include/asm/config.h
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> scripts/checkpatch.pl says this is the wrong one.

I'm going to add a pre-commit git hook to run checkpatch.pl in the future...

> 
>> +
>> +/*
>> + * This file contains prototypes provided by each m68k machine
>> + * to parse bootinfo datastructure and to configure the machine
> 
> data structures
> 
>> + */
>> +
>> +#ifndef _M68K_CONFIG_H
>> +#define _M68K_CONFIG_H
>> +
>> +extern int amiga_parse_bootinfo(const struct bi_record *);
>> +extern int atari_parse_bootinfo(const struct bi_record *);
>> +extern int mac_parse_bootinfo(const struct bi_record *);
>> +extern int q40_parse_bootinfo(const struct bi_record *);
>> +extern int bvme6000_parse_bootinfo(const struct bi_record *);
>> +extern int mvme16x_parse_bootinfo(const struct bi_record *);
>> +extern int mvme147_parse_bootinfo(const struct bi_record *);
>> +extern int hp300_parse_bootinfo(const struct bi_record *);
>> +extern int apollo_parse_bootinfo(const struct bi_record *);
> 
> Missing parameter names.
> 
> I can fix those while applying.

Please, do.

> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v5.18 branch.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert

Thanks,
Laurent

