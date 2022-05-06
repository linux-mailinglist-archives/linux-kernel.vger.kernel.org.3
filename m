Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADDE51D9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441984AbiEFOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441985AbiEFOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:08:57 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757356762;
        Fri,  6 May 2022 07:05:14 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 77F3E7FD1E;
        Fri,  6 May 2022 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1651845912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8PQ6ZppMbJK9YEvYymT3s+2KUmz/2wUmtRG/KrTmGs=;
        b=CJBM90vLK6FF2svC+lLCwWg2iAirFM6fOiHi8TIVN3G2nxHPaSNWMyImI0bPdsMmbL6twx
        4x2+2Cpv6RQThUO5mVPNz015VONId9XpbLlkc2Tf7Atjrr+ITArrDaehUNbU+O+0pZxysW
        I4mxs9P5l5ubHiTJ2MgoKt+6Ho/RGVtCQXHWbA+MEjrhnifN3Ja704P0b20oPnrg91Gmvt
        Lnrih5mC2eqtNraXIct3IjViODxkbqLGNlGoth5lKqFW7KWaUHcCvn1YrxCgLqFqG0c0RC
        nCtNNhSOYaKArFODDeDqMY7nbQjPsQz6eRTAnj1/2SVbeD3XfF0KeLUpjZSfew==
From:   Paulo Alcantara <pc@cjr.nz>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Tom Talpey <tom@talpey.com>, Steven French <sfrench@samba.org>,
        Byron Stanoszek <gandalf@winds.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
In-Reply-To: <CAN05THQYKRChdR_4T86dGtCO=xY+cWpfa6_fOVNh9WSB=RNE-A@mail.gmail.com>
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org>
 <878rri2i6o.fsf@cjr.nz> <7dc6c729-73cd-74be-eec7-ac4a0013f60f@samba.org>
 <87tua51550.fsf@cjr.nz> <df763cb0-83f2-35a5-a381-57cfd040becf@talpey.com>
 <87r15910c1.fsf@cjr.nz>
 <CAN05THQYKRChdR_4T86dGtCO=xY+cWpfa6_fOVNh9WSB=RNE-A@mail.gmail.com>
Date:   Fri, 06 May 2022 11:05:06 -0300
Message-ID: <87wneyah9p.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_PBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ronnie sahlberg <ronniesahlberg@gmail.com> writes:

> This regression should be easy to fix, but maybe we should not have
> done the initial change in the first place.
> If things is broken and do not work under SMB1, that is a good thing.
> Instead of adding features or fixing
> missing parts to SMB1 we should just tell people to switch to SMB2 instead.
>
> I think if things do not work correctly or things are missing in smb1,
> that is a GOOD THING.
> :-)

LOL - couldn't agree more :-)
