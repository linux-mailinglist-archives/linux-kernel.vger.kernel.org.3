Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932194FEFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiDMGSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiDMGSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:18:43 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510252B14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PMpKw/8qdBQfrItEV05VGyxC4ciZaKh4yI/Y2XQ6d40=;
  b=AEjL1UqhV2QCBIccBzRCaePDLTvzjw/AcUR43HcS5xpDhvHINW/qRMyT
   JpN8BIHfqqmJUsBbz9SW3BfPUXebxQ9z45cFvT2b0lDaNpZoUB+41AqU3
   WzxdTQBILtP1RdwobjZUkrZQ8PcADorEv6oyjrQ+anWFpUIuz9EGA2K0G
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,256,1643670000"; 
   d="scan'208";a="11356775"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:16:20 +0200
Date:   Wed, 13 Apr 2022 08:16:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     johan@kernel.org, Jaehee Park <jhpark1013@gmail.com>,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: greybus: remove unneeded return
In-Reply-To: <5792471.alqRGMn8q6@leap>
Message-ID: <alpine.DEB.2.22.394.2204130815020.3470@hadrien>
References: <cover.1649793138.git.jhpark1013@gmail.com> <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com> <5792471.alqRGMn8q6@leap>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-929786816-1649830581=:3470"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-929786816-1649830581=:3470
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 12 Apr 2022, Fabio M. De Francesco wrote:

> On martedì 12 aprile 2022 21:59:15 CEST Jaehee Park wrote:
> > An empty function with void return type does not need an explicit
> > return. Issue found by checkpatch.
> >
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >  drivers/staging/greybus/audio_codec.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/
> greybus/audio_codec.c
> > index 0f50d1e51e2c..3e3a16568def 100644
> > --- a/drivers/staging/greybus/audio_codec.c
> > +++ b/drivers/staging/greybus/audio_codec.c
> > @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component
> *comp)
> >  static void gbcodec_remove(struct snd_soc_component *comp)
> >  {
> >  	/* Empty function for now */
> > -	return;
> >  }
> >
> >  static int gbcodec_write(struct snd_soc_component *comp, unsigned int
> reg,
> > --
> > 2.25.1
> >
> Hi Jaehee,
>
> If I recall it correctly, Dan Carpenter suggested to remove this empty
> function.
>
> When developers remove lines of code from a function which becomes empty
> after the removals, they also remove the resulting empty function and
> delete all the calls (if there are any left) at the same time.

It's probably not relevant in this case, but the function could be needed
if it is a branch of an ifdef.  Also if it is stored in a structure field
and the user of the structure does not check for NULL.

julia
--8323329-929786816-1649830581=:3470--
