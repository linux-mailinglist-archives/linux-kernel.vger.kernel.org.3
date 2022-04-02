Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE684F0605
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbiDBUEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbiDBUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:04:08 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD3910FD2;
        Sat,  2 Apr 2022 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1648929731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJ4mwsha3lQSqlBrzoJlxnsLLf/Tzlgc86esu7PtlcA=;
        b=MNNXOUkVP5cBP8wi+pvh/BperKoqa8Vb/0jWXD9lJYD3lzBlvhX25xDPiNQGv6uwQadte3
        H6zLAQJLX8qRhnkaOoC65lq3v9te975SvGdHtlRHaSdVL81t463f+ZX8z1O6bvg5/fugmo
        Tyt4W4QPLOs0vtvBiDf/88OXBaC3LEPeRUYeea/DPsXqyPDGC4V+AqrmiAUniGBMBQgfa/
        FiF512e/zKirwKzHm0AzhFTly4sy5xLMzL4XmGr6rJ1TLiDgmvQ1tXpYrxmPfAASoX9o00
        kaFM0BcVLvGka9M5FkkHPu49Zt+FfOfv1A3Ky/m4SENjWOIj24k+s9YeT42XzhVsGWpW6J
        TAPSTnc2mzHg306zmMLPEwdcqG0QsvIbfSpZMkBSa5vTaQ4IX8hEn0fD1v4QlXElTwdgBp
        +BIbBGA3MPNEf7+DRtrlQSwm9CpHzHZBuXkqwFxgDEgZyeV+jkaOwJRAdiHFhwbH5PmA1+
        ZXB0TOMYM8+bnQp8x09JkTK4vgKVoFkwSG/V2hA+/ZfFaixFNuZhbaVXpl4XH2AurWE5ax
        kyh2eInBZCNfOMHUM4t16a0IL8YilMTpNSvc0hEaqq3VPw2L4uMQNlTDd2gkCBqPEwvjKI
        tEO4rfKSSTbVjFwd9KAJrX1CgO0MnFKVUTNVhQp9FhG68jYcodYlg=
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id cdd70f66 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 2 Apr 2022 20:02:11 +0000 (UTC)
Date:   Sat, 2 Apr 2022 15:02:09 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: accel: dmard09: fixed code styling issues
Message-ID: <YkirwZaMWfgNTtS1@hp-amd-paul>
References: <YkItIE5sp3P4sZdY@hp-amd-paul>
 <20220402172814.5117cdb7@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402172814.5117cdb7@jic23-huawei>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 05:28:14PM +0100, Jonathan Cameron wrote:
> On Mon, 28 Mar 2022 16:48:16 -0500
> Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:
> 
> > Cleaning up code.
> > 
> > Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to see if it can find anything we did wrong.
> 
> BTW.  You seem to have sent two identical copies of this patch.
> I randomly decided to apply this second one.

Yes, I accidentally sent two identical patches. Sorry!

Thank you so much for applying my patch,
Paul
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/dmard09.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> > index 53ab6078c..cb0246ca7 100644
> > --- a/drivers/iio/accel/dmard09.c
> > +++ b/drivers/iio/accel/dmard09.c
> > @@ -24,7 +24,7 @@
> >  #define DMARD09_AXIS_Y 1
> >  #define DMARD09_AXIS_Z 2
> >  #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
> > -#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
> > +#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)
> >  #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
> >  
> >  struct dmard09_data {
> 
