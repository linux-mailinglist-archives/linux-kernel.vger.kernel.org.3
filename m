Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83BF5848A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiG1XY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG1XY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:24:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8B785A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:24:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m8so3951053edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIA4RVx2AB2aGku6+GNAoiOt+zr30HmSggaLIZR7Rb8=;
        b=NlmLk8oda7BWnIZUcK2H0PzTRfh3iT5XLbYjkYZ6seU7fFknpWw36RqcBEP2JGMOy7
         oQOGj/qMTpupY+AxgM705aB8WLKvxuiLMVu1Th8UkpdbsTStkOCMB0DCjyrL1ra2DUm/
         O/P/tyxWCHnq7oS2hdYAzyA0HTYIdP43MoeI9e5ewZG5wZ52qaick0H9Qx5Mz6w27RbF
         +EV4QRFaHMN4SWAdFZEhLzUCLzE34ZwsfptHiWFWYFUcouvaphR+wH7XOTvTClyJB0cA
         RczTztzwgcN8A++WohoQTj/y42XLY074VxwHoh817MpDWR8yISaePKJSlfKL+mQDWHOm
         dWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIA4RVx2AB2aGku6+GNAoiOt+zr30HmSggaLIZR7Rb8=;
        b=AFYnOUoZExdR3zmCIzuSb5NeDynfQs0bIR9YdXq9N2anwP0LGDskclOkjmnEIZ8Qxc
         MlOyjmg4vfdlgo4c2Jr+E0Dhi5FIfdgp/qBoAlOHVwypPqs50XfLZ6NjeeNRWYQYfNjb
         1sr+59pYvAZ+GY6fTmtDHmSBCulllEvADZ/Mt68cU82eRVd/XsuJ4xUP31IRCnRV0b9j
         AfH1xdicVRKVJodN87x+pbRcEYYkWVc8yrbKsqJIaKVXv2YaIpebHkp5pC/xOaQoDoGq
         zXkfcMU7pafwGh1KD6SShRFU4VqLn5th5f9xcAEHBCBLf7z3gu4U8tj+30aNcHT/VEDg
         +U3Q==
X-Gm-Message-State: AJIora+eEmSyvhtIdJpJzG0dRQY6hNaHUKHle739n0MNnu6lzbNbehAF
        S2YNZARdKmrFWGXo8qaIXqwlR39sITbXYyVBH/Q=
X-Google-Smtp-Source: AGRyM1uL+/LS63rJB52evTcvuk1tse011MzwsBD9wpLEacOG/tM0fRTjbKj6Sn2Vp+/ZWJbVOjL3Mi9liDVsbrgUJ8Y=
X-Received: by 2002:a05:6402:64c:b0:43c:ea8e:85d6 with SMTP id
 u12-20020a056402064c00b0043cea8e85d6mr1164234edx.269.1659050663929; Thu, 28
 Jul 2022 16:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
 <YtuceCr5OCJcDatJ@kroah.com> <874jz82kx0.wl-tiwai@suse.de>
 <CANX2M5Ywm+GpYY3+GsOWCLH24Nhy0M0LjBE-pHC8wFcd7SO=wQ@mail.gmail.com> <87tu73p1o2.wl-tiwai@suse.de>
In-Reply-To: <87tu73p1o2.wl-tiwai@suse.de>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Thu, 28 Jul 2022 16:24:12 -0700
Message-ID: <CANX2M5abRrSADvd3x_rm+TrA2ziu71VL6X3=v_Cft4LtaB=6Eg@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, perex@perex.cz,
        tiwai@suse.com, consult.awy@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:25 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> Thanks for the analysis.  A good news is that, at least for the
> vmalloc() case, it's a kind of false-positive; vmalloc() always takes
> the full pages, so practically seen, the size is page-aligned.  It's
> fooling the memory checker, though.
>
> But the similar problem could be seen with genalloc calls, and this
> was fixed by the upstream commit
> 5c1733e33c888a3cb7f576564d8ad543d5ad4a9e
>     ALSA: memalloc: Align buffer allocations in page size
>
> I suppose you can simply backport this commit to 5.10.y.  Could you
> confirm that this fixes your problem?

We confirm that the patch you proposed fixes the problem (blocks the
reproducer). How do we proceed with getting the issue fixed? Do we
send a patch according to the steps detailed here:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html?

-- 
Thanks and Regards,

Dipanjan
