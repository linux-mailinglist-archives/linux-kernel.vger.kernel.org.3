Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8828C4BD0D4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiBTTGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:06:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiBTTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:06:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AEF4C7B0;
        Sun, 20 Feb 2022 11:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645383920;
        bh=6KNpyc0ZW7k54/xmz9GluUG6R/Rcoqer5CR8Xt+p03g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gcsDqFRvghF/nV5U7WrtjeBCt9E9BnAx7jpWah7N1dQJH7AhpruPDtVJEiZpJWaJ8
         nV47flPc2mS6ZNYVMU7+ITwYbC0BFXPQqMcCP4kzsr1vEbu+4RN9s7M0j40vQ91l7Y
         joWLjbIRBk8swaJY0OQT6843u5vEOcutrhMxy6BM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1oH0Qy243s-014GKV; Sun, 20
 Feb 2022 20:05:20 +0100
Subject: Re: [PATCH v2] hwmon: (dell-smm) Improve assembly code
To:     David Laight <David.Laight@ACULAB.COM>,
        "pali@kernel.org" <pali@kernel.org>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220219211011.16600-1-W_Armin@gmx.de>
 <6f4c21b5e1cb4fa38a5e0c1716658329@AcuMS.aculab.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <77eeca08-e970-84df-6490-36e330ce91ca@gmx.de>
Date:   Sun, 20 Feb 2022 20:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6f4c21b5e1cb4fa38a5e0c1716658329@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:CP19/Q2N1lpZ0Mfk8s8lmQfk+E3TuQKYsTQR3rNDSbjop2IP5zl
 NRSDyx9Dz1A+mYyGXBMjYveHMeY+RXMRQGq69ubLFDTBMB3tESHHguBeJWBCFgHksnTbR8j
 VOOPrVt7JGwaWKjz9JQv1i2fuFjL4A0CE3qguAVqyCSpPOyrG0QWYwEv2S8OWjAZJJrRnzG
 vqmx2zg90apFtAYJxt/0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qwydroLaiYw=:oVQub30VXGCLLmcsMtJ0Nx
 Vacr4Amkgg0xP49SrNhYgAr+95dCiZB5EmWzlL9worOYJ2V32BM5NKQCl1gJNtvju3zK20k/o
 VdNIyVFpj0LDx2Ry+Fwgv1i6ewdtwl2BMMof/dMNfo+gridt1skZ/NqYqN24+ZMljTGXxX+FG
 ZRuI/cfy3X8z9EklNGWWev1NadKnZLfLAiNy9JW3BRKOvPNQdfAF1JVAy6yU9Zldi3PTIkTCI
 8OaUvJRL1lR8dIUOOtgIFPS5y4oeTczqFB8Dnmw9S1ded3KJeaITNePpFyWoQy1vRierVrEl2
 jFXXPL3E1epCU0nVOvtuEidgzJgjzqt/Oqg4uZws9uEDER1eFogEIocI0hJRN6Su22ZuIGgnx
 jC3Y1fHIG1BYmp8y2uKiyNCKjCqP2nsXryjmvzh0ezDmXHIeHUxJciq6U2DVWUcV/6MLZiK30
 D294kuMDBfshdxHfwDc8EOEAS080bfquK/f7azxJuvICFxxa53aq5hwHo0Ag9TapputLZ5YxB
 a1ncf0GFy77EnTutN2ILfJAn2UCp6BWg7GFyrhxldQ69LnAVLGw9K8LZzsGaYsX9+Yu254UYG
 d0SAmDnxQsaVl9E04s4c4NDcBCOjpaF4YI3xkOjn9088I1QQS5v4pFwNIPKAmfOPNVFAPFaUi
 EGmp3b9WztoID4iVeFjw4ESlJOzwRjAZx2elebAGm2NyPK5dGqaU0U7T8SbyTLuClMcmnslxh
 q/Gsep48XvgJDArtwMdbzepj1uV9T+35VoNLYdzshSlzXa0CiPPLV/t2JO1t1yZrW21DbLfnH
 Q4PrwPaDTz0TbLPmmPhHiRjWKXSGboKYTeMznRzMb4NoQx+gnW99voXN9RULOD6WvNN4/il6d
 Yp0tfGWSvjxAvBb83pjsaccuspJAcKRzboXHJadD2sFUXypQ6ZR1R47ymDrWXZGbc3BgdIwsr
 9P6NdxYEkeamREsMZ82FrdLQ0s1GF0ckPqW8KisGDTSM4DhlnQ+YZdVDxrerfGRbbVh2brpft
 Fs8tpeQuAPeVEF/fdZ2O/rL24B7oDG+QLtMvj4Ff5fPILxTczNt4se2HACEpmdOiIQDrOKSn3
 yhsVDjbinVO/zM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.22 um 19:48 schrieb David Laight:

> From: Armin Wolf
>> Sent: 19 February 2022 21:10
>>
>> The new assembly code works on both 32 bit and 64 bit
>> cpus and allows for more compiler optimisations by not
>> requiring smm_regs to be packed
> I'm intrigued about the __packed..
>
> Prior to 5.17-rc1 __packed was only applied to the fields after 'eax'.
> This actually has no effect (on any architecture) because there is
> no padding to remove - so all the later fields are still assumed to
> be 32bit aligned.
>
> 5.17-rc1 (565210c781201) moved the __packed to the end of the
> structure.
> AFAICT this structure is only ever used in one file and for on-stack
> items. It will always actually be aligned and is only read by the
> code in the file - so why was it ever marked __packed at all!
> On x86 it would make no difference anyway.
>
> I can only guess it was to ensure that the asm code didn't go
> 'wrong' because of the compiler adding 'random' padding.
> That isn't what __packed is for at all.
> The linux kernel requires that the compiler doesn't add 'random'
> padding - even if the C standard might allow it.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
Your right, after looking at the assembly output, i can confirm that
the removal of __packed changed nothing.
Maybe i should update this part of the commit message as well.

Armin Wolf

