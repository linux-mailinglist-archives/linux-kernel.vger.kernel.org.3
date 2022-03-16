Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0A4DB0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356181AbiCPNPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356165AbiCPNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 231443123B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647436451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6eH0YtiXAwxaE8S/9oN+NS+Lr1yASIS4rv8M7vDZ2P4=;
        b=dJlxwmQP3oeDohFmqQgFg8RklJwyLRAGFekpEqoSCFVs2Uhxdg8nhgMHpZ4S24ScaTjciv
        cYaiC6wMDTMraPlAHsGEGvDZ/EiYEnm4Vqpxx0CV4KUjt/uUA022MgwC22lv2SMZK2xFQO
        0eK/Kos0q4rLUZfV+nUBEPg1KMIGg24=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-XEYK9hxTMYKR0Cz4QAtUOw-1; Wed, 16 Mar 2022 09:14:09 -0400
X-MC-Unique: XEYK9hxTMYKR0Cz4QAtUOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8CE31C168EA;
        Wed, 16 Mar 2022 13:14:08 +0000 (UTC)
Received: from localhost (unknown [10.22.17.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A33200D8FD;
        Wed, 16 Mar 2022 13:14:08 +0000 (UTC)
Date:   Wed, 16 Mar 2022 10:14:07 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.104-rt63
Message-ID: <YjHin0XYJ10voZUG@uudg.org>
References: <Yip/3Gp8iiVbZ85Z@uudg.org>
 <20220313223026.GA19874@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rfwHUegpD7znHBJN"
Content-Disposition: inline
In-Reply-To: <20220313223026.GA19874@duo.ucw.cz>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfwHUegpD7znHBJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 13, 2022 at 11:30:26PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > I'm pleased to announce the 5.10.104-rt63 stable release.
> >=20
> > This release is just an update to the new stable 5.10.104
> > version and no RT specific changes have been made.
>=20
> Thanks for the release.
>=20
> It seems more security fixes (spectre again, AFAICT) are pending for
> 5.10.105. Do you plan an -rt release based on that, too?

Yes, it is in the works. The testing should be complete tomorrow morning.

Luis


--rfwHUegpD7znHBJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmIx4p4ACgkQ85SkI/jm
fCZevA//QCHJOdXDVVks0BX5UvuotbzA774kzDUDtCkaQ+EigQHHD4WcVDgXDbBC
DbV5R4KrmVTVcZqtytrU+4+CCrOTVhYFZ0tJPbISMKWCLN9cnf6AWwCk/2FzbLQs
MNdR+KWPgFduPsfWkjsD1/0dMGJfB4EjhHco1AiZ++yZRoztSwK6nIjM3XaMCcYv
JaZ6oI9Vd0juzRCDLKfAWV67X4FscE5t5ZR1D46sgjvBctqwZSsoVZDvDkDe4dEc
XrNKxmKZUJ2kN47h0Pz/OIYeff5nxJhGhGxSTpPpC3tRJbpMEvDFEY18IJWfigYn
P2dvYYs3I38oMdV0sOpvceCRvu9IXY3JJ3dzYiH2wzdV6y3NaPN08d2jqEiqn3hR
2Cq/ADgYNW4rpjvMNOzJUCxMZ7q3PJ/Hk7W4QSg6VqKrozaSZFRFykXHtHNKnZ4N
loxvpkMWb94XTsjr2I/iro9rmZne7o/fDmDMvc6W9WVTBWBdNplKKg6qdxkjeoRg
vUC/Psc/xyZ9iKj7O4fn9QVI5lKj1fcqaEzY0MabxIz76z0zTgLWa/rqLl6tXjnC
Mmxtatyizxn2JxJQiu6kq5VvNiZexqmOovbFxegwr77prkhsaxBHYk0k3zL30xDY
nB451oHVCeCZ7bi/wN8/9LydzxG4Sj7HECkVIz5rDOaDbl7MmB8=
=1GUd
-----END PGP SIGNATURE-----

--rfwHUegpD7znHBJN--

