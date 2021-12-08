Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664BF46DCEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhLHU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:28:49 -0500
Received: from mail1.perex.cz ([77.48.224.245]:36254 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240171AbhLHU2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:28:48 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6046AA003F;
        Wed,  8 Dec 2021 21:25:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6046AA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1638995114; bh=ZmSlxHFTTANPlzLGsy+tkobABA2RwHN/Rim8XYjrOgo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mcstFoZuKzL+ur7Zd5z8dU2irkFFtsri7L/g+h1yGaaTYO/gdcJCwovt69jJBfyIh
         mINgH1h77jloF5iYyLrvTINLPzk4Rpv0/EmfmObD8tS+u20Eu11DNJfL1PyxMAEDXP
         SaeQ+dk1qCwkXMaFerP+VtSAu/INRLSDBCkomRvk=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  8 Dec 2021 21:25:04 +0100 (CET)
Message-ID: <1571a09a-a766-a733-e23f-36cf1ab14b86@perex.cz>
Date:   Wed, 8 Dec 2021 21:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ASoC: max98357a: Add mixer control to mute/unmute speaker
Content-Language: en-US
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211208185850.1555996-1-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 12. 21 19:58, Ajit Kumar Pandey wrote:
> Add "Playback Switch" mixer control to mute or unmute speaker
> playback from ucm conf depend on use cases.
> 
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

The "Playback Switch" is too short. It should be more specific (Headphone, 
Speaker etc.).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
