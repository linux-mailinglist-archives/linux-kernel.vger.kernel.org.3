Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800984F485E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381662AbiDEViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392105AbiDEPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639A812E775
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A5B1B81C6D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB2C385A0;
        Tue,  5 Apr 2022 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649166367;
        bh=tEPAy+NbytRr8LPw00hVjTlHe62y4ooPjjnn32amCII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyNi6FyvaNdAHMo2HEF5qEjBKMeMUTU3O/vPvFBgdkzXewf1tDQ+QF0VMQIG3TTrx
         sr/y65z0al95dQNkLplZ3mcnx9HCK4sJFFf8gQjgzLIJ8sohAxlK86eIHYgOca+g2n
         iacvEz+fISPqWVOzWMP3bo8LeSGYymg4P8JaHOFg=
Date:   Tue, 5 Apr 2022 15:45:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: Add line after declarations
Message-ID: <YkxIDdCrJT1rV3SZ@kroah.com>
References: <860d8e222e2b695ce5cb4f48aa46a7f66e05d8e4.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
 <19d8f316e43d16c9341f7fe94e68534cf60cc05c.1649082939.git.eng.alaamohamedsoliman.am@gmail.com>
 <c8461d9c-dda1-3c1e-0e3b-169073e8c4d0@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8461d9c-dda1-3c1e-0e3b-169073e8c4d0@lwfinger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:47:33PM -0500, Larry Finger wrote:
> On 4/4/22 09:39, Alaa Mohamed wrote:
> > Reported by checkpatch:
> > 
> > WARNING: Missing a blank line after declarations
> > 
> > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_br_ext.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > index 7c664f80fa99..f7811b46db1c 100644
> > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > @@ -313,6 +313,7 @@ void nat25_db_cleanup(struct adapter *priv)
> >   	for (i = 0; i < NAT25_HASH_SIZE; i++) {
> >   		struct nat25_network_db_entry *f;
> > +
> >   		f = priv->nethash[i];
> >   		while (f) {
> >   			struct nat25_network_db_entry *g;
> > @@ -339,12 +340,12 @@ void nat25_db_expire(struct adapter *priv)
> >   	for (i = 0; i < NAT25_HASH_SIZE; i++) {
> >   		struct nat25_network_db_entry *f;
> > -		f = priv->nethash[i];
> > +		f = priv->nethash[i];
> >   		while (f) {
> >   			struct nat25_network_db_entry *g;
> > -			g = f->next_hash;
> > +			g = f->next_hash;
> >   			if (__nat25_has_expired(f)) {
> >   				if (atomic_dec_and_test(&f->use_count)) {
> >   					if (priv->scdb_entry == f) {
> 
> Acked_by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> That applies to both patches.

b4 doesn't pick this ack up for both patches, you either need to do it
on the 0/X message, or on each one individually.

thanks,

greg k-h
