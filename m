Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9D461A53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhK2Oxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:53:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:53002 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345031AbhK2Ovq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:51:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="216674772"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="216674772"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 06:37:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="499351229"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 06:37:11 -0800
Date:   Mon, 29 Nov 2021 16:29:36 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Mark Brown <broonie@kernel.org>
cc:     Takashi Iwai <tiwai@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: linux-next: manual merge of the sound-asoc tree with the
 sound-current tree
In-Reply-To: <YaTDKNOOP2I2dbI+@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2111291602310.3554566@eliteleevi.tm.intel.com>
References: <20211129113554.59416109@canb.auug.org.au> <s5ho8635n9g.wl-tiwai@suse.de> <YaTDKNOOP2I2dbI+@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Nov 2021, Mark Brown wrote:

> On Mon, Nov 29, 2021 at 10:23:07AM +0100, Takashi Iwai wrote:
> 
> > Mark, could you resolve in the latter branch?
> 
> I'll just leave them for now, Linus got angry about merging up fixes
> just to resolve conflicts so if it's not an actual dependency...

the asoc for-5.17 branch does have all the needed changes and the 
linux-next merged version seems ok. We've already sent many further 
changes that touch this area of code to asoc for-5.17. Let me know if some 
actions are needed to help.

Br, Kai
