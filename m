Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D44461CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbhK2Rbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:31:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:55584 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237175AbhK2R32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:29:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234746255"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="234746255"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 09:24:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511773514"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 09:24:11 -0800
Date:   Mon, 29 Nov 2021 19:16:35 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Takashi Iwai <tiwai@suse.de>
cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: linux-next: manual merge of the sound-asoc tree with the
 sound-current tree
In-Reply-To: <s5h8rx758g3.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2111291913470.3554566@eliteleevi.tm.intel.com>
References: <20211129113554.59416109@canb.auug.org.au> <s5ho8635n9g.wl-tiwai@suse.de> <YaTDKNOOP2I2dbI+@sirena.org.uk> <alpine.DEB.2.22.394.2111291602310.3554566@eliteleevi.tm.intel.com> <s5h8rx758g3.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Nov 2021, Takashi Iwai wrote:

> On Mon, 29 Nov 2021 15:29:36 +0100, Kai Vehmanen wrote:
> > the asoc for-5.17 branch does have all the needed changes and the 
> > linux-next merged version seems ok. We've already sent many further 
> > changes that touch this area of code to asoc for-5.17. Let me know if some 
> 
> The question is rather whether this discrepancy would cause a problem
> for further developments.  If back-merging 5.16 stuff makes things
> easier, it should be done so.  OTOH, if it's just for resolving the
> conflict in the final tree, we can leave it.

I believe it's the latter case, it would be just for resolving conflict
in the final tree. The patches we have queued up for 5.17 but not yet 
sent, all apply cleanly on top of asoc for-5.17, so back-merge is not 
needed for this.

Br, Kai
