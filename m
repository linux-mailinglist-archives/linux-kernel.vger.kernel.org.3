Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28BA46B659
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhLGIvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 03:51:08 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46283 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhLGIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:51:07 -0500
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 30C1A1C0012;
        Tue,  7 Dec 2021 08:47:34 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:47:32 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: soc-core: add the driver component name to the
 component struc
Message-ID: <20211207094732.3be5befb@kmaincent-XPS-13-7390>
In-Reply-To: <Ya5lplIoyhKsqFmZ@sirena.org.uk>
References: <20211206095920.40552-1-kory.maincent@bootlin.com>
        <Ya5lplIoyhKsqFmZ@sirena.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Mon, 6 Dec 2021 19:33:58 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Dec 06, 2021 at 10:59:20AM +0100, Kory Maincent wrote:
> 
> > If a non i2c driver register two components the function will return the
> > same "device_name" for both components. This could cause unexpected issue,
> > in my case it is a debugfs error which tries to create two directory with
> > the same component name.  
> 
> Why is one device registering multiple components in the first place?

Because the sound components are more and more complex. Why they shouldn't?

It seems to be already the case:
sound/soc/codecs/cros_ec_codec.c
sound/soc/fsl/fsl_easrc.c
sound/soc/mediatek/mt*/mt*-afe-pcm.c
sound/soc/sunxi/sun4i-codec.c
sound/soc/soc-utils.c

Regards,

Köry
