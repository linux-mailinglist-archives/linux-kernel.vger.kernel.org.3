Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D457AD58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiGTBp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiGTBpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:45:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F32181
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:45:52 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 637093F11B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658281551;
        bh=iOuR3EM03nrpsetThLhUXGtVu7Isu8s8xoqrJT0diWs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=S8sFopArTZPAyTLnBlNI6k/vuVZRO7LQJ4L0ICto3DzdWeDPZKM8kTtt3cx+s1c7Q
         lGDN+mBNFyObzSMaVmbvkeBa7ONQHMnNetmXsJ7mTdis5MUHQ4HqjTOv1O2GqlXM/5
         eGn1+fMbN1oj6StCdkXBHz9myw+iKYgi0eskz65SnJOLvK67cHRI1AzM5GEEKfKZ5o
         YqE3J/VBgY6by+TFQfJ4+XoydyPfmyyQepewmZxODwao6rLF0drhWTreN4yMzccOeS
         WxE5oIS7nAoaFWDi3ww980KLbKgEa/x9V78FXptVXaeg4G54uWR4sOxh2JFRTohgdC
         60QE3OdLJNTBQ==
Received: by mail-ot1-f72.google.com with SMTP id t9-20020a05683022e900b0061c99c2e074so5116272otc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOuR3EM03nrpsetThLhUXGtVu7Isu8s8xoqrJT0diWs=;
        b=pteRJT74HfuUvdXv4JQRZHkUrxL5zo/s4fU6SbuXhTJFb+nsQOLqbecoiYeZlaxXbN
         EbOzwR7ObPPelPcjTyhMIIvNSIMaGLF3R6o+GD0sjA9I74pA4qqcWQ5I6rJNX+pe/FUx
         gwyf1nBgphwGTUhKCSNPsiDQ2lmBIXYlGCnouP327pzKlbkbciUkYh77Xjsst/NfmYEp
         Gjk/3j4PZsM3OaP3SHENJA6YG9KSVaJ4DHMyq5vuGWfnZDWxpIU95WEJN4sm0h1xRoR5
         eUIwsdEopnLWmYqEFTT7I0lDwvA4T9W0W3hjrfgGgc1VRvH3aKV9McTbHWD0GIjb7ZIh
         fO+A==
X-Gm-Message-State: AJIora8p6+THxj2L4rLsXcS3RZSjKET34KiJZsQ2hnA7LubQeGTIGbs3
        nP1LRNo0Pt3e/fol3ZDJSpBHwOf46tb4ZW0YSc22baE+BICEbf5e6GqaP1HczAnTAAYSRssjfLP
        8lLscjigfQB1IWHzZlUoPV0X3DQb+xbz9FU32f1EE4VPHQSXfMrd041MGZQ==
X-Received: by 2002:a05:6808:1643:b0:335:19ba:b696 with SMTP id az3-20020a056808164300b0033519bab696mr1182857oib.42.1658281550237;
        Tue, 19 Jul 2022 18:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkqVMnvlcjLzvddK7hpCOREpVXa/YHDQEvQpn434ZWcGkUjDvObTxsU7wR38MQurF9rMrutmsOZ9CbmJ5gYNU=
X-Received: by 2002:a05:6808:1643:b0:335:19ba:b696 with SMTP id
 az3-20020a056808164300b0033519bab696mr1182847oib.42.1658281549971; Tue, 19
 Jul 2022 18:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220719144753.252231-1-kai.heng.feng@canonical.com> <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz>
In-Reply-To: <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 20 Jul 2022 09:45:37 +0800
Message-ID: <CAAd53p6ru7CJ=pJ2knCL5pgU_Y+nA=yTPscKk225zTD-fv4qQg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Skip creating captures in SOF context
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     tiwai@suse.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:41 PM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 19. 07. 22 v 16:47 Kai-Heng Feng napsal(a):
> > On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
> > light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
> > topology: use new sound control LED layer").
> >
> > The micmute LED itself is still working via sysfs, but it doesn't follow
> > mute anymore. That's because unlike vendors like Dell and Lenovo, HP
> > laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
> > laptops, both SOF and HDA create captures with
> > SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
> > there are two different kcontrols and one of them is not muted.
>
> It does not mean that it's a wrong behavior. When both controls are muted, the
> LED should be turned on. It just requires that all inputs are off (and it may
> be the default - probably we can set in UCM or so). If you turn the "Capture
> Switch" off in amixer / alsamixer, do things work as expected ?

Yes. When all captures are muted the micmute LED is on.

>
> > So skip creating captures for HDA when it's called from SOF, the
> > captures are already handled by SOF.
>
> The capture controls are for other inputs like external analog microphone. If
> it is required to suppress the MIC LED for some hardware, just skip the
> "spec->mic_mute_led = 1" assignment in hda_generic.c . Also, the check
> "codec->core.type != HDA_DEV_ASOC" is not sufficient, because you don't know,
> if the topology really sets the MIC LED flag.

AFAIK the external analog microphone on DMIC laptop is driven by SOF driver too.
If those capture controls are indeed needed for external analog mics,
use UCM to mute them by default won't work either.

Skip "mic_mute_led = 1" can be hard because it's still needed for legacy HDA.
If checking "HDA_DEV_ASOC" isn't sufficient, is it possible to just
check "card" in snd_ctl_led_set_state(), instead of kcontrols?
I think it's reasonable to assume a card has just one speaker LED and
one microphone LED.

Kai-Heng

>
>                                         Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
