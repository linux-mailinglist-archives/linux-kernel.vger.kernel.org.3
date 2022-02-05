Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FE84AA988
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380251AbiBEOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiBEOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:54:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B2C061346
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 06:54:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i34so18359237lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZcqcXCLEtEOHv5S/HU5DQ6aN7Gm92b8leydHIAl6ik=;
        b=RrcFFDkH0kfjnSHJthnNe5NntffHciXVRSW52mlJWKrMarxvqWj8GiHkNJWBoZSae4
         BwpMGm60VS2HHqcocpJTg2WgejLESpfcE4os/hMV5txUTPZntF3ut+RC9+OfMxjbE2di
         mcxwDJq//k1EYM20FERKL9lMsA945zrVO5X3+UEFp5Wf5W3Ha22HLJzUdI5s3+oVRsoZ
         BCnVL2OeIPdgYWVfw4kM5TgZv1sVndKjcnWp2qkRW39PjLAvBTzSFP/+nAFfTdLESSBO
         GIRfnfJyl0vWNaJKNSxOo9LBJMF/EtTV5NtUyutdOBwBN9xMuWJwMJPeEf2aE6QE4o8k
         WKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=KZcqcXCLEtEOHv5S/HU5DQ6aN7Gm92b8leydHIAl6ik=;
        b=FxRmT1g9umt0XNTxjT+oQndJwObY+l589GMO1mRiRUbiZXupF1Z5YdNFW1vcub/0UP
         JbGH1UFyAk2VpIt19N+07bb5kk5yawotIfK7yfd3kAKTco92VyXyhPhTnRhBPUx34H1z
         yryN2y5DWjgPsYZIcCtfKFP+q7lD3cqvAxtA8OtyJDGqIkENJ5Lr8X5r/0IxeZk0/H1P
         EeviE0fb9kuYrf2XWa+Ha8RqDuWsJhcH5m59iRJpfqGBY1TLZl6cWcAIup7/4j62njbm
         ZZ03o4BWa69gfO1v2oJq9rbYikYqIw8fMBt1t3Bsa8yrYo9m5iDRIe7GVplysWv/XRO2
         qUbg==
X-Gm-Message-State: AOAM531LaOKfSOPYIgP8rmhFP6nYNt2Ndk9S1nPFahxk98R2blYgxmwf
        Efh/w/QjgVaQFlZX7QlgOA7jQRJ7ceY=
X-Google-Smtp-Source: ABdhPJx0tVCdAuWyQPmp/IL/thvmeAiDNRAtFth81R+uGCQqfRoxjQv+C5fNZ54TdDVJrMRMnmKMcA==
X-Received: by 2002:a19:f24a:: with SMTP id d10mr2809631lfk.649.1644072859289;
        Sat, 05 Feb 2022 06:54:19 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id i18sm751298lfr.104.2022.02.05.06.54.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 05 Feb 2022 06:54:18 -0800 (PST)
Date:   Sat, 5 Feb 2022 18:00:16 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>, tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220205150016.gvrst7ldvgjh7fra@localhost.localdomain>
User-Agent: mtt
References: <s5hsftp3027.wl-tiwai@suse.de>
 <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
 <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
 <s5ho83yldu3.wl-tiwai@suse.de>
 <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
 <20220130111020.44gzrm5ckrakjta2@localhost.localdomain>
 <s5htudk9cn3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5htudk9cn3.wl-tiwai@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:57:04PM +0100, Takashi Iwai wrote:
> > IO_PAGE_FAULTs go away with CONFIG_IOMMU_DEFAULT_PASSTHROUGH enabled. As I 
> > understand, this leads to reduced DMA device isolation which is generally 
> > not desirable. I was initially thinking about races between some delayed 
> > code and io-memory pages unmapping, but first IO_PAGE_FAULTs (running 
> > non-passthrough iommu) happen during bind operations as well.

> I still don't get what really triggers it.  This won't happen when you
> build modules and load/unload the driver instead of dynamic binding?

I've built snd_hda_intel as a module, everything else is left built-in.
The initial modprobe and rmmod were clean, but the subsequent modprobe gave 
IO_PAGE_FAULT.

# modprobe snd-hda-intel
snd_hda_intel 0000:05:00.1: bound 0000:05:00.0 (ops amdgpu_dm_audio_component_bind_ops)
input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input24
input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input25
input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input26
input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input27
snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC285: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC1D0:    inputs:
snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
