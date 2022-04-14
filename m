Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F350080C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiDNIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiDNIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:15:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B904DF62
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649923925;
        bh=oGZu+94rAXlCiXDG/hQ36QbR5j42yHG/i+8ThDB/29s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cJ2x1g8nE+XtLfMUF3zevyHxqptewBDzMynwpmGfN3ftSCpcPCq0/voUs97Ar9x1s
         /Fg52/4VyKctxDvg+NwWUXsYhQC+Hi6GFl2PZUv4Qwj1jipmw5e55111yZR/AHeNNU
         IyZnU34uir3GpKkXplBjgN5snRaE4rJzEar05YEw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from genesis.localnet ([91.18.94.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1npOz11hZC-00BZNJ; Thu, 14
 Apr 2022 10:12:05 +0200
From:   Alois Wohlschlager <alwoju@gmx.de>
To:     Christian Brauner <brauner@kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Date:   Thu, 14 Apr 2022 10:11:40 +0200
Message-ID: <11982900.O9o76ZdvQC@genesis>
In-Reply-To: <YlZVnMk39kFHF0Kp@google.com>
References: <3412128.IC5jYiYEAv@genesis> <20220401094225.epianrz3afrhfrqp@wittgenstein> <YlZVnMk39kFHF0Kp@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5582229.DvuYhMxLoT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:noaDPfjJBFYTAr1itkpzTineaTxZS/aBjsraMnVRaKcuAZCmZEK
 ul58bczCHEkmQRVYGhq/KlsxyUdbU8lUxItbV6Qf1srX5PdDhxAEz1jVtE8BqEzSFcE6Z6h
 9HpaHz6f+ouz7/x0W8CfRYt2j/fqsFrpjuLcgLZEDID8eoqSOW3hyrolUrAWbDB49oJl5nV
 wuajBcISHqqNf3R2CQlJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:91FC5J8p17Q=:EqymG/DIWQwyvOra4Hdp5R
 L58WA6PJdbOocz1fdxTnblSf3yr4BGL1rYpPELuibdJxY5ObfujOQx2RAVATNZyQ/K0/j8vLU
 BmpopbTd0hNuTbLF8XXmVnkSrxaeO4BeBPZl5SCBOx6igmSEtmWveVPYojPfGW7w0O+bOeQu7
 T8cyRJs0jBcVgS8pSv13cWCIzd68lI2xheJ/8id80u2otix/ymvi4ajwcXOupdiTL4iwWlv68
 0ExUcNP1uUmwgB/MFfAy5pHq4CVYmZpix41xaCZD/dOFlfUnGZWizG6eK4YosQjwKxSd6Wy1h
 M5nWa5vuW7UQvbOK8dveFX4sXrk5GgoemnGpXB6zp/pGqdjUBkrW4tth7mKRKxvrRYWUtE1DE
 PAWRNeYEwbtSiSKunRYNz3zKttE6Uv2mwcpAhG9f/7pQPW+sZVLNyl7lhrqPHBAfpCoU2KqVk
 AAXF7MO5vekEnZqy0Ue5ygQfsVXUqDQgDQOY7TUmDuETaUHCtzyCHl/dnRBJiHDNUEie+ePMc
 xuZ+tQY/PCiQzo1fSXbNUQgnVg9+j2cg+tCX+ApQnXNRAIrNRsaSPbyuPvTvqB/Bcp91jEjvy
 4L7zk6tn9cPiyQBESZATuv/W7fifcQOi/c5wSu/7UK7gwQL6xV1U77VKhfoaoxFZlmYd1GH63
 KnzUKu3M+XxwcoCj++TgvWBRzgjSrXvEk4HluaHtZaHSskpGzmV6Dp9YERZ8+k0+XeLSISLEz
 Ea5nfBOqjBCkum5pL2fTgQL0j4i8F/vIPBXDWfMhuZDn4S7vG/0bnNqmjahyBye96M4Uz9k0X
 ZrUQeTbHXYT7Z7Q7rsyaefv45Xe7+6t8HRJ0yvCXkAjN+W6kkMCwMNT8O4p7A3FGX2FiY/2Ch
 AxrVXCRkl24kqyBzHtx39t75RgkyTK70uIRR2U5VNFRf42lNbYDaCKYdv8Mq+BP5OERRYQyRu
 5obaJxw0hXvK6VFThilCoCQEZE5HI01IhOIhcyNVkI84H+Scsq/JN47gM/OdK91OwZ3ocFqo1
 DHQxwjtVX++UinJFwcd893XtH99u+Mu9pRKnsjowWYACGyh9CnPGVaWBib4Gjz8jS0NGP5FdU
 hsMeb8Q1tVU79s=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5582229.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Alois Wohlschlager <alwoju@gmx.de>
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Date: Thu, 14 Apr 2022 10:11:40 +0200
Message-ID: <11982900.O9o76ZdvQC@genesis>
In-Reply-To: <YlZVnMk39kFHF0Kp@google.com>

Am Mittwoch, 13. April 2022, 06:46:20 CEST schrieb Matthew Bobrowski:
> For the fanotify API i.e. FAN_REPORT_PIDFD, I don't see there being
> any issues with supporting/returning pidfds which belong to
> non-thread-group leaders. In saying that, for this to be useful from
> the fanotify API POV, I definitely do think we should consider
> supporting the ability to send thread-specific signals via
> pidfd_send_signal(). Adding this extension through the optional flag
> parameter makes sense to me.

I actually started implementing this, but then took it out again because I
couldn't think of a use case. Now that one has been found, I can bring it =
back
in a v2.

--nextPart5582229.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEypeoIv8kJdR0rz5L4PWepeUhaRQFAmJX1z0ACgkQ4PWepeUh
aRSx5A//RSaaPgPRr2IiIc6daxSni4Sa3jF9kiJ0lZSvkuFPmmpocm7zKolEwqMQ
0SmGJ/YNlNrkIGDE+JW3LmSvmbftV1/gVJZq/n/cpUPwRYF4mO2VW66mkHVPDU35
Tzh3g8mjyI+op9mUs/tKW48LDwUcB3SnAWOuwf5cwAtWHmbx9qXmyZ/Bbh7AFqev
dg/L6e2In/9pDQokRpSr0EJT04ZgmrBbux6lGcuBsJse2mhSyL2uMaqZNGp9di8k
LWQHeI8f7c3i3iKdEz2zkz1SXxtbL6ztfh3RfVEPq/4Hvn+2peuqErPRiLASSDzw
JclQDCuxGxu02mcx9VO6fbWi3x/ndNW5lfIQv1vEhLUiWFY7rvxvfBpZx6jVb6Wy
BUpcYFh0j1bhlxD+nxSMhIO3l/UIFmfzI8xs1j0OzeuyJONJ7lSHZhe8VBTT8EAp
3pe5TQWc8XFz8akVCaeTFc4jSBGB9+PIM2svxrZfY7QDWMe920e+wXtJc0DA++Yc
hyPQGOLjbDmTBn+UAyUgUIr0peeYrnfh+chl1CCm+jLGerUm7FONB2GgXJunWm8m
tJGcVieb+FgoEQ1m7g5rx9nTjJ0Fk+ZMvbVXj4pOKk7CYOEOZiCotOnHVubmo5PH
2RRKg7dCByyTOJ7DPq2ktYCmkWjNi4fjEtTLErLBKBaLLA/r6ag=
=GhxY
-----END PGP SIGNATURE-----

--nextPart5582229.DvuYhMxLoT--



