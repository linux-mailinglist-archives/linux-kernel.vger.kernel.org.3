Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BC46BF09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhLGPUP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 10:20:15 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34915 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLGPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:20:14 -0500
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CF6AF20007;
        Tue,  7 Dec 2021 15:16:39 +0000 (UTC)
Date:   Tue, 7 Dec 2021 16:16:32 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: soc-core: add the driver component name to the
 component struc
Message-ID: <20211207161632.47ee0020@kmaincent-XPS-13-7390>
In-Reply-To: <Ya9c0d/X0z1QUVN6@sirena.org.uk>
References: <20211206095920.40552-1-kory.maincent@bootlin.com>
        <Ya5lplIoyhKsqFmZ@sirena.org.uk>
        <20211207094732.3be5befb@kmaincent-XPS-13-7390>
        <Ya9c0d/X0z1QUVN6@sirena.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Tue, 7 Dec 2021 13:08:33 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Dec 07, 2021 at 09:47:32AM +0100, Köry Maincent wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > Why is one device registering multiple components in the first place?  
> 
> > Because the sound components are more and more complex. Why they shouldn't?
> >  
> 
> In what way are they more complex? 

The sound hardware components add more and more features.

> 
> > It seems to be already the case:
> > sound/soc/codecs/cros_ec_codec.c
> > sound/soc/fsl/fsl_easrc.c
> > sound/soc/mediatek/mt*/mt*-afe-pcm.c
> > sound/soc/sunxi/sun4i-codec.c
> > sound/soc/soc-utils.c  
> 
> Quite a few (I think all?) of these are quite old and and are the result
> of refactoring from pre-component code rather than modern drivers, it's
> likely there is no concrete reason for them to behave as they do.

I am a beginner in the kernel sound stack, alright then, the issue comes from
the drivers.

Thanks,

Regards
