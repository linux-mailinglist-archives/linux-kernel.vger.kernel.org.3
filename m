Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42D547C876
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhLUU5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbhLUU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:57:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435AC061574;
        Tue, 21 Dec 2021 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JlGXSycQ7pzr3PGyA1sPezdZeG1opUCtN8x1QkVjzYs=;
        t=1640120222; x=1641329822; b=PXuX/S5IV5EmWSDc8qBId9/WrJQILFV+UQPFkAhzXzNR+MM
        KVNrY9IKleo06yVUPpiCTPTwo+NqGvmR+u1gYUnK4+Mj+zdQ1j0ko4jL+Q5MHxUkJJ5zCtVUT68CW
        9SxqXxVTutjDGAEukq2tW5SVBgqxctnNBfgPhOac86c10M+Drpx6zbbCLnkaELwZ8aPA1WLnVFUt7
        I4gsKmA1sYv0h5rYYGEHVg224TWAC5S9apwx0pddMy9Nfd8gbkEhDtEfG/6+g+nvzbGVq9bpJAbHG
        oV08piMIv79C0OWGfvw/7q9BdRPEYWCSqd5XcfdAakTosExWi80FpTev3OfyNONA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzmBm-00EitN-Uo;
        Tue, 21 Dec 2021 21:56:51 +0100
Message-ID: <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] Devicetree support for UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Richard Weinberger <richard@nod.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        kernel@axis.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Date:   Tue, 21 Dec 2021 21:56:50 +0100
In-Reply-To: <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
         <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-21 at 21:55 +0100, Richard Weinberger wrote:
> Vincent,
> 
> ----- Ursprüngliche Mail -----
> > Von: "Vincent Whitchurch" <vincent.whitchurch@axis.com>
> > An: "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>
> > CC: kernel@axis.com, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um" <linux-um@lists.infradead.org>,
> > "devicetree" <devicetree@vger.kernel.org>, "Vincent Whitchurch" <vincent.whitchurch@axis.com>
> > Gesendet: Mittwoch, 8. Dezember 2021 16:11:21
> > Betreff: [PATCH 0/2] Devicetree support for UML
> 
> > This series add support for passing a devicetree blob to UML.  It can be used
> > for testing device drivers.
> 
> Nice feature.
> Code looks good so far. But while building I'm facing this warning:
> 
> WARNING: unmet direct dependencies detected for OF_EARLY_FLATTREE
>   Depends on [n]: OF [=n]
>   Selected by [y]:
>   - UML [=y]
> 
> 
> Please note that my UML config has CONFIG_OF=n.
> 

Hm. So maybe that needs to be

	select OF_EARLY_FLATTREE if OF

or so?

johannes
